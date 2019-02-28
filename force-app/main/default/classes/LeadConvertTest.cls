@isTest
private class LeadConvertTest {

	public static Lead aLead;

	static{
		alead = new Lead(
			FirstName = 'FirstName',
			LastName = 'LastName',
			CNPJ__c = '88581816000105',
			Company = 'Company Test',
			Description = 'Descrição do Lead',
            Street = 'a',
            City = 'b',
            PostalCode = '09090909',
            Country = 'Brazil',
            Numero_endereco__c = 21,
            Complemento_endereco__c = 'Complementation',
            Bairro_endereco__c = 'Bairralasso',
			agregado__c = 'Não',
			Qual_empresa_esta_agregando__c = 'Empresa teste'
		);
		Insert alead;
	}
	
	@isTest 
	static void testConvertLead() {
		// existe formatacao de CNPJ em lead
		Id accId = LeadConvert.convertLead(alead.Id, '88.581.816/0001-05');
		
		Account acc = [SELECT CNPJ__c FROM Account WHERE Id =: accId];

		// resposta deve ser igual ao CNPJ do Lead
		System.assertEquals('88581816000105', acc.CNPJ__c);
	}
}