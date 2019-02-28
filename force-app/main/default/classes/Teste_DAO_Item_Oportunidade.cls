/*
  @testClass DAO_Item_Oportunidade

  @author Renan Rocha
  @date 19/11/2018
*/

@isTest
public class Teste_DAO_Item_Oportunidade{
  /*
    @author Renan Rocha
    @date 21/11/2018
  */
  static testMethod void getItemLinhaPorFamiliaId(){
    Map<String, sObject> mapBase = Teste_Util.createMapBase();
    Opportunity oportunidade = (Opportunity) mapBase.get('Opportunity');
	OpportunityLineItem oppLi = (OpportunityLineItem) mapBase.get('OpportunityLineItem');
      
    System.assertEquals(oppLi.Id, DAO_Item_Oportunidade.getItemLinhaPorFamiliaId(oportunidade.Id, null).Id);
  }

  /*
    @author Renan Rocha
    @date 12/12/2018
  */
  static testMethod void getOppQliByOppId(){
    Map<String, sObject> mapBase = Teste_Util.createMapBase();
    Opportunity oportunidade = (Opportunity) mapBase.get('Opportunity');
      
    System.assertEquals(1, DAO_Item_Oportunidade.getOppQliByOppId(oportunidade.Id).size());
  }
}