public class CampaignMemberTriggers{

    public static void AtualizaLead(List<CampaignMember> TriggerList, Boolean isDelete){
        Set<String> campanhaIds = new Set<String>();
        Set<String> leadIds = new Set<String>();
        Map<String,String> mapCM = new Map<String,String>();
  
        if(!isDelete){
            for(CampaignMember cm :TriggerList){
                if(cm.CampaignId != null) campanhaIds.add(cm.CampaignId);
                if(cm.LeadId != null) leadIds.add(cm.LeadId);
            }
            Map<Id, Campaign> campanhaMap = new Map<Id, Campaign>([SELECT Id, Name FROM Campaign WHERE Id IN :campanhaIds]);
            for(CampaignMember cm :TriggerList){
                mapCM.put(cm.LeadId, campanhaMap.get(cm.CampaignId).Name);
            }
            List<Lead> lstLead = [SELECT Id, Campanha__c FROM Lead WHERE Id IN :leadIds];
            for(Lead l : lstLead){
                if(mapCM.get(l.Id) != null) l.Campanha__c = mapCM.get(l.Id);
            }
            if(lstLead.size() > 0) update lstLead;
        }else{
            for(CampaignMember cm :TriggerList){
                if(cm.CampaignId != null) campanhaIds.add(cm.CampaignId);
                if(cm.LeadId != null) leadIds.add(cm.LeadId);
            }
            Map<Id, Campaign> campanhaMap = new Map<Id, Campaign>([SELECT Id, Name FROM Campaign WHERE Id IN :campanhaIds]);
            for(CampaignMember cm :TriggerList){
                if(campanhaMap.get(cm.CampaignId).Name != null) mapCM.put(cm.LeadId, campanhaMap.get(cm.CampaignId).Name);
            }
            List<Lead> lstLead = [SELECT Id, Campanha__c FROM Lead WHERE Id IN :leadIds];
            for(Lead l : lstLead){
                if(mapCM.get(l.Id) != null && l.Campanha__c == mapCM.get(l.Id)) l.Campanha__c = '';
            }
            if(lstLead.size() > 0) update lstLead;
        }
    }
    
