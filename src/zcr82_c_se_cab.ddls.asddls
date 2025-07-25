@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Side Effects Consumption Header'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZCR82_C_SE_CAB as projection on ZCR82_I_SE_CAB
{
    key IdRegistro,
    Nome,
    Sobrenome,
    TotalItens,
    Lastchangedat,
    Createdby,
    Createdat,
    Lastchangedby,
    Locallastchangedat,
    /* Associations */
    _Item
}
