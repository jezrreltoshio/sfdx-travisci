/*
	@testClass Teste_OS_Atualizar_Hist_Item_Usados
	
	@description Batch auxiliar para atualização dos Históricos e Items da OS após passarem pela Schedulable de hora em hora
	
	@author Renan Rocha
	@date 20/12/2018
	@JIRA KCA-378
*/

global class OS_Atualizar_Hist_Item_Usados implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {
	private static String CLASS_NAME = 'OS_Atualizar_Hist_Item_Usados';
	
	global final String listaFilter;
	global final String objeto;
	
	global OS_Atualizar_Hist_Item_Usados(String pObjeto, String pListaFilter) {
		String METHOD_NAME = 'Construtor';

		System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - pobjeto: '+ pobjeto);
		System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - pListaFilter: '+ pListaFilter);

		objeto = pObjeto;
		listaFilter = pListaFilter;
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		String METHOD_NAME = 'start';

		System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - SELECT: '+ 'SELECT Id FROM ' + objeto + ' WHERE Id IN ' + listaFilter);

		return Database.getQueryLocator('SELECT Id FROM ' + objeto + ' WHERE Id IN ' + listaFilter);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		String METHOD_NAME = 'execute';

		System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - scope: '+ scope);

		List<Historico_OS__c> listaHistOSScope = new List<Historico_OS__c>();
		List<Historico_OS__c> listaHistOSScopeUpd = new List<Historico_OS__c>();
		List<Item_ordem_servico__c> listaItemOS = new List<Item_ordem_servico__c>();
		List<Item_ordem_servico__c> listaItemOSUpd = new List<Item_ordem_servico__c>();

		try{
			if(objeto == 'Historico_OS__c'){
				for(sObject so : scope){
					Historico_OS__c histOS = (Historico_OS__c) so;
					listaHistOSScope.add(histOS);
				}

				System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaHistOSScope.size(): '+ listaHistOSScope.size());

				for(Historico_OS__c forhistOS : listaHistOSScope){
					Historico_OS__c histOSObj = new Historico_OS__c();
					histOSObj.Id = forhistOS.Id;
					histOSObj.SELECT_Batch__c = true;

					listaHistOSScopeUpd.add(histOSObj);
				}

				System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaHistOSScopeUpd.size(): '+ listaHistOSScopeUpd.size());

				if(listaHistOSScopeUpd.size() > 0) Database.update(listaHistOSScopeUpd, false);
			} else if(objeto == 'Item_ordem_servico__c'){
				for(sObject so : scope){
					Item_ordem_servico__c histOS = (Item_ordem_servico__c) so;
					listaItemOS.add(histOS);
				}

				System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaItemOS.size(): '+ listaItemOS.size());

				for(Item_ordem_servico__c forItemOS: listaItemOS){
					Item_ordem_servico__c itemOSObj = new Item_ordem_servico__c();
					itemOSObj.Id = forItemOS.Id;
					itemOSObj.SELECT_Batch__c = true;

					listaItemOSUpd.add(itemOSObj);
				}

				System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaItemOSUpd.size(): '+ listaItemOSUpd.size());

				if(listaItemOSUpd.size() > 0) Database.update(listaItemOSUpd, false);
			}
		}catch(Exception e){
			System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());
		}
	}
	
	global void finish(Database.BatchableContext BC) {}
}