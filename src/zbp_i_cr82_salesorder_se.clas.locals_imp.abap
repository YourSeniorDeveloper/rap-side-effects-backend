" Definição da classe lhc_SalesOrder, herdando de cl_abap_behavior_handler
CLASS lhc_SalesOrder DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    " Método para calcular o valor total líquido ao modificar itens do pedido
    METHODS calculateTotalNetValue FOR DETERMINE ON MODIFY
      IMPORTING keys FOR SalesOrderItem~CalculateTotalNetValue.

    " Método para obter autorizações específicas de instância
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR SalesOrder RESULT result.

    " Método para obter autorizações globais
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR SalesOrder RESULT result.

    METHODS validaValorTotalOrdem FOR VALIDATE ON SAVE
      IMPORTING keys FOR SalesOrder~validaValorTotalOrdem.

ENDCLASS.

" Implementação da classe lhc_SalesOrder
CLASS lhc_SalesOrder IMPLEMENTATION.

  " Implementação vazia: método de autorização por instância
  METHOD get_instance_authorizations.
  ENDMETHOD.

  " Implementação vazia: método de autorização global
  METHOD get_global_authorizations.
  ENDMETHOD.

  " Método responsável por calcular o valor total líquido do pedido
  METHOD calculatetotalnetvalue.

    " Declaração de variável para armazenar o valor total líquido
    DATA: lv_total_net_value TYPE ZI_CR82_SalesOrder_H-TotalNetValue.

    " Lê as entidades modificadas de itens do pedido
    READ ENTITIES OF ZI_CR82_SalesOrder_H IN LOCAL MODE
      ENTITY SalesOrderItem
      ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(lt_changed_items)
        FAILED DATA(lt_failed_items).

    " Obtém a chave do cabeçalho do pedido a partir do primeiro item alterado
    READ TABLE lt_changed_items INTO DATA(ls_changed_item) INDEX 1.
    DATA(lv_hdr_key) = ls_changed_item-SalesOrderUuid.

    " Soma o NetValue de todos os itens alterados
    LOOP AT lt_changed_items INTO ls_changed_item.
      lv_total_net_value = lv_total_net_value + ls_changed_item-NetValue.
    ENDLOOP.

    " Seleciona todos os itens do pedido no banco de dados que não foram alterados
    SELECT * FROM ZI_CR82_SalesOrder_I
      WHERE SalesOrderUuid = @lv_hdr_key
      INTO TABLE @DATA(lt_sales_order_item).

    " Soma o NetValue dos itens não alterados
    LOOP AT lt_sales_order_item INTO DATA(ls_sales_order_item).
      CHECK NOT line_exists( lt_changed_items[ SalesOrderItemUuid = ls_sales_order_item-SalesOrderItemUuid ] ).
      lv_total_net_value = lv_total_net_value + ls_sales_order_item-NetValue.
    ENDLOOP.

    " Atualiza o valor total líquido no cabeçalho do pedido
    MODIFY ENTITIES OF ZI_CR82_SalesOrder_H IN LOCAL MODE
      ENTITY SalesOrder
      UPDATE FIELDS ( TotalNetValue  )
      WITH VALUE #( ( SalesOrderUuid = lv_hdr_key
                    TotalNetValue = lv_total_net_value ) )
      REPORTED DATA(lt_modified_items)
      FAILED DATA(lt_failed_modify).

  ENDMETHOD.

  METHOD validaValorTotalOrdem.

    READ ENTITIES OF ZI_CR82_SalesOrder_H IN LOCAL MODE
      ENTITY SalesOrder
      ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(lt_changed_items)
        FAILED DATA(lt_failed_items).

    IF lt_changed_items[ 1 ]-TotalNetValue > 100.
      APPEND VALUE #( %tky        = lt_changed_items[ 1 ]-%tky
                      %msg        = new_message_with_text(    severity = if_abap_behv_message=>severity-error
                                                              text = 'Valor da ordem não pode ultrapassar 100,00' )
                      %element-TotalNetValue  = if_abap_behv=>mk-on ) TO reported-salesorder.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
