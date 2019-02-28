trigger PentahoUpsertInFrotaSascar on Frota_Sascar__c (before insert) {
    Boolean b = false;    
    if(Trigger.isInsert){b = true;}
    
    ProjetoCRM.pentahoUpsertInFrotaSascar(Trigger.new, b);
}