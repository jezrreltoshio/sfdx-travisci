/*
    Classe de testes para a classe "Service_Conta"

    Criado por: Mario Reis
    Data: 04/09/2017

*/
@isTest
public class Teste_Service_Conta {

    //public static Account conta;
    public static Parametros_ORG__c confParametrosORG;
    public static Triggers__c confTriggers;
    public static Duplicidade_conta__c confDuplicidadeConta;
    public static Servicos__c confServicos;

    // Metodo que cria os objetos necessários para o teste
    @testSetup		 
    static void setup() {

        Util_Conta.carregarTipoRegistro();

    } // Fim método setup()


    // Método para testar o método para preencher os campos de verificação de duplicidade
    static testmethod void testePreencheCamposConta() {

        Test.startTest();

        setup();

		confParametrosORG = Teste_Util_Configuracao.criarConfiguracaoParametrosORG();
        confTriggers = Teste_Util_Configuracao.criarConfiguracaoTriggers();
        confDuplicidadeConta = Teste_Util_Configuracao.criarConfiguracaoDuplicidadeConta(true, true, 
                                                       					 true, true, true);
		confServicos = Teste_Util_Configuracao.criarConfiguracaoServicosORG();

        List<Account> listaConta = new List<Account>();

        Account conta1 = Teste_Util_Conta.criaContaBluetecF(Util_Conta.bluetec, '843.163.290-90');
        Account conta2 = Teste_Util_Conta.criaContaBluetecJ(Util_Conta.bluetec, '54.335.618/0001-31');
        Account conta3 = Teste_Util_Conta.criaContaCargoTracckF(Util_Conta.cargoTracck, '740.358.381-79');
        Account conta4 = Teste_Util_Conta.criaContaCargoTracckJ(Util_Conta.cargoTracck, '56.418.080/0001-54');
        Account conta5 = Teste_Util_Conta.criaContaCORP(Util_Conta.CORP, '38.088.177/0001-64');
        Account conta6 = Teste_Util_Conta.criaContaFreteiroF(Util_Conta.FRETEIRO, '203.848.625-51');
        Account conta7 = Teste_Util_Conta.criaContaGrupoEconomico(Util_Conta.grupoEconomico, 'Conta GE');
        Account conta8 = Teste_Util_Conta.criaContaMichelin(Util_Conta.michelin, '22.584.078/0001-33');
        Account conta9 = Teste_Util_Conta.criaContaSIGGOF(Util_Conta.SIGGO, '411.760.716-29');

        listaConta.add(conta1);
        listaConta.add(conta2);
        listaConta.add(conta3);
        listaConta.add(conta4);
        listaConta.add(conta5);
        listaConta.add(conta6);
        listaConta.add(conta7);
        listaConta.add(conta8);
        listaConta.add(conta9);

        Service_Conta.preencheCamposConta(listaConta);

        Test.stopTest();

    } // Fim testePreencheCamposConta


    // Método para testar o método para preencher verificação de duplicidade
    static testmethod void testeVerificaDuplicidadeConta() {

        Test.startTest();

        setup();

        confParametrosORG = Teste_Util_Configuracao.criarConfiguracaoParametrosORG();
        confTriggers = Teste_Util_Configuracao.criarConfiguracaoTriggers();
        confDuplicidadeConta = Teste_Util_Configuracao.criarConfiguracaoDuplicidadeConta(true, true, 
                                                       					 true, true, true);
		confServicos = Teste_Util_Configuracao.criarConfiguracaoServicosORG();

        List<Account> listaConta = new List<Account>();

        confTriggers.Duplicidade_conta__c = true;
        update confTriggers;

        confDuplicidadeConta.CORP__c = true;
        update confDuplicidadeConta;

        try {

            Service_Conta.verificaDuplicidadeConta(listaConta);
        } catch(Exception e){

            // Verificação de erro quando a lista de contas está nula ou vazia
            System.Assert(e.getMessage().contains(Label.MSG_ERRO_0001));
        }

        Account conta1 = Teste_Util_Conta.criaContaBluetecF(Util_Conta.bluetec, '843.163.290-90');
        Account conta2 = Teste_Util_Conta.criaContaBluetecJ(Util_Conta.bluetec, '54.335.618/0001-31');
        Account conta3 = Teste_Util_Conta.criaContaCargoTracckF(Util_Conta.cargoTracck, '740.358.381-79');
        Account conta4 = Teste_Util_Conta.criaContaCargoTracckJ(Util_Conta.cargoTracck, '56.418.080/0001-54');
        Account conta5 = Teste_Util_Conta.criaContaCORP(Util_Conta.CORP, '38.088.177/0001-64');
        Account conta6 = Teste_Util_Conta.criaContaFreteiroF(Util_Conta.FRETEIRO, '203.848.625-51');
        Account conta7 = Teste_Util_Conta.criaContaGrupoEconomico(Util_Conta.grupoEconomico, 'Conta GE');
        Account conta8 = Teste_Util_Conta.criaContaMichelin(Util_Conta.michelin, '22.584.078/0001-33');
        Account conta9 = Teste_Util_Conta.criaContaSIGGOF(Util_Conta.SIGGO, '411.760.716-29');
        Account conta10 = Teste_Util_Conta.criaContaBluetecF(Util_Conta.bluetec, '843.163.290-90');

        listaConta.add(conta1);
        listaConta.add(conta2);
        listaConta.add(conta3);
        listaConta.add(conta4);
        listaConta.add(conta5);
        listaConta.add(conta6);
        listaConta.add(conta7);
        listaConta.add(conta8);
        listaConta.add(conta9);
        listaConta.add(conta10);

        Service_Conta.preencheCamposConta(listaConta);

        Account conta11 = Teste_Util_Conta.criaContaCORP(Util_Conta.CORP, '38.088.177/0001-64');
        listaConta.add(conta11);
        Service_Conta.verificaDuplicidadeConta(listaConta);

        Test.stopTest();

    } // Fim testePreencheCamposConta



