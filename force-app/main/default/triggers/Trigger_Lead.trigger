/*
  Classe de teste: Teste_Trigger_Lead
  Atualizado por: Mario Reis
  Data da alteração: 02/10/2017
  Descrição: - Controle de execução da Trigger pela configuração personalizada
             - Verificação sendo ennviada para Trigger
  ---------------------------------
  @author Renan Rocha
  @date 16/11/2018
  @description:
    - Retirado chamadas para Handler pois os métodos estão hoje nas Services
    - Trigger refatorada.
    - Adicionado método abasteceHistoricoDetalhes, método extraído da Trigger: Lead_AbasteceHistoricoDetalhes
    - Adicionado métodos: LeadTriggers.markLeadOrigin e StageTracking.createLeadStageTracking, métodos retirados da Trigger: LeadTrigger
  @JIRA KCA-10
  ---------------------------------
  @author Renan Rocha
  @date 28/12/2018
  @description Inserido método vericaUsuarioCanalExclusivo
  @JIRA KCA-384
  ---------------------------------
  @author Renan Rocha
  @date 23/01/2019
  @description Alterado método verificaUsuarioCanalExclusivo
  @JIRA KCA-384
*/
trigger Trigger_Lead on Lead (before insert, before update, after insert, after update) {

  if(!Triggers__c.getOrgDefaults().Trigger_lead__c) return;

  if(trigger.isBefore){
    if(trigger.isInsert || trigger.isUpdate){
      // o ideal seria ter esses métodos na Handler, porém, como estão em Services, vamos manter
      Service_Lead.validacaoCUIT(trigger.new);
      Service_Lead.validacaoCPF(trigger.new);
      Service_Lead.validacaoCNPJ(trigger.new);
      Service_Lead.formataTelefone(trigger.new);
      Service_Lead.preencheCamposLead(trigger.new);
      Service_Lead.verificaDuplicidadeLead(trigger.new);
      Service_lead.buscaCEP(trigger.new);
      Handler_Lead.vericaUsuarioCanalExclusivo(trigger.new, trigger.oldmap, trigger.isInsert);
    }
  }

  if(trigger.isUpdate){
    LeadTriggers.markLeadOrigin(trigger.new);
  }

  if(trigger.isAfter){
    Handler_Lead.abasteceHistoricoDetalhes(trigger.new, trigger.old);

    if(!StageTracking.rastreamentoCamposLead) StageTracking.createLeadStageTracking(trigger.oldMap, trigger.new);
  }
}