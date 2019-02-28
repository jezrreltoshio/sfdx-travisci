/*
	@testClass OS_Atualizar_Hist_Item_Usados
	
	@author Renan Rocha
	@date 20/12/2018
*/

@isTest
public class Teste_OS_Atualizar_Hist_Item_Usados{
	
	/*
		@author Renan Rocha
		@date 20/12/2018
	*/
	static testMethod void teste(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		Historico_OS__c histOS = (Historico_OS__c) mapBase.get('Historico_OS__c');
		Item_ordem_servico__c itemOS = (Item_ordem_servico__c) mapBase.get('Item_ordem_servico__c');

		Database.executeBatch(new OS_Atualizar_Hist_Item_Usados('Historico_OS__c', '(\'' + histOS.Id + '\')'), 200);
		Database.executeBatch(new OS_Atualizar_Hist_Item_Usados('Item_ordem_servico__c', '(\'' + itemOS.Id + '\')'), 200);
	}
}