	// Método para testar o método para buscar o CEP
    static testmethod void testeBuscaCEP(){

        Test.startTest();

        setup();

		confParametrosORG = Teste_Util_Configuracao.criarConfiguracaoParametrosORG();
        confTriggers = Teste_Util_Configuracao.criarConfiguracaoTriggers();
        confDuplicidadeConta = Teste_Util_Configuracao.criarConfiguracaoDuplicidadeConta(true, true, 
                                                       					 true, true, true);
		confServicos = Teste_Util_Configuracao.criarConfiguracaoServicosORG();

		confServicos.Busca_CEP_Conta__c = true;
        update confServicos;
        
        List<Account> listaConta = new List<Account>();
        
        Account conta = Teste_Util_Conta.criaContaCORP(Util_Conta.CORP, '38.088.177/0001-64');
        conta.Enderecos_Principal_CEP__c = '83045200';
        conta.Enderecos_Entrega_CEP__c = '83045200';
        conta.Enderecos_Cobranca_CEP__c = '83045200';

        update conta;

        listaConta.add(conta);

        Service_Conta.buscaCEP(listaConta);

		Test.stopTest();

    } // Fim testeBuscaCEP



    // Método para testar validação do CUIT
    static testmethod void testeValidacaoCUIT(){

		Test.startTest();

        setup();

		confParametrosORG = Teste_Util_Configuracao.criarConfiguracaoParametrosORG();
        confTriggers = Teste_Util_Configuracao.criarConfiguracaoTriggers();
        confDuplicidadeConta = Teste_Util_Configuracao.criarConfiguracaoDuplicidadeConta(true, true, 
                                                       					 true, true, true);
		confServicos = Teste_Util_Configuracao.criarConfiguracaoServicosORG();
        
        List<Account> listaConta = new List<Account>();
        
        Account conta = Teste_Util_Conta.criaContaArgentinaCUIT(Util_Conta.mercosul, '20-14902524-4');
        Account conta2 = Teste_Util_Conta.criaContaArgentinaCUIT(Util_Conta.mercosul, '20-14902524-1');

        listaConta.add(conta);

        Service_Conta.validacaoCUIT(listaConta);

        // Erro na validação
        try {
	        Service_Conta.validacaoCUIT(null);
        } catch (Exception e){
            System.Assert(e.getMessage().contains(Label.MSG_ERRO_0009));
        }

		// CUIT inválido
        try {
            listaConta.add(conta2);
	        Service_Conta.validacaoCUIT(listaConta);
        } catch (Exception e){
            System.Assert(e.getMessage().contains(Label.MSG_ERRO_0008));
        }

		Test.stopTest();

    } //validacaoCUIT



    // Método para testar validação do CPF
    static testmethod void testeValidacaoCPF(){

        Test.startTest();

        setup();

        confParametrosORG = Teste_Util_Configuracao.criarConfiguracaoParametrosORG();
        confTriggers = Teste_Util_Configuracao.criarConfiguracaoTriggers();
        confDuplicidadeConta = Teste_Util_Configuracao.criarConfiguracaoDuplicidadeConta(true, true, 
                                                       					 true, true, true);
		confServicos = Teste_Util_Configuracao.criarConfiguracaoServicosORG();

        List<Account> listaConta = new List<Account>();

        Account conta = Teste_Util_Conta.criaContaBluetecF(Util_Conta.bluetec, '024.556.412-87');

        listaConta.add(conta);

        Service_Conta.validacaoCPF(listaConta);

        // CPF inválido
        try {
            Account conta2 = Teste_Util_Conta.criaContaBluetecF(Util_Conta.bluetec, '024.556.412-00');
            listaConta.add(conta2);
            Service_Conta.validacaoCPF(listaConta);
        } catch (Exception e){
            System.Assert(e.getMessage().contains(Label.MSG_ERRO_0011));
        }


        // Erro na validação
        try {
	        Service_Conta.validacaoCPF(null);
        } catch (Exception e){
            System.Assert(e.getMessage().contains(Label.MSG_ERRO_0012));
        }

		Test.stopTest();

    } //testeValidacaoCPF



