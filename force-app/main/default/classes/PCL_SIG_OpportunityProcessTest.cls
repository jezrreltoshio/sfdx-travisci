/*
    @testClass PCL_SIG_OpportunityProcess
    
    @author Renan Rocha
    @date 12/12/2018
*/

@isTest
private class PCL_SIG_OpportunityProcessTest {
    
    static testMethod void myUnitTest() {
        Map<String, sObject> mapBase = Teste_Util.createMapBase();
        Opportunity opp = (Opportunity) mapBase.get('Opportunity');
        Account acc = (Account) mapBase.get('Account');
        acc.Tipo_de_pessoa__c = 'F-Física';
        update acc;
        
        PCL_SIG_OpportunityProcess pcl = new PCL_SIG_OpportunityProcess();
        pcl.doAnalisePreliminarProcess(opp.Id);
        pcl.doAnaliseCreditoProcess(opp.Id);

        opp.Siggo_AnalCred_ResultadoAnalise__c = 0;
        update opp;

        pcl.doPersistirPropostaProcess(opp.Id);
        pcl.doRestartCreditAnalysis(opp.Id);
    }
}