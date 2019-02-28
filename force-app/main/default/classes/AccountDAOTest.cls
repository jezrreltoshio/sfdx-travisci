@isTest
private class AccountDAOTest {

	public static Account acc;

	static{

		acc = new Account(
			Name = 'Name',
			CNPJ__c = '71453355000184',
            Circuito__c = '2', 
            Cadencia__c = '2'
		);
		Insert acc;
	}
	
	@isTest 
	static void testGetAccountByCNPJ() {
        
        acc = new Account(
			Name = 'Name',
			CNPJ__c = '71453355000184',
            Circuito__c = '2', 
            Cadencia__c = '2'
		);
		Insert acc;
        System.debug('acc.Id'+acc.Id+'acc.CNPJ__c'+acc.CNPJ__c);
        
		// existe formatacao de CNPJ em Account
		Account conta = new Account();
        conta = AccountDAO.getAccountByCNPJ('71453355000184');
		// existe uppercase em nome de Account
		System.debug('conta'+conta);
		System.assertEquals('NAME', conta.Name);
	}
	
	@isTest 
	static void testAllFields() {
		String fields = AccountDAO.allFields();
		// existe uppercase em nome de Account
		System.assert(fields.contains('Name'));
	}
	
}