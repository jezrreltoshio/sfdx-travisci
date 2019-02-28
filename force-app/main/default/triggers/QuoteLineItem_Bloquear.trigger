trigger QuoteLineItem_Bloquear on QuoteLineItem (before update, before delete) {
 List<QuoteLineItem> lstQli = new List<QuoteLineItem>();
 String perfil = [SELECT Name FROM Profile WHERE Id = :UserInfo.getProfileId()].Name;
 
 if(perfil != 'Administrador do sistema'){
  if(Trigger.isDelete){
   for(QuoteLineItem qli :trigger.old){
    lstQli.add(qli);
   }
  }else{
   for(QuoteLineItem qli :trigger.new){
    lstQli.add(qli);
   }
  }
 if(lstQli.size() > 0) QuoteLineItemTriggers.Bloquear(lstQli);
 }
}