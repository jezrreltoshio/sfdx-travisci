/*
    Classe de testes: Teste_OS_Atualizar_Informacoes_Batch
    Criado por: Mario Reis
    Data de criação: 11/06/2018
    Descrição: Classe batch agendada
    ----------------------------------------------------------------------
    ---------------------------------
    @author Renan Rocha
    @date 18/12/2018
    @description:
        - Classe refatorada
        - Novos debugs inseridos
        - Parâmetro do construtor alterado para receber uma lista preparada de string da Schedulabe
        - Alterado query do start para receber uma string vinda da DAO + o parâmetro do construtor
    @JIRA KCA-86
*/
global class OS_Atualizar_Informacoes_Batch implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {

    private static String CLASS_NAME = 'OS_Atualizar_Informacoes_Batch';

    global final String listaIds;

    global OS_Atualizar_Informacoes_Batch(String pListaIds){
        String METHOD_NAME = 'Construtor';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - pListaIds: '+ pListaIds);

        listaIds = pListaIds;
    }

    /*
     	Metodo start do batch
    */       
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String METHOD_NAME = 'start';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaIds: '+ listaIds);
        
        return Database.getQueryLocator(DAO_Ordem_Servico.getQueryBatch(listaIds));
    }

    /*
    Metodo execute, roda quando iniciar o Batch
    */        
    global void execute(Database.BatchableContext BC, List<WorkOrder> scope) {
        String METHOD_NAME = 'execute';
        
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - scope: '+ scope);

        List<WorkOrder> listaOrdemServico = new List<WorkOrder>();

        try {

            for(sObject so : scope){
                WorkOrder OS = (WorkOrder) so;
                listaOrdemServico.add(OS);
            }

            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaOrdemServico: '+ listaOrdemServico);

            List<WorkOrder> listaAtualizar = new List<WorkOrder>();

            if(listaOrdemServico != null && listaOrdemServico.size() > 0) {
                listaAtualizar = Util_OS_Atualizar_Informacoes.atualizarInformacoesOS(listaOrdemServico);
            }

            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaAtualizar: '+ listaAtualizar);

            if(listaAtualizar != null && listaAtualizar.size() > 0) update listaAtualizar;

        } catch(Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());
        }
    } // Fim execute

    global void finish(Database.BatchableContext BC) {}
}