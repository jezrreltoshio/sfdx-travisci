@isTest
private class SVC_SiggoOpportunityTest {

    public static Opportunity createOppty() {
        Opportunity opp = new Opportunity();
        
        opp.CartaoCredito_Numero_Cript__c = '1111444477778884';
        opp.CartaoCredito_CodigoSeguranca_Cript__c = '123';
        opp.CartaoCredito_Vencimento__c = '1012';
        
        opp.name = 'Opp 1';
        opp.StageName = 'Abordagem inicial';
        opp.CloseDate = Date.today();
        opp.Description = 'Teste';
        
        return opp;
    }
    
    static testMethod void doRestartCreditAnalysisTest() {
        Opportunity opp = CreateOppty();
        insert opp;
        SVC_SiggoOpportunity.doRestartCreditAnalysis(opp.Id);
    }
    
    static testMethod void doAnaliseCreditoProcessTest() {
        Opportunity opp = CreateOppty();
        insert opp;
        SVC_SiggoOpportunity.doAnaliseCreditoProcess(opp.Id);
    }
    
    static testMethod void doAnalisePreliminarProcessTest() {
        Opportunity opp = CreateOppty();
        insert opp;
        //SVC_SiggoOpportunity.doAnalisePreliminarProcess(opp.Id);
    }
    
    static testMethod void doPersistirPropostaProcessTest() {
        Opportunity opp = CreateOppty();
        insert opp;
        SVC_SiggoOpportunity.doPersistirPropostaProcess(opp.Id);
    }
    
    
}