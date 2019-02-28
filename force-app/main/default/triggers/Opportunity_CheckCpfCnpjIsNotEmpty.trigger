/**
 * [STI 85949] - [PRJ - SALESFORCE] - VALIDAR CPF/CNPJ OBJETO CONTA E OPORTUNIDADE
 * @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
 * @sinze 03/09/2015
 */
trigger Opportunity_CheckCpfCnpjIsNotEmpty on Opportunity (before insert, before update, after insert, after update){

    /* 
    Como a trigger antigamente era apenas "Before", então coloquei a condição de entrada no metodo apenas para "Before"
    by Edvaldo - [ kolekto ] 
    */
    if(Trigger.isBefore){

        //Recuperando o Record type name do objeto Oportunidade
        String recordTypeName = Opportunity.SObjectType.getDescribe().getRecordTypeInfosById().get(Trigger.new[0].RecordTypeId).getName();
        recordTypeName = recordTypeName.touppercase();
        
        OpportunityCheckCpfCnpjIsNotEmpty.opportunityCheckCpfCnpjIsNotEmpty(Trigger.new[0], recordTypeName);

    }

    /* by @Edvaldo - kolekto 
    Para gerar um acompanhamento de mudança de fases da oportunidade e gravar no obj personalizado.
    */
    if(Trigger.isAfter && !Test.isRunningTest()){
    
        // Funcionalidade para evitar que a gravação do rastreamento fique duplicado
        if(!StageTracking.rastreamentoCamposOportunidade){
            StageTracking.createOpportunityStageTracking(Trigger.oldMap, Trigger.new);
        }
    }

}