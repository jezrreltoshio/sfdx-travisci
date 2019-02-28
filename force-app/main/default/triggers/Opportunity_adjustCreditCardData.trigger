/****************************************************************** 
 *CHANGE 24/02/2015 - Carlos Prates - DESATIVAR TRIGGER           *
 * Causa: Unificação de Triggers do Objeto Oportunidade           *
 * Motivo: Evitar que exceções causados por limites da ferramenta *
 * Alterações: Métodos enviados para trigger OpportunityTrigger   * 
 ******************************************************************/

trigger Opportunity_adjustCreditCardData on Opportunity (before insert, before update) {
    PCL_SIG_OpportunityProcess.adjustCreditCardData(Trigger.new);
}