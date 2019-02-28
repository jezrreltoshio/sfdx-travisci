trigger Quote_Bloquear on Quote (before insert, before update, before delete) {
 List<Quote> lstQuote = new List<Quote>();
 Boolean isDelete;
 String perfil = [SELECT Name FROM Profile WHERE Id = :UserInfo.getProfileId()].Name;
 
 if(perfil != 'Administrador do sistema'){
  if(Trigger.isDelete){
   isDelete = true;
   for(Quote q :trigger.old){
    lstQuote.add(q);
   }
   if(lstQuote.size() > 0) QuoteTriggers.Bloquear(lstQuote, isDelete);
  }else{
   isDelete = false;
   if(lstQuote.size() > 0) lstQuote.clear();
   for(Quote q :trigger.new){
    lstQuote.add(q);
   }
   if(lstQuote.size() > 0) QuoteTriggers.Bloquear(lstQuote, isDelete);
  }
 } 
}