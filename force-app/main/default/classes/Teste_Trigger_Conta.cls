/*
    Classe de testes para a Trigger "Trigger_Conta"

    Criado por: Mario Reis
    Data: 25/08/2017

*/
@isTest
public class Teste_Trigger_Conta {

    /*
        @author Renan Rocha
        @date 11/01/2019
    */
    static testMethod void teste(){
        Triggers__c trigg = new Triggers__c();
        trigg.Trigger_conta__c = true;
        insert trigg;
        
        Map<String, sObject> mapBase = Teste_Util.createMapBase();   
    }
}