public class QuoteLineItemTriggers{
 
 public static void PreenchePrazo(List<QuoteLineItem> lstQli){
  Set<String> setQuote = new Set<String>();
  Set<String> setOpp = new Set<String>();
  Map<String, String> mapOpp = new Map<String, String>();
  Map<String, OpportunityLineItem> mapOli = new Map<String, OpportunityLineItem>();
  
  for(QuoteLineItem qli :lstQli){
   setQuote.add(qli.QuoteId);
  }
  
  for(Quote q : [SELECT Id, OpportunityId FROM Quote WHERE Id IN :setQuote]){
   setOpp.add(q.OpportunityId);
   mapOpp.put(q.Id, q.OpportunityId); 
  }
  
  for(OpportunityLineItem oli: [SELECT Id, PricebookEntryId, Prazo_do_contrato2__c, OpportunityId, Opportunity.Name FROM OpportunityLineItem WHERE OpportunityId IN :setOpp]){
   mapOli.put(oli.PricebookEntryId, oli);
  }

  for(QuoteLineItem qli :lstQli){
   if(mapOli.containsKey(qli.PricebookEntryId) && mapOpp.get(qli.QuoteId) == mapOli.get(qli.PricebookEntryId).OpportunityId){
    qli.Prazo_do_contrato__c = mapOli.get(qli.PricebookEntryId).Prazo_do_contrato2__c;
   }
  } 
 }
 
 public static void Bloquear(List<QuoteLineItem> lstQli){
  Set<Id> quoteIds = new Set<Id>();
  Set<Id> oppIds = new Set<Id>();
  for(QuoteLineItem qli :lstQli){
   quoteIds.add(qli.QuoteId);
  }
  Map<String,String> mapQuoteOpp = new Map<String,String>();
  for(Quote q :[SELECT Id, Opportunity.Aprova_o__c FROM Quote WHERE Id IN :quoteIds AND Opportunity.Aprova_o__c = 'Aprovado']){
   mapQuoteOpp.put(q.Id, q.Opportunity.Aprova_o__c);
  }
  for(QuoteLineItem qli :lstQli){
   if(mapQuoteOpp.containsKey(qli.QuoteId)){
    if(mapQuoteOpp.get(qli.QuoteId) == 'Aprovado'){
     qli.addError(Label.MSG_ERRO_0042);
    }
   }
  }
 }
 
}