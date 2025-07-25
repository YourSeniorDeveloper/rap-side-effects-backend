@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Side Effects Item View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCR82_I_SE_ITM
  as select from zcr82_t_se_itm
  association to parent ZCR82_I_SE_CAB as _Cabecalho on $projection.IdRegistro = _Cabecalho.IdRegistro
{
  key id_registro        as IdRegistro,
  key id_item            as IdItem,
      descricao_item     as DescricaoItem,
      lastchangedat      as Lastchangedat,
      createdby          as Createdby,
      createdat          as Createdat,
      lastchangedby      as Lastchangedby,
      locallastchangedat as Locallastchangedat,
      
      _Cabecalho
}
