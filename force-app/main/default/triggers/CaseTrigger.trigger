trigger CaseTrigger on Case (before insert, before update, after insert, after update) {
    
    if(Trigger.isBefore && Trigger.isInsert){
        
        CaseBO.setValuesOfCaseInitial(Trigger.new);
        
        
    }
    
    if(Trigger.isAfter && Trigger.isInsert){
        
        List<Case> casesToSetTeam = new List<Case>();
        RecordType rcMexico = [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName = 'Mexico' AND SObjectType = 'Case'];
        
        for(Case c : (List<Case>) Trigger.new)
        {
            if(c.RecordTypeId == rcMexico.Id)
                casesToSetTeam.add(c);
        }
        
        if(casesToSetTeam.size()>0)
            CaseBO.fillCaseTeamRecentlyCreated(casesToSetTeam);
    }
    
    
    if (Trigger.isBefore && Trigger.isUpdate) {
        CaseBO.whatQueueIsUser(Trigger.new);
        caseBO.setEscalationLevels(Trigger.new);
    }
    
    if(Trigger.isBefore){
        CaseBO.searchAccount(Trigger.new, Trigger.oldMap);
        CaseBO.setStatusEmAndamento(Trigger.new, Trigger.oldMap);
        if(!ProcessorControl.isRecursiveCommentVerif)
        	CaseBO.isCaseHasComments(Trigger.new, Trigger.oldMap);
        CaseBO.fillFieldDeadLineForResponse(Trigger.new, Trigger.oldMap);
        CaseBO.defineMarcoSLA(Trigger.new);
        CaseBO.setStatusRespostaAndStatusSolucao(Trigger.new);
        
        List<Case> casesMXsetRespCAC = new List<Case>();
        List<Case> casesMXEscalar = new List<Case>();
        Map<Case, Id> mapIdCase = new Map<Case, Id>();
        List<Case> casesMXsetSLA = new List<Case>();
        List<Case> casesMXsetAccount = new List<Case>();
        List<Case> casosPropForaCAC = new List<Case>();
        List<Case> casosDevolverCAC = new List<Case>();
        List<Case> casosValidarComentario = new List<Case>();
        List<Case> casesRespCACTelefone = new List<Case>();
        RecordType rcMexico = [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName = 'Mexico' AND SObjectType = 'Case'];
        System.debug('casesMXsetSLA: '+ casesMXsetSLA);
        for(Case c : (List<Case>) Trigger.new)
        {
            
            System.debug('c.RecordType.DeveloperName: '+c.RecordTypeId);
            if(c.RecordTypeId == rcMexico.Id)
                casesMXsetSLA.add(c);
            
            if(c.Id != null){
                if(c.RecordtypeId == rcMexico.Id &&  c.SuppliedEmail != null && c.SuppliedEmail != Trigger.oldMap.get(c.Id).SuppliedEmail)
                    casesMXsetAccount.add(c);
            }else{
                if(c.RecordtypeId == rcMexico.Id &&  c.SuppliedEmail != null)
                    casesMXsetAccount.add(c);
            }
            
            if(c.RecordTypeId == rcMexico.Id && c.Status == 'Listo' && Trigger.oldMap.get(c.Id).Status != 'Listo')
                casosDevolverCAC.add(c);
            
            
            if(c.Id != null)
            {
                if(c.RecordTypeId == rcMexico.Id && c.Status != 'Escalado' && c.OwnerId != Trigger.oldMap.get(c.Id).OwnerId)
                    casosPropForaCAC.add(c);
                
                if(c.RecordTypeId == rcMexico.Id && c.Reason != Trigger.oldMap.get(c.Id).Reason && Trigger.oldMap.get(c.Id).Reason == null)
                {
                    mapIdCase.put(c, UserInfo.getUserId());
                    casesMXsetRespCAC.add(c);
                }
                
                if(c.RecordTypeId == rcMexico.Id && c.Status != Trigger.oldMap.get(c.Id).Status && Trigger.oldMap.get(c.Id).Status != 'Escalado' && Trigger.oldMap.get(c.Id).Status != 'Não iniciado' && c.OwnerId == Trigger.oldMap.get(c.Id).OwnerId && c.Status == 'Escalado')
                    casesMXEscalar.add(c);
            }else{
                if(c.Origin == 'Telefone')
                {
                    casesRespCACTelefone.add(c);
                }
                System.debug('CaseTrigger, 72: '+ casesMXsetRespCAC);
            }
            
            if(casesRespCACTelefone.size()>0)
                CaseBO.fillRespCACTelefone(casesRespCACTelefone, UserInfo.getUserId());
            
            if(casesMXsetSLA.size()>0)
                CaseBO.fillFieldDeadLineForResponseMexico(casesMXsetSLA);
            
            if(casesMXsetAccount.size()>0)
                CaseBO.fillAccountMexico(casesMXsetAccount);
            
            if(casesMXsetRespCAC.size()>0)
                CaseBO.fillRespCACMexico(casesMXsetRespCAC, mapIdCase);
            
            if(casesMXEscalar.size()>0)
                CaseBO.escalarCasoMexico(casesMXEscalar);
            
            if(casosPropForaCAC.size()>0)
                CaseBO.mxProprietarioForaDoCAC(casosPropForaCAC);
            
            if(casosDevolverCAC.size()>0)
                CaseBO.devolverCasoCAC(casosDevolverCAC);
            
        }
        System.debug('casesMXsetSLA: '+ casesMXsetSLA);
        
    }
    
    System.debug('***Trigger old: '+JSON.serializePretty(Trigger.old));
    System.debug('***Trigger new: '+JSON.serializePretty(Trigger.new));
    
    
}