    public static void UpdateCampaignMember(List<CampaignMember> lstCM){
        Map<String,List<Membro_da_Campanha_vs_Lead__c>> mapCMvsLead = new Map<String,List<Membro_da_Campanha_vs_Lead__c>>();
        for(Membro_da_Campanha_vs_Lead__c cmStatus :[SELECT Id, Name, Tipo_da_Campanha__c, Status_do_membro_da_campanha__c, Status_do_Lead__c, Motivo_da_Desqualificacao__c FROM Membro_da_Campanha_vs_Lead__c]){
            if(!mapCMvsLead.containsKey(cmStatus.Tipo_da_Campanha__c)){
                mapCMvsLead.put(cmStatus.Tipo_da_Campanha__c, new List<Membro_da_Campanha_vs_Lead__c>());
            }
            mapCMvsLead.get(cmStatus.Tipo_da_Campanha__c).add(cmStatus);
        }
        
        Set<Id> campaignIds = new Set<Id>();
        Set<Id> leadIds = new Set<Id>();
        for(CampaignMember cm :lstCM){
            if(cm.CampaignId != null) campaignIds.add(cm.CampaignId);
            if(cm.LeadId != null) leadIds.add(cm.LeadId);
        }
        
        Map<Id, String> mapCampaignType = new Map<Id, String>(); 
        Map<Id, String> mapCampaignOwnerEmail = new Map<Id, String>(); 
        Map<Id, String> mapCampaignOwnerName = new Map<Id, String>(); 
        Map<Id, String> mapCampaignName = new Map<Id, String>();
        Set<String> setCampaignTypes = new set<String>();
        for(Campaign c :[SELECT Id, Type, RecordType.DeveloperName, Owner.Email, Owner.Name, Name FROM Campaign WHERE Id IN :campaignIds AND RecordType.DeveloperName IN :mapCMvsLead.keySet()]){
            //system.debug('CP Campanha: ' + c);
            if(c.RecordType.DeveloperName != null) mapCampaignType.put(c.Id, c.RecordType.DeveloperName);
            if(c.Owner.Email != null) mapCampaignOwnerEmail.put(c.Id,c.Owner.Email);
            if(c.Owner.Name != null) mapCampaignOwnerName.put(c.Id,c.Owner.Name);
            if(c.Name != null) mapCampaignName.put(c.Id,c.Name);
        }
    	
        Map<Id, Lead> mapLead = new Map<Id, Lead>([SELECT Id, Name, Status, Motivo_da_desqualifica_o_do_lead__c, Atualizacao_manual_de_motivo__c, Historico_Atualizacao_manual_de_motivo__c
                                 FROM Lead WHERE Id IN :leadIds]); 
        
        for(CampaignMember cm :lstCM){
            system.debug('CP mapCampaignType: ' + mapCampaignType);
            system.debug('CP mapCMvsLead: ' + mapCMvsLead);
            if(mapCampaignType.containsKey(cm.CampaignId)){
                if(mapCMvsLead.containsKey(mapCampaignType.get(cm.CampaignId)) && cm.LeadId != null){
                    Boolean containStatus = false;
                    for(Membro_da_Campanha_vs_Lead__c cmStatus :mapCMvsLead.get(mapCampaignType.get(cm.CampaignId))){
                        if(cm.Status == cmStatus.Status_do_membro_da_campanha__c){
                            if(mapLead.containsKey(cm.LeadId)){
                                Lead l = mapLead.get(cm.LeadId);
                                l.Status = cmStatus.Status_do_Lead__c;
                                l.Motivo_da_desqualifica_o_do_lead__c = cmStatus.Motivo_da_Desqualificacao__c;
                                //if(cm.Status == 'Não interessado em ouvir proposta'){
                                //    l.Atualizacao_manual_de_motivo__c = true;
                                //    l.Historico_Atualizacao_manual_de_motivo__c = true;
                                //}else{
                                //    l.Atualizacao_manual_de_motivo__c = false;
                                //    l.Historico_Atualizacao_manual_de_motivo__c = false;
                                //}
                                mapLead.put(l.Id,l);
                            }
                            containStatus = true;
                    	}
                    }
                    if(!containStatus){
                        if(mapCampaignOwnerEmail.containsKey(cm.CampaignId)){
                            String result = sendEmailAlert(mapCampaignOwnerEmail.get(cm.CampaignId), mapCampaignOwnerName.get(cm.CampaignId), mapLead.get(cm.LeadId).Name, mapCampaignName.get(cm.CampaignId));
                            if(result != '0') cm.addError(result);
                        }
                    }
                }
            }
        }
        if(mapLead.size() > 0) update mapLead.values();
    }
    
    private static String sendEmailAlert(String ownerEmail, String ownerName, String memberName, String campaignName) {
        //Value for return
        String result = '0';
        
        // Define the email
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        String addresses;
        addresses = ownerEmail;
        String[] toAddresses = addresses.split(':', 0);
        
        // Sets the paramaters of the email
        email.setSubject( 'Status de membro da campanha não definido no objeto "Membro da Campanha vs Lead".' );
        email.settoAddresses( toAddresses );
        email.setHtmlBody( 'Prezado '+ ownerName +',<br><br>O Membro da Campanha abaixo não possui o Status de Lead relacionado ao status de membro da campanha atual.<br><br>Membro: <b>'+ memberName +'</b><br>Campanha: <b>'+ campaignName +'</b>.<br><br>Solicite ao Administrador do Sistema que configure a relação deste Status de Membro da Campanha a um Status de Lead.<br><br>Atenciosamente' );
        
        // Sends the email
        try{
            Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});   
        }catch(Exception e){
            result = 'Erro no processo de envio: \n' + e;
        }
        return result;
    }
}