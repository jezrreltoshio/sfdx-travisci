/*
	Classe de teste: Teste_Util_Integracao
	Criado por: Mario Reis
	Data de criação: 31/08/2017
	Descrição: Classe com métodos uteis para Integração
*/
public class Util_Integracao {

    public static Boolean test = false;

    /*
    public static String endpointBarramentoHomologacao = Integracoes__c.getOrgDefaults().Barramento_homologacao__c;
    public static String endpointBarramentoProducao = Integracoes__c.getOrgDefaults().Barramento_producao__c;
    public static String portaBarramentoHomologacao = Integracoes__c.getOrgDefaults().Barramento_homologacao_porta__c;
    public static String portaBarramentoProducao = Integracoes__c.getOrgDefaults().Barramento_producao_porta__c;
    public static String authorizationBarramentoHomologacao = Integracoes__c.getOrgDefaults().Barramento_homologacao_authorization__c;
    public static String authorizationBarramentoProducao = Integracoes__c.getOrgDefaults().Barramento_producao_authorization__c;
    public static String tokenBarramentoHomologacao = Integracoes__c.getOrgDefaults().Barramento_homologacao_token__c;
    public static String tokenBarramentoProducao = Integracoes__c.getOrgDefaults().Barramento_producao_token__c;
	*/

    public static String endpointBuscaCEPDesenvolvimento = Integracoes__c.getOrgDefaults().Busca_CEP_desenvolvimento__c;
    public static String endpointBuscaCEPHomologacao = Integracoes__c.getOrgDefaults().Busca_CEP_homologacao__c;
    public static String endpointBuscaCEPProducao = Integracoes__c.getOrgDefaults().Busca_CEP_producao__c;
    public static String endpointOportunidadeCORPGPDesenvolvimento = Integracoes__c.getOrgDefaults().Oportunidade_CORP_GP_desenvolvimento__c;
    public static String endpointOportunidadeCORPGPHomologacao = Integracoes__c.getOrgDefaults().Oportunidade_CORP_GP_homologacao__c;
    public static String endpointOportunidadeCORPGPProducao = Integracoes__c.getOrgDefaults().Oportunidade_CORP_GP_producao__c;
    public static String endpointOportunidadeFreteiroGPDesenvolvimento = Integracoes__c.getOrgDefaults().Oportunidade_freteiro_GP_desenvolvimento__c;
    public static String endpointOportunidadeFreteiroGPHomologacao = Integracoes__c.getOrgDefaults().Oportunidade_freteiro_GP_homologacao__c;
    public static String endpointOportunidadeFreteiroGPProducao = Integracoes__c.getOrgDefaults().Oportunidade_freteiro_GP_producao__c;
    public static String endpointServerSIGGODesenvolvimento = Integracoes__c.getOrgDefaults().Server_SIGGO_desenvolvimento__c;
    public static String endpointServerSIGGOHomologacao = Integracoes__c.getOrgDefaults().Server_SIGGO_homologacao__c;
    public static String endpointServerSIGGOProducao = Integracoes__c.getOrgDefaults().Server_SIGGO_producao__c;
    public static String endpointServerCargoTracckDesenvolvimento = Integracoes__c.getOrgDefaults().Server_cargo_tracck_desenvolvimento__c;
    public static String endpointServerCargoTracckHomologacao = Integracoes__c.getOrgDefaults().Server_cargo_tracck_homologacao__c;
    public static String endpointServerCargoTracckProducao = Integracoes__c.getOrgDefaults().Server_cargo_tracck_producao__c;

    // Método para retornar o endpoint para o server siggo
    public static String getEndpointServerSiggo(){

        System.debug(LoggingLevel.ERROR, '__ [cls Util_Integracao - getEndpointServerSiggo()] - Inicio...');

        try {

            String ambiente = Util_Organizacao.getAmbienteSF();

	        if(ambiente == Util_Organizacao.DESENVOLVIMENTO && !test) return endpointServerSIGGODesenvolvimento;
   		    else if(ambiente == Util_Organizacao.HOMOLOGACAO && !test) return endpointServerSIGGOHomologacao;
   	    	else if(ambiente == Util_Organizacao.PRODUCAO || test) return endpointServerSIGGOProducao;
   	     	else return endpointServerSIGGODesenvolvimento;

        } catch(Exception e){

			System.debug(LoggingLevel.ERROR, '__ [cls Util_Integracao - getEndpointServerSiggo()] - ERRO: ' + e.getMessage());
			throw new customException(Label.MSG_ERRO_0005);
        }

    } // Fim getEndpointServerSiggo


