public with sharing class LeadDAO {
	
	public static Lead getLeadByCNPJ(String cnpj){
		
        String query = 'SELECT ' + allFields() + 
			' FROM Lead' + 
			' WHERE CNPJ__c = \'' + cnpj + '\'' + 
			' LIMIT 1';

		System.debug('***QUERY: '+query);

		List<Lead> leadList = Database.Query(query);
		
		if(leadList.isEmpty()){
			return null;
		}
        
        return leadList[0];
		
	}

	public static Lead getLeadById(Id leadId){
		
        String query = 'SELECT ' + allFields() + 
			' FROM Lead' + 
			' WHERE Id = \'' + leadId + '\'' + 
			' LIMIT 1';

		System.debug('***QUERY: '+query);

		List<Lead> leadList = Database.Query(query);
		
		if(leadList.isEmpty()){
			return null;
		}
        
        return leadList[0];
		
	}
	
	public static String allFields(){
		
		String allFields = 'CEP_sg__c, Logradouro_sg__c, Cidade_sg__c, Numero_sg__c, UF_sg__c, ' + 
		'Complemento_sg__c, Codigo_municipio__c, Bairro_sg__c, Description, Name, Street, City, PostalCode, ' +
		'Numero_endereco__c, State, Complemento_endereco__c, Bairro_endereco__c, RG_sg__c, CPF__c, Country, ' +
		'FirstName, LastName, CNPJ__c, RecordType.DeveloperName, ' +
		'Indicador__c';
		
		return allFields;
	}

	
}