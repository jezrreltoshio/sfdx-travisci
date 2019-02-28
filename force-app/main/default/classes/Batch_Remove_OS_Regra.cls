/*
	@testClass Teste_Batch_Remove_OS_Regra
	
	@description Batch para remoção dos direcionamentos das OS que saíram das regras
	
	@author Renan Rocha
	@date 09/01/2019
	@JIRA KCA-59
*/

global class Batch_Remove_OS_Regra implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful{
	private static String CLASS_NAME = 'Batch_Remove_OS_Regra';

	global final String idRegra;
	global final String stringSetIdsOS;
	global final String query;
	
	global Batch_Remove_OS_Regra(Set<Id> pSetIdsOS, String pIdRegra){
		String METHOD_NAME = 'Construtor';

		List<Id> listaIdFilter = new List<Id>();

		System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - pSetIdsOS: '+ pSetIdsOS);
		System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - pIdRegra: '+ pIdRegra);

		idRegra = pIdRegra;
		System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - idRegra: '+ idRegra);

		if(pSetIdsOS.size() > 0){
			for(Id forSetId : pSetIdsOS) listaIdFilter.add(forSetId);

			for(Integer i = 0; i < listaIdFilter.size(); i++){
				if(i == 0){
					if(i == listaIdFilter.size() -1) stringSetIdsOS = '(\'' + listaIdFilter[i] + '\')';
					else stringSetIdsOS = '(\'' + listaIdFilter[i] + '\',';
				} else if(i == listaIdFilter.size() -1) stringSetIdsOS += listaIdFilter[i] + '\')';
				else stringSetIdsOS += '\'' + listaIdFilter[i] + '\',';
			}

			System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - stringSetIdsOS: '+ stringSetIdsOS);

			query = DAO_Ordem_Servico.getQueryBatch(stringSetIdsOS, idRegra);
		} else {
			query = DAO_Ordem_Servico.getQueryBatch(null, idRegra);
		}

		System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - query: '+ query);
	}

	global Database.QueryLocator start(Database.BatchableContext BC) {
        String METHOD_NAME = 'start';

        return Database.getQueryLocator(query);
    }

	//Metodo execute, roda quando iniciar o Batch
    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        String METHOD_NAME = 'execute';

		List<WorkOrder> listaOSDAO = new List<WorkOrder>();
		List<WorkOrder> listaOSUpd = new List<WorkOrder>();

        for(sObject so : scope){
            WorkOrder OS = (WorkOrder) so;
            listaOSDAO.add(OS);
        }

		if(listaOSDAO.size() > 0){
			for(WorkOrder wo : listaOSDAO){
				wo.Regra_direcionamento_OS__c = null;
				wo.Data_direcionamento__c = null;
				wo.OwnerId = Parametros_ORG__c.getOrgDefaults().ID_fila_ordem_servico__c;
				listaOSUpd.add(wo);
			}
		}

		if(listaOSUpd.size() > 0) update listaOSUpd;
    }

    // Metodo que executo ao finalizar o batch
    global void finish(Database.BatchableContext BC) {}
}