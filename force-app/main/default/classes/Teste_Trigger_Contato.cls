/*
    Classe de testes para a Trigger "Trigger_Contato"

    Criado por: Mario Reis
    Data: 08/12/2017

*/
@isTest
public class Teste_Trigger_Contato {

    /*
        @author Renan Rocha
        @date 28/01/2019
    */
    static testMethod void teste(){
        Triggers__c confTriggers = Teste_Util_Configuracao.criarConfiguracaoTriggers();
        confTriggers.Trigger_contato__c = true;
        update confTriggers;

        Map<String, sObject> mapBase = Teste_Util.createMapBase();
    }
}