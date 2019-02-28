/*
	Classe de teste: Teste_Lead_Converter_Mexico
	Criado por: Mario Reis
	Data de criação: 19/12/2017
	Descrição: Classe Global utilizada no botão para converter o Lead
*/
global class Lead_Converter_Mexico{

	// Método que faz a conversão    
    webservice static String convertLead(Id leadId) {

        System.debug(LoggingLevel.ERROR, '__ [cls Lead_Converter_Mexico - convertLead()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Lead_Converter_Mexico - convertLead()] - leadId: '+leadId);

        try {

            Database.LeadConvert lc = new Database.LeadConvert();
            lc.setLeadId(leadId);
            lc.setOwnerId(UserInfo.getUserId());
    
            LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
            lc.setConvertedStatus(convertStatus.MasterLabel);
            lc.setDoNotCreateOpportunity(true);
    
            Database.LeadConvertResult lcr = Database.convertLead(lc);
    
            System.debug(LoggingLevel.ERROR, '__ [cls Lead_Converter_Mexico - convertLead()] - lcr: '+lcr);
    
            if(lcr.isSuccess()){
                return lcr.getAccountId();
            }

            return 'error';

        } catch (DmlException e){

            System.debug(LoggingLevel.ERROR, '__ [cls Lead_Converter_Mexico - convertLead()] - e.getDmlMessage(0): '+e.getDmlMessage(0));
            throw new DmlException(e.getDmlMessage(0)); 
        }
        

    } // Fim convertLead

}