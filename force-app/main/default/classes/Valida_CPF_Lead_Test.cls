@isTest
public class Valida_CPF_Lead_Test {

    static testMethod void teste(){ 
        Account conta = new Account();
            conta.Name = 'Nome';
            conta.CPF__c = '876.308.765-05';
            insert conta;
        
        
        Lead lead = new Lead();
            lead.LastName = 'Teste';
            lead.Company = 'Teste';
            lead.CPF__c = '876.308.765-05';
            insert lead;
        
     }
}