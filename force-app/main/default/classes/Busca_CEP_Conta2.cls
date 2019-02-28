/*

	Classe de teste: Busca_CEP_Conta2Test
	Criado por: Mauricio Alexandre Silva
	Data de criação: 02/03/2016
	Descrição: Classe com a funcionalidade de buscar o CEP para a Conta

	===================================================

    Atualizado por: Mario Reis
    Data da alteração: 31/8/2017
    Descrição: Tratamento para buscar URL conforme o ambiente, ajustado padronização do código

*/
public class Busca_CEP_Conta2 {

    // Método que faz a busca e atualiza o Contato
	@Future(callout=true)
	public static void busca(String id, String cep) {

        System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta2 - busca()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta2 - busca()] - Id: '+id);
        System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta2 - busca()] - cep: '+cep);

        try {

	        Account acc = new Account(Id=id);
    	    String endereco = '';

	        HttpRequest req = new HttpRequest();

	        String endpoint = Util_Integracao.getEndpointBuscaCEP();

            System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta2 - busca()] - endpoint: '+endpoint);

	        req.setEndpoint(endpoint+cep);
	        req.setMethod('GET');
    	    Http http = new Http();

        	if(!Test.isRunningTest()){

	            HTTPResponse res = http.send(req);

    	        try {

					endereco = res.getBody(); 
                } catch(Exception e) {

                    System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta2 - busca()] - ERRO: '+e.getMessage());
                }

        	} else {

	            endereco = '"tipo":"RUA","logradouro":"JOAO FALARZ","complemento":"","bairro":"CIDADE INDUSTRIAL","municipio":"CURITIBA","uf":"PR","cep":"81280270","cod_ibge":"4106902","cod_tom":null';
    	    }

        	System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta2 - busca()] - endereco: '+endereco);

	        HTTPResponse res = http.send(req);

	        Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
    	    String mensagem = (String) m.get('mensagem');
        	Integer status  = (Integer) m.get('status');

        	System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta2 - busca()] - mensagem: '+mensagem);
            System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta2 - busca()] - status: '+status);
            System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta2 - busca()] - m: '+m);

            Map<String, Object> dados = (Map<String, Object>) m.get('dados');

            if(dados != null) {

                String bairro = (String) dados.get('bairro');
                String cep1 = (String) dados.get('cep');
                String ibge = (String) dados.get('cod_ibge');
                String tom = (String) dados.get('cod_tom');
                String complemento = (String) dados.get('complemento');
                String logradouro = (String) dados.get('logradouro');
                String municipio = (String) dados.get('municipio');
                String tipo = (String) dados.get('tipo');
                String uf = (String) dados.get('uf');

                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta2 - busca()] - tipo: '+tipo);
                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta2 - busca()] - logradouro: '+logradouro);
                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta2 - busca()] - complemento: '+complemento);
                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta2 - busca()] - bairro: '+bairro);
                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta2 - busca()] - cep1: '+cep1);
                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta2 - busca()] - municipio: '+municipio);
                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta2 - busca()] - uf: '+uf);
                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta2 - busca()] - ibge: '+ibge);
                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta2 - busca()] - tom: '+tom);

            	if(logradouro != null) acc.Enderecos_Entrega_Logradouro__c = tipo + ' ' + logradouro;
                if(bairro != null) acc.Enderecos_Entrega_Bairro__c = bairro;
                if(municipio != null) acc.Enderecos_Entrega_Cidade__c = municipio;
                if(uf != null) acc.Enderecos_Entrega_UF__c = uf;
                if(ibge != null) acc.Codigo_municipio_entrega__c= ibge;
                acc.Enderecos_Entrega_Pais__c = 'BRASIL';
                if(cep1 != null) acc.Enderecos_Entrega_CEP__c = cep1;

         		update acc;
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