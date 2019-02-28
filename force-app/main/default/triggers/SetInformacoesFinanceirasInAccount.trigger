trigger SetInformacoesFinanceirasInAccount on Situacao_Financeira__c (after insert, after update) {
    Account acc = new Account();
    acc.Id = Trigger.new[0].Conta__c;
    
    ProjetoCRM.setInformacoesFinanceirasInAccount(Trigger.new[0].Conta__c);
}