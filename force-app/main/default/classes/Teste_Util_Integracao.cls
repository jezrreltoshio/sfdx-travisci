/*
    Classe de testes para a Classe "Util_Integracao"

    Criado por: Mario Reis
    Data: 25/08/2017

*/
@isTest
public class Teste_Util_Integracao {

    public static Parametros_ORG__c confParametrosORG;
    public static Integracoes__c integracoes;

    // Metodo que cria os objetos necessários para o teste
    @testSetup		 
    static void setup() {

        Util_Conta.carregarTipoRegistro();
    } // Fim método setup()


    // Método para testar o retorno da conf do server Siggo
    static testmethod void testeServerSiggo() {

        Test.startTest();

        setup();

		confParametrosORG = Teste_Util_Configuracao.criarConfiguracaoParametrosORG();
        integracoes = Teste_Util_Configuracao.criarConfiguracaoIntegracoes();

        Profile perfil = Teste_Util_Usuario.getPerfilPorNome('Administrador do sistema');
        User usuario = Teste_Util_Usuario.criaNovoUsuarioBR(perfil.Id, 'dev@sascar.com.br.dev', 1.998);

        System.debug('usuario: '+usuario);

        System.RunAs(usuario) {
        	Util_Integracao.getEndpointServerSiggo();
        }

        User usuario2 = Teste_Util_Usuario.criaNovoUsuarioBR(perfil.Id, 'dev@sascar.com.br.homolog', 2.998);

        System.RunAs(usuario2) {
        	Util_Integracao.getEndpointServerSiggo();
        }

		User usuario3 = Teste_Util_Usuario.criaNovoUsuarioBR(perfil.Id, 'dev@sascar.com.br', 3.998);

        System.RunAs(usuario3) {
            Util_Integracao.test = true;
        	Util_Integracao.getEndpointServerSiggo();
        }

        Test.stopTest();

    } // Fim testeServerSiggo


    // Método para testar o retorno da conf do server Cargo Tracck
    static testmethod void testeServerCargoTracck() {

        Test.startTest();

		confParametrosORG = Teste_Util_Configuracao.criarConfiguracaoParametrosORG();
        integracoes = Teste_Util_Configuracao.criarConfiguracaoIntegracoes();

        setup();

        Profile perfil = Teste_Util_Usuario.getPerfilPorNome('Administrador do sistema');
        User usuario = Teste_Util_Usuario.criaNovoUsuarioBR(perfil.Id, 'dev@sascar.com.br.dev', 1.998);

        System.debug('usuario: '+usuario);

        System.RunAs(usuario) {
        	Util_Integracao.getEndpointServerCargoTracck();
        }

        User usuario2 = Teste_Util_Usuario.criaNovoUsuarioBR(perfil.Id, 'dev@sascar.com.br.homolog', 2.998);

        System.RunAs(usuario2) {
        	Util_Integracao.getEndpointServerCargoTracck();
        }

		User usuario3 = Teste_Util_Usuario.criaNovoUsuarioBR(perfil.Id, 'dev@sascar.com.br', 3.998);

        System.RunAs(usuario3) {
            Util_Integracao.test = true;
        	Util_Integracao.getEndpointServerCargoTracck();
        }

        Test.stopTest();

    } // Fim testeServerCargoTracck


    // Método para testar o retorno da conf da busca de endereço
    static testmethod void testeBuscaCEP() {

        Test.startTest();

		confParametrosORG = Teste_Util_Configuracao.criarConfiguracaoParametrosORG();
        integracoes = Teste_Util_Configuracao.criarConfiguracaoIntegracoes();

        setup();

        Profile perfil = Teste_Util_Usuario.getPerfilPorNome('Administrador do sistema');
        User usuario = Teste_Util_Usuario.criaNovoUsuarioBR(perfil.Id, 'dev@sascar.com.br.dev', 1.998);

        System.debug('usuario: '+usuario);

        System.RunAs(usuario) {
        	Util_Integracao.getEndpointBuscaCEP();
        }

        User usuario2 = Teste_Util_Usuario.criaNovoUsuarioBR(perfil.Id, 'dev@sascar.com.br.homolog', 2.998);

        System.RunAs(usuario2) {
        	Util_Integracao.getEndpointBuscaCEP();
        }

		User usuario3 = Teste_Util_Usuario.criaNovoUsuarioBR(perfil.Id, 'dev@sascar.com.br', 3.998);

        System.RunAs(usuario3) {
            Util_Integracao.test = true;
        	Util_Integracao.getEndpointBuscaCEP();
        }

        Test.stopTest();

    } // Fim testeBuscaCEP


    // Método para testar o retorno da conf da integração da Oportunidade FRETEIRO
    static testmethod void testeFreteiroGenerateProposal() {

        Test.startTest();

		confParametrosORG = Teste_Util_Configuracao.criarConfiguracaoParametrosORG();
        integracoes = Teste_Util_Configuracao.criarConfiguracaoIntegracoes();

        setup();

        Profile perfil = Teste_Util_Usuario.getPerfilPorNome('Administrador do sistema');
        User usuario = Teste_Util_Usuario.criaNovoUsuarioBR(perfil.Id, 'dev@sascar.com.br.dev', 1.998);

        System.debug('usuario: '+usuario);

        System.RunAs(usuario) {
        	Util_Integracao.getEndpointFreteiroGenerateProposal();
        }

        User usuario2 = Teste_Util_Usuario.criaNovoUsuarioBR(perfil.Id, 'dev@sascar.com.br.homolog', 2.998);

        System.RunAs(usuario2) {
        	Util_Integracao.getEndpointFreteiroGenerateProposal();
        }

		User usuario3 = Teste_Util_Usuario.criaNovoUsuarioBR(perfil.Id, 'dev@sascar.com.br', 3.998);

        System.RunAs(usuario3) {
            Util_Integracao.test = true;
        	Util_Integracao.getEndpointFreteiroGenerateProposal();
        }

        Test.stopTest();

    } // Fim testeFreteiroGenerateProposal


	// Método para testar o retorno da conf da integração da Oportunidade CORP
    static testmethod void testeCorpGenerateProposal() {

        Test.startTest();

        setup();

		confParametrosORG = Teste_Util_Configuracao.criarConfiguracaoParametrosORG();
        integracoes = Teste_Util_Configuracao.criarConfiguracaoIntegracoes();

        Profile perfil = Teste_Util_Usuario.getPerfilPorNome('Administrador do sistema');
        User usuario = Teste_Util_Usuario.criaNovoUsuarioBR(perfil.Id, 'dev@sascar.com.br.dev', 1.998);

        System.debug('usuario: '+usuario);

        System.RunAs(usuario) {
        	Util_Integracao.getEndpointCorpGenerateProposal();
        }

        User usuario2 = Teste_Util_Usuario.criaNovoUsuarioBR(perfil.Id, 'dev@sascar.com.br.homolog', 2.998);

        System.RunAs(usuario2) {
        	Util_Integracao.getEndpointCorpGenerateProposal();
        }

		User usuario3 = Teste_Util_Usuario.criaNovoUsuarioBR(perfil.Id, 'dev@sascar.com.br', 3.998);

        System.RunAs(usuario3) {
            Util_Integracao.test = true;
        	Util_Integracao.getEndpointCorpGenerateProposal();
        }

        Test.stopTest();

    } // Fim testeCorpGenerateProposal

}