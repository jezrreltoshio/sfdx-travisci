global class SVC_SiggoOpportunity {
    
    webservice static String doRestartCreditAnalysis(Id opptyId) {
        PCL_SIG_OpportunityProcess siggoProcess = new PCL_SIG_OpportunityProcess();

        return siggoProcess.doRestartCreditAnalysis(opptyId); 
    }
	
    webservice static String doAnaliseCreditoProcess(Id opptyId) {
        PCL_SIG_OpportunityProcess siggoProcess = new PCL_SIG_OpportunityProcess();

        return siggoProcess.doAnaliseCreditoProcess(opptyId); 
    }
    
    webservice static void doAnalisePreliminarProcess(Id opptyId) {
        PCL_SIG_OpportunityProcess siggoProcess = new PCL_SIG_OpportunityProcess();
        
        siggoProcess.doAnalisePreliminarProcess(opptyId);
    }
    
    webservice static String doPersistirPropostaProcess(Id opptyId) {
        PCL_SIG_OpportunityProcess siggoProcess = new PCL_SIG_OpportunityProcess();
        
        return siggoProcess.doPersistirPropostaProcess(opptyId);
    }
    
}