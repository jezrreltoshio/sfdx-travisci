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
    ---------------------------------
    @author Renan Rocha
    @date 15/02/2019
    @description:
        - Inserido novos debugs no método verificaDuplicidadeCNPJ
        - Retirado for e alterado para tratar somente um resultado por vez com o método
        - Adicionado try/catch no método verificaDuplicidadeCNPJ para tratamento de erros
        - Adicionado parâmetro pIsInsert para verificar se está sendo inserido e validações do CNPJ quando for alterado
    @JIRA KCA-549
    ---------------------------------
    @author Renan Rocha
    @date 18/02/2019
    @description Inserido verificação no método verificaDuplicidadeCNPJ para cobrir o cenário onde contas antigas são atualizadas mas o CNPJ manten-se o mesmo
    @JIRA KCA-549
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
        @param List<Account> pListaNew, Map<Id, Account> pOldMap, Boolean pIsInsert
        @return void
        
        @author Renan Rocha
        @date 11/01/2019
        @JIRA KCA-410
    */
    public static void verificaDuplicidadeCNPJ(List<Account> pListaNew, Map<Id, Account> pOldMap, Boolean pIsInsert){
        String METHOD_NAME = 'verificaDuplicidadeCNPJ';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - pListaNew: '+ pListaNew);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - pOldMap: '+ pOldMap);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - pIsInsert: '+ pIsInsert);

        for(Account forConta : pListaNew){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - forConta: '+ forConta);

            if(String.isNotEmpty(forConta.CNPJ__c)){
                try{
                    Account contaDAO = DAO_Conta.getContasByCNPJERecordTypeId(forConta.CNPJ__c, forConta.RecordTypeId, forConta.Id);
                    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - contaDAO: '+ contaDAO);
                    
                    if(contaDAO.RecordTypeId == forConta.RecordTypeId) forConta.addError(' ' + System.Label.LBL_002); //LBL_002: Não é possível criar ou atualizar a conta pois já existe uma com o mesmo CNPJ para este tipo de registro.
                }catch(Exception e){
                    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());
                }  
            }
        }
    }
}