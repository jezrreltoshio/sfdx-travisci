/****************************************************************** 
 *CHANGE 24/02/2015 - Carlos Prates - DESATIVAR TRIGGER           *
 * Causa: Unificação de Triggers do Objeto Oportunidade           *
 * Motivo: Evitar que exceções causados por limites da ferramenta *
 * Alterações: Métodos enviados para trigger OpportunityTrigger   * 
 ******************************************************************/

trigger Opportunity_LogApprovalProcess on Opportunity (after update) {
  Map<Id, Opportunity> aprovacoes = new Map<Id, Opportunity>{};
  
  //END Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
  Set<Id> OppIds = new Set<Id>();
  for(Opportunity opp: trigger.new) {
      if(opp.Status_aprova_o_manual__c != null && opp.Status_aprova_o_manual__c != ''){
          OppIds.add(opp.Id);
      }
  }
  Map<Id,Resumo_analise_manual_oportunidade__c> mapResumos = new Map<Id,Resumo_analise_manual_oportunidade__c>();
  if(OppIds.size() > 0){
      for(Resumo_analise_manual_oportunidade__c resumo :[SELECT Oportunidade__c, Resultado_do_processo__c
                                                                , T_rmino_do_processo_em__c, Aprovador__c
                                                         FROM Resumo_analise_manual_oportunidade__c
                                                         WHERE Oportunidade__c IN :OppIds]){
        mapResumos.put(resumo.Oportunidade__c,resumo);
      }
  }
  //END Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
      
  for(Opportunity opp: trigger.new) {
    Opportunity oldOpp = System.Trigger.oldMap.get(opp.Id);
    
    // Verify that it's starting a new approval process and inserts the value in the custom object
    if ((oldOpp.Status_aprova_o_manual__c == '' || oldOpp.Status_aprova_o_manual__c == 'Nova' || oldOpp.Status_aprova_o_manual__c == null) && 
        opp.Status_aprova_o_manual__c == 'Em análise'){
        Resumo_analise_manual_oportunidade__c resumo = 
            new Resumo_analise_manual_oportunidade__c(
                Oportunidade__c = opp.Id,
                Resultado_analise_automatica__c = opp.Siggo_AnalCred_ResultadoAnalise__c,
                Resultado_do_processo__c = 'Em análise',
                T_rmino_do_processo_em__c = DateTime.now(),
                Aprovador__c = UserInfo.getUserId());
        insert resumo;
    }
    
    if (oldOpp.Status_aprova_o_manual__c == 'Reiniciada' && opp.Status_aprova_o_manual__c == 'Em análise'){
        Resumo_analise_manual_oportunidade__c resumo = 
            new Resumo_analise_manual_oportunidade__c(
                Oportunidade__c = opp.Id,
                Resultado_analise_automatica__c = opp.Siggo_AnalCred_ResultadoAnalise__c,
                Resultado_do_processo__c = 'Em análise',
                T_rmino_do_processo_em__c = DateTime.now(),
                Aprovador__c = UserInfo.getUserId());
        insert resumo;
    }
    
    // Verify that it's recalling a approval process 
    if (oldOpp.Status_aprova_o_manual__c == 'Em análise' && opp.Status_aprova_o_manual__c == 'Recall'){
        //Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
         // Resumo_analise_manual_oportunidade__c resumo = 
         // [SELECT Oportunidade__c, Resultado_do_processo__c, T_rmino_do_processo_em__c, Aprovador__c
         //     FROM Resumo_analise_manual_oportunidade__c WHERE Oportunidade__c = :opp.Id];
        if(mapResumos.containsKey(opp.Id)){
            Resumo_analise_manual_oportunidade__c resumo = mapResumos.get(opp.Id);
            resumo.Resultado_do_processo__c = 'Recall';
            resumo.T_rmino_do_processo_em__c = DateTime.now();
            resumo.Aprovador__c = UserInfo.getUserId();
            update resumo;
        }
        //END Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
    }

    // Verify that it's starting a new approval process AFTER a recall
    if (oldOpp.Status_aprova_o_manual__c == 'Recall' && opp.Status_aprova_o_manual__c == 'Em análise'){
        //Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
         // Resumo_analise_manual_oportunidade__c resumo = 
         // [SELECT Oportunidade__c, Resultado_do_processo__c, T_rmino_do_processo_em__c, Aprovador__c
         //     FROM Resumo_analise_manual_oportunidade__c WHERE Oportunidade__c = :opp.Id];
        if(mapResumos.containsKey(opp.Id)){
            Resumo_analise_manual_oportunidade__c resumo = mapResumos.get(opp.Id);
            resumo.Resultado_do_processo__c = 'Em análise';
            resumo.T_rmino_do_processo_em__c = DateTime.now();
            resumo.Aprovador__c = UserInfo.getUserId();
            update resumo;
        }
        //END Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
    }
    
    // Verify it's trying again a denied process
    if (oldOpp.Status_aprova_o_manual__c == 'Negada' && opp.Status_aprova_o_manual__c == 'Em análise'){
        //Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
         // Resumo_analise_manual_oportunidade__c resumo = 
         // [SELECT Oportunidade__c, Resultado_do_processo__c, T_rmino_do_processo_em__c, Aprovador__c
         //     FROM Resumo_analise_manual_oportunidade__c WHERE Oportunidade__c = :opp.Id];
        if(mapResumos.containsKey(opp.Id)){
            Resumo_analise_manual_oportunidade__c resumo = mapResumos.get(opp.Id);
            resumo.Resultado_do_processo__c = 'Em análise';
            resumo.T_rmino_do_processo_em__c = DateTime.now();
            resumo.Aprovador__c = UserInfo.getUserId();
            update resumo;
        }
        //END Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
    }

    /* Verify it's starting a process after a return of 2 ("Em análise") 
     * in the automatic credit analysis process. */
    if (oldOpp.Siggo_AnalCred_ResultadoAnalise__c != 2 && opp.Siggo_AnalCred_ResultadoAnalise__c == 2) {
        
        // Resending to approval
        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments('Envio automático.');
        req1.setObjectId(opp.Id);
        Approval.ProcessResult result = Approval.process(req1);
    }
  }
}