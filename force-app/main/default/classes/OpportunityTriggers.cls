/*
    @testClass OpportunityTriggersTest

    @description 

    @author Admin CRM Sascar
    @date 14/02/2014

     * CHANGE 28/maio Saulo para chamar atenção da SASCAR
     * criamos campo indicador siggo, tornando esta trigger obsoleta
    ---------------------------------
    @author Renan Rocha
    @date 19/11/2018
    @description:
        - Alterado parâmetro List<Opportunity> OldOpp para Map<Id, Opportunity> pOldMap do método validarNomePortador pois o mesmo não envia apenas uma oportunidade, sim uma por vez, tornando o método mais dinâmico
        - Classe refatorada e novos debugs inseridos
    @JIRA KCA-9
*/
public class OpportunityTriggers{
    
    private static String CLASS_NAME = 'OpportunityTriggers';
    
    public static void AbasteceHistoricoDetalhes(List<Opportunity> lstOpp){
        String METHOD_NAME = 'AbasteceHistoricoDetalhes';

        List<Historico_Oportunidade__c> lstHO = new List<Historico_Oportunidade__c>();
        
        for(Opportunity o :lstOpp){
            Historico_Oportunidade__c newHO = new Historico_Oportunidade__c(
                Oportunidade__c = o.Id,
                Descricao__c = o.Description,
                Data_da_Alteracao__c = datetime.now(),
                Usuario__c = UserInfo.getUserId()
            );
            
            if(o.Description != null){
                if(o.Description.length() < 70) newHO.Name = o.Description;
                else newHO.Name = o.Description.substring(0, 70) + '...';
                
                lstHO.add(newHO);
            }
        }

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - lstHO: '+ lstHO);
        
        if(lstHO.size() > 0) insert lstHO;
    }
    
    public static void ImportaHistoricoDetalhes(List<Opportunity> lstOpp){
        String METHOD_NAME = 'ImportaHistoricoDetalhes';
        
        List<Historico_Oportunidade__c> lstHO = new List<Historico_Oportunidade__c>();
        Map<String,String> leadXopp = new Map<String,String>();
        Set<String> leadIds = new Set<String>();
        
        for(Opportunity o :lstOpp){
            leadIds.add(o.IdLeadForOpp__c);
            leadXopp.put(o.IdLeadForOpp__c, o.Id);
        }
        
        List<Historico_Lead__c> lstHL = DAO_Historico_Lead.getHistoricoBySetIdLead(leadIds);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - lstHL: '+ lstHL);
        
        for(Historico_Lead__c hl :lstHL){
            Historico_Oportunidade__c newHO = new Historico_Oportunidade__c(
                Oportunidade__c = leadXopp.get(string.ValueOf(hl.Lead__c).substring(0,15)),
                Name = hl.Name,
                Descricao__c = hl.Descricao__c,
                Data_da_Alteracao__c = hl.Data_da_Alteracao__c,
                Usuario__c = hl.Usuario__c
            );
            
            lstHO.add(newHO);
        }

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - lstHO: '+ lstHO);
        
        if(lstHO.size() > 0) insert lstHO;
        if(lstHL.size() > 0) delete lstHL;
    }
    
