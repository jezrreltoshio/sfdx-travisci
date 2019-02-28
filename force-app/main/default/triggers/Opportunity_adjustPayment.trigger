/****************************************************************** 
 *CHANGE 24/02/2015 - Carlos Prates - DESATIVAR TRIGGER           *
 * Causa: Unificação de Triggers do Objeto Oportunidade           *
 * Motivo: Evitar que exceções causados por limites da ferramenta *
 * Alterações: Métodos enviados para trigger OpportunityTrigger   * 
 ******************************************************************/

trigger Opportunity_adjustPayment on Opportunity (before insert, before update) {
    
    Map<Id,RecordType> tipoRegistro = new Map<Id,RecordType>();
    Map<Id,Account> acc = new Map<Id,Account>();
    String msgErro = '';
    
    // Check the type of the records
    for(Opportunity opp: trigger.new) {
        tipoRegistro.put(opp.RecordTypeId,null);
    }
    for (RecordType rt : [select Id, Name from RecordType where Id in :tipoRegistro.keySet()]) {
        tipoRegistro.put(rt.Id, rt);
    }
    
    // Build account list
    for(Opportunity opp: trigger.new) {
        if (tipoRegistro.get(opp.RecordTypeId).Name == 'Siggo' && trigger.isInsert && opp.Siggo_AnalCred_ResultadoAnalise__c != 0 && 
            opp.Status_aprova_o_manual__c != 'Aprovada') {
            acc.put(opp.AccountId,null);
        } else if (tipoRegistro.get(opp.RecordTypeId).Name == 'Siggo' && trigger.isUpdate) {
            Opportunity oldOpp = System.Trigger.oldMap.get(opp.Id);
            if (oldOpp.Siggo_AnalCred_ResultadoAnalise__c != 0 && oldOpp.Status_aprova_o_manual__c != 'Aprovada'){
                if(oldOpp.Forma_pagamento_monitoramento__c != opp.Forma_pagamento_monitoramento__c
                   && oldOpp.Dia_vcto_monitoramento__c != opp.Dia_vcto_monitoramento__c
                   && oldOpp.Agencia_para_D_A_do_monitoramento__c != opp.Agencia_para_D_A_do_monitoramento__c
                   && oldOpp.Conta_Corrente_para_DA_do_monitoramento__c != opp.Conta_Corrente_para_DA_do_monitoramento__c
                   && oldOpp.Nome_do_Tit_para_DA_do_monitoramento__c != opp.Nome_do_Tit_para_DA_do_monitoramento__c
                   && oldOpp.C_d_de_Seg_do_C_de_Cr_dito_do_monit__c != opp.C_d_de_Seg_do_C_de_Cr_dito_do_monit__c
                   && oldOpp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c != opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c
                   && oldOpp.Vcto_do_C_de_Cr_dito_do_monitoramento__c != opp.Vcto_do_C_de_Cr_dito_do_monitoramento__c
                  ){
                    acc.put(opp.AccountId,null);
                }
            }
        }
    }
    if (acc.size() != 0){
        for (Account ac : [select Id, FormaCobranca__c, 
                           // Melhorias Siggo
                           Cobranca_DiaVcto__c, Dia_de_vencimento__c,
                           DebAut_Agencia__c, DebAut_ContaCorrente__c, DebAut_NomeTitular__c, 
                                    Cobranca_Cartao_CodigoSeguranca_Cript__c, Cobranca_Cartao_Numero_Cript__c, Cobranca_Cartao_Vcto__c
                            from Account where id in :acc.keySet()]) {
            acc.put(ac.Id, ac);
        }
        
        for(Opportunity opp: trigger.new) {
            if (tipoRegistro.get(opp.RecordTypeId).Name == 'Siggo' && opp.Siggo_AnalCred_ResultadoAnalise__c != 0 && opp.Status_aprova_o_manual__c != 'Aprovada'){
                
                // Copy data from account
                if (opp.Usar_dados_da_conta__c) {
                    
                    // INSTALAÇÃO
                    try {
                        opp.Forma_de_pagamento_instala_o__c = acc.get(opp.AccountId).FormaCobranca__c;
                    } catch (Exception e) {
                        msgErro = msgErro + 'Erro copiando campo "Forma de Pagamento instalação". Possivelmente, o valor selecionado em conta não é válido para oportunidade. ';
                    }
                    opp.CartaoCredito_Numero_Cript__c = acc.get(opp.AccountId).Cobranca_Cartao_Numero_Cript__c;
                    opp.CartaoCredito_CodigoSeguranca_Cript__c = acc.get(opp.AccountId).Cobranca_Cartao_CodigoSeguranca_Cript__c;
                    opp.CartaoCredito_Vencimento__c = acc.get(opp.AccountId).Cobranca_Cartao_Vcto__c;
                    
                    // MONITORAMENTO
                    try {
                        opp.Forma_pagamento_monitoramento__c = acc.get(opp.AccountId).FormaCobranca__c;
                    } catch (Exception e) {
                        msgErro = msgErro + 'Erro copiando campo "Forma de Pagamento monitoramento". Possivelmente, o valor selecionado em conta não é válido para oportunidade. ';
                    }
                    opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c = acc.get(opp.AccountId).Cobranca_Cartao_Numero_Cript__c;
                    opp.C_d_de_Seg_do_C_de_Cr_dito_do_monit__c = acc.get(opp.AccountId).Cobranca_Cartao_CodigoSeguranca_Cript__c;
                    opp.Vcto_do_C_de_Cr_dito_do_monitoramento__c = acc.get(opp.AccountId).Cobranca_Cartao_Vcto__c;
                    // Melhorias Siggo
                    if (String.isEmpty(acc.get(opp.AccountId).Dia_de_vencimento__c) || acc.get(opp.AccountId).Dia_de_vencimento__c == null) {
                        opp.Dia_vcto_monitoramento__c = String.valueOf(acc.get(opp.AccountId).Cobranca_DiaVcto__c);
                    }else{
                        opp.Dia_vcto_monitoramento__c = acc.get(opp.AccountId).Dia_de_vencimento__c;
                    }
                    opp.Agencia_para_D_A_do_monitoramento__c = acc.get(opp.AccountId).DebAut_Agencia__c;
                    opp.Conta_Corrente_para_DA_do_monitoramento__c = acc.get(opp.AccountId).DebAut_ContaCorrente__c;
                    opp.Nome_do_Tit_para_DA_do_monitoramento__c = acc.get(opp.AccountId).DebAut_NomeTitular__c;
                }
                
                // Copy data from INSTALACAO to MONITORAMENTO
                if (!opp.Usar_dados_da_conta__c && opp.Usar_dados_de_pagamento_da_instala_o__c){
                    opp.Forma_pagamento_monitoramento__c = opp.Forma_de_pagamento_instala_o__c;
                    if (opp.Forma_de_pagamento__c == '24-Cartão Visa' || opp.Forma_de_pagamento__c == '25-Cartão Master'){
                        opp.C_d_de_Seg_do_C_de_Cr_dito_do_monit__c = opp.CartaoCredito_CodigoSeguranca_Cript__c;
                        opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c = opp.CartaoCredito_Numero_Cript__c;
                        opp.Vcto_do_C_de_Cr_dito_do_monitoramento__c = opp.CartaoCredito_Vencimento__c;
                    } else if (opp.Usar_dados_de_pagamento_da_instala_o__c && opp.Forma_de_pagamento__c != '24-Cartão Visa' && opp.Forma_de_pagamento__c != '25-Cartão Master'){
                        opp.C_d_de_Seg_do_C_de_Cr_dito_do_monit__c = null;
                        opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c = null;
                        opp.Vcto_do_C_de_Cr_dito_do_monitoramento__c = null;
                    }
                }
                
                // Check rule for vencimento vs forma de pagamento
                /* MODIFICATION - CARLOS PRATES - unnecessary check - 15/07/2014 18:39
                if (opp.Total_Produtos_com_Seguro__c > 0 && opp.Dia_vcto_monitoramento__c != '12' && 
                    (opp.Forma_pagamento_monitoramento__c == '24-Cartão Visa' || opp.Forma_pagamento_monitoramento__c == '25-Cartão Master')) {
                    msgErro = msgErro + 'O campo "Dia do vencimento do monitoramento" deve ser 12 para pagamento com cartão de crédito e produto com seguro.';
               } else if (opp.Total_Produtos_com_Seguro__c == 0 && opp.Dia_vcto_monitoramento__c != '16' && 
                    (opp.Forma_pagamento_monitoramento__c == '24-Cartão Visa' || opp.Forma_pagamento_monitoramento__c == '25-Cartão Master')){
                    msgErro = msgErro + 'O campo "Dia do vencimento do monitoramento" deve ser 16 para pagamento com cartão de crédito e produto sem seguro.';
               }
                END MODIFICATION - CARLOS PRATES - unnecessary check - 15/07/2014 18:39 */
                
                // Returns the error to the user
                if (!String.isEmpty(msgErro)){
                    opp.addError(msgErro);
                }
                
                /*
                 * Copy data from "monitoramento" to account fields, when UPDATING the Opportunity and when 
                 * 
                 */
                if (trigger.isUpdate){
                    if (!String.isEmpty(opp.Forma_pagamento_monitoramento__c))
                        acc.get(opp.AccountId).FormaCobranca__c = opp.Forma_pagamento_monitoramento__c;
                    
                    // Melhorias Siggo
                    if (!String.isEmpty(opp.Dia_vcto_monitoramento__c))
                        acc.get(opp.AccountId).Dia_de_vencimento__c = opp.Dia_vcto_monitoramento__c;
                    
                    if (!String.isEmpty(String.valueOf(opp.Agencia_para_D_A_do_monitoramento__c)))
                        acc.get(opp.AccountId).DebAut_Agencia__c = opp.Agencia_para_D_A_do_monitoramento__c;
                    
                    if (!String.isEmpty(String.valueOf(opp.Conta_Corrente_para_DA_do_monitoramento__c)))
                        acc.get(opp.AccountId).DebAut_ContaCorrente__c = opp.Conta_Corrente_para_DA_do_monitoramento__c;
                    
                    if (!String.isEmpty(opp.Nome_do_Tit_para_DA_do_monitoramento__c))
                        acc.get(opp.AccountId).DebAut_NomeTitular__c = opp.Nome_do_Tit_para_DA_do_monitoramento__c;
                    
                    if(!String.isEmpty(opp.C_d_de_Seg_do_C_de_Cr_dito_do_monit__c))
                        acc.get(opp.AccountId).Cobranca_Cartao_CodigoSeguranca_Cript__c = opp.C_d_de_Seg_do_C_de_Cr_dito_do_monit__c;
                    
                    if (!String.isEmpty(opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c))
                        acc.get(opp.AccountId).Cobranca_Cartao_Numero_Cript__c = opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c;
                    
                    if (!String.isEmpty(opp.Vcto_do_C_de_Cr_dito_do_monitoramento__c))
                        acc.get(opp.AccountId).Cobranca_Cartao_Vcto__c = opp.Vcto_do_C_de_Cr_dito_do_monitoramento__c;
                }
            }
        }
        if (trigger.isUpdate) {
            if (acc.size() > 0) {
                update acc.values();
            }
        }
    }
}