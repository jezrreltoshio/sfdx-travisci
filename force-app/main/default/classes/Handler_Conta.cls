/*
 * Classe de teste: Teste_Handler_Conta
 * Criado por: Mario Reis
 * Data de criação: 24/08/2017
 * Descrição: Classe responsável por realizar o tratamento da Trigger para o objeto Conta e direcionar para a funcionalidade correta
 * =====================================
 * Atualizado por: Mario Reis
 * Data da alteração: 14/03/2018
 * Descrição: Adicionado validação para não realizar busca de CEP quando ha alteração do usuário
 * 
 * 
 * Alteração: Rafael Silva
 * Data de alteração: 05/07/2018
 * Descrição: Correção de erros e unificação das triggers de Conta.
    ---------------------------------
    @author Renan Rocha
    @date 11/01/2019
    @description:
        - Classe refatorada
        - Novos debugs inseridos
        - Método verificacao direcionado à trigger juntos com suas chamadas de método
        - Adicionado método buscaCEP extraído de uma parte do método verificacao
        - Adicionado método verificaDuplicidadeCNPJ
    @JIRA KCA-410
*/

public class Handler_Conta {

    private static String CLASS_NAME = 'Handler_Conta';
    
    /*
        @description Atualiza o CEP da conta
        @param List<Account> pListaNew
        @return void
        
        @author Renan Rocha
        @date 11/01/2019
        @JIRA KCA-410
    */
    public static void buscaCEP(List<Account> pListaNew){
        String METHOD_NAME = 'buscaCEP';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - pListaNew: '+ pListaNew);

        List<Account> listaContaFilter = new List<Account>();

        for(Account forConta : pListaNew){
            if(forConta.BotaoAtualizaCEPEndPrincipal__c == true || forConta.BotaoAtualizaCEPEndEntrega__c == true || forConta.BotaoAtualizaCEPEndCobranca__c == true) listaContaFilter.add(forConta);
        }

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaContaFilter: '+ listaContaFilter);

        if(listaContaFilter.size() > 0) Service_Conta.buscaCEP(listaContaFilter);
    }

    /*
        @description Verifica se o CNPJ informado já não existe no mesmo tipo de registro
        @param List<Account> pListaNew, Map<Id, Account> pOldMap
        @return void
        
        @author Renan Rocha
        @date 11/01/2019
        @JIRA KCA-410
    */
    public static void verificaDuplicidadeCNPJ(List<Account> pListaNew, Map<Id, Account> pOldMap){
        String METHOD_NAME = 'verificaDuplicidadeCNPJ';

        for(Account forConta : pListaNew){
            if(String.isNotEmpty(forConta.CNPJ__c)){
                for(Account forContaDAO : DAO_Conta.getContasByCNPJERecordTypeId(forConta.CNPJ__c, forConta.RecordTypeId)){
                    if(forContaDAO.CNPJ__c == forConta.CNPJ__c && forContaDAO.Id != forConta.Id) forConta.addError(' ' + System.Label.LBL_002); //LBL_002: Não é possível criar ou atualizar a conta pois já existe uma com o mesmo CNPJ para este tipo de registro.
                }
            }
        }
    }
}