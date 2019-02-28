Global class UpdateStatusCase {
    
    WebService static String updateStatusResponse(Id caseId) {  
        
        Case caso = [SELECT Id, StatusResposta__c FROM Case WHERE Id =: caseId LIMIT 1];
        
        if(caso.StatusResposta__c == 'Não iniciada' || caso.StatusResposta__c == 'Em andamento'){
            caso.StatusResposta__c = 'Em andamento aguardando cliente';
            Update caso;
        }
        
        if(caso.StatusResposta__c == 'Atrasada'){
            caso.StatusResposta__c = 'Atrasado aguardando cliente';
            Update caso;
        }
        
        if(caso.StatusResposta__c != 'Em andamento aguardando cliente' && caso.StatusResposta__c != 'Em andamento aguardando cliente' &&
          caso.StatusResposta__c != 'Atrasado aguardando cliente'){
            return 'Esta resposta está ' + caso.StatusResposta__c + '.';
        } 
        
        return 'Sucesso!';
    }
    
    WebService static String updateStatusSolution(Id caseId) {  
        
        Case caso = [SELECT Id, StatusSolucao__c FROM Case WHERE Id =: caseId LIMIT 1];
        
        if(caso.StatusSolucao__c == 'Não iniciada' || caso.StatusSolucao__c == 'Em andamento'){
            caso.StatusSolucao__c = 'Em andamento aguardando cliente';
            Update caso;
        }
        
        if(caso.StatusSolucao__c == 'Atrasada'){
            caso.StatusSolucao__c = 'Atrasado aguardando cliente';
            Update caso;
        }
        
        if(caso.StatusSolucao__c != 'Em andamento aguardando cliente' && caso.StatusSolucao__c != 'Em andamento aguardando cliente' &&
          caso.StatusSolucao__c != 'Atrasado aguardando cliente'){
            return 'Esta solução está ' + caso.StatusSolucao__c + '.';
        } 
        
        return 'Sucesso!';
    }
    
}