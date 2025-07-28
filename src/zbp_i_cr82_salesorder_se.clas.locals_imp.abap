CLASS lhc_SalesOrder DEFINITION INHERITING FROM cl_abap_behavior_handler.


  PRIVATE SECTION.

    METHODS calculateTotalNetValue FOR DETERMINE ON MODIFY
      IMPORTING keys FOR SalesOrderItem~CalculateTotalNetValue.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR SalesOrder RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR SalesOrder RESULT result.

ENDCLASS.

CLASS lhc_SalesOrder IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD calculatetotalnetvalue.

    DATA: lv_total_net_value TYPE ZI_CR82_SalesOrder_H-TotalNetValue.

    READ ENTITIES OF ZI_CR82_SalesOrder_H IN LOCAL MODE
      ENTITY SalesOrderItem
      ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(lt_changed_items)
        FAILED DATA(lt_failed_items).

    LOOP AT lt_changed_items INTO DATA(ls_changed_item).
      DATA(lv_hdr_key) = ls_changed_item-SalesOrderUuid.
      lv_total_net_value = lv_total_net_value + ls_changed_item-NetValue.
    ENDLOOP.

    MODIFY ENTITIES OF ZI_CR82_SalesOrder_H IN LOCAL MODE
      ENTITY SalesOrder
      UPDATE FIELDS ( TotalNetValue  )
      WITH VALUE #( ( SalesOrderUuid = lv_hdr_key
                    TotalNetValue = lv_total_net_value ) )
      REPORTED DATA(lt_modified_items)
      FAILED DATA(lt_failed_modify).

  ENDMETHOD.

ENDCLASS.
