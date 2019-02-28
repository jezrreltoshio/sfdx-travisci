public class QuoteTriggers{
 public static void Bloquear(List<Quote> lstQuote, Boolean isDelete){
  Set<Id> oppIds = new Set<Id>();
  for(Quote q :lstQuote){
   oppIds.add(q.OpportunityId);
  }
  Map<Id,Opportunity> mapOpp = new Map<Id,Opportunity>([SELECT Id, Aprova_o__c FROM Opportunity WHERE Id IN :oppIds]);
  for(Quote q :lstQuote){
   if(isDelete){
    if(mapOpp.containsKey(q.OpportunityId)){
     if(mapOpp.get(q.OpportunityId).Aprova_o__c == 'Aprovado'){
      q.addError('A Oportunidade relacionada a este item já foi aprovada, portanto, este registro não pode ser excluído.');
     }
    }
   }else{
    // COMENTADO EM 06/03/2014 17:51 - Será usado posteriormente
    //if(mapOpp.containsKey(q.OpportunityId)){
    // if(mapOpp.get(q.OpportunityId).Aprova_o__c != 'Aprovado'){
    //  q.addError('Para criar uma Proposta, a Oportunidade relacionada deve estar Aprovada.');
    // }
    //}
   }
  }
 }
}