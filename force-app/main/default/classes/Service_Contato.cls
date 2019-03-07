/*
    Classe de teste: N/A
    Criado por: Rafael Silva
    Data de criação: 21/06/2018
    Descrição: Classe reescrita para a unificação das triggers de contato, e correção dos erros de construção.
    ---------------------------------
    @author Renan Rocha
    @date 28/01/2019
    @description:
        - Classe refatorada
        - Novos debugs inseridos
    @JIRA KCA-482
*/
public class Service_Contato {

    private static String CLASS_NAME = 'Service_Contato';
    
    public static void carregarEnderecoConta(List<Contact> listaContato){
        String METHOD_NAME = 'carregarEnderecoConta';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaContato: '+ listaContato);
 
        List<Account> accounts = new List<Account>();
        List<Account> accountsToUpdate = new List<Account>();
        List<Id> accountIds = new List<Id>();
        Map<Id,Account> mapConta = new Map<Id,Account>();

        try{
            for(Contact c : listaContato) accountIds.add(c.AccountId);
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - accountIds: '+ accountIds);
            
            accounts = DAO_Conta.getContaPorListaId(accountIds);
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - accounts: '+ accounts);
            
            for(Account a : accounts) mapConta.put(a.Id, a);
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - mapConta: '+ mapConta);
            
            for(Contact c : listaContato){
                
                if(c.MailingPostalCode != null && mapConta.get(c.AccountId).Enderecos_Principal_CEP__c == null){
                    mapConta.get(c.AccountId).Enderecos_Principal_CEP__c = c.MailingPostalCode;
                    
                    if(!accountsToUpdate.contains(mapConta.get(c.AccountId))) accountsToUpdate.add(mapConta.get(c.AccountId));
                }
                
                if(c.MailingStreet != null && mapConta.get(c.AccountId).Enderecos_Principal_Logradouro__c == null){
                    mapConta.get(c.AccountId).Enderecos_Principal_Logradouro__c = c.MailingStreet;
                    
                    if(!accountsToUpdate.contains(mapConta.get(c.AccountId))) accountsToUpdate.add(mapConta.get(c.AccountId));
                }
                
                if(c.MailingState != null && mapConta.get(c.AccountId).Enderecos_Principal_Bairro__c == null){
                    mapConta.get(c.AccountId).Enderecos_Principal_Bairro__c = c.MailingState;
                    
                    if(!accountsToUpdate.contains(mapConta.get(c.AccountId))) accountsToUpdate.add(mapConta.get(c.AccountId));
                } 
                
                if(c.MailingCity != null && mapConta.get(c.AccountId).Enderecos_Principal_Cidade__c == null){
                    mapConta.get(c.AccountId).Enderecos_Principal_Cidade__c = c.MailingCity;
                    
                    if(!accountsToUpdate.contains(mapConta.get(c.AccountId))) accountsToUpdate.add(mapConta.get(c.AccountId));
                }

                if(c.MailingCountry != null && mapConta.get(c.AccountId).Enderecos_Principal_Pais__c == null){
                    mapConta.get(c.AccountId).Enderecos_Principal_Pais__c = c.MailingCountry;
                    
                    if(!accountsToUpdate.contains(mapConta.get(c.AccountId))) accountsToUpdate.add(mapConta.get(c.AccountId));
                }   
                
                if(c.Numero_endereco__c != null && mapConta.get(c.AccountId).Enderecos_Principal_Numero__c == null){
                    mapConta.get(c.AccountId).Enderecos_Principal_Numero__c = c.Numero_endereco__c;
                    
                    if(!accountsToUpdate.contains(mapConta.get(c.AccountId))) accountsToUpdate.add(mapConta.get(c.AccountId));
                }
                
                if(c.Complemento_endereco__c != null && mapConta.get(c.AccountId).Enderecos_Principal_Complemento__c == null){
                    mapConta.get(c.AccountId).Enderecos_Principal_Complemento__c = c.Complemento_endereco__c;
                    
                    if(!accountsToUpdate.contains(mapConta.get(c.AccountId))) accountsToUpdate.add(mapConta.get(c.AccountId));
                }

                if(c.Bairro_endereco__c != null && mapConta.get(c.AccountId).Enderecos_Principal_Bairro__c == null){
                    mapConta.get(c.AccountId).Enderecos_Principal_Bairro__c = c.Bairro_endereco__c;
                    
                    if(!accountsToUpdate.contains(mapConta.get(c.AccountId))) accountsToUpdate.add(mapConta.get(c.AccountId));
                }
            }
            
            update accountsToUpdate;
            
        }catch(Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

            throw new customException(e.getMessage());
        }
    } // carregarEnderecoConta
    