    // Método para retornar o endpoint para o server cargo tracck
    public static String getEndpointServerCargoTracck(){

        System.debug(LoggingLevel.ERROR, '__ [cls Util_Integracao - getEndpointServerCargoTracck()] - Inicio...');

        try {

            String ambiente = Util_Organizacao.getAmbienteSF();

	        if(ambiente == Util_Organizacao.DESENVOLVIMENTO && !test) return endpointServerCargoTracckDesenvolvimento;
   		    else if(ambiente == Util_Organizacao.HOMOLOGACAO && !test) return endpointServerCargoTracckHomologacao;
   	    	else if(ambiente == Util_Organizacao.PRODUCAO || test) return endpointServerCargoTracckProducao;
   	     	else return endpointServerSIGGODesenvolvimento;

        } catch(Exception e){

			System.debug(LoggingLevel.ERROR, '__ [cls Util_Integracao - getEndpointServerCargoTracck()] - ERRO: ' + e.getMessage());
			throw new customException(Label.MSG_ERRO_0005);
        }

    } // Fim getEndpointServerSiggo


    // Método para retornar o endpoint para busca de CEP
    public static String getEndpointBuscaCEP(){

        System.debug(LoggingLevel.ERROR, '__ [cls Util_Integracao - getEndpointServerSiggo()] - Inicio...');

        try {

            String ambiente = Util_Organizacao.getAmbienteSF();

	        if(ambiente == Util_Organizacao.DESENVOLVIMENTO && !test) return endpointBuscaCEPDesenvolvimento;
   		    else if(ambiente == Util_Organizacao.HOMOLOGACAO && !test) return endpointBuscaCEPHomologacao;
   	    	else if(ambiente == Util_Organizacao.PRODUCAO || test) return endpointBuscaCEPProducao;
   	     	else return endpointBuscaCEPDesenvolvimento;

        } catch(Exception e){

			System.debug(LoggingLevel.ERROR, '__ [cls Util_Integracao - getEndpointBuscaCEP()] - ERRO: ' + e.getMessage());
			throw new customException(Label.MSG_ERRO_0005);
        }

    } // Fim getEndpointBuscaCEP


    // Método para retornar o endpoint para integração da Oportunidade de FRETEIRO
    public static String getEndpointFreteiroGenerateProposal(){

        System.debug(LoggingLevel.ERROR, '__ [cls Util_Integracao - getEndpointFreteiroGenerateProposal()] - Inicio...');

        try {

            String ambiente = Util_Organizacao.getAmbienteSF();

	        if(ambiente == Util_Organizacao.DESENVOLVIMENTO && !test) return endpointOportunidadeFreteiroGPDesenvolvimento;
   		    else if(ambiente == Util_Organizacao.HOMOLOGACAO && !test) return endpointOportunidadeFreteiroGPHomologacao;
   	    	else if(ambiente == Util_Organizacao.PRODUCAO || test) return endpointOportunidadeFreteiroGPProducao;
   	     	else return endpointOportunidadeFreteiroGPDesenvolvimento;

        } catch(Exception e){

			System.debug(LoggingLevel.ERROR, '__ [cls Util_Integracao - getEndpointFreteiroGenerateProposal()] - ERRO: ' + e.getMessage());
			throw new customException(Label.MSG_ERRO_0005);
        }

    } // Fim getEndpointFreteiroGenerateProposal


