/*
	@testClass Teste_Helper_Atualizar_Historico_Item_OS
	
	@description Helper para a Schedulable: OS_Atualizar_Informacoes_Agendada
	
	@author Renan Rocha
	@date 20/12/2018
	@JIRA KCA-381
*/

public class Helper_Atualizar_Historico_Item_OS{
	private static String CLASS_NAME = 'Helper_Atualizar_Historico_Item_OS';
	
	/*
		@description Chama a bach  para atualizar as informações do Histórico ou Item da OS
		@param String pNomeObjeto, List<sOBject> pListaObjeto
		@return void
		
		@author Renan Rocha
		@date 20/12/2018
		@JIRA KCA-381
	*/
	public static void atualizaHistOuItemBatch(String pNomeObjeto, List<sOBject> pListaObjeto){
		String METHOD_NAME = 'atualizaHistOuItemBatch';

		if(pNomeObjeto == 'Historico_OS__c'){
			List<Historico_OS__c> listaHistOSParam = (List<Historico_OS__c>) pListaObjeto;

		}else if(pNomeObjeto == 'Item_ordem_servico__c'){
			List<Item_ordem_servico__c> listaItemOSParam = (List<Item_ordem_servico__c>) pListaObjeto;

		}else{
			System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - ERRO: Objeto informado não válido ou não suportado');
		}
		
		// Set<Id> setIdOS = new Set<Id>();
		// List<Id> listaIdsOSFilter = new List<Id>();
		// List<Id> listaIdsHistOSFilter = new List<Id>();
		// List<Id> listaIdsitemOSFilter = new List<Id>();
		// String listaIds = '';
		// String listaIdsHistOS = '';
		// String listaIdsItemOS = '';

		// List<Historico_OS__c> listaHistoricoOSDAO = [SELECT Id, Ordem_servico__c FROM Historico_OS__c WHERE Verificacao_batch_temp__c = false LIMIT 15000];
		// System.debug(LoggingLevel.ERROR, '___ [cls DEV()] - listaHistoricoOSDAO.size(): '+ listaHistoricoOSDAO.size());

		// List<Item_ordem_servico__c> listaItemOSDAO = [SELECT Id, Ordem_servico__c FROM Item_ordem_servico__c WHERE Verificacao_batch_temp__c = false LIMIT 15000];
		// System.debug(LoggingLevel.ERROR, '___ [cls DEV()] - listaItemOSDAO: '+ listaItemOSDAO);

		// if(listaHistoricoOSDAO.size() > 0 || listaItemOSDAO.size() > 0){

		// 	if(listaHistoricoOSDAO.size() > 0){
		// 		for(Historico_OS__c forHistOS : listaHistoricoOSDAO){
		// 			if(!setIdOS.contains(forHistOS.Ordem_servico__c)) setIdOS.add(forHistOS.Ordem_servico__c);

		// 			listaIdsHistOSFilter.add(forHistOS.Id);
		// 		}

		// 		System.debug(LoggingLevel.ERROR, '___ [cls DEV()] - listaIdsHistOSFilter.size(): '+ listaIdsHistOSFilter.size());

		// 		if(listaIdsHistOSFilter.size() > 0){
		// 			for(Integer i = 0; i < listaIdsHistOSFilter.size(); i++){
		// 				if(i == 0){
		// 					if(i == listaIdsHistOSFilter.size() - 1) listaIdsHistOS = '(\'' + listaIdsHistOSFilter[i] + '\')';
		// 					else listaIdsHistOS = '(\'' + listaIdsHistOSFilter[i] + '\',';
		// 				}else{
		// 					if(i == listaIdsHistOSFilter.size() - 1) listaIdsHistOS += '\'' + listaIdsHistOSFilter[i] + '\')';
		// 					else listaIdsHistOS += '\'' + listaIdsHistOSFilter[i] + '\',';
		// 				}
		// 			}

		// 			System.debug(LoggingLevel.ERROR, '___ [cls DEV()] - listaIdsHistOS: '+ listaIdsHistOS);

		// 			if(listaIdsHistOS != ''){
		// 				OS_Atualizar_Inf_Old_Temp batchTemp = new OS_Atualizar_Inf_Old_Temp('Historico_OS__c', listaIdsHistOS);
		// 				System.debug(LoggingLevel.ERROR, '___ [cls DEV()] - batchTemp: '+ batchTemp);
						
		// 				Database.executeBatch(batchTemp, 200);
		// 			}
		// 		}
		// 	}
			
		// 	if(listaItemOSDAO.size() > 0){
		// 		for(Item_ordem_servico__c forItemOS : listaItemOSDAO){
		// 			if(!setIdOS.contains(forItemOS.Ordem_servico__c)) setIdOS.add(forItemOS.Ordem_servico__c);

		// 			listaIdsitemOSFilter.add(forItemOS.Id);
		// 		}

		// 		System.debug(LoggingLevel.ERROR, '___ [cls DEV()] - listaIdsitemOSFilter.size(): '+ listaIdsitemOSFilter.size());

		// 		if(listaIdsHistOSFilter.size() > 0){
		// 			for(Integer i = 0; i < listaIdsitemOSFilter.size(); i++){
		// 				if(i == 0){
		// 					if(i == listaIdsitemOSFilter.size() - 1) listaIdsItemOS = '(\'' + listaIdsitemOSFilter[i] + '\')';
		// 					else listaIdsItemOS = '(\'' + listaIdsitemOSFilter[i] + '\',';
		// 				}else{
		// 					if(i == listaIdsitemOSFilter.size() - 1) listaIdsItemOS += '\'' + listaIdsitemOSFilter[i] + '\')';
		// 					else listaIdsItemOS += '\'' + listaIdsitemOSFilter[i] + '\',';
		// 				}
		// 			}

		// 			System.debug(LoggingLevel.ERROR, '___ [cls DEV()] - listaIdsItemOS: '+ listaIdsItemOS);

		// 			if(listaIdsItemOS != ''){
		// 				OS_Atualizar_Inf_Old_Temp batchTemp = new OS_Atualizar_Inf_Old_Temp('Item_ordem_servico__c', listaIdsItemOS);
		// 				System.debug(LoggingLevel.ERROR, '___ [cls DEV()] - batchTemp: '+ batchTemp);
						
		// 				Database.executeBatch(batchTemp, 200);
		// 			}
		// 		}
		// 	}
			
		// 	if(setIdOS.size() > 0){
		// 		for(Id forSetId : setIdOS) listaIdsOSFilter.add(forSetId);
		// 	}

		// 	if(listaIdsOSFilter.size() > 0){
		// 		for(Integer i = 0; i < listaIdsOSFilter.size(); i++){
		// 			if(i == 0){
		// 				if(i == listaIdsOSFilter.size() - 1) listaIds = '(\'' + listaIdsOSFilter[i] + '\')';
		// 				else listaIds = '(\'' + listaIdsOSFilter[i] + '\',';
		// 			}else{
		// 				if(i == listaIdsOSFilter.size() - 1) listaIds += '\'' + listaIdsOSFilter[i] + '\')';
		// 				else listaIds += '\'' + listaIdsOSFilter[i] + '\',';
		// 			}
		// 		}

		// 		if(listaIds != ''){
		// 			OS_Atualizar_Informacoes_Batch batch = new OS_Atualizar_Informacoes_Batch(listaIds);
		// 			System.debug(LoggingLevel.ERROR, '___ [cls DEV()] - batch: '+ batch);
					
		// 			Database.executeBatch(batch, 200);
		// 		}
		// 	}
		// }
	}
}