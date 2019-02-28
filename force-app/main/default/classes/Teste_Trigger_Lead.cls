/*
    Classe de testes para a Trigger "Trigger_Lead"

    Criado por: Mario Reis
    Data: 02/10/2017

*/
@isTest
public class Teste_Trigger_Lead{

    /*
        @author Renan Rocha
        @date 16/11/2018
    */
    static testMethod void teste(){
        Triggers__c confTrigger = new Triggers__c();
        confTrigger.Trigger_lead__c = true;
        insert confTrigger;

        Id mercosulId = Schema.getGlobalDescribe().get('Lead').getDescribe().getRecordTypeInfosByName().get('Mercosul').getRecordTypeId();

        Lead lead = Teste_Util_Lead.criaLeadMercosulCUIT(mercosulId, '27-28081114-4');
    }
}