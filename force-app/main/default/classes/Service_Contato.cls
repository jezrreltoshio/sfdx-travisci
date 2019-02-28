/*
Classe de teste: N/A
Criado por: Rafael Silva
Data de criação: 21/06/2018
Descrição: Classe reescrita para a unificação das triggers de contato, e correção dos erros de construção.
*/
public class Service_Contato {
    
    
    public static void carregarEnderecoConta(List<Contact> listaContato)
    {
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Contato - carregarEnderecoConta()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Contato - carregarEnderecoConta()] - listaContato: '+listaContato);
        
        try{
            
            Map<Id,Account> mapConta = new Map<Id,Account>();
            List<Id> accountIds = new List<Id>();
            List<Account> accounts = new List<Account>();
            List<Account> accountsToUpdate = new List<Account>();
            for(Contact c : listaContato)
            {
                accountIds.add(c.AccountId);
            }
            
            accounts = DAO_Conta.getContaPorListaId(accountIds);
            
            for(Account a : accounts)
            {
                mapConta.put(a.Id, a);
            }
            
            for(Contact c : listaContato)
            {
                /* rbasilva 21-06-2018:
                * 
                * Essa lógica está correta? Está atualizando os campos em conta somente quando o valor do campo está vazio.
                */
                if(c.MailingPostalCode != null && mapConta.get(c.AccountId).Enderecos_Principal_CEP__c == null)
                {
                    mapConta.get(c.AccountId).Enderecos_Principal_CEP__c = c.MailingPostalCode;
                    if(!accountsToUpdate.contains(mapConta.get(c.AccountId)))
                        accountsToUpdate.add(mapConta.get(c.AccountId));
                }
                if(c.MailingStreet != null && mapConta.get(c.AccountId).Enderecos_Principal_Logradouro__c == null)
                {
                    mapConta.get(c.AccountId).Enderecos_Principal_Logradouro__c = c.MailingStreet;
                    if(!accountsToUpdate.contains(mapConta.get(c.AccountId)))
                        accountsToUpdate.add(mapConta.get(c.AccountId));
                }
                if(c.MailingState != null && mapConta.get(c.AccountId).Enderecos_Principal_Bairro__c == null)
                {
                    mapConta.get(c.AccountId).Enderecos_Principal_Bairro__c = c.MailingState;
                    if(!accountsToUpdate.contains(mapConta.get(c.AccountId)))
                        accountsToUpdate.add(mapConta.get(c.AccountId));
                } 
                if(c.MailingCity != null && mapConta.get(c.AccountId).Enderecos_Principal_Cidade__c == null)
                {
                    mapConta.get(c.AccountId).Enderecos_Principal_Cidade__c = c.MailingCity;
                    if(!accountsToUpdate.contains(mapConta.get(c.AccountId)))
                        accountsToUpdate.add(mapConta.get(c.AccountId));
                }
                if(c.MailingCountry != null && mapConta.get(c.AccountId).Enderecos_Principal_Pais__c == null) 
                {
                    mapConta.get(c.AccountId).Enderecos_Principal_Pais__c = c.MailingCountry;
                    if(!accountsToUpdate.contains(mapConta.get(c.AccountId)))
                        accountsToUpdate.add(mapConta.get(c.AccountId));
                }   
                if(c.Numero_endereco__c != null && mapConta.get(c.AccountId).Enderecos_Principal_Numero__c == null) 
                {
                    mapConta.get(c.AccountId).Enderecos_Principal_Numero__c = c.Numero_endereco__c;
                    if(!accountsToUpdate.contains(mapConta.get(c.AccountId)))
                        accountsToUpdate.add(mapConta.get(c.AccountId));
                }
                if(c.Complemento_endereco__c != null && mapConta.get(c.AccountId).Enderecos_Principal_Complemento__c == null) 
                {
                    mapConta.get(c.AccountId).Enderecos_Principal_Complemento__c = c.Complemento_endereco__c;
                    if(!accountsToUpdate.contains(mapConta.get(c.AccountId)))
                        accountsToUpdate.add(mapConta.get(c.AccountId));
                }
                if(c.Bairro_endereco__c != null && mapConta.get(c.AccountId).Enderecos_Principal_Bairro__c == null)
                {
                    mapConta.get(c.AccountId).Enderecos_Principal_Bairro__c = c.Bairro_endereco__c;
                    if(!accountsToUpdate.contains(mapConta.get(c.AccountId)))
                        accountsToUpdate.add(mapConta.get(c.AccountId));
                }
            }
            
            update accountsToUpdate;
            
        }catch(Exception e)
        {
            System.debug(LoggingLevel.ERROR, '__ [cls Service_Contato - carregarEnderecoConta()] - ERRO: '+e.getMessage());
            throw new customException(e.getMessage());
        }
    } // carregarEnderecoConta
    
    public static void copiarDadosConta(List<Contact> listaContato) //rbsilva 22-06-2018: replicar a trigger "Contact_CopyAccountDate.apxt" no processo de unificação.
    {
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Contato - copiarDadosConta()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Contato - copiarDadosConta()] - listaContato: '+listaContato);
        
        try{
            Map<Id,Account> mapConta = new Map<Id,Account>();
            List<Id> accountIds = new List<Id>();
            List<Account> accounts = new List<Account>();
            List<Account> accountsToUpdate = new List<Account>();
            for(Contact c : listaContato)
            {
                accountIds.add(c.AccountId);
            }
            accounts = DAO_Conta.getContaPorListaId(accountIds);
            
            for(Account a : accounts)
            {
                mapConta.put(a.Id, a);
            }
            
            for (Contact con : listaContato) 
            {
                if (con.AccountId != null) 
                {
                    if (!String.isEmpty(mapConta.get(con.AccountId).Tipo_de_pessoa__c) && mapConta.get(con.AccountId).Tipo_de_pessoa__c == 'F-Física'){
                        if (String.isEmpty(con.CPF__c) && !String.isEmpty(mapConta.get(con.AccountId).CPF__c)){
                            con.CPF__c = mapConta.get(con.AccountId).CPF__c;
                        }
                        if (String.isEmpty(con.RG__c) && !String.isEmpty(mapConta.get(con.AccountId).DadosPF_RG__c)){
                            con.RG__c = mapConta.get(con.AccountId).DadosPF_RG__c;
                        }
                    }
                    if (String.isEmpty(con.Email) && !String.isEmpty(mapConta.get(con.AccountId).EmailNFE__c)){
                        con.Email = mapConta.get(con.AccountId).EmailNFE__c;
                    }
                    if (String.isEmpty(con.Phone) && !String.isEmpty(mapConta.get(con.AccountId).Phone)){
                        con.Phone = mapConta.get(con.AccountId).Phone;
                    }
                    if (String.isEmpty(con.MobilePhone) && !String.isEmpty(mapConta.get(con.AccountId).TelefoneCelular__c)){
                        con.MobilePhone = mapConta.get(con.AccountId).TelefoneCelular__c;
                    }
                }
            }  
        }
        catch(Exception e)
        {
            System.debug(LoggingLevel.ERROR, '__ [cls Service_Contato - copiarDadosConta()] - ERRO: '+e.getMessage());
            throw new customException(e.getMessage());
        }
    } // copiarDadosConta
    
    public static void cleanBlankSpaceFields(List<Contact> listaContato) //rbsilva 22-06-2018: replicar a trigger "Contact_CleanBlankSpaceFields.apxt" no processo de unificação.
    {
        try{
            //Aplicando .trim() para remover espaços em branco
            //no início e final do texto
            System.debug(LoggingLevel.ERROR, '__ [cls Service_Contato - cleanBlankSpaceFields()] - Inicio...');
            System.debug(LoggingLevel.ERROR, '__ [cls Service_Contato - cleanBlankSpaceFields()] - listaContato: '+listaContato);
            
            for(Contact c : listaContato)
            {
                if(c.FirstName != null) 
                    c.FirstName = c.FirstName.trim();
                if(c.LastName != null) 
                    c.LastName = c.LastName.trim();
                if(c.Title != null) 
                    c.Title = c.Title.trim();
                if(c.Tipo_de_registro_Lead__c != null) 
                    c.Tipo_de_registro_Lead__c = c.Tipo_de_registro_Lead__c.trim();
                if(c.RG__c != null) 
                    c.RG__c = c.RG__c.trim();
                if(c.CPF__c != null) 
                    c.CPF__c = c.CPF__c.trim();
                if(c.Phone != null) 
                    c.Phone = c.Phone.trim();			
                if(c.HomePhone != null) 
                    c.HomePhone = c.HomePhone.trim();
                if(c.MobilePhone != null) 
                    c.MobilePhone = c.MobilePhone.trim();
                if(c.AssistantPhone != null) 
                    c.AssistantPhone = c.AssistantPhone.trim();
                if(c.Email != null) 
                    c.Email = c.Email.trim();
                if(c.Telefone_2__c != null) 
                    c.Telefone_2__c = c.Telefone_2__c.trim();
                if(c.Telefone_3__c != null) 
                    c.Telefone_3__c = c.Telefone_3__c.trim();
                if(c.Telefone_4__c != null) 
                    c.Telefone_4__c = c.Telefone_4__c.trim();
                if(c.Description != null) 
                    c.Description = c.Description.trim();
            }																
        } 
        catch(Exception e)
        {
            System.debug(LoggingLevel.ERROR, '__ [cls Service_Contato - cleanBlankSpaceFields()] - ERRO: '+e.getMessage());
            throw new customException(e.getMessage());
        }
    } // cleanBlankSpaceFields
    
    public static void formataCPF(List<Contact> listaContato)
    {
        try{
            Contact oldCtct = new Contact();
            
            String s;
            
            for(Contact c : listaContato)
            {
                //oldCtct = (Contact) Trigger.oldMap.get(c.Id);
                
                //System.debug(LoggingLevel.ERROR, '__ [cls Service_Contato - formataCPF()] - oldCtct: '+oldCtct);
                
                //if((oldCtct.CPF__c != c.CPF__c) || (oldCtct == null)) //verificar se entra na trigger em insert e em update
                //{
                    if(c.CPF__c != null)
                        s = BCL_HLP_String.getNumberFromFormatedString(c.CPF__c);
                    
                    if(s != null)
                        c.CPF__c = BCL_HLP_String.formatCPF(s);
                //}
            }
        }
        catch(customException e)
        {
            throw new customException(e.getMessage());
        }
        
    } // formataCPF
    
    // Agregando e reescrevendo a trigger "Busca_CEP_Contato".
    @Future(callout=true)
    public static void buscaCEP(List<Id> idsToQuery){//(String id, String cep) {
        
        System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Contato - busca()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Contato - busca()] - idsToQuery: '+idsToQuery);
        
        List<Contact> contacts = [SELECT Id, MailingPostalCode FROM Contact WHERE Id IN : idsToQuery];
        
        try {
            
            for(Contact c : contacts)
            {
                String endereco = '';
                String endpoint = Util_Integracao.getEndpointBuscaCEP();
                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Contato - busca()] - endpoint: '+endpoint);
                System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Contato - busca()] - MailingPostalCode: '+c.MailingPostalCode);
                
                HttpRequest req = new HttpRequest();                
                req.setEndpoint(endpoint+c.MailingPostalCode);
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
                }// if (dados != null)
            } // for (contacts)
            
            ProcessorControl.inFutureContext = true;
            
            update contacts;
            
        } // try 
        catch (Exception e){
            System.debug(LoggingLevel.ERROR, '__ [cls Busca_CEP_Contato - busca()] - ERRO: '+e.getMessage());
        } // catch                
    }// Fim metodo busca 
}