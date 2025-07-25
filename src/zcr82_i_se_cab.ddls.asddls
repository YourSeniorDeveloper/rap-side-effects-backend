@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Side Effects Root view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZCR82_I_SE_CAB
  as select from ZCR82_T_SE_CAB
  composition [0..*] of ZCR82_I_SE_ITM as _Item
{
  key id_registro        as IdRegistro,
      nome               as Nome,
      sobrenome          as Sobrenome,
      total_itens        as TotalItens,
      lastchangedat      as Lastchangedat,
      createdby          as Createdby,
      createdat          as Createdat,
      lastchangedby      as Lastchangedby,
      locallastchangedat as Locallastchangedat,
      _Item // Make association public
}
