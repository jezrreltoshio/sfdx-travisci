global class LeadConvert {
    
    webservice static String convertLead(Id leadId, String cnpj) {

        Database.LeadConvert lc = new Database.LeadConvert();
        lc.setLeadId(leadId);
        lc.setOwnerId(UserInfo.getUserId());

        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        lc.setConvertedStatus(convertStatus.MasterLabel);

        Database.LeadConvertResult lcr = Database.convertLead(lc);
        
        if(lcr.isSuccess()){
            return lcr.getAccountId();
        }

        return 'Erro ao converter o Lead.';
        
    }
    
}