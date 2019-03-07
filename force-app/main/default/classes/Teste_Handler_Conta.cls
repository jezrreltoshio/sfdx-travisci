/*
    Classe de testes para a Classe "Handler_Conta"

    Criado por: Mario Reis
    Data: 05/09/2017

*/
@isTest
public class Teste_Handler_Conta {

    /*
        @author Renan Rocha
        @date 11/01/2019
    */
    static testMethod void buscaCEP(){
        Map<String, sObject> mapBase = Teste_Util.createMapBase();
        Account conta = (Account) mapBase.get('Account');
        conta.BotaoAtualizaCEPEndPrincipal__c = true;
        conta.Enderecos_Principal_CEP__c = '54090-111';
        update conta;

        Handler_Conta.buscaCEP(new List<Account>{conta});
    }

    /*
        @author Renan Rocha
        @date 11/01/2019
    */
    static testMethod void verificaDuplicidadeCNPJ(){
        Map<String, sObject> mapBase = Teste_Util.createMapBase();
        Account conta = (Account) mapBase.get('Account');
        conta.CNPJ__c = '';
        conta.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CORP').getRecordTypeId();
        update conta;

        Account conta2 = Teste_Util.newAccount();
        conta2.CNPJ__c = '30.022.945/0001-75';
        conta2.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CORP').getRecordTypeId();
        update conta2;

        Account conta3 = Teste_Util.newAccount();
        conta3.CNPJ__c = '30.022.945/0001-75';
        conta3.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('CORP').getRecordTypeId();
        update conta3;

        Handler_Conta.verificaDuplicidadeCNPJ(new List<Account>{conta, conta3}, new Map<Id, Account>{conta.Id => conta2}, true);
    }
}