    public static void copiarDadosConta(List<Contact> listaContato){
        String METHOD_NAME = 'copiarDadosConta';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaContato: '+ listaContato);

        List<Account> accounts = new List<Account>();
        List<Account> accountsToUpdate = new List<Account>();
        List<Id> accountIds = new List<Id>();
        Map<Id,Account> mapConta = new Map<Id,Account>();
        
        try{
            
            for(Contact c : listaContato) accountIds.add(c.AccountId);
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - accountIds: '+ accountIds);
            
            accounts = DAO_Conta.getContaPorListaId(accountIds);
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - accounts: '+ accounts);
            
            for(Account a : accounts) mapConta.put(a.Id, a);
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - mapConta: '+ mapConta);
            
            for (Contact con : listaContato){
                if (con.AccountId != null){
                    if (!String.isEmpty(mapConta.get(con.AccountId).Tipo_de_pessoa__c) && mapConta.get(con.AccountId).Tipo_de_pessoa__c == 'F-Física'){
                        if(String.isEmpty(con.CPF__c) && !String.isEmpty(mapConta.get(con.AccountId).CPF__c)) con.CPF__c = mapConta.get(con.AccountId).CPF__c;
                        
                        if(String.isEmpty(con.RG__c) && !String.isEmpty(mapConta.get(con.AccountId).DadosPF_RG__c)) con.RG__c = mapConta.get(con.AccountId).DadosPF_RG__c;
                    }
                    
                    if(String.isEmpty(con.Email) && !String.isEmpty(mapConta.get(con.AccountId).EmailNFE__c)) con.Email = mapConta.get(con.AccountId).EmailNFE__c;
                    
                    if(String.isEmpty(con.Phone) && !String.isEmpty(mapConta.get(con.AccountId).Phone)) con.Phone = mapConta.get(con.AccountId).Phone;
                    
                    if(String.isEmpty(con.MobilePhone) && !String.isEmpty(mapConta.get(con.AccountId).TelefoneCelular__c)) con.MobilePhone = mapConta.get(con.AccountId).TelefoneCelular__c;
                }
            }  
        }catch(Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());
            
            throw new customException(e.getMessage());
        }
    } // copiarDadosConta
    
    public static void cleanBlankSpaceFields(List<Contact> listaContato){
        String METHOD_NAME = 'cleanBlankSpaceFields';
        
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaContato: '+ listaContato);
        
        try{
            //Aplicando .trim() para remover espaços em branco
            //no início e final do texto
            
            for(Contact c : listaContato){
                if(c.FirstName != null) c.FirstName = c.FirstName.trim();
                
                if(c.LastName != null) c.LastName = c.LastName.trim();
                
                if(c.Title != null) c.Title = c.Title.trim();
                
                if(c.Tipo_de_registro_Lead__c != null) c.Tipo_de_registro_Lead__c = c.Tipo_de_registro_Lead__c.trim();
                
                if(c.RG__c != null) c.RG__c = c.RG__c.trim();
                
                if(c.CPF__c != null) c.CPF__c = c.CPF__c.trim();
                
                if(c.Phone != null) c.Phone = c.Phone.trim();			
                
                if(c.HomePhone != null) c.HomePhone = c.HomePhone.trim();
                
                if(c.MobilePhone != null) c.MobilePhone = c.MobilePhone.trim();
                
                if(c.AssistantPhone != null) c.AssistantPhone = c.AssistantPhone.trim();
                
                if(c.Email != null) c.Email = c.Email.trim();
                
                if(c.Telefone_2__c != null) c.Telefone_2__c = c.Telefone_2__c.trim();
                
                if(c.Telefone_3__c != null) c.Telefone_3__c = c.Telefone_3__c.trim();
                
                if(c.Telefone_4__c != null) c.Telefone_4__c = c.Telefone_4__c.trim();
                
                if(c.Description != null) c.Description = c.Description.trim();
            }																
        }catch(Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

            throw new customException(e.getMessage());
        }
    } // cleanBlankSpaceFields
    
    public static void formataCPF(List<Contact> listaContato){
        String METHOD_NAME = 'formataCPF';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaContato: '+ listaContato);

        Contact oldCtct = new Contact();
        String s;

        try{
            for(Contact c : listaContato){
                if(c.CPF__c != null) s = BCL_HLP_String.getNumberFromFormatedString(c.CPF__c);
                System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - s: '+ s);
                
                if(s != null) c.CPF__c = BCL_HLP_String.formatCPF(s);
                System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - c.CPF__c: '+ c.CPF__c);
            }
        }catch(customException e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

            throw new customException(e.getMessage());
        }
    } // formataCPF
    
    // Agregando e reescrevendo a trigger "Busca_CEP_Contato".
    @Future(callout=true)
    public static void buscaCEP(List<Id> idsToQuery){
        String METHOD_NAME = 'buscaCEP';
        
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - idsToQuery: '+ idsToQuery);
        
        List<Contact> contacts = DAO_Contato.getContatoByListId(idsToQuery);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - contacts: '+ contacts);
        
        try {
            
            for(Contact c : contacts){
                
                String endereco = '';
                String endpoint = Util_Integracao.getEndpointBuscaCEP();
                System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - endpoint: '+ endpoint);
                System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - c.MailingPostalCode: '+ c.MailingPostalCode);
                
                HttpRequest req = new HttpRequest();                
                req.setEndpoint(endpoint + c.MailingPostalCode);
                req.setMethod('GET');
                Http http = new Http();
                
                if(!Test.isRunningTest()){
                    HTTPResponse res = http.send(req);
                    
                    try {
                        endereco = res.getBody(); 
                    }catch(Exception e) {
                        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());
                    }
                } else {
                    endereco = '"tipo":"RUA","logradouro":"JOAO FALARZ","complemento":"","bairro":"CIDADE INDUSTRIAL","municipio":"CURITIBA","uf":"PR","cep":"81280270","cod_ibge":"4106902","cod_tom":null';
                }
                
                System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - endereco: '+ endereco);
                
                HTTPResponse res = http.send(req);
                
                Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                String mensagem = (String) m.get('mensagem');
                Integer status  = (Integer) m.get('status');

                System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - mensagem: '+ mensagem);
                System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - status: '+ status);
                System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - m: '+ m);
                
                Map<String, Object> dados = (Map<String, Object>) m.get('dados');
                
                if(dados != null){
                    String bairro = (String) dados.get('bairro');
                    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - bairro: '+ bairro);
                    
                    String cep1 = (String) dados.get('cep');
                    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - cep1: '+ cep1);
                    
                    String ibge = (String) dados.get('cod_ibge');
                    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - ibge: '+ ibge);
                    
                    String tom = (String) dados.get('cod_tom');
                    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - tom: '+ tom);
                    
                    String complemento = (String) dados.get('complemento');
                    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - complemento: '+ complemento);
                    
                    String logradouro = (String) dados.get('logradouro');
                    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - logradouro: '+ logradouro);
                    
                    String municipio = (String) dados.get('municipio');
                    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - municipio: '+ municipio);
                    
                    String tipo = (String) dados.get('tipo');
                    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - tipo: '+ tipo);
                    
                    String uf = (String) dados.get('uf');
                    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - uf: '+ uf);
                    
                    if(logradouro != null) c.MailingStreet = tipo + ' ' + logradouro;
                    if(bairro != null) c.Bairro_endereco__c = bairro;
                    if(municipio != null) c.MailingCity = municipio;
                    if(uf != null) c.MailingState = uf;
                    if(ibge != null) c.Codigo_municipio__c = ibge;
                    if(cep1 != null) c.MailingPostalCode = cep1;
                    
                    c.MailingCountry = 'BRASIL';

                    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - c: '+ c);
                }// if (dados != null)
            } // for (contacts)
            
            ProcessorControl.inFutureContext = true;
            
            update contacts;
        }catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());
        } // catch                
    }// Fim metodo busca 
}