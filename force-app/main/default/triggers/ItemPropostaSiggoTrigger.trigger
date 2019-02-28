trigger ItemPropostaSiggoTrigger on ItemPropostaSiggo__c (before insert, before update) {
    if (Trigger.isInsert) {
    	itemPropostaSiggoTriggers.vehicleBlocker(Trigger.new,'ins',null);
    } else if (Trigger.isUpdate) {
        itemPropostaSiggoTriggers.vehicleBlocker(Trigger.new,'upd',Trigger.old);
    }
}