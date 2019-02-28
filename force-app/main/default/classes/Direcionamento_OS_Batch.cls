/*
    Classe de testes: Teste_Direcionamento_OS_Batch
    Criado por: Mario Reis
    Data de criação: 28/05/2018
    Descrição: Classe batch para direcionamento de OS
    ----------------------------------------------------------------------
    ---------------------------------
    @author Renan Rocha
    @date 07/01/2019
    @description:
        - Alterado construtor para receber um Select específico, caso vir nulo, utilizará o getQueryBatch
        - Alterado método start para trabalhar com getQUeryLocator + String
        - Alterado método execute, recebe o sObjectm converte e envia normalmente para Util_Direcionamento_OS como era efetuado
    @JIRA KCA-59
*/
global class Direcionamento_OS_Batch implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {

    private static String CLASS_NAME = 'Direcionamento_OS_Batch';

    global final String query;

    // Método construtor
    global Direcionamento_OS_Batch(String pQuery){
        String METHOD_NAME = 'Construtor';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - pQuery: '+ pQuery);

        if(pQuery == null) query = DAO_Direcionamento_OS.getQueryBatch();
        else query = pQuery;

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - query: '+ query);
    }

    // Metodo start do batch
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String METHOD_NAME = 'start';

        return Database.getQueryLocator(query);
    }

	//Metodo execute, roda quando iniciar o Batch
    global void execute(Database.BatchableContext BC, List<Direcionamento_os__c> scope) {
        String METHOD_NAME = 'execute';

        for(sObject so : scope){
            Direcionamento_os__c dirOS = (Direcionamento_os__c) so;
            
            try{
                Util_Direcionamento_OS.direcionarOS(dirOS);
            }catch(Exception e){
                System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());
            }
        }
    }

    // Metodo que executo ao finalizar o batch
    global void finish(Database.BatchableContext BC) {}
}