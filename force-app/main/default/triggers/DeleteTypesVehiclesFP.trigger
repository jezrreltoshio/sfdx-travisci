trigger DeleteTypesVehiclesFP on Frota_Potencial__c (after delete) {
    Id accId = Trigger.old[0].Conta__c;    
    ProjetoCRM.deleteTypesVehicles(accId, Trigger.old[0].Tipo_de_ve_culo__c);
    ProjetoCRM.setPotencialInFrotaTotal(accId);
    ProjetoCRM.setSascarInFrotaTotal(accId);
    ProjetoCRM.setBlankInAccountFields(accId);
    //ProjetoCRM.setTotalFrotaInAccount(accId);
}