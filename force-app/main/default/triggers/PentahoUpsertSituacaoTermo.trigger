trigger PentahoUpsertSituacaoTermo on Situacao_do_Termo__c (before insert) {
    Boolean b = false;
    List<Situacao_do_Termo__c> frota = Trigger.new;
    
    if(Trigger.isInsert){b = true;}
    ProjetoCRM.pentahoUpsertSituacaoTermo(frota, b);
}