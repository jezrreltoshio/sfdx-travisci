@isTest
public class Valida_CNPJ_Account_Test {
    
   
    static testMethod void teste(){ 
        Account conta = new Account();
            conta.Name = 'Nome';
            conta.CNPJ__c = '43.347.806/0001-63';
            insert conta;
        
        
        Lead lead = new Lead();
            lead.LastName = 'Teste';
            lead.Company = 'Teste';
            lead.CNPJ__c = '43.347.806/0001-63';
            insert lead;
        
     }
}