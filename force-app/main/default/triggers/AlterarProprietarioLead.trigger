trigger AlterarProprietarioLead on Lead (after update, before update) {
    for (Lead ld : Trigger.new) {
    
        Id profileId = userinfo.getProfileId();
        String profileName = [Select Id,Name from Profile where Id=:profileId].Name;
        system.debug('ProfileName'+profileName);
    
         if( ld.IsConverted == false && 
             (ProfileName == 'Novo Siggo' || 
              ProfileName == 'Novo Siggo - Parcela 10x' ||
              ProfileName == 'Siggo' ||
              ProfileName == 'Siggo (com acesso remoto)' ||
              ProfileName == 'Siggo Indicador') && 
                          (ld.idproprietario__c == '00e400000017Qdq' || 
                           ld.idproprietario__c == '00e400000017bl6' ||
                           ld.idproprietario__c == '00e40000001FZPW' ||
                           ld.idproprietario__c == '00e400000017cB4' ||
                           ld.idproprietario__c == '00e400000017cOX') &&
                           (ld.OwnerId != Trigger.oldMap.get(ld.Id).OwnerId)
                           ){
             ld.addError('Você pode apenas transferir leads para Filas'); 
         }
   }
}