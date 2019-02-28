trigger Account_updateShippingAddress on Account (before insert, before update) {
    PCL_AccountProcess.updateShippingAddress(Trigger.new);
}