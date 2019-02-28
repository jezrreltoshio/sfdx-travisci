/*
	@testClass Batch_Remove_OS_Regra
	
	@author Renan Rocha
	@date 09/01/2019
*/

@isTest
public class Teste_Batch_Remove_OS_Regra{
	
	/*
		@author Renan Rocha
		@date 09/01/2019
	*/
	static testMethod void teste(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		Direcionamento_os__c dirOS = (Direcionamento_os__c) mapBase.get('Direcionamento_os__c');
		WorkOrder OS = (WorkOrder) mapBase.get('WorkOrder');
		OS.Regra_direcionamento_OS__c = dirOS.Id;
		update OS;

		Database.executeBatch(new Batch_Remove_OS_Regra(new Set<Id>{OS.Id}, dirOS.Id), 1);
	}
}