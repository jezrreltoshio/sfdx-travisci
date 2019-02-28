trigger SetSascarInFrotaTotal on Frota_Potencial__c (after insert, after update) {    
    ProjetoCRM.setSascarInFrotaTotal(Trigger.new[0].Conta__c);
}