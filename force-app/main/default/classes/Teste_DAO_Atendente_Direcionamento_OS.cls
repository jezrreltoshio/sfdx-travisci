/*
	@testClass DAO_Atendente_Direcionamento_OS
	
	@author Renan Rocha
	@date 07/01/2019
*/

@isTest
public class Teste_DAO_Atendente_Direcionamento_OS{
	
	/*
		@author Renan Rocha
		@date 07/01/2019
	*/
	static testMethod void getUsuariosSelecionados(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		Direcionamento_os__c dirOS = (Direcionamento_os__c) mapBase.get('Direcionamento_os__c');

		System.assertEquals(1, DAO_Atendente_Direcionamento_OS.getUsuariosSelecionados(dirOS.Id).size());
	}
}