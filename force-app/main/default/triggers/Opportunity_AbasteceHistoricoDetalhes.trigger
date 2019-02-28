/****************************************************************** 
 *CHANGE 24/02/2015 - Carlos Prates - DESATIVAR TRIGGER           *
 * Causa: Unificação de Triggers do Objeto Oportunidade           *
 * Motivo: Evitar que exceções causados por limites da ferramenta *
 * Alterações: Métodos enviados para trigger OpportunityTrigger   * 
 ******************************************************************/

trigger Opportunity_AbasteceHistoricoDetalhes on Opportunity (after insert, after update) {
    List<Opportunity> lstOpp = new List<Opportunity>();
 
 if(Trigger.isInsert){
  for(Opportunity o :trigger.new){
   //System.Debug('DEBUG OPP o.IdLeadForOpp__c: ' + o.IdLeadForOpp__c);
   if(o.IdLeadForOpp__c != null){
    lstOpp.add(o);
   }
  }
  
  System.Debug('DEBUG SIZE LIST OPP: ' + lstOpp.size());
  System.Debug('DEBUG ITENS LIST OPP: ' + lstOpp);
  
  if(lstOpp.size() > 0) OpportunityTriggers.ImportaHistoricoDetalhes(lstOpp);
 }
 
 if(Trigger.isUpdate){
  Map<String,String> mapNew = new Map<String, String>();
  for(Opportunity o :trigger.new){
   mapNew.put(o.Id, o.Description);
  }
  if(lstOpp.size() > 0) lstOpp.clear();
  for(Opportunity o :trigger.old){
   if(mapNew.containsKey(o.Id)){
    if(mapNew.get(o.Id) != o.description && o.description != null){
     lstOpp.add(o);
    }
   }
  }
  if(lstOpp.size() > 0) OpportunityTriggers.AbasteceHistoricoDetalhes(lstOpp);
 }
}