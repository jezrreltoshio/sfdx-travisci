trigger PentahoUpsertSetAccount on Frota_Total__c (before insert) {
    Boolean b = false;    
    if(Trigger.isInsert){b = true;}
    
    ProjetoCRM.pentahoUpsertSetAccount(Trigger.new, b);
}