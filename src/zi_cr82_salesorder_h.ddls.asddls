@EndUserText.label: 'Sales Order Header Interface'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

define root view entity ZI_CR82_SalesOrder_H
  as select from zcr82_t_so_h
  composition [0..*] of ZI_CR82_SalesOrder_I as _Item
{

  key sales_order_uuid       as SalesOrderUuid,
      order_id               as OrderId,
      customer_id            as CustomerId,
      order_date             as OrderDate,
      total_net_value        as TotalNetValue,
      creation_date_time     as CreationDateTime,
      last_changed_date_time as LastChangedDateTime,
      
      _Item

}
