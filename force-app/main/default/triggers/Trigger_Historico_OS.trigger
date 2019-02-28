/*
    Classe de teste: Teste_Trigger_Historico_OS
    Criado por: Mario Reis
    Data de criação: 25/06/2018
    Descrição: Trigger padrão do Historico da OS

*/
trigger Trigger_Historico_OS on Historico_OS__c (before insert, after insert, 
                                                 before update, after update,
                                                 before delete, after delete,
                                                 after undelete) {

    System.debug(LoggingLevel.ERROR, '__ [trg Trigger_Historico_OS ] - Inicio...');

    if(!Triggers__c.getOrgDefaults().Trigger_historico_os__c) return;

    try {

        if(Handler_Historico_OS.rodouAtualizacaoInformacoes == false){

            Boolean executou = Handler_Historico_OS.verificacao(trigger.isBefore, trigger.isAfter, 
                                                                trigger.isInsert, trigger.isUpdate, 
                                                                trigger.isDelete, trigger.isUndelete, 
                                                                trigger.old, trigger.oldMap,
                                                                trigger.new, trigger.newMap);
        }

    } catch (Exception e){

        trigger.new[0].addError(e, false);
    }

}