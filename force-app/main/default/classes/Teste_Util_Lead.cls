/*
	Criado por: Mario Reis
	Data de criação: 02/10/2017
	Descrição: Classe com métodos para criar registros relacionados ao Lead
					para apoio as classes de teste
*/

@isTest
public class Teste_Util_Lead {

    // Método para retornar o lead do tipo Mercosul Pessoa Fisica
    public static Lead criaLeadMercosulDNI(String idTipoRegistro, String DNI){

        Lead lead = new Lead();
		lead.RecordTypeId = idTipoRegistro;
        lead.FirstName = 'Nome Mercosul';
        lead.LastName = 'Sobrenome Mercosul';
        lead.Status = 'Em aberto';
        lead.Company = 'Empresa';
        lead.DNI__c = DNI;
        lead.Tipo_de_pessoa__c = 'F-Física';
        lead.Canal_de_entrada__c = 'Ativo';
        lead.LeadSource = 'Facebook';

        insert lead;
        return lead;

    } // Fim método criaLeadMercosulDNI

    
    // Método para retornar a lead do tipo Mercosul Pessoa Juridca
    public static Lead criaLeadMercosulCUIT(String idTipoRegistro, String CUIT){

        Lead lead = new Lead();
		lead.RecordTypeId = idTipoRegistro;
        lead.FirstName = 'Nome Mercosul';
        lead.LastName = 'Sobrenome Mercosul';
        lead.Status = 'Em aberto';
        lead.Company = 'Empresa';
        lead.CUIT__c = CUIT;
        lead.Tipo_de_pessoa__c = 'J-Jurídica';
        lead.Canal_de_entrada__c = 'Ativo';
        lead.LeadSource = 'Facebook';
        lead.Country = 'Argentina';
        lead.agregado__c = 'Não';
        lead.Qual_empresa_esta_agregando__c = 'Empresa teste';

        insert lead;
        return lead;

    } // Fim método criaLeadMercosulCUIT


    // Método para retornar a lead do tipo Cargo Tracck Pessoa Fisica
    public static Lead criaLeadCargoTracckF(String idTipoRegistro, String CPF){

        Lead lead = new Lead();
		lead.RecordTypeId = idTipoRegistro;
        lead.FirstName = 'Nome Cargo Tracck';
        lead.LastName = 'Sobrenome Cargo Tracck';
        lead.Status = 'Em aberto';
        lead.Company = 'Empresa';
        lead.CPF__c = CPF;
        lead.Tipo_de_pessoa__c = 'F-Física';
        lead.Canal_de_entrada__c = 'Ativo';
        lead.LeadSource = 'Facebook';
        lead.Country = 'Brasil';

        insert lead;
        return lead;

    } // Fim método criaLeadCargoTracckF



    // Método para retornar a lead do tipo Cargo Tracck Pessoa Juridica
    public static Lead criaLeadCargoTracckJ(String idTipoRegistro, String CNPJ){

        Lead lead = new Lead();
		lead.RecordTypeId = idTipoRegistro;
        lead.FirstName = 'Nome Cargo Tracck';
        lead.LastName = 'Sobrenome Cargo Tracck';
        lead.Status = 'Em aberto';
        lead.Company = 'Empresa';
        lead.CNPJ__c = CNPJ;
        lead.Tipo_de_pessoa__c = 'J-Jurídica';
        lead.Canal_de_entrada__c = 'Ativo';
        lead.LeadSource = 'Facebook';
        lead.Country = 'Brasil';

        insert lead;
        return lead;

    } // Fim método criaLeadCargoTracckJ



    // Método para retornar a lead do tipo CORP
    public static Lead criaLeadCORP(String idTipoRegistro, String CNPJ){

        Lead lead = new Lead();
		lead.RecordTypeId = idTipoRegistro;
        lead.FirstName = 'Nome CORP';
        lead.LastName = 'Sobrenome Car';
        lead.Status = 'Em aberto';
        lead.Company = 'Empresa';
        lead.CNPJ__c = CNPJ;
        lead.Tipo_de_pessoa__c = 'J-Jurídica';
        lead.Canal_de_entrada__c = 'Ativo';
        lead.LeadSource = 'Facebook';
        lead.Country = 'Brasil';

        insert lead;
        return lead;

    } // Fim método criaLeadCargoTracckJ



