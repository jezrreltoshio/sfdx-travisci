/********************************************************************* 
 *CHANGE 24/02/2015 - Carlos Prates - DESATIVAR TRIGGER              *
 * Causa: Unificação de Triggers do Objeto Oportunidade              *
 * Motivo: Evitar que exceções causados por limites da ferramenta    *
 * Alterações: Métodos enviados para trigger OpportunityTrigger      * 
 *********************************************************************/

trigger Opportunity_UpdateOwner on Opportunity (before insert, before update) {
    // Check the id of the recordtype
    Set<Id> rtIds = new Set<Id>();
    for(Opportunity opp :Trigger.new){
        rtIds.add(opp.RecordTypeId);
    }
    // Add RecordTypes on the MAP
    Map<Id,RecordType> tipoRegistro = new Map<Id,RecordType>([SELECT Id, DeveloperName FROM RecordType WHERE Id IN :rtIds]);
    
    if(trigger.isInsert) OpportunityTriggers.UpdateOwner(trigger.new, null, tipoRegistro);
    if(trigger.isUpdate) OpportunityTriggers.UpdateOwner(trigger.new, trigger.old, tipoRegistro);
}