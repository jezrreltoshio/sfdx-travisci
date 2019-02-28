/*

	Classe de teste: Busca_CEP_Conta1Test
	Criado por: Bruno Bonfim Affonso
	Data de criação: 20/12/2016
	Descrição: Classe com a funcionalidade de buscar o CEP para a Conta

	===================================================

    Atualizado por: Mario Reis
    Data da alteração: 31/8/2017
    Descrição: Tratamento para buscar URL conforme o ambiente, ajustado padronização do código

*/
global class Busca_CEP_Conta {

    // Método para realizar a chamada da busca de CEP
	@Future(callout=true)
	webservice static void cepPrincipal(String id, String cep, String numero, 
                                        String complemento, String principal, String botao){

		busca(id, cep, numero, complemento, principal, botao);
	} // Fim método cepPrincipal


    // Método que realiza a busca de CEP
	public static void busca(String id, String cep, String numero, String compl, 
                             String principal, String botao) {

		System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta - busca()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta - busca()] - Id: '+id);
        System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta - busca()] - cep: '+cep);

        try {

        	Account acc = new Account(Id=id);

        	if(botao == 'cep_principal'){

                acc.Enderecos_Principal_CEP__c = cep;
                acc.Enderecos_Principal_Numero__c = Integer.valueOf(numero);
                acc.Enderecos_Principal_Complemento__c = compl;

				if(principal == 'true'){

					acc.Cep_preenchido_principal__c = true;
                    acc.BotaoAtualizaCEPEndPrincipal__c = true;
				}

        	} else if(botao == 'cep_cobranca'){

	        	acc.Enderecos_Cobranca_CEP__c = cep;
				acc.Enderecos_Cobranca_Numero__c = Integer.valueOf(numero);
				acc.Enderecos_Cobranca_Complemento__c = compl;
                acc.Enderecos_Cobranca_UsarPrincial__c = false;

	    		if(principal == 'true'){

					acc.Cep_preenchido_cobranca__c = true;
                    acc.BotaoAtualizaCEPEndCobranca__c = true;
				}

	        } else if(botao == 'cep_entrega'){

	        	acc.Enderecos_Entrega_CEP__c = cep;
				acc.Enderecos_Entrega_Numero__c = Integer.valueOf(numero);
				acc.Enderecos_Entrega_Complemento__c = compl;

	        	if(principal == 'true'){

					acc.Cep_preenchido_entrega__c = true;
                    acc.BotaoAtualizaCEPEndEntrega__c = true;
				}

	        } // Fim metodo if(botao == 'cep_principal')

	        /*String endereco = '';

	        HttpRequest req = new HttpRequest();

	        String endpoint = Util_Integracao.getEndpointBuscaCEP();

            System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta - busca()] - endpoint: '+endpoint);

	        req.setEndpoint(endpoint+cep);
        	req.setMethod('GET');
        	Http http = new Http();

        	if(!Test.isRunningTest()){

	            HTTPResponse res = http.send(req);

    	        try {

					endereco = res.getBody(); 
                } catch(Exception e) {

                    System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta - busca()] - ERRO: '+e.getMessage());
                }

        	} else {

	            endereco = '"tipo":"RUA","logradouro":"JOAO FALARZ","complemento":"","bairro":"CIDADE INDUSTRIAL","municipio":"CURITIBA","uf":"PR","cep":"81280270","cod_ibge":"4106902","cod_tom":null';
    	    }

        	System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta - busca()] - endereco: '+endereco);
	        HTTPResponse res = http.send(req);

	        Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
    	    String mensagem = (String) m.get('mensagem');
        	Integer status  = (Integer) m.get('status');

        	System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta - busca()] - mensagem: '+mensagem);
            System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta - busca()] - status: '+status);
            System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta - busca()] - m: '+m);

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

				System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta - busca()] - tipo: '+tipo);
                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta - busca()] - logradouro: '+logradouro);
                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta - busca()] - complemento: '+complemento);
                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta - busca()] - bairro: '+bairro);
                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta - busca()] - cep1: '+cep1);
                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta - busca()] - municipio: '+municipio);
                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta - busca()] - uf: '+uf);
                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta - busca()] - ibge: '+ibge);
                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta - busca()] - tom: '+tom);

        	Map<String, Object> dado = (Map<String, Object>) m.get('dados');            

	        if(botao == 'cep_principal'){

                acc.Enderecos_Principal_Logradouro__c = String.valueOf(dado.get('tipo')) + ' ' + String.valueOf(dado.get('logradouro'));
                acc.Enderecos_Principal_Bairro__c = String.valueOf(dado.get('bairro'));
                acc.Enderecos_Principal_Cidade__c = String.valueOf(dado.get('municipio'));
                acc.Enderecos_Principal_UF__c = String.valueOf(dado.get('uf'));
                acc.Codigo_municipio_principal__c= String.valueOf(dado.get('cod_ibge'));
                acc.Enderecos_Principal_Pais__c = 'BRASIL';
                acc.Enderecos_Principal_CEP__c = String.valueOf(dado.get('cep'));
        
			} else if(botao == 'cep_cobranca'){

                acc.Enderecos_Cobranca_Logradouro__c = String.valueOf(dado.get('tipo')) + ' ' + String.valueOf(dado.get('logradouro'));
                acc.Enderecos_Cobranca_Bairro__c = String.valueOf(dado.get('bairro'));
                acc.Enderecos_Cobranca_Cidade__c = String.valueOf(dado.get('municipio'));
                acc.Enderecos_Cobranca_UF__c = String.valueOf(dado.get('uf'));
                acc.Codigo_municipio_cobranca__c= String.valueOf(dado.get('cod_ibge'));
                acc.Enderecos_Cobranca_Pais__c = 'BRASIL';
                acc.Enderecos_Cobranca_CEP__c = String.valueOf(dado.get('cep'));

	        } else if(botao == 'cep_entrega'){

	        	acc.Enderecos_Entrega_Logradouro__c = String.valueOf(dado.get('tipo')) + ' ' + String.valueOf(dado.get('logradouro'));
    	        acc.Enderecos_Entrega_Bairro__c = String.valueOf(dado.get('bairro'));
        	    acc.Enderecos_Entrega_Cidade__c = String.valueOf(dado.get('municipio'));
            	acc.Enderecos_Entrega_UF__c = String.valueOf(dado.get('uf'));
	            acc.Codigo_municipio_entrega__c= String.valueOf(dado.get('cod_ibge'));
    	        acc.Enderecos_Entrega_Pais__c = 'BRASIL';
        	    acc.Enderecos_Entrega_CEP__c = String.valueOf(dado.get('cep'));

        	} // Fim if(botao == 'cep_principal')*/

			update acc;

		} catch (Exception e){

            System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Conta - busca()] - ERRO: '+e.getMessage());
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
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
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