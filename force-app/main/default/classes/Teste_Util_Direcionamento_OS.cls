/*
	@testClass Util_Direcionamento_OS
	
	@author Renan Rocha
	@date 09/01/2019
*/

@isTest
public class Teste_Util_Direcionamento_OS{
	
	/*
		@author Renan Rocha
		@date 09/01/2019
	*/
	static testMethod void direcionarOS(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		Direcionamento_os__c dirOS = (Direcionamento_os__c) mapBase.get('Direcionamento_os__c');

		System.assertNotEquals(true, Util_Direcionamento_OS.direcionarOS(dirOS));
	}
}