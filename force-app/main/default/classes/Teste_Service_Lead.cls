/*
    Classe de testes para a classe "Service_Lead"

    Criado por: Mario Reis
    Data: 05/12/2017

*/
@isTest
public class Teste_Service_Lead {


    // Método para testar o método de validação do CUIT
    static testmethod void testeValidacaoCUIT() {

        Util_Lead.carregarTipoRegistro();

        Test.startTest();

        List<Lead> listaLead = new List<Lead>();

        Lead lead = Teste_Util_Lead.criaLeadMercosulCUIT(Util_Lead.mercosul, '20-95048472-2');
        Lead lead2 = Teste_Util_Lead.criaLeadMercosulCUIT(Util_Lead.mercosul, '00-00000000-0');

        listaLead.add(lead);
        Service_Lead.validacaoCUIT(listaLead);

        // Teste validação CUIT inválido
        try {
            listaLead.add(lead2);
        	Service_Lead.validacaoCUIT(listaLead);
        } catch (Exception e){
            System.Assert(e.getMessage().contains(Label.MSG_ERRO_0008));
        }

        // Teste erro
        try {
        	Service_Lead.validacaoCUIT(listaLead = new List<Lead>());
        } catch (Exception e){
            System.Assert(e.getMessage().contains(Label.MSG_ERRO_0009));
        }

        Test.stopTest();

    } // Fim testeValidacaoCUIT



    // Método para testar o método de validação do CPF
    static testmethod void testeValidacaoCPF() {

        Util_Lead.carregarTipoRegistro();

        Test.startTest();

        List<Lead> listaLead = new List<Lead>();

        Lead lead = Teste_Util_Lead.criaLeadCargoTracckF(Util_Lead.cargoTracck, '887.365.073-26');
        Lead lead2 = Teste_Util_Lead.criaLeadCargoTracckF(Util_Lead.cargoTracck, '000.000.000-00');

        listaLead.add(lead);
        Service_Lead.validacaoCPF(listaLead);

        // Teste validação CPF inválido
        try {
            listaLead.add(lead2);
        	Service_Lead.validacaoCPF(listaLead);
        } catch (Exception e){
            System.Assert(e.getMessage().contains(Label.MSG_ERRO_0011));
        }

        // Teste erro
        try {
        	Service_Lead.validacaoCPF(listaLead = new List<Lead>());
        } catch (Exception e){
            System.Assert(e.getMessage().contains(Label.MSG_ERRO_0012));
        }

        Test.stopTest();

    } // Fim testeValidacaoCPF



    // Método para testar o método de validação do CNPJ
    static testmethod void testeValidacaoCNPJ() {

        Util_Lead.carregarTipoRegistro();

        Test.startTest();

        List<Lead> listaLead = new List<Lead>();

        Lead lead = Teste_Util_Lead.criaLeadCargoTracckJ(Util_Lead.cargoTracck, '99.063.286/0001-11');
        Lead lead2 = Teste_Util_Lead.criaLeadCargoTracckJ(Util_Lead.cargoTracck, '00.000.000/0000-00');

        listaLead.add(lead);
        Service_Lead.validacaoCNPJ(listaLead);

        // Teste validação CNPJ inválido
        try {
            listaLead.add(lead2);
        	Service_Lead.validacaoCNPJ(listaLead);
        } catch (Exception e){
            System.Assert(e.getMessage().contains(Label.MSG_ERRO_0013));
        }

        // Teste erro
        try {
        	Service_Lead.validacaoCNPJ(listaLead = new List<Lead>());
        } catch (Exception e){
            System.Assert(e.getMessage().contains(Label.MSG_ERRO_0014));
        }

        Test.stopTest();

    } // Fim testeValidacaoCPF



	// Método para testar o método de formatação do telefone
    static testmethod void testeFormataTelefone() {

        Util_Lead.carregarTipoRegistro();

        Test.startTest();

        List<Lead> listaLead = new List<Lead>();

        Lead lead = Teste_Util_Lead.criaLeadCargoTracckF(Util_Lead.cargoTracck, '887.365.073-26');
        lead.Phone = '4199886565';
		lead.Telefone_celular__c = '4199886565';
        lead.MobilePhone = '4199886565';
        lead.Telefone_gestor_responsavel__c = '4199886565';
        update lead;

        listaLead.add(lead);
        Service_Lead.formataTelefone(listaLead);

        // Teste erro
        try {
        	Service_Lead.formataTelefone(null);
        } catch (Exception e){
            System.Assert(e.getMessage().contains(Label.MSG_ERRO_0015));
        }

        Test.stopTest();

    } // Fim testeFormataTelefone



