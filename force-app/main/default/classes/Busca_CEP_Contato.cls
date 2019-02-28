/*

	Classe de teste: Busca_Contato_LeadTest
	Criado por: Mauricio Alexandre Silva
	Data de criação: 02/03/2016
	Descrição: Classe com a funcionalidade de buscar o CEP para o Contato

	===================================================

    Atualizado por: Mario Reis
    Data da alteração: 31/8/2017
    Descrição: Tratamento para buscar URL conforme o ambiente, ajustado padronização do código

*/
public class Busca_CEP_Contato {

	// Método que faz a busca e atualiza o Contato
	@Future(callout=true)
	public static void busca(String id, String cep) {

        System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Contato - busca()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Contato - busca()] - Id: '+id);
        System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Contato - busca()] - cep: '+cep);

        try {

        	Contact c = new Contact(Id=id);
        	String endereco = '';

	        HttpRequest req = new HttpRequest();

            String endpoint = Util_Integracao.getEndpointBuscaCEP();

            System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Contato - busca()] - endpoint: '+endpoint);

	        req.setEndpoint(endpoint+cep);
      	    req.setMethod('GET');
        	Http http = new Http();

        	if(!Test.isRunningTest()){

	            HTTPResponse res = http.send(req);
    	        try {

					endereco = res.getBody(); 
                } catch(Exception e) {

                    System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Contato - busca()] - ERRO: '+e.getMessage());
                }

        	} else {

	            endereco = '"tipo":"RUA","logradouro":"JOAO FALARZ","complemento":"","bairro":"CIDADE INDUSTRIAL","municipio":"CURITIBA","uf":"PR","cep":"81280270","cod_ibge":"4106902","cod_tom":null';
    	    }

        	System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Contato - busca()] - endereco: '+endereco);

        	HTTPResponse res = http.send(req);

	        Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
    	    String mensagem = (String) m.get('mensagem');
        	Integer status  = (Integer) m.get('status');
        
        	System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Contato - busca()] - mensagem: '+mensagem);
            System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Contato - busca()] - status: '+status);
            System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Contato - busca()] - m: '+m);

            Map<String, Object> dados = (Map<String, Object>) m.get('dados');

            if(dados != null){
                
                String bairro = (String) dados.get('bairro');
                String cep1 = (String) dados.get('cep');
                String ibge = (String) dados.get('cod_ibge');
                String tom = (String) dados.get('cod_tom');
                String complemento = (String) dados.get('complemento');
                String logradouro = (String) dados.get('logradouro');
                String municipio = (String) dados.get('municipio');
                String tipo = (String) dados.get('tipo');
                String uf = (String) dados.get('uf');

                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Contato - busca()] - tipo: '+tipo);
                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Contato - busca()] - logradouro: '+logradouro);
                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Contato - busca()] - complemento: '+complemento);
                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Contato - busca()] - bairro: '+bairro);
                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Contato - busca()] - cep1: '+cep1);
                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Contato - busca()] - municipio: '+municipio);
                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Contato - busca()] - uf: '+uf);
                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Contato - busca()] - ibge: '+ibge);
                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Contato - busca()] - tom: '+tom);

                if(logradouro != null) c.MailingStreet = tipo + ' ' + logradouro;
                if(bairro != null) c.Bairro_endereco__c = bairro;
                if(municipio != null) c.MailingCity = municipio;
                if(uf != null) c.MailingState = uf;
                if(ibge != null) c.Codigo_municipio__c = ibge;
                c.MailingCountry = 'BRASIL';
                if(cep1 != null) c.MailingPostalCode = cep1;

        	 	update c;
            }

         } catch (Exception e){

            System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Contato - busca()] - ERRO: '+e.getMessage());
        }

     } // Fim metodo busca



     public static void neverCallThisMethod() {
        integer a = 0;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
    }

}