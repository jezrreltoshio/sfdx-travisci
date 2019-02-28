/****************************************************************** 
 *CHANGE 24/02/2015 - Carlos Prates - DESATIVAR TRIGGER           *
 * Causa: Unificação de Triggers do Objeto Oportunidade           *
 * Motivo: Evitar que exceções causados por limites da ferramenta *
 * Alterações: Métodos enviados para trigger OpportunityTrigger   * 
 ******************************************************************/

trigger Opportunity_VerifyApprovalProcess on Opportunity (before update) {
  
    Map<Id,RecordType> tipoRegistro = new Map<Id,RecordType>();
    Map<Id, Opportunity> aprovacoes = new Map<Id, Opportunity>{};
      
    //String perfil = [SELECT Name FROM Profile WHERE Id = :UserInfo.getProfileId() LIMIT 1].Name;
    //String papel = '';
    //if (!String.isEmpty(UserInfo.getUserRoleId())) {
    //    papel = [SELECT Name FROM UserRole WHERE Id = :UserInfo.getUserRoleId() LIMIT 1].Name;
    //}
    
    //Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
    for( Opportunity opp: trigger.new ) {
        // Check the type of the record
        tipoRegistro.put(opp.RecordTypeId,null);
    }
    for( RecordType rt : [select Id, Name from RecordType where Id in :tipoRegistro.keySet()] ) {
        tipoRegistro.put(rt.Id, rt);
    }
    // END Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
    
    for(Opportunity opp: trigger.new) {
        Opportunity oldOpp = System.Trigger.oldMap.get(opp.Id);
        
       //Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
        // // Check the type of the record
        // tipoRegistro.put(opp.RecordTypeId,null);
        // for (RecordType rt : [select Id, Name from RecordType where Id in :tipoRegistro.keySet()]) {
        //    tipoRegistro.put(rt.Id, rt);
        //}
       // END Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014 
        
        // Verifies the payment methos to see if they're ok
        if (tipoRegistro.get(opp.RecordTypeId).Name == 'Siggo') {
            String perfil = [SELECT Name FROM Profile WHERE Id = :UserInfo.getProfileId() LIMIT 1].Name;
            String papel = '';
            if (!String.isEmpty(UserInfo.getUserRoleId())) {
                papel = [SELECT Name FROM UserRole WHERE Id = :UserInfo.getUserRoleId() LIMIT 1].Name;
            }
            // Verify if it's trying to save an approved record without "proposta"
            if(opp.Siggo_PersProp_AguardandoRetorno__c != true){
                if (opp.Status_aprova_o_manual__c != 'Reiniciada' && String.isEmpty(opp.Siggo_PersProp_NumeroProposta__c) && 
                    (oldOpp.Siggo_PersProp_AguardandoRetorno__c == opp.Siggo_PersProp_AguardandoRetorno__c) && 
                    (oldOpp.Siggo_AnalCred_ResultadoAnalise__c == 0 || oldOpp.Status_aprova_o_manual__c == 'Aprovada')){
                    opp.addError('Você não pode editar uma oportunidade aprovada. Gere a proposta, finalizando a oportunidade ou reinicie a análise de crédito.');
                }
            }
    
            // Verify if it's trying to change an approved oppty with a generated proposal;
            // only fields "Fase" and "Data de fechamento" should be updatable for SIGGO oppties
            // and all fields for ADMIN/Supervisor
            if (!String.isEmpty(opp.Siggo_PersProp_NumeroProposta__c) && perfil != 'Administrador do sistema' && papel != 'SUPERVISOR SIGGO' && 
               (oldOpp.Siggo_AnalCred_ResultadoAnalise__c == 0 || oldOpp.Status_aprova_o_manual__c == 'Aprovada')){
               if (papel == 'TELEVENDAS SIGGO'){
                    if (oldOpp.RecordTypeId != opp.RecordTypeId || oldOpp.OwnerId != opp.OwnerId || oldOpp.Indicador__c != opp.Indicador__c || 
                     oldOpp.Motivo_de_n_o_venda__c != opp.Motivo_de_n_o_venda__c || oldOpp.Name != opp.Name || 
                     oldOpp.CampaignId != opp.CampaignId || oldOpp.Canal_de_entrada__c != opp.Canal_de_entrada__c || oldOpp.LeadSource != opp.LeadSource ||
                     oldOpp.AccountId != opp.AccountId || oldOpp.Siggo_TipoProposta__c != opp.Siggo_TipoProposta__c || oldOpp.Description != opp.Description ||
                     oldOpp.Forma_de_pagamento_instala_o__c != opp.Forma_de_pagamento_instala_o__c || oldOpp.Parcelamento_da_instala_o__c != opp.Parcelamento_da_instala_o__c ||
                        
                     (oldOpp.CartaoCredito_Numero_Cript__c != opp.CartaoCredito_Numero_Cript__c && 
                        opp.CartaoCredito_Numero_Cript__c != '') || 
                     (oldOpp.CartaoCredito_CodigoSeguranca_Cript__c != opp.CartaoCredito_CodigoSeguranca_Cript__c && 
                        opp.CartaoCredito_CodigoSeguranca_Cript__c != '') ||
                        
                     oldOpp.CartaoCredito_Vencimento__c != opp.CartaoCredito_Vencimento__c || 
                     oldOpp.Usar_dados_de_pagamento_da_instala_o__c != opp.Usar_dados_de_pagamento_da_instala_o__c ||
                     oldOpp.Forma_pagamento_monitoramento__c != opp.Forma_pagamento_monitoramento__c || 
                        
                     (oldOpp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c != opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c &&
                        opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c != '') ||
                     (oldOpp.C_d_de_Seg_do_C_de_Cr_dito_do_monit__c != opp.C_d_de_Seg_do_C_de_Cr_dito_do_monit__c &&
                        opp.C_d_de_Seg_do_C_de_Cr_dito_do_monit__c != '') ||
                        
                     oldOpp.Agencia_para_D_A_do_monitoramento__c != opp.Agencia_para_D_A_do_monitoramento__c || 
                     oldOpp.Conta_Corrente_para_DA_do_monitoramento__c != opp.Conta_Corrente_para_DA_do_monitoramento__c || 
                     oldOpp.Vcto_do_C_de_Cr_dito_do_monitoramento__c != opp.Vcto_do_C_de_Cr_dito_do_monitoramento__c || 
                     oldOpp.Nome_do_Tit_para_DA_do_monitoramento__c != opp.Nome_do_Tit_para_DA_do_monitoramento__c || oldOpp.ProfissaoProprietario__c != opp.ProfissaoProprietario__c ||
                     oldOpp.PEP1__c != opp.PEP1__c || oldOpp.PEP2__c != opp.PEP2__c || oldOpp.Valor_da_instala_o__c != opp.Valor_da_instala_o__c || 
                     oldOpp.Justificativa_an_lise_manual_cr_dito__c != opp.Justificativa_an_lise_manual_cr_dito__c) {

                    opp.addError('Você só pode modificar os campos FASE e DATA DE FECHAMENTO após gerar a proposta.');
                   }
                } else {
                    opp.addError('Você não tem acesso a modificar uma oportunidade cuja proposta já foi gerada.');
                }
            }
        }
        
        /* Verify it's starting a process after a return of 2 ("Em análise") 
        * in the automatic credit analysis process. */
        if (oldOpp.Siggo_AnalCred_ResultadoAnalise__c != 2 && opp.Siggo_AnalCred_ResultadoAnalise__c == 2) {
            opp.Justificativa_an_lise_manual_cr_dito__c = 'Envio automático';
        }
    
        // Verifies that it's trying to approve or deny the opportunity
        if (oldOpp.Status_aprova_o_manual__c == 'Em análise' && 
            (opp.Status_aprova_o_manual__c == 'Negada' || opp.Status_aprova_o_manual__c == 'Aprovada')) { 
                aprovacoes.put(opp.Id, opp); 
        }
    //Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
    //    if (!aprovacoes.isEmpty()) {
    //        
    //        // UPDATE 2/1/2014: Get the most recent approval process instance for the object.
    //        // If there are some approvals to be reviewed for approval, then
    //        // get the most recent process instance for each object.
    //        List<Id> processInstanceIds = new List<Id>{};
    //    
    //        for (Opportunity opps : [SELECT (SELECT ID FROM ProcessInstances ORDER BY CreatedDate DESC LIMIT 1)
    //                                 FROM Opportunity
    //                                 WHERE ID IN :aprovacoes.keySet()]){
    //            processInstanceIds.add(opps.ProcessInstances[0].Id);
    //        }
    //  
    //        // Now that we have the most recent process instances, we can check
    //        // the most recent process steps for comments.  
    //        for (ProcessInstance pi : [SELECT TargetObjectId, (SELECT Id, StepStatus, Comments FROM Steps ORDER BY CreatedDate DESC LIMIT 1)
    //                                   FROM ProcessInstance
    //                                   WHERE Id IN :processInstanceIds
    //                                   ORDER BY CreatedDate DESC]) {                   
    //            if ((pi.Steps[0].Comments == null || 
    //                pi.Steps[0].Comments.trim().length() == 0)){
    //                aprovacoes.get(pi.TargetObjectId).addError(
    //                  '<span style="text-weight:bold;size:20pt;color:red;">Ocorreu um erro, você deve preencher o campo de comentários.</span>');
    //            } else {
    //    
    //                // Log the status change of approval in the custom object for reporting purposes
    //                try{
    //                    Resumo_analise_manual_oportunidade__c resumo = 
    //                        [SELECT Oportunidade__c, Resultado_do_processo__c, T_rmino_do_processo_em__c, Aprovador__c
    //                         FROM Resumo_analise_manual_oportunidade__c WHERE Oportunidade__c = :aprovacoes.get(pi.TargetObjectId).Id];
    //            
    //                    resumo.Resultado_do_processo__c = aprovacoes.get(pi.TargetObjectId).Status_aprova_o_manual__c;
    //                    resumo.T_rmino_do_processo_em__c = DateTime.now();
    //                    resumo.Aprovador__c = UserInfo.getUserId();
    //                    update resumo;
    //                }catch(Exception e){ /*needed to fix bug*/ }
    //            }
    //        }  
    //    }
    //END Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
    }
    //Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
    if (!aprovacoes.isEmpty()) {
            
        // UPDATE 2/1/2014: Get the most recent approval process instance for the object.
        // If there are some approvals to be reviewed for approval, then
        // get the most recent process instance for each object.
        List<Id> processInstanceIds = new List<Id>{};
        
        for (Opportunity opps : [SELECT (SELECT ID FROM ProcessInstances ORDER BY CreatedDate DESC LIMIT 1)
                                   FROM Opportunity
                                  WHERE ID IN :aprovacoes.keySet()]){
            processInstanceIds.add(opps.ProcessInstances[0].Id);
        }
      
        // Now that we have the most recent process instances, we can check
        // the most recent process steps for comments.  
        for (ProcessInstance pi : [SELECT TargetObjectId, (SELECT Id, StepStatus, Comments FROM Steps ORDER BY CreatedDate DESC LIMIT 1)
                                     FROM ProcessInstance
                                    WHERE Id IN :processInstanceIds
                                 ORDER BY CreatedDate DESC]) {                 
            if ((pi.Steps[0].Comments == null || 
                pi.Steps[0].Comments.trim().length() == 0)){
                aprovacoes.get(pi.TargetObjectId).addError(
                  '<span style="text-weight:bold;size:20pt;color:red;">Ocorreu um erro, você deve preencher o campo de comentários.</span>');
            } else {
        
                // Log the status change of approval in the custom object for reporting purposes
                try{
                    Resumo_analise_manual_oportunidade__c resumo = 
                        [SELECT Oportunidade__c, Resultado_do_processo__c, T_rmino_do_processo_em__c, Aprovador__c
                           FROM Resumo_analise_manual_oportunidade__c WHERE Oportunidade__c = :aprovacoes.get(pi.TargetObjectId).Id];
               
                    resumo.Resultado_do_processo__c = aprovacoes.get(pi.TargetObjectId).Status_aprova_o_manual__c;
                    resumo.T_rmino_do_processo_em__c = DateTime.now();
                    resumo.Aprovador__c = UserInfo.getUserId();
                    update resumo;
                }catch(Exception e){ /*needed to fix bug*/ }
            }
        }
    }
    //END Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
}