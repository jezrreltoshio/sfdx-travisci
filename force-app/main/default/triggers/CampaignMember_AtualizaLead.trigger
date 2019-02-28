trigger CampaignMember_AtualizaLead on CampaignMember (after insert, after Delete) {
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

/* -- Processos enviados para a Classe CampaignMemberTriggers --
if(trigger.isInsert || trigger.isUpdate){
  Set<String> campanhaIds = new Set<String>();
  Set<String> leadIds = new Set<String>();
  for(CampaignMember cm :trigger.new){
   if(cm.CampaignId != null) campanhaIds.add(cm.CampaignId);
   if(cm.LeadId != null) leadIds.add(cm.LeadId);
  }
  Map<Id, Campaign> campanhaMap = new Map<Id, Campaign>([SELECT Id, Name FROM Campaign WHERE Id IN :campanhaIds]);
  Map<String,String> mapCM = new Map<String,String>();
  for(CampaignMember cm :trigger.new){
   mapCM.put(cm.LeadId, campanhaMap.get(cm.CampaignId).Name);
  }
  List<Lead> lstLead = [SELECT Id, Campanha__c FROM Lead WHERE Id IN :leadIds];
  for(Lead l : lstLead){
   if(mapCM.get(l.Id) != null) l.Campanha__c = mapCM.get(l.Id);
  }
  if(lstLead.size() > 0) update lstLead;
 }
 
 if(trigger.isDelete){
  Set<String> campanhaIds = new Set<String>();
  Set<String> leadIds = new Set<String>();
  for(CampaignMember cm :trigger.old){
   if(cm.CampaignId != null) campanhaIds.add(cm.CampaignId);
   if(cm.LeadId != null) leadIds.add(cm.LeadId);
  }
  Map<Id, Campaign> campanhaMap = new Map<Id, Campaign>([SELECT Id, Name FROM Campaign WHERE Id IN :campanhaIds]);
  Map<String,String> mapCM = new Map<String,String>();
  for(CampaignMember cm :trigger.old){
   if(campanhaMap.get(cm.CampaignId).Name != null) mapCM.put(cm.LeadId, campanhaMap.get(cm.CampaignId).Name);
  }
  List<Lead> lstLead = [SELECT Id, Campanha__c FROM Lead WHERE Id IN :leadIds];
  for(Lead l : lstLead){
   if(mapCM.get(l.Id) != null && l.Campanha__c == mapCM.get(l.Id)) l.Campanha__c = '';
  }
  if(lstLead.size() > 0) update lstLead;
 }
*/
}