/*
	@testClass Helper_Atualizar_Historico_Item_OS
	
	@author Renan Rocha
	@date 20/12/2018
*/

@isTest
public class Teste_Helper_Atualizar_Historico_Item_OS{
	
	/*
		@author Renan Rocha
		@date 20/12/2018
	*/
	static testMethod void atualizaHistOuItemBatch(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		Historico_OS__c histOS = (Historico_OS__c) mapBase.get('Historico_OS__c');
		Item_ordem_servico__c itemOS = (Item_ordem_servico__c) mapBase.get('Item_ordem_servico__c');

		Helper_Atualizar_Historico_Item_OS.atualizaHistOuItemBatch('Historico_OS__c', new List<sObject>{(sObject) histOS});
		Helper_Atualizar_Historico_Item_OS.atualizaHistOuItemBatch('Item_ordem_servico__c', new List<sObject>{(sObject) itemOS});
	}
}