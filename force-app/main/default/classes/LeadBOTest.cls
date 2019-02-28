@isTest
private class LeadBOTest {

    private static testMethod void createLead() {
        Map<String, sObject> mapBase = Teste_Util.createMapBase();
		Lead lead = (Lead) mapBase.get('Lead');
		lead.agregado__c = 'Não';
		lead.CNPJ__c = '65.398.444/0001-72';
		lead.Qual_empresa_esta_agregando__c = 'Empresa teste';
		update lead;

        Test.startTest();
			Database.LeadConvert lc = new Database.LeadConvert();
			lc.setLeadId(lead.Id);

			LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted = true LIMIT 1];
			lc.setConvertedStatus(convertStatus.MasterLabel);

			Database.LeadConvertResult lcr = Database.convertLead(lc);
			System.assert(lcr.isSuccess());  
        Test.stopTest();
	}
}