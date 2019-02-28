@isTest
private class LeadAndAccountMappingTest {

	public static Lead aLead;
	public static Account acc;
	public static Contact con;

	static{

		acc = new Account(
			Name = 'Test Name Account',
			Description = 'Descrição da Conta'
		);
		Insert acc;

		con = new Contact(
			FirstName = 'Contato',
			LastName = 'Sobrenome',
			Description = 'Descrição do Contato'
		);
		Insert con;

		alead = new Lead(
			FirstName = 'FirstName',
			LastName = 'LastName',
			CNPJ__c = '11805156000166',
			Company = 'Company Test',
			Description = 'Descrição do Lead'
		);
		Insert alead;
	}
	
	@isTest 
	static void testAccountToLeadMapping() {
		// existe formatacao de CNPJ em lead
		Lead lead = LeadAndAccountMapping.getInstance().accountToLeadMapping(acc);
		// existe uppercase em nome de lead
		System.assertEquals(acc.Description, lead.Description);
	}

	@isTest 
	static void testLeadToAccountMapping() {
		// existe formatacao de CNPJ em lead
		Account conta = LeadAndAccountMapping.getInstance().leadToAccountMapping(aLead, acc.Id);
		// existe uppercase em nome de lead
		System.assertEquals(aLead.Description, conta.Description);
	}

	@isTest 
	static void testLeadToContactMapping() {
		// existe formatacao de CNPJ em lead
		Contact contato = LeadAndAccountMapping.getInstance().leadToContactMapping(aLead, con.Id);
		// existe uppercase em nome de lead
		System.assertEquals(aLead.FirstName, contato.FirstName);
	}
	
}