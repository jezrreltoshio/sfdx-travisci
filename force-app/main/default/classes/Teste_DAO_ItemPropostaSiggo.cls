/*
	@testClass DAO_ItemPropostaSiggo
	
	@author Renan Rocha
	@date 12/12/2018
*/

@isTest
public class Teste_DAO_ItemPropostaSiggo{
	
	/*
		@author Renan Rocha
		@date 12/12/2018
	*/
	static testMethod void getItemPropostaByOppId(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		Opportunity oportunidade = (Opportunity) mapBase.get('Opportunity');

		System.assertEquals(1, DAO_ItemPropostaSiggo.getItemPropostaByOppId(oportunidade.Id).size());
		System.assertEquals(1, DAO_ItemPropostaSiggo.getItemPropostaByOppId(oportunidade.Id, true).size());
	}
}