    public static void UpdateOwner(List<Opportunity> lstOpp, List<Opportunity> OldOpp, Map<Id,RecordType> tipoRegistro){
        String METHOD_NAME = 'UpdateOwner';
        
        Map<Id, User> mapUser = new Map<Id, User>();
        Map<Id,Id> mapOldExec = new Map<Id,Id>();
        Map<Id,Id> mapOldOwner = new Map<Id,Id>();
        Set<Id> OldOwnerId = new Set<Id>();
        Set<Id> userId = new Set<Id>();
            
        for(Opportunity opp :lstOpp){
            if(tipoRegistro.get(opp.RecordTypeId).DeveloperName == 'CORP') {
                userId.add(opp.OwnerId);
                
                if(opp.Executivo_de_vendas_new__c != null) userId.add(opp.Executivo_de_vendas_new__c);
            }
        }
        
        if(OldOpp != null){
            for(Opportunity opp:OldOpp){
                if(tipoRegistro.containsKey(opp.RecordTypeId)){
                    if(tipoRegistro.get(opp.RecordTypeId).DeveloperName == 'CORP') {
                        mapOldOwner.put(opp.Id,opp.OwnerId);
                        mapOldExec.put(opp.Id,opp.Executivo_de_vendas_new__c);
                    }
                }
            }
        }

        List<User> listaUserDAO = DAO_Usuario.getUsuariosBySetId(userId);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaUserDAO: '+ listaUserDAO);

        for(User forUser : listaUserDAO) mapUser.put(forUser.Id, forUser);  
        
        for(Opportunity opp :lstOpp){
            if(tipoRegistro.get(opp.RecordTypeId).DeveloperName == 'CORP') {
                if(string.valueOf(mapUser.get(opp.OwnerId).UserRole.Name) != null){
                    if(string.valueOf(mapUser.get(opp.OwnerId).UserRole.Name).contains('TELEVENDAS')){
                        if(opp.Executivo_de_vendas_new__c != null){
                            Id Owner = mapUser.get(opp.OwnerId).Id;
    						Id Exec = mapUser.get(opp.Executivo_de_vendas_new__c).Id;
    						
                            if(mapOldOwner.containsKey(opp.Id)){
                                if(mapOldExec.get(opp.Id) == null){
                                	opp.OwnerId = mapUser.get(Exec).Id;
                                    opp.Executivo_de_vendas_new__c = mapUser.get(Owner).Id;
                                } else {
                                    opp.Executivo_de_vendas_new__c = mapUser.get(Owner).Id;
                                    
                                    if(mapOldExec.get(opp.Id) != opp.Executivo_de_vendas_new__c) opp.OwnerId = mapOldExec.get(opp.Id);
                                    else opp.OwnerId = mapOldOwner.get(opp.Id); 
                                }
                            }else{
                                opp.Executivo_de_vendas_new__c = UserInfo.getUserId();
                            	opp.OwnerId = mapUser.get(Exec).Id;
                            }
                            
                            opp.Propriet_rio_alterado__c = false;
    	                }
                    }
                }
            }
        }	
    }
    
    //Method that checks if user has more than 10 Opp open, if yes, does not allow the creation of new Opp.
    public static void BlockOpportunityCreation(List<Opportunity> lstOpp, Map<Id,RecordType> tipoRegistro){
        String METHOD_NAME = 'BlockOpportunityCreation';
        
        Set<String> setStage = new Set<String>();
        List<Opportunity> lstOppPending = new List<Opportunity>();
        
        setStage.add('Fechado');
        setStage.add('Parcialmente instalado');
        setStage.add('Instalado');
        setStage.add('Fechado acessório');
        setStage.add('Não Venda');
        setStage.add('Perdido');
        
        Boolean verifyOppPending = false;
        
        for(Opportunity opp :lstOpp){
            if(tipoRegistro.get(opp.RecordTypeId).DeveloperName == 'CORP') verifyOppPending = true;
        }

        if(verifyOppPending){
            lstOppPending = DAO_Oportunidade.getOportunidadesByOwnerIdEStageName(UserInfo.getUserId(), setStage);
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - lstOppPending: '+ lstOppPending);
        }
        
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - lstOppPending.size(): '+ lstOppPending.size());

        Integer limite = Integer.valueOf(System.Label.Oportunidades_Expiradas_Limite);
        
        for(Opportunity opp :lstOpp){
            if(lstOppPending.size() > limite && tipoRegistro.get(opp.RecordTypeId).DeveloperName == 'CORP'){
                if(!test.isRunningTest()) opp.addError('Erro: ' + System.Label.Oportunidades_Expiradas_Mensagem_erro);
            }
        }
    }
    