    // Método para testar o método que preenche os campos para duplicidade de Lead
    static testmethod void testePreencheCamposLead() {

        Util_Lead.carregarTipoRegistro();

        Test.startTest();

        List<Lead> listaLead = new List<Lead>();

        Lead lead = Teste_Util_Lead.criaLeadCargoTracckF(Util_Lead.cargoTracck, '887.365.073-26');
        Lead lead2 = Teste_Util_Lead.criaLeadCargoTracckJ(Util_Lead.cargoTracck, '56.418.080/0001-54');
		Lead lead3 = Teste_Util_Lead.criaLeadMercosulCUIT(Util_Lead.mercosul, '20-95048472-2');
        Lead lead4 = Teste_Util_Lead.criaLeadMercosulCUIT(Util_Lead.mercosul, '00-00000000-0');
		Lead lead5 = Teste_Util_Lead.criaLeadCORP(Util_Lead.CORP, '38.088.177/0001-64');
        Lead lead6 = Teste_Util_Lead.criaLeadBluetecF(Util_Lead.bluetec, '843.163.290-90');
        Lead lead7 = Teste_Util_Lead.criaLeadBluetecJ(Util_Lead.bluetec, '54.335.618/0001-31');
        Lead lead8 = Teste_Util_Lead.criaLeadSiggo(Util_Lead.siggo, '411.760.716-29');
        Lead lead9 = Teste_Util_Lead.criaLeadFreteiroF(Util_Lead.FRETEIRO, '203.848.625-51');
        Lead lead10 = Teste_Util_Lead.criaLeadMichelin(Util_Lead.michelin, '22.584.078/0001-33');

        listaLead.add(lead);
        listaLead.add(lead2);
        listaLead.add(lead3);
        listaLead.add(lead4);
        listaLead.add(lead5);
        listaLead.add(lead6);
        listaLead.add(lead7);
        listaLead.add(lead8);
        listaLead.add(lead9);
        listaLead.add(lead10);

        Service_Lead.preencheCamposLead(listaLead);

        Test.stopTest();

    } // Fim testePreencheCamposLead


    
    // Método para testar o método que verifica a duplicidade de Lead
    static testmethod void testeVerificaDuplicidadeLead() {

        Util_Lead.carregarTipoRegistro();

        Test.startTest();

        List<Lead> listaLead = new List<Lead>();

        Lead lead = Teste_Util_Lead.criaLeadCargoTracckF(Util_Lead.cargoTracck, '887.365.073-26');
        Lead lead2 = Teste_Util_Lead.criaLeadCargoTracckJ(Util_Lead.cargoTracck, '56.418.080/0001-54');
		Lead lead3 = Teste_Util_Lead.criaLeadMercosulCUIT(Util_Lead.mercosul, '20-95048472-2');
        Lead lead4 = Teste_Util_Lead.criaLeadMercosulCUIT(Util_Lead.mercosul, '00-00000000-0');
		Lead lead5 = Teste_Util_Lead.criaLeadCORP(Util_Lead.CORP, '38.088.177/0001-64');
        Lead lead6 = Teste_Util_Lead.criaLeadBluetecF(Util_Lead.bluetec, '843.163.290-90');
        Lead lead7 = Teste_Util_Lead.criaLeadBluetecJ(Util_Lead.bluetec, '54.335.618/0001-31');
        Lead lead8 = Teste_Util_Lead.criaLeadSiggo(Util_Lead.siggo, '411.760.716-29');
        Lead lead9 = Teste_Util_Lead.criaLeadFreteiroF(Util_Lead.FRETEIRO, '203.848.625-51');
        Lead lead10 = Teste_Util_Lead.criaLeadMichelin(Util_Lead.michelin, '22.584.078/0001-33');

        listaLead.add(lead);
        listaLead.add(lead2);
        listaLead.add(lead3);
        listaLead.add(lead4);
        listaLead.add(lead5);
        listaLead.add(lead6);
        listaLead.add(lead7);
        listaLead.add(lead8);
        listaLead.add(lead9);
        listaLead.add(lead10);

        Service_Lead.preencheCamposLead(listaLead);

        Triggers__c confTriggers = Teste_Util_Configuracao.criarConfiguracaoTriggers();
        confTriggers.Duplicidade_lead__c = true;
        update confTriggers;

        Service_Lead.verificaDuplicidadeLead(listaLead);

        // Teste erro
        try {
        	Service_Lead.verificaDuplicidadeLead(null);
        } catch (Exception e){
            System.Assert(e.getMessage().contains(Label.MSG_ERRO_0021));
        }

        Test.stopTest();

    } // Fim testeVerificaDuplicidadeLead

    
    // Método para testar o método que busca o CEP
    static testmethod void testeBuscaCEP() {

        Util_Lead.carregarTipoRegistro();

        Test.startTest();

        List<Lead> listaLead = new List<Lead>();

		Lead lead = Teste_Util_Lead.criaLeadCORP(Util_Lead.CORP, '38.088.177/0001-64');
        lead.PostalCode = '83045200';
        update lead;

        listaLead.add(lead);

        Servicos__c confServicos = Teste_Util_Configuracao.criarConfiguracaoServicosORG();
        confServicos.Busca_CEP_Lead__c = true;
        update confServicos;

        Service_Lead.buscaCEP(listaLead);

        Test.stopTest();

    } // Fim testeBuscaCEP

}