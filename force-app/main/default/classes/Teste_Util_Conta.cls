/*
	Criado por: Mario Reis
	Data de criação: 25/08/2017
	Descrição: Classe com métodos para criar registros relacionados a Conta
					para apoio as classes de teste
*/
@isTest
public class Teste_Util_Conta {

	// Método para retornar a conta do tipo Bluetec Pessoa Fisica
    public static Account criaContaBluetecF(String idTipoRegistro, String CPF){

        Account conta = new Account();
		conta.RecordTypeId = idTipoRegistro;
        conta.Type = 'Corretora';
        conta.Name = 'Conta Bluetec teste';
        conta.Nome_fantasia__c = 'Conta Bluetec teste';
        conta.Tipo_de_pessoa__c = 'F-Física';
        conta.Ramo_de_Atividade__c = 'Cegonheiro';
        conta.CPF__c = CPF;
        conta.Circuito__c = '2';
        conta.Cadencia__c = '6';
        conta.TelefoneCelular__c = '(41) 9999-9999';
        conta.Phone = '(41) 9999-9999';
        conta.EMail__c = 'conta@teste.com.br';
        conta.EMailNFE__c = 'conta@teste.com.br';
        conta.Enderecos_Cobranca_UF__c = 'PR';
        conta.Enderecos_Cobranca_Cidade__c = 'Curitiba';

        insert conta;
        return conta;
    } // Fim método criaContaBluetecF


    // Método para retornar a conta do tipo Bluetec Pessoa Juridica
    public static Account criaContaBluetecJ(String idTipoRegistro, String CNPJ){

        Account conta = new Account();
		conta.RecordTypeId = idTipoRegistro;
        conta.Type = 'Corretora';
        conta.Name = 'Conta Bluetec teste';
        conta.Nome_fantasia__c = 'Conta Bluetec teste';
        conta.Tipo_de_pessoa__c = 'J-Jurídica';
        conta.Ramo_de_Atividade__c = 'Cegonheiro';
        conta.CNPJ__c = CNPJ;
        conta.Circuito__c = '2';
        conta.Cadencia__c = '6';
        conta.TelefoneCelular__c = '(41) 9999-9999';
        conta.Phone = '(41) 9999-9999';
        conta.EMail__c = 'conta@teste.com.br';
        conta.EMailNFE__c = 'conta@teste.com.br';
        conta.Enderecos_Cobranca_UF__c = 'PR';
        conta.Enderecos_Cobranca_Cidade__c = 'Curitiba';

        insert conta;
        return conta;
    } // Fim método criaContaBluetecJ


    // Método para retornar a conta do tipo Cargo Tracck Pessoa Fisica
    public static Account criaContaCargoTracckF(String idTipoRegistro, String CPF){

        Account conta = new Account();
		conta.RecordTypeId = idTipoRegistro;
        conta.Type = 'Seguradora';
        conta.Name = 'Conta Cargo Tracck teste';
        conta.Nome_fantasia__c = 'Conta Cargo Tracck teste';
        conta.Tipo_de_pessoa__c = 'F-Física';
        conta.Ramo_de_Atividade__c = 'Aeroportos';
        conta.CPF__c = CPF;
        conta.Cadencia__c = '8';
        conta.TelefoneCelular__c = '(41) 9999-9999';
        conta.Phone = '(41) 9999-9999';
        conta.Telefone_2__c = '(41) 9999-9999';
        conta.EMail__c = 'conta@teste.com.br';
        conta.EMailNFE__c = 'conta@teste.com.br';

        insert conta;
        return conta;
    } // Fim método criaContaCargoTracckF


	// Método para retornar a conta do tipo Cargo Tracck Pessoa Juridica
    public static Account criaContaCargoTracckJ(String idTipoRegistro, String CNPJ){

        Account conta = new Account();
		conta.RecordTypeId = idTipoRegistro;
        conta.Type = 'Seguradora';
        conta.Name = 'Conta Cargo Tracck teste';
        conta.Nome_fantasia__c = 'Conta Cargo Tracck teste';
        conta.Tipo_de_pessoa__c = 'J-Jurídica';
        conta.Ramo_de_Atividade__c = 'Aeroportos';
        conta.CNPJ__c = CNPJ;
        conta.Cadencia__c = '8';
        conta.TelefoneCelular__c = '(41) 9999-9999';
        conta.Phone = '(41) 9999-9999';
        conta.Telefone_2__c = '(41) 9999-9999';
        conta.EMail__c = 'conta@teste.com.br';
        conta.EMailNFE__c = 'conta@teste.com.br';

        insert conta;
        return conta;
    } // Fim método criaContaCargoTracckJ


