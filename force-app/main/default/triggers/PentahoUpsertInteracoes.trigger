trigger PentahoUpsertInteracoes on Interacoes__c (before insert){
    Boolean b = false;
    List<Interacoes__c> frota = Trigger.new;
    
    if(Trigger.isInsert){b = true;}
    ProjetoCRM.pentahoUpsertInteracoes(frota, b);   
}