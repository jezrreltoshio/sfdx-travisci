trigger DeleteTypesVehicles on Frota_Total__c (after insert, after update) {
    Id accId = Trigger.new[0].Conta__c;    
    //ProjetoCRM.deleteTypesVehicles(accId);
}