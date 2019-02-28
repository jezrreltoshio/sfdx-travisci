/*
	@testClass HistoricoOportunidade_fillDetails
	
	@author Renan Rocha
	@date 07/12/2018
*/

@isTest
public class Teste_HistoricoOportunidade_fillDetails{
	
	/*
		@author Renan Rocha
		@date 07/12/2018
	*/
	static testMethod void teste(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		Historico_Oportunidade__c histOpp = (Historico_Oportunidade__c) mapBase.get('Historico_Oportunidade__c');
	}
}