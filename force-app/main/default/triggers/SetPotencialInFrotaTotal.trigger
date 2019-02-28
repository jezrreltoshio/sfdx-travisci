trigger SetPotencialInFrotaTotal on Frota_Potencial__c (after insert, after update) {
    system.debug('trigger - SetPotencialInFrotaTotal: '+Trigger.new[0].Conta__c) ;      
    ProjetoCRM.setPotencialInFrotaTotal(Trigger.new[0].Conta__c);
}