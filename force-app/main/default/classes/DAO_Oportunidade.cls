/*
    Classe de teste: Teste_DAO_Oportunidade
    Criado por: Mario Reis
    Data de criação: 01/09/2017
    Descrição: Classe DAO para o objeto: Opportunity
    ---------------------------------
    @author Renan Rocha
    @date 19/11/2018
    @description Classe refatorada e novos debugs inseridos
    @JIRA KCA-9
*/
public class DAO_Oportunidade{

  private static String CLASS_NAME = 'DAO_Oportunidade';

  // Método que retorna a lista de Contas para verificação da duplicidade
    public static Opportunity getOportunidadePorFamiliaId(String idOportunidade, String familia){
    String METHOD_NAME = 'getOportunidadePorFamiliaId';

    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - idOportunidade: '+ idOportunidade);
    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - familia: '+ familia);

        try {
            return 
        [SELECT Id 
              , AccountId
              , Indicador__c
              , Mensagem_geracao_proposta__c
              , Name
              , Owner.IdUsuarioPreCadastro__c
              , Owner.Name
              , Owner.UserRole.Name
              , Percentual_alcan_ado__c
              , Prazo_contrato_Id__c
              , Prazo_do_contrato__c
              , Siggo_PersProp_NumeroProposta__c
              , Tipo_contrato_ID__c
              , Tipo_proposta_ID__c
              , Valor_da_taxa_de_ades_o__c
              , Valor_mensal_corp__c
              , Valor_mensal_monitoramento__c
              , Valor_mensal_parcelado__c
              , (SELECT Id
                      , Classe_do_contrato__c
                      , Discount
                      , Fam_lia_de_produtos__c
                      , Id_acessorio__c
                      , Prazo_do_contrato2__c
                      , PriceBookEntry.Product2.Id_acessorio__c
                      , PriceBookEntry.Product2Id
                      , Quantity
                      , UnitPrice
                      , Valor_mensal__c
                      , Valor_unit_rio_mensal__c
                 FROM OpportunityLineItems
                 WHERE Fam_lia_de_produtos__c =: familia)
        FROM Opportunity
        WHERE Id =: idOportunidade];
        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

            throw new customException(Label.MSG_ERRO_0006);
        } // Fim try/catch
    } // Fim método getContaVerificaoDuplicidadePorId

  /*
    @description 
    @param Id pOwnerId, Set<String> pSetStage
    @return List<Opportunity>
    
    @author Renan Rocha
  */
  public static List<Opportunity> getOportunidadesByOwnerIdEStageName(Id pOwnerId, Set<String> pSetStage){
    String METHOD_NAME = 'getOportunidadesByOwnerIdEStageName';
  
    return
      [SELECT Id 
       FROM Opportunity
       WHERE OwnerId =: pOwnerId 
       AND CloseDate <: Date.today()
       AND StageName NOT IN: pSetStage];
  }

  /*
    @description Retorna uma lista de oportunidades conforme o Set informado
    @param Set<Id> pSetId
    @return List<Opportunity>
    
    @author Renan Rocha
  */
  public static List<Opportunity> getOportunidadesBySetId(Set<Id> pSetId){
    String METHOD_NAME = 'getOportunidadesBySetId';
  
    return
      [SELECT Id
            , AccountId
            , (SELECT Id 
               FROM ProcessInstances 
               ORDER BY CreatedDate DESC 
               LIMIT 1)
      FROM Opportunity
      WHERE Id IN: pSetId];
  }

  /*
      @description Retorna a oportunidade conforme o Id informado
      @param String pOppId
      @return Opportunity
      
      @author Renan Rocha
      @date 12/12/2018
      @JIRA KCA-10
  */
  public static Opportunity getOppById(String pOppId){
      String METHOD_NAME = 'getOppById';
      
      return
        [SELECT Id
              , AccountId
              , CartaoCredito_CodigoSeguranca_Cript__c
              , CartaoCredito_Numero_Cript__c
              , CartaoCredito_ValorParcela__c
              , CartaoCredito_Vencimento__c
              , Cd_Produto__c
              , CodigoOportunidade__c
              , Forma_de_pagamento_instala_o__c
              , Id_produto_cobertura__c
              , N_de_Produtos__c
              , Nome_do_portador_2__c                   
              , Nome_do_portador__c
              , Numero_dos_contratos_ERP__c
              , PEP1__c
              , PEP2__c
              , Parcelamento_da_instala_o__c
              , Prazo_do_contrato__c 
              , Produto_VigenciaContrato__c
              , ProfissaoProprietario__c
              , Quantidade_placas__c
              , Siggo_AnalCred_AguardandoRetorno__c
              , Siggo_AnalCred_CodigoRetorno__c
              , Siggo_AnalCred_DataProcesso__c
              , Siggo_AnalCred_MensagemProcesso__c
              , Siggo_AnalCred_MensagemRetorno__c
              , Siggo_AnalCred_ResultadoAnalise__c
              , Siggo_AnalCred_RetornoGestor__c
              , Siggo_AnalPrel_AguardandoRetorno__c
              , Siggo_AnalPrel_CodigoRetorno__c
              , Siggo_AnalPrel_DataProcesso__c
              , Siggo_AnalPrel_MensagemProcesso__c
              , Siggo_AnalPrel_MensagemRetorno__c
              , Siggo_ClasseProduto__c
              , Siggo_PersProp_AguardandoRetorno__c
              , Siggo_PersProp_CodigoRetorno__c
              , Siggo_PersProp_DataProcesso__c
              , Siggo_PersProp_MensagemProcesso__c
              , Siggo_PersProp_MensagemRetorno__c
              , Siggo_PersProp_NumeroProposta__c
              , Siggo_PersProp_StatusProposta__c
              , Siggo_TipoContrato__c
              , Siggo_TipoProposta__c
              , Status_aprova_o_manual__c
              , Total_mensal_da_instala_o__c
              , Valor_unit_rio_mensal_new__c
              , Vl_franquia_cobertura__c
              , Vl_lmi_cobertura__c
              , indicador__c
        FROM Opportunity
        WHERE Id =: pOppId];   
  }
}