    // Método para retornar a conta do tipo CORP
    public static Account criaContaCORP(String idTipoRegistro, String CNPJ){

        Account conta = new Account();
		conta.RecordTypeId = idTipoRegistro;
        conta.Type = 'Seguradora';
        conta.Name = 'Conta CORP teste';
        conta.Nome_fantasia__c = 'Conta CORP teste';
        conta.Ramo_de_Atividade__c = 'Cegonheiro';
        conta.CNPJ__c = CNPJ;
        conta.Inscri_o_estadual__c = 'ISENTO';
        conta.TelefoneCelular__c = '(41) 9999-9999';
        conta.Phone = '(41) 9999-9999';
        conta.Telefone_2__c = '(41) 9999-9999';
        conta.Telefone_3__c = '(41) 9999-9999';
        conta.EMail__c = 'conta@teste.com.br';
        conta.EMailNFE__c = 'conta@teste.com.br';
        conta.Circuito__c = '2';
        conta.Cadencia__c = '2';
        
        insert conta;
        return conta;
    } // Fim método criaContaCORP

    
    // Método para retornar a conta do tipo FRETEIRO Pessoa Fisica
    public static Account criaContaFreteiroF(String idTipoRegistro, String CPF){

        Account conta = new Account();
		conta.RecordTypeId = idTipoRegistro;
        conta.Name = 'Conta FRETEIRO teste';
        conta.Nome_fantasia__c = 'Conta FRETEIRO teste';
        conta.Tipo_de_pessoa__c = 'F-Física';
        conta.CNPJ_CPF__c = CPF;
        conta.TelefoneCelular__c = '(41) 9999-9999';
        conta.Phone = '(41) 9999-9999';
        conta.Telefone_2__c = '(41) 9999-9999';
        conta.Telefone_3__c = '(41) 9999-9999';
        conta.EMail__c = 'conta@teste.com.br';
        conta.EMailNFE__c = 'conta@teste.com.br';
        conta.FormaCobranca__c = '1-Boleto Bancário';

        insert conta;
        return conta;
    } // Fim método criaContaFreteiroF


    // Método para retornar a conta do tipo Grupo Economico
    public static Account criaContaGrupoEconomico(String idTipoRegistro, String nome){

        Account conta = new Account();
		conta.RecordTypeId = idTipoRegistro;
        conta.Name = nome;

        insert conta;
        return conta;
    } // Fim método criaContaGrupoEconomico


    // Método para retornar a conta do tipo Michelin
    public static Account criaContaMichelin(String idTipoRegistro, String CNPJ){

        Account conta = new Account();
		conta.RecordTypeId = idTipoRegistro;
        conta.Name = 'Conta Michelin teste';
        conta.Type = 'Indicador';
        conta.CNPJ_CPF__c = CNPJ;
        conta.Phone = '(41) 9999-9999';
        conta.Possui_Escolta_Armada__c = 'SIM';

        insert conta;
        return conta;
    } // Fim método criaContaMichelin


     // Método para retornar a conta do tipo SIGGO Pessoa Fisica
    public static Account criaContaSIGGOF(String idTipoRegistro, String CPF){

        Account conta = new Account();
		conta.RecordTypeId = idTipoRegistro;
        conta.Name = 'Conta SIGGO teste';
        conta.Tipo_de_pessoa__c = 'F-Física';
        conta.CPF__c = CPF;
        conta.Phone = '(41) 9999-9999';
        conta.Nome_contato_autorizado__c = 'Contato autorizado';
		conta.Nome_contato_emergencia__c = 'Contato emergencia';
		conta.Nome_contato_instalacao__c = 'Contato instalacao';
        conta.Enderecos_Principal_UF__c = 'PR';
		conta.Enderecos_Cobranca_UF__c = 'PR';
		conta.FormaCobranca__c = '1-Boleto Bancário';

        insert conta;
        return conta;
    } // Fim método criaContaSIGGOF


    // Método para retornar a conta do tipo Mercosul Pessoa Fisica
    public static Account criaContaArgentinaCUIT(String idTipoRegistro, String CUIT){

        Account conta = new Account();
		conta.RecordTypeId = idTipoRegistro;
        conta.Name = 'Conta Mercosul Argentina';
        conta.Tipo_de_pessoa__c = 'J-Juridica';
        conta.CUIT__c = CUIT;
        conta.Phone = '(41) 9999-9999';
        conta.BillingCountry = 'Argentina';
        conta.Enderecos_Principal_Pais__c = 'Argentina';

        insert conta;
        return conta;
    } // Fim método criaContaSIGGOF

}