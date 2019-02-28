/*
    @testClass Teste_Batch_Upd_OS

    @description Batch para atualização das OS com base nos Históricos e Itens da OS

    @author Renan Rocha
    @date 03/01/2019
    @JIRA KCA-381
*/
global class Batch_Upd_OS implements Database.Batchable<sObject> {
    
    private static String CLASS_NAME = 'Batch_Upd_OS';

    global final String query;
    global final String nomeObjeto;

    global Batch_Upd_OS(String pQuery, String pNomeObjeto){
        String METHOD_NAME = 'Construtor';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - pQuery: '+ pQuery);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - pNomeObjeto: '+ pNomeObjeto);

        nomeObjeto = pNomeObjeto;

        if(nomeObjeto == 'Historico_OS__c'){
            if(pQuery == null) query = DAO_Historico_OS.getQueryHistoricoOSRecente();
            else query = pQuery;
        } else if(nomeObjeto == 'Item_ordem_servico__c'){
            if(pQuery == null) query = DAO_Item_Ordem_Servico.getQueryItemOSRecente();
            else query = pQuery;
        }
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String METHOD_NAME = 'start';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - query: '+ query);

        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        String METHOD_NAME = 'execute';
        
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - scope: '+ scope);

        Set<Id> setIdOS = new Set<Id>();
        List<Historico_OS__c> listaHistOS = new List<Historico_OS__c>();
        List<Id> listaIdsOSFilter = new List<Id>();
        List<Item_ordem_servico__c> listaItemOS = new List<Item_ordem_servico__c>();
        List<WorkOrder> listaOSDAO = new List<WorkOrder>();
        List<WorkOrder> listaOSUpd = new List<WorkOrder>();
        String listaIds = '';

        if(nomeObjeto == 'Historico_OS__c'){

            for(sObject so : scope){
                Historico_OS__c histOS = (Historico_OS__c) so;
                listaHistOS.add(histOS);
            }

            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaHistOS.size(): '+ listaHistOS.size());

            if(listaHistOS.size() > 0){
                Helper_Atualizar_Historico_Item_OS.atualizaHistOuItemBatch(nomeObjeto, listaHistOS);

                for(Historico_OS__c forHistOS : listaHistOS){
                    if(!setIdOS.contains(forHistOS.Ordem_servico__c)) setIdOS.add(forHistOS.Ordem_servico__c);
                }
            }

        } else if(nomeObjeto == 'Item_ordem_servico__c'){
            for(sObject so : scope){
                Item_ordem_servico__c itemOS = (Item_ordem_servico__c) so;
                listaItemOS.add(itemOS);
            }

            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaItemOS.size(): '+ listaItemOS.size());

            if(listaItemOS.size() > 0){
                Helper_Atualizar_Historico_Item_OS.atualizaHistOuItemBatch(nomeObjeto, listaItemOS);

                for(Item_ordem_servico__c forItemOS : listaItemOS){
                    if(!setIdOS.contains(forItemOS.Ordem_servico__c)) setIdOS.add(forItemOS.Ordem_servico__c);
                }
            }
        }

        if(setIdOS.size() > 0){
            for(Id forOSId : setIdOS){
                WorkOrder osDAO = DAO_Ordem_Servico.getOrdemById(forOSId);
                System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - osDAO: '+ osDAO);
                
                listaOSDAO.add(osDAO);
            }

            if(listaOSDAO.size() > 0) {
                listaOSUpd = Util_OS_Atualizar_Informacoes.atualizarInformacoesOS(listaOSDAO);
            }

            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaOSUpd: '+ listaOSUpd);

            if(listaOSUpd.size() > 0) update listaOSUpd;                
        }
    }
    
    global void finish(Database.BatchableContext BC) {}
}