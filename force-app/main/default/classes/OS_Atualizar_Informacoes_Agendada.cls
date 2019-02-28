/*
    Classe de testes: Teste_OS_Atualizar_Informacoes
    Criado por: Mario Reis
    Data de criação: 11/06/2018
    Modificado por: Diego Medeiros
    Data de modificação: 20/06/2018
    Descrição: Classe agendada para atualizar informações da OS
    ---------------------------------
    @author Renan Rocha
    @date 05/12/2018
    @description Classe refatorada, novos debugs inseridos e alterado Query do método execute para buscar da DAO
    @JIRA KCA-86
    ---------------------------------
    @author Renan Rocha
    @date 18/12/2018
    @description Criado set no método execute para filtrar somente os históricos criados ou alterados na data atual, evitando assim, limite de CPU ou query
    @JIRA KCA-86
    ---------------------------------
    @author Renan Rocha
    @date 20/12/2018
    @description Inserido chamada para Helper que atualiza os Históricos ou Itens já utilizados nesta Schedulable
    @JIRA KCA-381
    ---------------------------------
    @author Renan Rocha
    @date 03/01/2019
    @description Alterado método execute para chamar nova batch Batch_Upd_OS que evita erros de limit de Query e CPU pois executa todas as ações na própria batch
    @JIRA KCA-381
*/
global class OS_Atualizar_Informacoes_Agendada implements Schedulable {
    private static String CLASS_NAME = 'OS_Atualizar_Informacoes_Agendada';

    global void scheduleIt() {
        String METHOD_NAME = 'scheduleIt';
        
        String hour = String.valueOf(Datetime.now().hour());
        String min = String.valueOf(Datetime.now().minute() + 1); 
        String ss = String.valueOf(Datetime.now().second());

        //parse to cron expression
        String nextFireTime = ss + ' ' + min + ' ' + hour + ' * * ?';
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - nextFireTime: '+ nextFireTime);

        OS_Atualizar_Informacoes_Agendada s = new OS_Atualizar_Informacoes_Agendada(); 
        System.schedule('Job OS_Atualizar_Informacoes_Agendada ' + String.valueOf(Datetime.now()), nextFireTime, s);        
    }

    global void execute(SchedulableContext SC) {
        String METHOD_NAME = 'execute';

        Database.executeBatch(new Batch_Upd_OS(null, 'Historico_OS__c'), 50);

        Database.executeBatch(new Batch_Upd_OS(null, 'Item_ordem_servico__c'), 50);
    } // Fim execute
}