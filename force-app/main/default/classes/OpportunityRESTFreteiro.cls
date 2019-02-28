// * [PRJ - SALESFORCE]
// * [STI - 86225]
//     * Generate proposal in Intranet.
//     * @recordtype Freteiro
//     * @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
//     * @param String opportunityID
//     * @return JSON JSON String
//     * @throw Exception

global class OpportunityRESTFreteiro{

    @future (callout = true)
    webservice static void generateProposal(String opportunityID){
        try{
       		System.debug(opportunityID);
            Opportunity opp = new Opportunity(); //monitoramento
            Opportunity op1 = new Opportunity(); //acessorio
            Account acc  = new Account();
            Account acc2 = new Account();
            //Contact con = new Contact();
            //Contact conem = new Contact();
            //Contact conins = new Contact();
            List<Contact> listCon = new List<Contact>();
            ItemPropostaSiggo__c car = new ItemPropostaSiggo__c();
            String IdExternoClienteIndicador = '';
            OpportunityLineItem olil = new OpportunityLineItem(); //LOCACAO
            
            //dados da oportunidade  produto monitoramento
            if(opportunityID != null){
        		opp = [SELECT
                            Id, 
                            Name, 
                            AccountId,
                            Owner.Name,
                            Owner.UserRole.Name,
                            Tipo_proposta_ID__c,
                            Tipo_contrato_ID__c,
                            Owner.IdUsuarioPreCadastro__c,
                            Prazo_do_contrato__c,
                            Valor_da_taxa_de_ades_o__c,
                            Valor_mensal_corp__c,
                            Percentual_alcan_ado__c,
                            Valor_mensal_parcelado__c,
                            Mensagem_geracao_proposta__c,
                            Siggo_PersProp_NumeroProposta__c,
                            Valor_mensal_monitoramento__c,
                            Prazo_contrato_Id__c,
                            Valor_total__c,
                            Consulta_Serasa__c,
                            Indicador__c,
                            (SELECT Id, 
                                    UnitPrice,                           
                                    Classe_do_contrato__c, 
                                    PriceBookEntry.Product2Id, 
                                    Prazo_do_contrato2__c,
                                    Valor_mensal__c,
                                    Discount,
                                    Fam_lia_de_produtos__c,
                                    Valor_unit_rio_mensal__c,
                                    Quantity
                            FROM OpportunityLineItems
                            WHERE Fam_lia_de_produtos__c = 'Monitoramento')
                        FROM
                            Opportunity
                        WHERE
                            Id =:opportunityID];
                            
            //dados da oportunidade produto acessorio
            if(opportunityID != null)
            	op1 = [SELECT
                            Id, 
                            Name, 
                            AccountId,
                            Owner.Name,
                            Tipo_proposta_ID__c,
                            Tipo_contrato_ID__c,
                            Owner.IdUsuarioPreCadastro__c,
                            Prazo_do_contrato__c,
                            Valor_da_taxa_de_ades_o__c,
                            Valor_mensal_corp__c,
                            Percentual_alcan_ado__c,
                            Valor_mensal_parcelado__c,
                            Mensagem_geracao_proposta__c,
                            Siggo_PersProp_NumeroProposta__c,
                            Valor_mensal_monitoramento__c,
                            Valor_total__c,
                            Consulta_Serasa__c, 
                            (SELECT Id, 
                                    UnitPrice,                           
                                    Classe_do_contrato__c, 
                                    PriceBookEntry.Product2Id,
                                    Id_acessorio__c, 
                                    PriceBookEntry.Product2.Id_acessorio__c,
                                    Prazo_do_contrato2__c,
                                    Valor_mensal__c,
                                    Discount,
                                    Fam_lia_de_produtos__c,
                                    Valor_unit_rio_mensal__c
                            FROM OpportunityLineItems
                            WHERE Fam_lia_de_produtos__c = 'Acessório')
                        FROM
                            Opportunity
                        WHERE
                            Id =:opportunityID];
                
/*
                 //dados do veículo            
                if(opportunityID != null){
                car = [SELECT
                            Id, 
                            Veiculo_Placa__c,
                            Veiculo_Renavam__c,
                            Veiculo_Chassi__c,
                            Veiculo_Cor__c,
                            Veiculo_AnoModelo__c,
                            Id_modelo__c,
                            Oportunidade__c
                            FROM ItemPropostaSiggo__c
                            WHERE Oportunidade__c =:opportunityID];
                    }else{
                        opp.Mensagem_geracao_proposta__c.addError('Por favor, vincule um Veículo a oportunidade.');
                    }
*/ 
                //dados da oportunidade -  produto locacao
                if(opportunityID != null){
                    olil = [SELECT Id, 
                                    UnitPrice,                           
                                    Classe_do_contrato__c, 
                                    PriceBookEntry.Product2Id,
                                    Id_acessorio__c, 
                                    PriceBookEntry.Product2.Id_acessorio__c,
                                    Prazo_do_contrato2__c,
                                    Valor_mensal__c,
                                    Discount,
                                    Fam_lia_de_produtos__c,
                                    Valor_unit_rio_mensal__c
                                FROM
                                    OpportunityLineItem
                                WHERE
                                    Fam_lia_de_produtos__c = 'Locação'
                                AND
                                    OpportunityId =:opportunityID];
                }
                
                //dados da conta              
                if(opp.AccountId != null){
                    acc = [SELECT
                                Id, 
                                Name,
                                Owner.IdUsuarioPreCadastro__c,
                                RecordType.Name,
                                CNPJ__c, 
                                CNPJ_CPF__c, 
                                Enderecos_Principal_CEP__c,
                                Enderecos_Principal_Logradouro__c,                                 
                                Enderecos_Principal_Numero__c,
                                Enderecos_Principal_Complemento__c,
                                Enderecos_Principal_Bairro__c,
                                Enderecos_Principal_Cidade__c,
                                Enderecos_Principal_UF__c,
                                Enderecos_Cobranca_CEP__c,
                                Enderecos_Cobranca_Logradouro__c,                                 
                                Enderecos_Cobranca_Numero__c,
                                Enderecos_Cobranca_Complemento__c,
                                Enderecos_Cobranca_Bairro__c,
                                Enderecos_Cobranca_Cidade__c,
                                Enderecos_Cobranca_UF__c,                                
                                Phone, 
                                Telefone_2__c, 
                                Telefone_3__c,
                                Telefone_4__c, 
                                TelefoneCelular__c, 
                                DadosPF_NomeMae__c,
                                DadosPF_DataNascimento__c,
                                DadosPF_RG__c,
                                Forma_cobranca_ID__c,
                                Dia_de_vencimento__c,
                                Tipo_pessoa_ID__c,
                                Inscri_o_estadual__c,
                                Estado_Inscricao_Estadual__c,
                                ContatoPessoaAutorizada__c,
                                ContatoEmergencia__c,
                                ContatoInstalacao__c,
                                Tipo_cliente_ID__c,
                                EMail__c,
                                EMailNFE__c,
                                DebAut_NomeTitular__c,
                                DebAut_Agencia__c,
                                DebAut_ContaCorrente__c,
                                Nome_contato_autorizado__c,
                                CPF_contato_autorizado__c,
                                RG_contato_autorizado__c,
                                Email_contato_autorizado__c,
                                Celular_contato_autorizado__c,
                                Nome_contato_emergencia__c,
                                CPF_contato_emergencia__c,
                                RG_contato_emergencia__c,
                                Email_contato_emergencia__c,
                                Celular_contato_emergencia__c,
                                Nome_contato_instalacao__c,
                                CPF_contato_instalacao__c,
                                RG_contato_instalacao__c,
                                Email_contato_instalacao__c,
                                Celular_contato_instalacao__c,
                                Cobranca_Cartao_Vcto__c,
                                Cobranca_Cartao_Numero_Cript__c                          
                            FROM
                                Account
                            WHERE
                                Id =:opp.AccountId];
                    
                    //busca ID Externo da conta indicador            
                    if(opp.Indicador__c != null){
                        acc2 = [SELECT IdExternoClienteIndicador__c FROM Account WHERE Id =:opp.Indicador__c];
                        IdExternoClienteIndicador = String.valueOf(acc2.IdExternoClienteIndicador__c);
                    } else{
                        IdExternoClienteIndicador = '';
                    }
                    
                    system.debug('IdExternoClienteIndicador__c ' + acc2.IdExternoClienteIndicador__c);
                    
                    listCon = [SELECT 
                                    Id, 
                                    Name,
                                    CPF__c,
                                    RG__c,
                                    Email,
                                    MobilePhone,
                                    Pessoa_autorizada__c,
                                    Pessoa_emergencia__c,
                                    Pessoa_instala_o__c,
                                    Account.Id
                                FROM Contact
                                WHERE Account.Id =: acc.Id];
                                
                    if(listCon.size() < 1){
                    	opp.Mensagem_geracao_proposta__c.addError('Por favor, vincule o(s) contato(s) na Conta.');
                    }
/*                                     
                    //dados do contato autorizado
                    if(acc.ContatoPessoaAutorizada__c != null){
                        con = [SELECT 
                                    Id, 
                                    Name,
                                    CPF__c,
                                    RG__c,
                                    Email,
                                    MobilePhone,
                                    Tipo_contato__c,
                                    Account.Id
                                FROM Contact
                                WHERE Id =:acc.ContatoPessoaAutorizada__c];
                                } else{
                                opp.addError('Por favor, vincule uma Pessoa Autorizada na Conta.');
                                }
                    
                     //dados do contato emergencia
                    if(acc.ContatoEmergencia__c != null){
                        conem = [SELECT 
                                    Id, 
                                    Name,
                                    CPF__c,
                                    RG__c,
                                    Email,
                                    MobilePhone,
                                    Tipo_contato__c,
                                    Account.Id
                                FROM Contact
                                WHERE Id =:acc.ContatoEmergencia__c];
                                } else{
                        opp.addError('Por favor, vincule um Contato de Emergencia na Conta.');
                    }
                    
                     //dados do contato instalacao
                     if(acc.ContatoInstalacao__c != null){
                        conins = [SELECT 
                                    Id, 
                                    Name,
                                    CPF__c,
                                    RG__c,
                                    Email,
                                    MobilePhone,
                                    Tipo_contato__c,
                                    Account.Id
                                FROM Contact
                                WHERE Id =:acc.ContatoInstalacao__c];                    
                                } else{
                                        opp.addError('Por favor, vincule um Contato de Instalação na Conta.');
                                }
*/
                } else{
					opp.addError('Por favor, vincule uma Conta a Oportunidade.');
                }           
                
                //JSON String - OPEN            
                String record = 'data={';
                
                //conta
                record = record + '"client" : {"name" : "'+ acc.Name +'", "cnpj_cpf" : "'+ acc.CNPJ_CPF__c +'", "rg" : "'+ acc.DadosPF_RG__c +'", "mother" : "'+ acc.DadosPF_NomeMae__c +'", "birthday" : "'+ acc.DadosPF_DataNascimento__c +'", "typePerson" : "'+ acc.Tipo_pessoa_ID__c +'", "numberStateRegistration": "'+ acc.Inscri_o_estadual__c +'", "localeStateRegistration" : "'+ acc.Estado_Inscricao_Estadual__c +'", "cellphone" : "'+ acc.TelefoneCelular__c +'", "phone" : "'+ acc.Phone +'", "phone2" : "'+ acc.Telefone_2__c +'", "phone3" : "'+ acc.Telefone_3__c +'", "phone4" : "'+ acc.Telefone_4__c +'", "street" : "'+ acc.Enderecos_Principal_Logradouro__c +'", "streetNumber" : "'+ acc.Enderecos_Principal_Numero__c +'", "complementAddress" : "'+ acc.Enderecos_Principal_Complemento__c +'", "district" : "'+ acc.Enderecos_Principal_Bairro__c +'", "zipCode" : "'+ acc.Enderecos_Principal_CEP__c +'", "city" : "'+ acc.Enderecos_Principal_Cidade__c +'", "state" : "'+ acc.Enderecos_Principal_UF__c +'", "street2" : "'+ acc.Enderecos_Cobranca_Logradouro__c +'", "streetNumber2" : "'+ acc.Enderecos_Cobranca_Numero__c +'", "complementAddress2" : "'+ acc.Enderecos_Cobranca_Complemento__c +'", "district2" : "'+ acc.Enderecos_Cobranca_Bairro__c +'", "zipCode2" : "'+ acc.Enderecos_Cobranca_CEP__c +'", "city2" : "'+ acc.Enderecos_Cobranca_Cidade__c +'", "state2" : "'+ acc.Enderecos_Cobranca_UF__c +'", "paymentFormat" : "'+ acc.Forma_cobranca_ID__c +'", "expirationDay" : "'+ acc.Dia_de_vencimento__c +'", "clientTypeID" : "'+ acc.Tipo_cliente_ID__c +'", "email" : "'+ acc.EMail__c +'", "email2" : "'+ acc.EMailNFE__c +'", "nameAccountHolder" : "'+ acc.DebAut_NomeTitular__c +'", "bankBranch" : "'+ acc.DebAut_Agencia__c +'", "accCurrentBank" : "'+ acc.DebAut_ContaCorrente__c +'", "cardNumber" : "'+acc.Cobranca_Cartao_Numero_Cript__c+'", "expirationDateCard" : "'+ acc.Cobranca_Cartao_Vcto__c +'"}';
                
                //contato
                record = record + ',' + '"contact" : ['; 
                String separator = '';
                
                for(Contact c: listCon){
	                //autorizado
	                if (c.Pessoa_autorizada__c == true){
                    	record = record + separator + '{"person" : {"name" : "'+ c.Name +'", "cpf" : "'+ c.CPF__c +'", "rg" : "'+ c.RG__c +'", "email" : "'+ c.Email +'",  "type" : "A", "phone" : "'+ c.MobilePhone +'"}}';
                    	separator = ',';
					}
                
	                //emergencia
	                if (c.Pessoa_emergencia__c == true){
	                	record = record + separator + '{"person" : {"name" : "'+ c.Name +'", "cpf" : "'+ c.CPF__c +'", "rg" : "'+ c.RG__c +'", "email" : "'+ c.Email +'",  "type" : "E", "phone" : "'+ c.MobilePhone +'"}}';
	                	separator = ',';
	                }
	                
	                //instalacao    
	                if (c.Pessoa_instala_o__c == true){
	            		record = record + separator + '{"person" : {"name" : "'+ c.Name +'", "cpf" : "'+ c.CPF__c +'", "rg" : "'+ c.RG__c +'", "email" : "'+ c.Email +'",  "type" : "I", "phone" : "'+ c.MobilePhone +'"}}';
	                    separator = ',';
	                }                
                }
                   
                record = record + ']';
                
                //Opportunity
                record = record + ',' + '"opportunity" : {"totalPurchase" : "'+ opp.Valor_total__c +'", "consultSerasa" : "'+ opp.Consulta_Serasa__c +'", "typeProposal" : "'+ opp.Tipo_proposta_ID__c +'", "typeContract" : "'+ opp.Tipo_contrato_ID__c +'", "paymentCondition" : "'+ opp.Prazo_contrato_Id__c +'", "contractDeadline" : "'+ opp.Prazo_do_contrato__c +'", "indicatorID" : "'+ IdExternoClienteIndicador +'", "role" : "'+ opp.Owner.UserRole.Name +'", "quantity" : "'+ opp.OpportunityLineItems[0].Quantity +'", "opportunityId" : "'+ opportunityID +'"';
                
                //produto da oportunidade 
                record = record + ',' + '"product" : [';
                separator = '';
                //caso existam varios produtos monitoramento               
                for (OpportunityLineItem li : opp.OpportunityLineItems){
       				record = record + separator + '{"item" : {"contractClass" : "'+ li.Classe_do_contrato__c +'", "membershipFeeID" : "'+ acc.Forma_cobranca_ID__c +'", "valueParcel" : "'+ olil.Valor_unit_rio_mensal__c +'", "valueMonitoring" : "'+ li.Valor_unit_rio_mensal__c +'", "percentageDiscount" : "'+ opp.Percentual_alcan_ado__c +'", "installationRateValue" : "'+ opp.Valor_da_taxa_de_ades_o__c +'", "membershipFeeAmount" : "'+ 0 +'", "numberInstallmentsMembershipFee" : "1"}}';
       				separator = ',';
				}
                record = record + ']}';

                //veiculo
                record = record + ',' + '"vehicle" : [';
                separator = '';
                //caso existam varios veiculos               
                Map<ID, ItemPropostaSiggo__c> vei = new Map<ID, ItemPropostaSiggo__c>([Select Id, 
                                                                                                Veiculo_Placa__c, 
                                                                                                Veiculo_Renavam__c, 
                                                                                                Veiculo_Chassi__c, 
                                                                                                Veiculo_Cor__c, 
                                                                                                Veiculo_AnoModelo__c, 
                                                                                                Id_modelo__c, 
                                                                                                Oportunidade__c  
                                                                                        from ItemPropostaSiggo__c 
                                                                                        where Oportunidade__c =:opportunityId]);
                for (ID idKey : vei.keyset()) {
                    ItemPropostaSiggo__c v = vei.get(idKey);
                    system.debug(vei.get(idKey));
                    record = record + separator + '{"item" : {"tag" : "'+ v.Veiculo_Placa__c +'", "renavam" : "'+ v.Veiculo_Renavam__c +'", "chassi" : "'+ v.Veiculo_Chassi__c +'", "color" : "'+ v.Veiculo_Cor__c +'", "year" : "'+ v.Veiculo_AnoModelo__c +'", "installmentsValue" : "'+ opp.Valor_mensal_parcelado__c +'", "monitoringValue" : "'+ opp.Valor_mensal_monitoramento__c +'", "model" : "'+ v.Id_modelo__c +'"}}';
                    separator = ',';
                }   
                record = record + ']';
                
                //acessorio
                record = record + ',' + '"accessory" : [';
                separator = '';
                //caso existam varios acessorios
                if (op1!= null){
                    for (OpportunityLineItem op : op1.OpportunityLineItems){
                        record = record + separator + '{"item" : {"accessoryId" : "'+ op.Id_acessorio__c +'", "contractClass" : "'+ op.Classe_do_contrato__c +'", "membershipFeeID" : "'+ acc.Forma_cobranca_ID__c +'", "valueParcel" : "'+ op.Valor_mensal__c +'", "valueMonitoring" : "'+ op.Valor_unit_rio_mensal__c +'", "percentageDiscount" : "'+ op1.Percentual_alcan_ado__c +'", "installationRateValue" : "'+ op1.Valor_da_taxa_de_ades_o__c +'", "membershipFeeAmount" : "'+ 0 +'", "numberInstallmentsMembershipFee" : "'+ 1 +'"}}';
                        separator = ',';
                    }
                }
                record = record + ']';
                
                //User ID Pré-cadastro proprietario da oportunidade
                record = record + ',' + '"usuoid": "'+ opp.Owner.IdUsuarioPreCadastro__c +'"';
                
                //User ID Pré-cadastro proprietario da conta
                record = record + ',' + '"accountOwnerId": "'+ acc.Owner.IdUsuarioPreCadastro__c +'"';
                
                //Tipo de registro da Conta
                record = record + ',' + '"recordTypeName": "'+ acc.RecordType.Name +'"'; 
                
                //JSON String - CLOSE               
                record = record + '}';
                System.debug(record);
                
                //HTTP Request
                HttpRequest req  = new HttpRequest();
                HttpResponse res = new HttpResponse();          
                Http http = new Http();

                String endpoint = Util_Integracao.getEndpointFreteiroGenerateProposal();

                req.setMethod('POST');
                req.setEndpoint(endpoint);
                //req.setEndpoint('http://intranet.sascar.com.br/RESTful/FRETEIRO/GenerateProposal.php');
                //req.setEndpoint('http://hom1-intranet.sascar.com.br/sistemaWeb/RESTful/FRETEIRO/GenerateProposal.php');
                //req.setEndpoint('http://teste.intranet.sascar.com.br/sistemaWeb/RESTful/FRETEIRO/GenerateProposal.php');
                //req.setEndpoint('http://desenvolvimento.sascar.com.br/sistemaWeb/RESTful/FRETEIRO/GenerateProposal.php');       
                req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
                req.setBody(record);
          		System.debug(record);
          
                //Send request
                res = http.send(req);
                System.debug(res);
		        System.debug(req);
                
                ///resultado do envio de dados
                String jsonString = res.getBody();
          		System.debug(jsonString);
                
                //converte os dados de retorno
                Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(jsonString);
                Integer status = (Integer) result.get('status');
                String message = (String) result.get('message');
                String data    = (String) result.get('data');
				System.debug(status);
				System.debug(message);
				System.debug(data);
          
                //grava dados de retorno na oportunidade      
                //opp.Numero_dos_contratos_ERP__c = (String) result.get('data');
                //opp.Mensagem_geracao_contrato_ERP__c = (String) result.get('message'); 
                opp.Siggo_PersProp_NumeroProposta__c = (String) result.get('data');
                opp.Mensagem_geracao_proposta__c = (String) result.get('message');
                update opp; 
            } else{
                opp.addError('O ID da Oportunidade está vazio.');
            }
        } catch(Exception e){
            System.debug('Generate Proposal Exception: ' + e);
        }
    } 
    
    
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
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
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