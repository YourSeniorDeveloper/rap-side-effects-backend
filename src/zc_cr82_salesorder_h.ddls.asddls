@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Header'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.representativeKey: 'SalesOrderUUID'
define root view entity ZC_CR82_SalesOrder_H as projection on ZI_CR82_SalesOrder_H
{
    key SalesOrderUuid,
    OrderId,
    CustomerId,
    OrderDate,
    TotalNetValue,
    CreationDateTime,
    LastChangedDateTime,
    /* Associations */
    _Item: redirected to composition child ZC_CR82_SalesOrder_I
}
