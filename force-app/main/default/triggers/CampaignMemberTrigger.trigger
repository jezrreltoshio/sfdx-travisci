trigger CampaignMemberTrigger on CampaignMember (after insert, after Delete, after update) {
    List<CampaignMember> TriggerList = new List<CampaignMember>();
     
    if(Trigger.isDelete){
	    for(CampaignMember cm :trigger.old) TriggerList.add(cm);
    	if(TriggerList.size() > 0) CampaignMemberTriggers.AtualizaLead(TriggerList,true);
    }
    
    if(TriggerList.size() > 0) TriggerList.clear();
    if(Trigger.isInsert){
    	for(CampaignMember cm :trigger.new) TriggerList.add(cm);
    	if(TriggerList.size() > 0) CampaignMemberTriggers.AtualizaLead(TriggerList,false);
    }
    
    if(Trigger.isUpdate){
        for(CampaignMember cm :trigger.new) TriggerList.add(cm);
        if(TriggerList.size() > 0) CampaignMemberTriggers.UpdateCampaignMember(TriggerList);
    }
}