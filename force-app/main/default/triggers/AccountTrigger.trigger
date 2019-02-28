trigger AccountTrigger on Account (before update) {


    if(trigger.isInsert || trigger.isUpdate){   AccountTriggers.markLeadOrigin(trigger.new);    }

}