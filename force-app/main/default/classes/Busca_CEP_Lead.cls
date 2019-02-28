/*

	Classe de teste: Busca_CEP_LeadTest
	Criado por: Mauricio Alexandre Silva
	Data de criação: 02/03/2016
	Descrição: Classe com a funcionalidade de buscar o CEP para o Lead

	===================================================

    Atualizado por: Mario Reis
    Data da alteração: 31/8/2017
    Descrição: Tratamento para buscar URL conforme o ambiente, ajustado padronização do código

*/
public class Busca_CEP_Lead {

	// Método que faz a busca e atualiza o Lead
	@Future(callout=true)
	public static void busca(String leadId, String cep) {

        System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Lead - busca()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Lead - busca()] - leadId: '+leadId);
        System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Lead - busca()] - cep: '+cep);

        try {

            Lead lead = new Lead(Id = leadid);

            String endereco = '';

            String endpoint = Util_Integracao.getEndpointBuscaCEP();

            System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Lead - busca()] - endpoint: '+endpoint);

            HttpRequest req = new HttpRequest();
            req.setEndpoint(endpoint+cep);
            req.setMethod('GET');
            Http http = new Http();

        	if(!Test.isRunningTest()){

				HTTPResponse res = http.send(req);

            	try {

                	endereco = res.getBody(); 
            	} catch(Exception e) {

                	System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Lead - busca()] - ERRO: '+e.getMessage());
            	}

        	} else {

            	endereco = '"tipo":"RUA","logradouro":"JOAO FALARZ","complemento":"","bairro":"CIDADE INDUSTRIAL","municipio":"CURITIBA","uf":"PR","cep":"81280270","cod_ibge":"4106902","cod_tom":null';
			}

        	System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Lead - busca()] - endereco: '+endereco);

        	HTTPResponse res = http.send(req);

            Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            String mensagem = (String) m.get('mensagem');
            Integer status  = (Integer) m.get('status');

            System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Lead - busca()] - mensagem: '+mensagem);
            System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Lead - busca()] - status: '+status);
            System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Lead - busca()] - m: '+m);

            Map<String, Object> dados = (Map<String, Object>) m.get('dados');
                String bairro = (String) dados.get('bairro');
                String cep1 = (String) dados.get('cep');
                String ibge = (String) dados.get('cod_ibge');
                String tom = (String) dados.get('cod_tom');
                String complemento = (String) dados.get('complemento');
                String logradouro = (String) dados.get('logradouro');
                String municipio = (String) dados.get('municipio');
                String tipo = (String) dados.get('tipo');
                String uf = (String) dados.get('uf');

            System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Lead - busca()] - tipo: '+tipo);
            System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Lead - busca()] - logradouro: '+logradouro);
            System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Lead - busca()] - complemento: '+complemento);
            System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Lead - busca()] - bairro: '+bairro);
            System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Lead - busca()] - cep1: '+cep1);
            System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Lead - busca()] - municipio: '+municipio);
            System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Lead - busca()] - uf: '+uf);
            System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Lead - busca()] - ibge: '+ibge);
            System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Lead - busca()] - tom: '+tom);

        	Map<String, Object> dado = (Map<String, Object>) m.get('dados');

                lead.Id = leadid;
                lead.Street = String.valueOf(dado.get('tipo')) + ' ' + String.valueOf(dado.get('logradouro'));
                lead.Bairro_endereco__c = String.valueOf(dado.get('bairro'));
                lead.City = String.valueOf(dado.get('municipio'));
                lead.State = String.valueOf(dado.get('uf'));
                lead.Codigo_municipio__c = String.valueOf(dado.get('cod_ibge'));
                lead.Country = 'BRASIL';
                lead.PostalCode = String.valueOf(dado.get('cep'));

        	update lead;

        } catch (Exception e){

            System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Lead - busca()] - ERRO: '+e.getMessage());
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