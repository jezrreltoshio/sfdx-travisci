public with sharing class AccountDAO {
	
	public AccountDAO() {}
	
    public static Account getAccountByCNPJ(String cnpj) {
		
		String query = 'SELECT ' + allFields() +
			' FROM Account ' + 
			' WHERE CNPJ__c = \'' + cnpj + '\'' +
			' LIMIT 1';
			
		System.debug('***QUERY: '+query);
		
		List<Account> accList = Database.Query(query);
		
		if(accList.isEmpty()){
			return null;
		}
        
        return accList[0];
		
	}
	
	public static String allFields(){
		
		String allFields = 'Enderecos_Principal_CEP__c, Enderecos_Principal_Logradouro__c, Name, ' + 
		'Enderecos_Principal_Cidade__c, Enderecos_Principal_Numero__c, Enderecos_Principal_UF__c, ' + 
		'Enderecos_Principal_Complemento__c, Codigo_municipio_principal__c, Enderecos_Principal_Bairro__c, ' +
		'Description, CNPJ__c';
		
		return allFields;
	}
	
}