/*
    Classe de teste: Teste_Trigger_Contato
    Criado por: Mario Reis
    Data de criação: 16/11/2017
    Descrição: Trigger padrão do Contato
    ---------------------------------
    @author Renan Rocha
    @date 28/01/2019
    @description:
        - Classe refatorada
        - Trigger corrigida para chamar métodos e não ter um que chama todos
        - Retirado chamada para método verificacao da Handler_Contato
    @JIRA KCA-482
*/
trigger Trigger_Contato on Contact (before insert, before update, after insert, after update) {

    if(!Triggers__c.getOrgDefaults().Trigger_contato__c) return;

    if(trigger.isBefore){
        if(trigger.isInsert) Service_Contato.copiarDadosConta(trigger.new);

        if(trigger.isInsert || trigger.isUpdate) Service_Contato.formataCPF(trigger.new);
    }

    if(trigger.isAfter){
        if(trigger.isInsert) Service_Contato.carregarEnderecoConta(trigger.new);
            
        if(trigger.isInsert || trigger.isUpdate) Handler_Contato.buscaCEP(trigger.new, trigger.oldMap, trigger.isInsert);
    }
}