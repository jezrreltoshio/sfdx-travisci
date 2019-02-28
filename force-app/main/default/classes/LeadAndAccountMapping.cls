public class LeadAndAccountMapping {
	
	private static final LeadAndAccountMapping instance = new LeadAndAccountMapping();
	
	private LeadAndAccountMapping(){}
	
	public static LeadAndAccountMapping getInstance(){
        return instance;
    }
		
    public Lead accountToLeadMapping(Account acc){
    	
        Lead lead = new Lead();
        
		lead.CEP_sg__c = acc.Enderecos_Principal_CEP__c;
		lead.Logradouro_sg__c = acc.Enderecos_Principal_Logradouro__c;
		lead.Cidade_sg__c = acc.Enderecos_Principal_Cidade__c;
		lead.Numero_sg__c = acc.Enderecos_Principal_Numero__c;
		lead.UF_sg__c = acc.Enderecos_Principal_UF__c;
		lead.Complemento_sg__c = acc.Enderecos_Principal_Complemento__c;
		lead.Codigo_municipio__c = acc.Codigo_municipio_principal__c;
		lead.Bairro_sg__c = acc.Enderecos_Principal_Bairro__c;
		lead.Description = acc.Description;
		lead.CNPJ__c = acc.CNPJ__c;

        return lead;
    }
    
    public Account leadToAccountMapping(Lead lead, Id accId){
    	
        Account acc = new Account(Id = accId);
        
		acc.Enderecos_Principal_CEP__c = lead.PostalCode;
		acc.Enderecos_Principal_Logradouro__c = lead.Street;
		acc.Enderecos_Principal_Cidade__c = lead.City;
		acc.Enderecos_Principal_Numero__c = lead.Numero_endereco__c;
		acc.Enderecos_Principal_UF__c = lead.State;
		acc.Enderecos_Principal_Complemento__c = lead.Complemento_endereco__c;
		acc.Codigo_municipio_principal__c = lead.Codigo_municipio__c;
		acc.Enderecos_Principal_Bairro__c = lead.Bairro_endereco__c;
		acc.Name = buildNameAccount(lead.FirstName, lead.LastName);
		acc.Description = lead.Description;
		acc.Enderecos_Principal_Pais__c = lead.Country;
		acc.CNPJ__c = lead.CNPJ__c;
		acc.Indicador__c = lead.Indicador__c;

        return acc;
    }

    private String buildNameAccount(String firstName, String lastName){
    	return !String.isEmpty(firstName) ? firstName + ' ' + lastName : lastName;
    }
    
    public Contact leadToContactMapping(Lead lead, Id contactId){
    	
    	Contact contato = new Contact(Id = contactId);
    	
    	contato.RG__c = lead.RG_sg__c;
    	contato.CPF__c = lead.CPF__c;
    	contato.FirstName = lead.FirstName;
    	contato.LastName = lead.LastName;
    	
    	return contato;
    }
}