    // Método para retornar o endpoint para integração da Oportunidade de CORP
    public static String getEndpointCorpGenerateProposal(){

        System.debug(LoggingLevel.ERROR, '__ [cls Util_Integracao - getEndpointCorpGenerateProposal()] - Inicio...');

        try {

            String ambiente = Util_Organizacao.getAmbienteSF();

	        if(ambiente == Util_Organizacao.DESENVOLVIMENTO && !test) return endpointOportunidadeCORPGPDesenvolvimento;
   		    else if(ambiente == Util_Organizacao.HOMOLOGACAO && !test) return endpointOportunidadeCORPGPHomologacao;
   	    	else if(ambiente == Util_Organizacao.PRODUCAO || test) return endpointOportunidadeCORPGPProducao;
   	     	else return endpointOportunidadeCORPGPDesenvolvimento;

        } catch(Exception e){

			System.debug(LoggingLevel.ERROR, '__ [cls Util_Integracao - getEndpointCorpGenerateProposal()] - ERRO: ' + e.getMessage());
			throw new customException(Label.MSG_ERRO_0005);
        }

    } // Fim getEndpointCorpGenerateProposal


    // Método para retornar o endpoint completo para o barramento
    /*public static String getEndpointBarramento(){

        System.debug(LoggingLevel.ERROR, '__ [cls Util_Integracao - getEndpointBarramento()] - Inicio...');

        try {

            String ambiente = Util_Organizacao.getAmbienteSF();

	        if(ambiente == Util_Organizacao.DESENVOLVIMENTO && !test) return endpointBarramentoHomologacao+':'+portaBarramentoHomologacao;
   		    else if(ambiente == Util_Organizacao.HOMOLOGACAO && !test) return endpointBarramentoHomologacao+':'+portaBarramentoHomologacao;
   	    	else if(ambiente == Util_Organizacao.PRODUCAO || test) return endpointBarramentoProducao+':'+portaBarramentoProducao;
   	     	else return endpointBarramentoHomologacao+':'+portaBarramentoHomologacao;

        } catch(Exception e){

			System.debug(LoggingLevel.ERROR, '__ [cls Util_Integracao - getEndpointBarramento()] - ERRO: ' + e.getMessage());
			throw new customException(Label.MSG_ERRO_0005);
        }

    } // Fim getEndpointBarramento


    // Método para retornar o código authorization para o barramento
    public static String getAuthorizationBarramento(){

        System.debug(LoggingLevel.ERROR, '__ [cls Util_Integracao - getAuthorizationBarramento()] - Inicio...');

        try {

            String ambiente = Util_Organizacao.getAmbienteSF();

	        if(ambiente == Util_Organizacao.DESENVOLVIMENTO && !test) return 'Basic '+authorizationBarramentoHomologacao;
   		    else if(ambiente == Util_Organizacao.HOMOLOGACAO && !test) return 'Basic '+authorizationBarramentoHomologacao;
   	    	else if(ambiente == Util_Organizacao.PRODUCAO || test) return 'Basic '+authorizationBarramentoProducao;
   	     	else return 'Basic '+authorizationBarramentoHomologacao;

        } catch(Exception e){

			System.debug(LoggingLevel.ERROR, '__ [cls Util_Integracao - getAuthorizationBarramento()] - ERRO: ' + e.getMessage());
			throw new customException(Label.MSG_ERRO_0005);
        }

    } // Fim getAuthorizationBarramento


	// Método para retornar o código token para o barramento
    public static String getTokenBarramento(){

        System.debug(LoggingLevel.ERROR, '__ [cls Util_Integracao - getTokenBarramento()] - Inicio...');

        try {

            String ambiente = Util_Organizacao.getAmbienteSF();

	        if(ambiente == Util_Organizacao.DESENVOLVIMENTO && !test) return tokenBarramentoHomologacao;
   		    else if(ambiente == Util_Organizacao.HOMOLOGACAO && !test) return tokenBarramentoHomologacao;
   	    	else if(ambiente == Util_Organizacao.PRODUCAO || test) return tokenBarramentoProducao;
   	     	else return tokenBarramentoHomologacao;

        } catch(Exception e){

			System.debug(LoggingLevel.ERROR, '__ [cls Util_Integracao - getTokenBarramento()] - ERRO: ' + e.getMessage());
			throw new customException(Label.MSG_ERRO_0005);
        }

    } // Fim getAuthorizationBarramento

*/
}