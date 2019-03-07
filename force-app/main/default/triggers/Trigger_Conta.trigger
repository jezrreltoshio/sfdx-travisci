/*
    Classe de teste: Teste_Trigger_Conta
    Criado por: Mauricio Alexandre Silva
    Data de criação: 11/01/2016
    Descrição: Trigger para verificar a duplicidade de conta

    ===================================================

    Atualizado por: Mario Reis
    Data da alteração: 24/08/2017
    Descrição: - Controle de execução da Trigger pela configuração personalizada
               - Verificação do usuário que está executando
			   - Verificação sendo ennviada para Trigger
    ---------------------------------
    @author Renan Rocha
    @date 11/01/2019
    @description:
        - Classe refatorada
        - Trazido todos as chamadas de método que estavam erroneamente na classe Handler_Conta
        - Adicionado método verificaDuplicidadeCNPJ
    @JIRA KCA-410
    ---------------------------------
    @author Renan Rocha
    @date 15/02/2019
    @description Alterado chamada duplicadas em Trigger.isBefore
    @JIRA KCA-549
    ---------------------------------
    @author Renan Rocha
    @date 18/02/2019
    @description Alterado chamada do método verificaDuplicidadeCNPJ para isAfter
    @JIRA KCA-549
*/
trigger Trigger_Conta on Account (before insert, before update, after insert, after update) {

    String req = String.valueOf(URL.getCurrentRequestUrl());

    if(UserInfo.getUserEmail() == Parametros_ORG__c.getOrgDefaults().Email_usuario_pentaho__c 
        || !Triggers__c.getOrgDefaults().Trigger_conta__c
        || req.contains('salesforce.com/services/Soap/u/')) return;

    if(trigger.isBefore){

        if(trigger.isInsert || trigger.isUpdate){
            Service_Conta.cleanBlankSpaceFields(trigger.new); // trigger agregada na unificação
            Service_Conta.validacaoCNPJ(trigger.new);
            Service_Conta.validacaoCPF(trigger.new);
            Service_Conta.validacaoCUIT(trigger.new);
            Service_Conta.marcarDuplicidades(trigger.new);
            Service_Conta.formataTelefone(trigger.new);
            Service_Conta.preencheCamposConta(trigger.new);
            Service_Conta.updateShippingAddress(trigger.new); // trigger agregada na unificação
            Service_Conta.updateBillingAddress(trigger.new); // trigger agregada na unificação
            Service_Conta.setBandeiraCartao(trigger.new); // trigger agregada na unificação
            Service_Conta.validarCircuitoCadencia(trigger.new, UserInfo.getUserRoleId()); // trigger agregada na unificação
            Service_Conta.validarNomePortador(trigger.new, trigger.isInsert, trigger.isUpdate); // trigger agregada na unificação
        }

        if(trigger.isInsert) Service_Conta.preencheCamposFaltantesConversao(trigger.new);

        if(trigger.isUpdate){
            Handler_Conta.buscaCEP(trigger.new);
            Service_Conta.possuiOportunidade(trigger.new);
            Service_Conta.markLeadOrigin(trigger.new); // trigger agregada na unificação
        }
    }

    if(trigger.isAfter){
        if(trigger.isInsert || trigger.isUpdate) Handler_Conta.verificaDuplicidadeCNPJ(trigger.new, trigger.oldMap, trigger.isInsert);
        
        if(trigger.isUpdate){
            if(!ProcessorControl.insertingAccounts) Service_Conta.updateRelatedContacts(trigger.new); //rbsilva 11-06-18: agregada na unificação. Não deveria estar também no insert?
        }
    }
}