	// Método para testar validação do CNPJ
    static testmethod void testeValidacaoCNPJ(){

        Test.startTest();

        setup();

		confParametrosORG = Teste_Util_Configuracao.criarConfiguracaoParametrosORG();
        confTriggers = Teste_Util_Configuracao.criarConfiguracaoTriggers();
        confDuplicidadeConta = Teste_Util_Configuracao.criarConfiguracaoDuplicidadeConta(true, true, 
                                                       					 true, true, true);
		confServicos = Teste_Util_Configuracao.criarConfiguracaoServicosORG();
        
        List<Account> listaConta = new List<Account>();

        Account conta = Teste_Util_Conta.criaContaCORP(Util_Conta.cargoTracck, '48.782.613/0001-54');

        listaConta.add(conta);

        Service_Conta.validacaoCNPJ(listaConta);

		// CNPJ inválido
        try {
            Account conta2 = Teste_Util_Conta.criaContaBluetecJ(Util_Conta.bluetec, '00000000000000');
	        listaConta.add(conta2);
	        Service_Conta.validacaoCNPJ(listaConta);
        } catch (Exception e){
            System.Assert(e.getMessage().contains(Label.MSG_ERRO_0013));
        }


        // Erro na validação
        try {
	        Service_Conta.validacaoCNPJ(null);
        } catch (Exception e){
            System.Assert(e.getMessage().contains(Label.MSG_ERRO_0014));
        }


        Test.stopTest();

    } //testeValidacaoCNPJ



    // Método para testar a formatação do telefone
    static testmethod void testeFormataTelefone(){

        Test.startTest();

        setup();

        confParametrosORG = Teste_Util_Configuracao.criarConfiguracaoParametrosORG();
        confTriggers = Teste_Util_Configuracao.criarConfiguracaoTriggers();
        confDuplicidadeConta = Teste_Util_Configuracao.criarConfiguracaoDuplicidadeConta(true, true, 
                                                       					 true, true, true);
		confServicos = Teste_Util_Configuracao.criarConfiguracaoServicosORG();
        
        List<Account> listaConta = new List<Account>();

        Account conta = Teste_Util_Conta.criaContaCORP(Util_Conta.cargoTracck, '48.782.613/0001-54');

        listaConta.add(conta);

        Service_Conta.formataTelefone(listaConta);

        // Erro na validação
        try {
	        Service_Conta.formataTelefone(null);
        } catch (Exception e){
            System.Assert(e.getMessage().contains(Label.MSG_ERRO_0015));
        }

        Test.stopTest();

    } //testeFormataTelefone



    // Método para testar a copia dos campos do Lead para a Conta
    static testmethod void testeCopiarCamposLeadConta(){

        Test.startTest();

        confParametrosORG = Teste_Util_Configuracao.criarConfiguracaoParametrosORG();
        confTriggers = Teste_Util_Configuracao.criarConfiguracaoTriggers();
        confDuplicidadeConta = Teste_Util_Configuracao.criarConfiguracaoDuplicidadeConta(true, true, 
                                                       					 true, true, true);
		confServicos = Teste_Util_Configuracao.criarConfiguracaoServicosORG();

        Util_Conta.carregarTipoRegistro();
        Util_Lead.carregarTipoRegistro();

        List<Account> listaConta = new List<Account>();

        Lead lead = Teste_Util_Lead.criaLeadMercosulCUIT(Util_Lead.mercosul, '20-39627937-2');

        database.leadConvert lc = new database.leadConvert();
        lc.setLeadId(lead.id);

        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];

		lc.setConvertedStatus(convertStatus.MasterLabel);
     	Database.LeadConvertResult lcr = Database.convertLead(lc);

        lead = [SELECT Id, Name, ConvertedAccountId FROM Lead WHERE Id =: lead.Id];

        Account conta = [SELECT Id, Name FROM Account WHERE Id =: lead.ConvertedAccountId];

        listaConta.add(conta);

        Service_Conta.copiarCamposLeadConta(listaConta);

        Test.stopTest();

    } //testeCopiarCamposLeadConta

}