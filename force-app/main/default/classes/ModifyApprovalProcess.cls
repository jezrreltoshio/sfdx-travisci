/**
 * [STI 85960] - [PRJ - SALESFORCE] - DESBUROCRATIZAÇÃO DA OPORTUNIDADE
 * @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
 * @sinze 30/10/2015
 */
global class ModifyApprovalProcess{
  /**
   * Desbloqueia oportunidades aprovadas.
   * @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
   * @param String Opportunity Id
   * @return Boolean
   */ 
    webservice static boolean unlockOpportunity(String oppId){
        Boolean result = false;
        String status;
        
        //Recuperando os dados do processo de aprovação atual.
        List<ProcessInstance> PI = [SELECT Id, TargetObjectId, Status FROM ProcessInstance WHERE TargetObjectId =:oppId order by CreatedDate desc limit 1];     
        status = PI[0].Status;
        
        //Verifica de existe alguma solicitação APROVADA.
        if(status == 'Approved'){
            //The new Approval.UnlockResult class contains methods that show
            //the results of record unlocks by System.Approval.unlock() methods.
            //A Boolean value that is set to true if the unlock operation is successful
            //for this object, or false otherwise.
            result = System.Approval.unlock(oppId).isSuccess();
                    
            if(result){
                //Reiniciando a aprovacao manual.
                Opportunity opp = [SELECT Id, Aprova_o__c, Renegociar__c FROM Opportunity WHERE Id =:oppId];
                opp.Aprova_o__c = null;
                opp.Renegociar__c = True;
                update opp;
            }
        }
            
        /*List<ProcessInstance> PI = [SELECT Id, TargetObjectId FROM ProcessInstance WHERE TargetObjectId =:oppId AND Status = 'Pending'];
        if(PI.size() > 0){
            List<ProcessInstanceWorkitem> PIWI = [SELECT Id, ActorId FROM ProcessInstanceWorkitem WHERE ProcessInstanceId =:PI[0].Id];
            
            if(PIWI.size() > 0){
                //Rejeitando o processo de aprovação existente.
                Approval.ProcessWorkitemRequest req2 = new Approval.ProcessWorkitemRequest();  
                req2.setComments('Solicitado desbloqueio para edição do Registro.');  
                req2.setAction('Removed');  
                req2.setNextApproverIds(new Id[] {UserInfo.getUserId()});  
                req2.setWorkitemId(PIWI[0].Id);  
                Approval.ProcessResult result2 = Approval.process(req2);
            }
        }*/
        
        return result;
    }
}