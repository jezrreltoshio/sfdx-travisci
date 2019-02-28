trigger ItemPropostaSiggo_updateOwnerData on ItemPropostaSiggo__c (before insert, before update) {
	PCL_SIG_OpportunityProcess.updateOwnerData(Trigger.new);
}