/*
    Classe de testes para a Trigger "Trigger_Item_Ordem_Servico"
    Criado por: Juliano Szlachta
    Data: 26/06/2018
*/
@isTest
public class Teste_Trigger_Item_Ordem_Servico {

	static testmethod void teste()  {
		Triggers__c confTriggers = new Triggers__c();
        confTriggers.Trigger_item_ordem_servico__c = true;
    	insert confTriggers;
        
        Map<String, sObject> mapBase = Teste_Util.createMapBase();
	}	
}