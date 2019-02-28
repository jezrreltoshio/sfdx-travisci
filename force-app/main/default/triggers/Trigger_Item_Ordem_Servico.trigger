/*
    Classe de teste: Teste_Trigger_Item_Ordem_Servico
    Criado por: Mario Reis
    Data de criação: 25/06/2018
    Descrição: Trigger padrão do Item da Ordem de serviço

*/
trigger Trigger_Item_Ordem_Servico on Item_ordem_servico__c (before insert, after insert, 
                                                             before update, after update,
                                                             before delete, after delete,
                                                             after undelete) {

	System.debug(LoggingLevel.ERROR, '__ [trg Trigger_Item_Ordem_Servico ] - Inicio...');

    if(!Triggers__c.getOrgDefaults().Trigger_item_ordem_servico__c) return;

    try {

        if(Handler_Item_Ordem_Servico.rodouAtualizacaoInformacoes == false){

            Boolean executou = Handler_Item_Ordem_Servico.verificacao(trigger.isBefore, trigger.isAfter, 
                                                                    trigger.isInsert, trigger.isUpdate, 
                                                                    trigger.isDelete, trigger.isUndelete, 
                                                                    trigger.old, trigger.oldMap,
                                                                    trigger.new, trigger.newMap);
        }

    } catch (Exception e){

        trigger.new[0].addError(e, false);
    }
}