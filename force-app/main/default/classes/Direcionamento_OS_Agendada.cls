/*
    Classe de testes: Teste_Direcionamento_OS_Agendada
    Criado por: Mario Reis
    Data de criação: 28/05/2018
    Descrição: Classe agendada que faz o direcionamento automatico das OS
    ----------------------------------------------------------------------
    ---------------------------------
    @author Renan Rocha
    @date 07/01/2019
    @description:
        - Classe refatorada
        - Novos debugs inseridos
        - Alterado método execute para efetuar a query diretamente na Batch, evitando assim limites ou erros
    @JIRA KCA-59
*/

global class Direcionamento_OS_Agendada implements Schedulable {

    private static String CLASS_NAME = 'Direcionamento_OS_Agendada';

    // Metodo que será executado ao rodar o agendamento
    global void execute(SchedulableContext SC) {   
        String METHOD_NAME = 'execute';

        // Cria o batch e executa uma configuração de cada vez
        Database.executeBatch(new Direcionamento_OS_Batch(null), 1);
    } // Fim direcionarOS
}