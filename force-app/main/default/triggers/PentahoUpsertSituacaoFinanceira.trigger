trigger PentahoUpsertSituacaoFinanceira on Situacao_Financeira__c(before insert) {
    Boolean b = false;
    List<Situacao_Financeira__c> frota = Trigger.new;
        
    if(Trigger.isInsert){b = true;}
    ProjetoCRM.pentahoUpsertSituacaoFinanceira(frota, b);
}