trigger Opportunity_Bloquear on Opportunity (before insert, before update) {
    Map<Id,Opportunity> mapRTOpp = new Map<Id,Opportunity>();
    Map<Id,Opportunity> mapOpp = new Map<Id,Opportunity>();
    
    Set<Id> rtIds = new Set<Id>();
    //Map<Id,RecordType> tipoRegistro = new Map<Id,RecordType>();
    
    Set<Id> OppId = new Set<Id>();
    Set<Id> OppError = new Set<Id>();
    
    // Check the id of the recordtype
    for(Opportunity opp :Trigger.new){
        rtIds.add(opp.RecordTypeId);
    }
    // Add RecordTypes on the MAP
    Map<Id,RecordType> tipoRegistro = new Map<Id,RecordType>([SELECT Id, DeveloperName FROM RecordType WHERE Id IN :rtIds]);
    
    String perfil = [SELECT Name FROM Profile WHERE Id = :UserInfo.getProfileId() LIMIT 1].Name;
    
    if(perfil != 'Administrador do sistema' || Test.isRunningTest()){

      if(trigger.isInsert){
            OpportunityTriggers.BlockOpportunityCreation(trigger.new, tipoRegistro);
      } else {
        
        if(!(trigger.IsDelete)){
            
            for(Opportunity opp: Trigger.new){
                OppId.add(opp.Id);
                
                Opportunity oldOpp = System.Trigger.oldMap.get(opp.Id);
                
                // Verifies that is trying to change fields that can't be changed by business rules
                if (tipoRegistro.get(opp.RecordTypeId).DeveloperName == 'Siggo' && 
                    ((oldOpp.Canal_de_entrada__c != null && opp.Canal_de_entrada__c != oldOpp.Canal_de_entrada__c) || 
                    (oldOpp.LeadSource != null && opp.LeadSource != oldOpp.LeadSource))
                   ) {
                        opp.addError('Não é permitido alterar o canal de entrada ou a origem do lead.');
                    }
            }
            
            for(Opportunity opp: [SELECT Id, RecordType.Name, Name, AccountId, Executivo_de_vendas_new__c,
                                  Enviado_por__c, Type, Regional__c, CampaignId, LeadSource,
                                  Conhece_o_produto__c, Utiliza_rastreador_do_concorrente__c,
                                  Marca_do_concorrente__c, Embarcador__c, Gerenciador_de_risco__c,
                                  Outro_GR__c, Segmento__c, Outro_Segmento__c, Taxa_de_ades_o__c,
                                  Valor_da_taxa_de_ades_o__c, Propriet_rio_alterado__c, Tipo_de_registro_Lead__c,
                                  Criado_depois_de_03_02__c, Aprova_o__c, StageName, Motivo_da_perda__c,
                                  Detalhes_da_perda__c, Owner.isActive
                                  FROM Opportunity
                                  WHERE Id IN :OppId]){
                if(opp.RecordType.Name == 'CORP') mapRTOpp.put(opp.Id,opp);
            }
            
            for(Opportunity opp: Trigger.new){
                if(mapRTOpp.containsKey(opp.Id)) mapOpp.put(opp.Id, opp);
            }
        }
            
        for(Opportunity opp: Trigger.old){
            if(mapOpp.containsKey(opp.Id)){
                if(opp.Aprova_o__c == 'Aprovado' && mapRTOpp.get(opp.Id).Owner.isActive == true){
                    /*** MODIFICATION GI 1682- Carlos Prates - 30/06/2014 15:30
                    *** if(
                    ***   opp.Name != mapOpp.get(opp.Id).Name ||
                    ***   opp.AccountId != mapOpp.get(opp.Id).AccountId ||
                    ***   opp.Executivo_de_vendas_new__c != mapOpp.get(opp.Id).Executivo_de_vendas_new__c ||
                    ***   opp.Enviado_por__c != mapOpp.get(opp.Id).Enviado_por__c ||
                    ***   opp.Type != mapOpp.get(opp.Id).Type ||
                    ***   opp.Regional__c != mapOpp.get(opp.Id).Regional__c ||
                    ***   opp.CampaignId != mapOpp.get(opp.Id).CampaignId ||
                    ***   opp.LeadSource != mapOpp.get(opp.Id).LeadSource ||
                    ***   opp.Conhece_o_produto__c != mapOpp.get(opp.Id).Conhece_o_produto__c ||
                    ***   opp.Utiliza_rastreador_do_concorrente__c != mapOpp.get(opp.Id).Utiliza_rastreador_do_concorrente__c ||
                    ***   opp.Marca_do_concorrente__c != mapOpp.get(opp.Id).Marca_do_concorrente__c ||
                    ***   opp.Embarcador__c != mapOpp.get(opp.Id).Embarcador__c ||
                    ***   opp.Gerenciador_de_risco__c != mapOpp.get(opp.Id).Gerenciador_de_risco__c ||
                    ***   opp.Outro_GR__c != mapOpp.get(opp.Id).Outro_GR__c ||
                    ***   opp.Segmento__c != mapOpp.get(opp.Id).Segmento__c ||
                    ***   opp.Outro_Segmento__c != mapOpp.get(opp.Id).Outro_Segmento__c ||
                    ***   opp.Taxa_de_ades_o__c != mapOpp.get(opp.Id).Taxa_de_ades_o__c ||
                    ***   opp.Valor_da_taxa_de_ades_o__c != mapOpp.get(opp.Id).Valor_da_taxa_de_ades_o__c ||
                    ***   opp.Propriet_rio_alterado__c != mapOpp.get(opp.Id).Propriet_rio_alterado__c ||
                    ***   opp.Tipo_de_registro_Lead__c != mapOpp.get(opp.Id).Tipo_de_registro_Lead__c ||
                    ***   opp.Criado_depois_de_03_02__c != mapOpp.get(opp.Id).Criado_depois_de_03_02__c
                    *** )
                    ***
                    *** END MODIFICATION GI 1682- Carlos Prates - 30/06/2014 15:30
                    ***/
                    
                    // MODIFICATION GI 1682- Carlos Prates - 30/06/2014 15:30
                    // The fields can not be changed if the opportunity is approved.
                    if( opp.Valor_da_taxa_de_ades_o__c != mapOpp.get(opp.Id).Valor_da_taxa_de_ades_o__c ||
                       opp.Criado_depois_de_03_02__c != mapOpp.get(opp.Id).Criado_depois_de_03_02__c
                      ) {
                          // END MODIFICATION GI 1682- Carlos Prates - 30/06/2014 15:30
                          //opp.addError('Não é possível concluir as alterações realizadas após a Oportunidade já ter sido Aprovada.');
                          OppError.add(opp.Id);
                      }
                    
                    // MODIFICATION GI 1682- Carlos Prates - 01/07/2014 15:40
                    // The fields can not be changed if the opportunity is approved.
                    if( opp.Taxa_de_ades_o__c != mapOpp.get(opp.Id).Taxa_de_ades_o__c &&
                       (opp.Taxa_de_ades_o__c == 'Não' && mapOpp.get(opp.Id).Taxa_de_ades_o__c == '')
                      ){
                          //opp.addError('Não é possível concluir as alterações realizadas após a Oportunidade já ter sido Aprovada.');
                          OppError.add(opp.Id);
                      }
                    // END MODIFICATION GI 1682- Carlos Prates - 01/07/2014 15:40
                    
                    if( mapOpp.get(opp.Id).StageName != 'Perdido' && (opp.Motivo_da_perda__c != mapOpp.get(opp.Id).Motivo_da_perda__c || 
                                                                      opp.Detalhes_da_perda__c != mapOpp.get(opp.Id).Detalhes_da_perda__c)){
                                                                          //opp.addError('Não é possível concluir as alterações realizadas após a Oportunidade já ter sido Aprovada.');
                                                                          oppError.add(opp.Id);
                                                                      }
                }
            }
        }
     
        if(!(trigger.IsDelete)){
            for(Opportunity opp :trigger.new){
                if(oppError.contains(opp.Id)) opp.addError('Não é possível concluir as alterações realizadas após a Oportunidade já ter sido Aprovada.'); 
            }
        }
      }
    }
}