trigger Account_updateBillingAddress on Account (before insert, before update) {
    PCL_AccountProcess.updateBillingAddress(Trigger.new);
}