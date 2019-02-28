/*
    Criado por: Mario Reis
    Data de criação: 25/08/2017
    Descrição: Classe com métodos para criar registros de Configuração Personalizada 
                    para apoio as classes de teste
*/
@isTest
public class Teste_Util_Configuracao {

    // Método para criar a configuração personalizada "Parâmetros ORG"
    public static Parametros_ORG__c criarConfiguracaoParametrosORG(){

        Parametros_ORG__c conf = new Parametros_ORG__c();
        conf.Email_usuario_pentaho__c = 'pentaho@sascar.com.br';

        insert conf;
        return conf;
    } // Fim método criarConfiguracaoParametrosORG


    // Método para criar a configuração personalizada "Triggers"
    public static Triggers__c criarConfiguracaoTriggers(){

        Triggers__c conf = new Triggers__c();
        conf.Duplicidade_conta__c = false;
        conf.Trigger_conta__c = false;
        conf.Trigger_lead__c = false;

        insert conf;
        return conf;
    } // Fim método criarConfiguracaoTriggers


    // Método para criar a configuração personalizada "Integrações"
    public static Integracoes__c criarConfiguracaoIntegracoes(){

        Integracoes__c conf = new Integracoes__c();
		conf.Busca_CEP_desenvolvimento__c = 'http://desenvolvimento.sascar.com.br/sistemaWeb/WS_Siggo/WS_SiggoCRM.php';
        conf.Busca_CEP_homologacao__c = 'http://hom1-intranet.sascar.com.br/sistemaWeb/WS_Siggo/WS_SiggoCRM.php';
        conf.Busca_CEP_producao__c = 'http://intranet.sascar.com.br/WS_Siggo/WS_SiggoCRM.php';
        conf.Oportunidade_CORP_GP_desenvolvimento__c = 'http://desenvolvimento.sascar.com.br/sistemaWeb/WS_CEP/?cep=';
        conf.Oportunidade_CORP_GP_homologacao__c = 'http://hom1.intranet.sascar.com.br/sistemaWeb/WS_CEP/?cep=';
        conf.Oportunidade_CORP_GP_producao__c = 'http://intranet.sascar.com.br/WS_CEP/?cep=';
        conf.Oportunidade_freteiro_GP_desenvolvimento__c = 'http://desenvolvimento.sascar.com.br/sistemaWeb/RESTful/FRETEIRO/GenerateProposal.php';
        conf.Oportunidade_freteiro_GP_homologacao__c = 'http://hom1-intranet.sascar.com.br/sistemaWeb/RESTful/FRETEIRO/GenerateProposal.php';
        conf.Oportunidade_freteiro_GP_producao__c = 'http://intranet.sascar.com.br/RESTful/FRETEIRO/GenerateProposal.php';
        conf.Server_SIGGO_desenvolvimento__c = 'http://desenvolvimento.sascar.com.br/sistemaWeb/RESTful/CORP/GenerateProposal.php';
        conf.Server_SIGGO_homologacao__c = 'http://hom1-intranet.sascar.com.br/sistemaWeb/RESTful/CORP/GenerateProposal.php';
        conf.Server_SIGGO_producao__c = 'http://intranet.sascar.com.br/RESTful/CORP/GenerateProposal.php';
        conf.Server_cargo_tracck_desenvolvimento__c = 'http://desenvolvimento.sascar.com.br/sistemaWeb/WS_SALESFORCE/WS_IntegracaoSalesForce.php';
        conf.Server_cargo_tracck_homologacao__c = 'http://hom1-intranet.sascar.com.br/sistemaWeb/WS_SALESFORCE/WS_IntegracaoSalesForce.php';
        conf.Server_cargo_tracck_producao__c = 'http://intranet.sascar.com.br/WS_SALESFORCE/WS_IntegracaoSalesForce.php';

        insert conf;
        return conf;
    } // Fim método criarConfiguracaoIntegracoes


    // Método para criar a configuração personalizada "Duplicidade de conta"
    public static Duplicidade_conta__c criarConfiguracaoDuplicidadeConta(Boolean verificarBluetec,
        Boolean verificarCORP, Boolean verificarGrupoEconomico, Boolean verificarMichelin, 
        Boolean verificarSIGGO){

        Duplicidade_conta__c conf = new Duplicidade_conta__c();
        conf.Bluetec__c = verificarBluetec;
        conf.CORP__c = verificarCORP;
        conf.Grupo_economico__c = verificarGrupoEconomico;
        conf.Michelin__c = verificarMichelin;
        conf.SIGGO__c = verificarSIGGO;

        insert conf;
        return conf;
    } // Fim método criarConfiguracaoDuplicidadeConta



    // Método para criar a configuração personalizada "Serviços"
    public static Servicos__c criarConfiguracaoServicosORG(){

        Servicos__c conf = new Servicos__c();
        conf.Busca_CEP_Lead__c = false;
		conf.Busca_CEP_Conta__c = false;

        insert conf;
        return conf;
    } // Fim método criarConfiguracaoServicosORG

}