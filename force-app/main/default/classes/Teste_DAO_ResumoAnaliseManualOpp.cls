/*
  @testClass DAO_ResumoAnaliseManualOpp

  @author Renan Rocha
  @date 20/11/2018
*/

@isTest
public class Teste_DAO_ResumoAnaliseManualOpp{

  /*
    @author Renan Rocha
    @date 06/12/2018
  */
  static testMethod void getResumoAnaliseManualOppBySetId(){
    Map<String, sObject> mapBase = Teste_Util.createMapBase();
    Opportunity oportunidade = (Opportunity) mapBase.get('Opportunity');

    System.assertEquals(1, DAO_ResumoAnaliseManualOpp.getResumoAnaliseManualOppBySetId(new Set<Id>{oportunidade.Id}).size());
  }
}