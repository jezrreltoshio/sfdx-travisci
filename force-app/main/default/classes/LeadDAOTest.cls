@isTest
private class LeadDAOTest {

	public static Lead aLead;

	static{

		alead = new Lead(
			FirstName = 'FirstName',
			LastName = 'LastName',
			CNPJ__c = '11.805.156/0001-66',
			Company = 'Company Test'
		);
		Insert alead;
	}
	
	@isTest 
	static void testGetLeadByCNPJ() {
		// existe formatacao de CNPJ em lead
		Lead lead = LeadDAO.getLeadByCNPJ('11.805.156/0001-66');
		// existe uppercase em nome de lead
		System.assertEquals('FIRSTNAME', lead.FirstName);
	}
	
	@isTest 
	static void testGetLeadById() {
		Lead lead = LeadDAO.getLeadById(alead.Id);
		// existe uppercase em nome de lead
		System.assertEquals('FIRSTNAME', lead.FirstName);
	}

	@isTest 
	static void testAllFields() {
		String fields = LeadDAO.allFields();
		// existe uppercase em nome de lead
		System.assert(fields.contains('FirstName'));
	}
	
}