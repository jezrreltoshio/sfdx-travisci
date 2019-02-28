trigger Lead_AbasteceHistoricoDetalhes on Lead (after update) {
 
 Map<String,String> mapNew = new Map<String, String>();
 for(Lead l :trigger.new){
  mapNew.put(l.Id, l.Description);
 }
 
 List<Lead> lstLead = new List<Lead>();
 for(Lead l :trigger.old){
  if(mapNew.containsKey(l.Id)){
   if(mapNew.get(l.Id) != l.description && l.description != null){
    lstLead.add(l);
   }
  }
 }
 
 if(lstLead.size() > 0) LeadTriggers.AbasteceHistoricoDetalhes(lstLead);
}