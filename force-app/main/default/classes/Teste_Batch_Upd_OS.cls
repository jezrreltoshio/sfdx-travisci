/*
	@testClass Batch_Upd_OS

	@author Renan Rocha
	@date 03/01/2019
*/

@isTest
public class Teste_Batch_Upd_OS{

	/*
		@author Renan Rocha
		@date 03/01/2019
	*/
	static testMethod void teste(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();

		Database.executeBatch(new Batch_Upd_OS(null, 'Historico_OS__c'), 100);
		Database.executeBatch(new Batch_Upd_OS(null, 'Item_ordem_servico__c'), 100);
	}
}