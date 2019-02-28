Trigger LeadTrigger on Lead (after update, after insert) {

    /* by @Edvaldo - kolekto 
    Adicionado after insert para metodo de createOpportunityStageTrackingInOpp
    */

    if(Trigger.isUpdate){
        LeadTriggers.markLeadOrigin(trigger.new);
    }

    /* by @Edvaldo - kolekto 
    Para gerar um acompanhamento de mudança de fases do lead e gravar no obj personalizado.
    */
    if(Trigger.isAfter){

        System.debug(LoggingLevel.ERROR, '__ [trg LeadTrigger] - StageTracking.rastreamentoCamposLead: ' + StageTracking.rastreamentoCamposLead);

        // Funcionalidade para evitar que a gravação do rastreamento fique duplicado
        if(!StageTracking.rastreamentoCamposLead){

        	StageTracking.createLeadStageTracking(Trigger.oldMap, Trigger.new);
        }
    }

}