trigger OpportunityLineItem_Bloquear on OpportunityLineItem (before insert, before update, before delete) {
 List<OpportunityLineItem> lstOli = new List<OpportunityLineItem>();
 String perfil = [SELECT Name FROM Profile WHERE Id = :UserInfo.getProfileId()].Name;
 
 if(perfil != 'Administrador do sistema'){
  if(Trigger.isDelete){
   for(OpportunityLineItem oli :trigger.old){
    lstOli.add(oli);
   }
  }else{
   for(OpportunityLineItem oli :trigger.new){
    lstOli.add(oli);
   }
  }
  if(lstOli.size() > 0) OpportunityLineItemTriggers.Bloquear(lstOli);
 }
}