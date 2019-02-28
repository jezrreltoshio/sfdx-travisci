/*
	@testClass Teste_Trigger_Oportunidade

	@description Trigger for object Opportunity
	
	@author Renan Rocha
	@date 19/11/2018
*/

trigger Trigger_Oportunidade on Opportunity(before insert, before update, after insert, after update){
	private static String CLASS_NAME = 'Trigger_Oportunidade';

	if(!Triggers__c.getOrgDefaults().Trigger_oportunidade__c) return;

	if(trigger.isBefore){

		Handler_Oportunidade.checkCpfCnpjIsNotEmpty(trigger.new);

		if(trigger.isInsert) Handler_Oportunidade.updateOwner(trigger.new, null, true);

		if(trigger.isUpdate){
			Handler_Oportunidade.verificarAlteracaoAdesao(trigger.new);
			Handler_Oportunidade.updateOwner(trigger.new, trigger.old, false);
			Handler_Oportunidade.verifyApprovalProcess(trigger.new, trigger.oldMap);
			Handler_Oportunidade.pgtoProdutoSeguro(trigger.new);
			Handler_Oportunidade.logApprovalProcess(trigger.new, trigger.oldMap);
		}

		if(trigger.isInsert || trigger.isUpdate){
			Handler_Oportunidade.setBandeiraCartao(trigger.new);
			Handler_Oportunidade.validarNomePortador(trigger.new, trigger.oldMap, trigger.isInsert, trigger.isUpdate);
			Handler_Oportunidade.adjustPayment(trigger.new, trigger.isInsert, trigger.isUpdate, trigger.oldMap);
			PCL_SIG_OpportunityProcess.adjustCreditCardData(trigger.new);
		}
	}

	if(trigger.isAfter){
		Handler_Oportunidade.abasteceHistoricoDetalhes(trigger.new, trigger.old, trigger.isInsert, trigger.isUpdate);

        if(!StageTracking.rastreamentoCamposOportunidade) StageTracking.createOpportunityStageTracking(trigger.oldMap, trigger.new); // Funcionalidade para evitar que a gravação do rastreamento fique duplicado
	}
}