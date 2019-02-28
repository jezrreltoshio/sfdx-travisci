@isTest
public class AccountBuild {
    
    public static Account newAccount(){
        Account acc = new Account(
            Name = 'Teste',
            CPF__c = '838.130.090-84'
        );
        return acc;
    }

}