    public static void validarNomePortador(Opportunity opp, Map<Id, Opportunity> pOldMap, Boolean isInsert, Boolean isUpdate, String recordTypeName){
        String METHOD_NAME = 'validarNomePortador';

		if(recordTypeName.toUpperCase() == 'SIGGO'){
			if(isInsert){
				//Instalacao
				if(opp.Forma_de_pagamento_instala_o__c != null){
					if(opp.Forma_de_pagamento_instala_o__c == '24-Cartão Visa' || opp.Forma_de_pagamento_instala_o__c == '25-Cartão Mastercard' || opp.Forma_de_pagamento_instala_o__c == '82-Cartão Hipercard'){
						if(opp.Nome_do_portador__c == null || opp.Nome_do_portador__c == ''){
							opp.Nome_do_portador__c.addError('Informe o nome do portador conforme impresso no cartão.');
						}
					}
				}
				
				//Monitoramento
				if(opp.Forma_pagamento_monitoramento__c != null){
					if(opp.Forma_pagamento_monitoramento__c == '24-Cartão Visa' || opp.Forma_pagamento_monitoramento__c == '25-Cartão Mastercard' || opp.Forma_pagamento_monitoramento__c == '82-Cartão Hipercard'){
						if(opp.Nome_do_portador_2__c == null || opp.Nome_do_portador_2__c == ''){
							opp.Nome_do_portador_2__c.addError('Informe o nome do portador conforme impresso no cartão.');
						}
					}
				}
			} else if(isUpdate){
				//Instalacao
				if(opp.Forma_de_pagamento_instala_o__c != null){
					if(opp.Forma_de_pagamento_instala_o__c == '24-Cartão Visa' || opp.Forma_de_pagamento_instala_o__c == '25-Cartão Mastercard' || opp.Forma_de_pagamento_instala_o__c == '82-Cartão Hipercard'){
						//Tratando valores vazio, o sistema sempre verifica o OLD como null
						if(opp.CartaoCredito_Numero_Cript__c == ''){
							opp.CartaoCredito_Numero_Cript__c = null;
						}
						
						if(opp.Forma_de_pagamento_instala_o__c != pOldMap.get(opp.Id).Forma_de_pagamento_instala_o__c){
							if(opp.Nome_do_portador__c == null || opp.Nome_do_portador__c == ''){
								opp.Nome_do_portador__c.addError('Informe o nome do portador conforme impresso no cartão.');
							}
						} else if(opp.CartaoCredito_Numero_Cript__c != pOldMap.get(opp.Id).CartaoCredito_Numero_Cript__c){
							if(opp.Nome_do_portador__c == null || opp.Nome_do_portador__c == ''){
								opp.Nome_do_portador__c.addError('Informe o nome do portador conforme impresso no cartão.');
							}
						} else if(opp.Nome_do_portador__c != pOldMap.get(opp.Id).Nome_do_portador__c){
							if(opp.Nome_do_portador__c == null || opp.Nome_do_portador__c == ''){
								opp.Nome_do_portador__c.addError('Informe o nome do portador conforme impresso no cartão.');
							}
						}
					}
				}
				
				//Monitoramento
				if(opp.Forma_pagamento_monitoramento__c != null){
					if(opp.Forma_pagamento_monitoramento__c == '24-Cartão Visa' || opp.Forma_pagamento_monitoramento__c == '25-Cartão Mastercard' || opp.Forma_pagamento_monitoramento__c == '82-Cartão Hipercard'){
						//Tratando valores vazio, o sistema sempre verifica o OLD como null
						if(opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c == ''){
							opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c = null;
						}
						
						if(opp.Forma_pagamento_monitoramento__c != pOldMap.get(opp.Id).Forma_pagamento_monitoramento__c){
							if(opp.Nome_do_portador_2__c == null || opp.Nome_do_portador_2__c == ''){
								opp.Nome_do_portador_2__c.addError('Informe o nome do portador conforme impresso no cartão.');
							}
						} else if(opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c != pOldMap.get(opp.Id).N_mero_do_C_de_Cr_dito_do_Monitoramento__c){
							if(opp.Nome_do_portador_2__c == null || opp.Nome_do_portador_2__c == ''){
								opp.Nome_do_portador_2__c.addError('Informe o nome do portador conforme impresso no cartão.');
							}
						} else if(opp.Nome_do_portador_2__c != pOldMap.get(opp.Id).Nome_do_portador_2__c){
							if(opp.Nome_do_portador_2__c == null || opp.Nome_do_portador_2__c == ''){
								opp.Nome_do_portador_2__c.addError('Informe o nome do portador conforme impresso no cartão.');
							}
						}
					}
				}
			}
		}
    }
}