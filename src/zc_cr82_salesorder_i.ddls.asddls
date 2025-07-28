@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Item'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.representativeKey: 'SalesOrderItemUUID'
define view entity ZC_CR82_SalesOrder_I as projection on ZI_CR82_SalesOrder_I
{
    key SalesOrderItemUuid,
    SalesOrderUuid,
    ProductId,
    Quantity,
    UnitPrice,
    NetValue,
    CreationDateTime,
    LastChangedDateTime,
    /* Associations */
    _Header: redirected to parent ZC_CR82_SalesOrder_H
}
