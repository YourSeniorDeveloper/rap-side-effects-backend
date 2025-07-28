@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Item'
@Metadata.ignorePropagatedAnnotations: true

// Aqui é onde a mágica do SideEffects começa. A anotação @Common.SideEffects será definida na Projection View (próximo passo), 
// mas a associação é definida aqui.

define view entity ZI_CR82_SalesOrder_I
  as select from zcr82_t_so_i
  association to parent ZI_CR82_SalesOrder_H as _Header on _Header.SalesOrderUuid = $projection.SalesOrderUuid
{
  key sales_order_item_uuid  as SalesOrderItemUuid,
      sales_order_uuid       as SalesOrderUuid,
      product_id             as ProductId,
      quantity               as Quantity,
      unit_price             as UnitPrice,
      net_value              as NetValue,
      creation_date_time     as CreationDateTime,
      last_changed_date_time as LastChangedDateTime,

      _Header
}
