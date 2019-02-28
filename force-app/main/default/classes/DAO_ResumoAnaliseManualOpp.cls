/*
  @testClass Teste_DAO_ResumoAnaliseManualOpp

  @description DAO para o objeto: Resumo_analise_manual_oportunidade__c

  @author Renan Rocha
  @date 20/11/2018
  @JIRA KCA-9
*/

public class DAO_ResumoAnaliseManualOpp{

  private static String CLASS_NAME = 'DAO_ResumoAnaliseManualOpp';
  
   /*
    @description Retorna uma lista de Resumo_analise_manual_oportunidade__c conforme o Set informado
    @param Set<Id> pSetId
    @return List<Oportunidade__c>
    
    @author Renan Rocha
  */
  public static List<Resumo_analise_manual_oportunidade__c> getResumoAnaliseManualOppBySetId(Set<Id> pSetId){
    String METHOD_NAME = 'getOportunidade__cBySetId';
  
    return
      [SELECT Id
            , Oportunidade__c
            , Resultado_do_processo__c
            , T_rmino_do_processo_em__c
            , Aprovador__c
      FROM Resumo_analise_manual_oportunidade__c 
      WHERE Oportunidade__c IN: pSetId];    
  }
}