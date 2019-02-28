trigger Account_updateRelatedContacts on Account (after update) {
    AccountTriggers.updateRelatedContacts(trigger.new);
}