    // Método para retornar a lead do tipo Bluetec Pessoa Fisica
    public static Lead criaLeadBluetecF(String idTipoRegistro, String CPF){

        Lead lead = new Lead();
		lead.RecordTypeId = idTipoRegistro;
        lead.FirstName = 'Nome Bluetec';
        lead.LastName = 'Sobrenome Bluetec';
        lead.Status = 'Em aberto';
        lead.Company = 'Empresa';
        lead.CPF__c = CPF;
        lead.Tipo_de_pessoa__c = 'F-Física';
        lead.Canal_de_entrada__c = 'Ativo';
        lead.LeadSource = 'Facebook';
        lead.Country = 'Brasil';

        insert lead;
        return lead;

    } // Fim método criaLeadBluetecF



    // Método para retornar a lead do tipo Bluetec Pessoa Juridica
    public static Lead criaLeadBluetecJ(String idTipoRegistro, String CNPJ){

        Lead lead = new Lead();
		lead.RecordTypeId = idTipoRegistro;
        lead.FirstName = 'Nome Bluetec';
        lead.LastName = 'Sobrenome Bluetec';
        lead.Status = 'Em aberto';
        lead.Company = 'Empresa';
        lead.CNPJ__c = CNPJ;
        lead.Tipo_de_pessoa__c = 'J-Jurídica';
        lead.Canal_de_entrada__c = 'Ativo';
        lead.LeadSource = 'Facebook';
        lead.Country = 'Brasil';

        insert lead;
        return lead;

    } // Fim método criaLeadBluetecJ



    // Método para retornar a lead do tipo Bluetec Pessoa Fisica
    public static Lead criaLeadSiggo(String idTipoRegistro, String CPF){

        Lead lead = new Lead();
		lead.RecordTypeId = idTipoRegistro;
        lead.FirstName = 'Nome Siggo';
        lead.LastName = 'Sobrenome Siggo';
        lead.Status = 'Em aberto';
        lead.Company = 'Empresa';
        lead.CPF__c = CPF;
        lead.Tipo_de_pessoa__c = 'F-Física';
        lead.Canal_de_entrada__c = 'Ativo';
        lead.LeadSource = 'Facebook';
        lead.Country = 'Brasil';

        insert lead;
        return lead;

    } // Fim método Siggo



    // Método para retornar o lead do tipo FRETEIRO Pessoa Fisica
    public static Lead criaLeadFreteiroF(String idTipoRegistro, String CPF){

        Lead lead = new Lead();
		lead.RecordTypeId = idTipoRegistro;
        lead.FirstName = 'Nome Freteiro';
        lead.LastName = 'Sobrenome Freteiro';
        lead.Status = 'Em aberto';
        lead.Company = 'Empresa';
        lead.Tipo_de_pessoa__c = 'F-Física';
        lead.CNPJ_CPF__c = CPF;
        lead.Phone = '(41) 9999-9999';
        lead.Telefone_2__c = '(41) 9999-9999';
        lead.Telefone_3__c = '(41) 9999-9999';
        lead.Canal_de_entrada__c = 'Ativo';
        lead.LeadSource = 'Facebook';
        lead.Country = 'Brasil';

        insert lead;
        return lead;

    } // Fim método criaLeadFreteiroF



    // Método para retornar o lead do tipo Michelin Pessoa Fisica
    public static Lead criaLeadMichelin(String idTipoRegistro, String CNPJ){

        Lead lead = new Lead();
		lead.RecordTypeId = idTipoRegistro;
        lead.FirstName = 'Nome Michelin';
        lead.LastName = 'Sobrenome Michelin';
        lead.Status = 'Em aberto';
        lead.Company = 'Empresa';
        lead.CNPJ_CPF__c = CNPJ;
        lead.Phone = '(41) 9999-9999';
        lead.Telefone_2__c = '(41) 9999-9999';
        lead.Telefone_3__c = '(41) 9999-9999';
        lead.Canal_de_entrada__c = 'Ativo';
        lead.LeadSource = 'Facebook';
        lead.Country = 'Brasil';

        insert lead;
        return lead;

    } // Fim método criaLeadMichelin
    

}