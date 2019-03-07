/*
 * Classe de teste: Teste_Handler_Contato
 * Criado por: Mario Reis
 * Data de criação: 16/11/2017
 * Descrição: Classe responsável por realizar o tratamento da Trigger para o objeto Contato e
 * 			direcionar para a funcionalidade correta
 * 
 * Alteração: Rafael Silva
 * Data de alteração: 05/07/2018
 * Descrição: Correção de erros e unificação das triggers.
    ---------------------------------
    @author Renan Rocha
    @date 28/01/2019
    @description:
        - Classe refatorada
        - Novos debugs inseridos
        - Retirado método verificacao e direcionado chamadas na Trigger_Contato
        - Criado método buscaCEP
    @JIRA KCA-482
*/

public class Handler_Contato {

    private static String CLASS_NAME = 'Handler_Contato';

    /*
        @description Efetua o tratamento para chamar a verificação do CEP
        @param List<Contact> pListaContatoNew, Map<Id, Contact> pOldMap, Boolean pTriggerIsInsert
        @return void
        
        @author Renan Rocha
        @date 28/01/2019
        @JIRA KCA-482
    */
    public static void buscaCEP(List<Contact> pListaContatoNew, Map<Id, Contact> pOldMap, Boolean pTriggerIsInsert){
        String METHOD_NAME = 'buscaCEP';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - pListaContatoNew: '+ pListaContatoNew);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - pOldMap: '+ pOldMap);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - pTriggerIsInsert: '+ pTriggerIsInsert);

        List<Id> listaIdContatoFilter = new List<Id>();
        
        for(Contact forContato : pListaContatoNew){
            if(forContato.MailingPostalCode != null){
                if(pTriggerIsInsert) listaIdContatoFilter.add(forContato.Id);
                else if(forContato.MailingPostalCode != pOldMap.get(forContato.Id).MailingPostalCode) listaIdContatoFilter.add(forContato.Id);
            }
        }

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaIdContatoFilter: '+ listaIdContatoFilter);

        if(listaIdContatoFilter.size() > 0) Service_Contato.buscaCEP(listaIdContatoFilter);
    }
}