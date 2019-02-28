/*
    Classe de teste: Teste_Trigger_Contato
    Criado por: Mario Reis
    Data de criação: 16/11/2017
    Descrição: Trigger padrão do Contato

*/
trigger Trigger_Contato on Contact (before insert, before update, after insert, after update) {

    System.debug(LoggingLevel.ERROR, '__ [trg Trigger_Contato ] - Inicio...');

    if(!Triggers__c.getOrgDefaults().Trigger_contato__c) return;

    try {

        /*Boolean executou = Handler_Contato.verificacao(trigger.isBefore, trigger.isAfter, 
                                                       trigger.isInsert, trigger.isUpdate, 
                              						   trigger.isDelete, trigger.isUndelete, 
                                                       trigger.old, trigger.oldMap,
                              						   trigger.new, trigger.newMap);*/
        
        Boolean executou = Handler_Contato.verificacao(trigger.isBefore, trigger.isAfter, 
                                                       trigger.isInsert, trigger.isUpdate, 
                              						   trigger.isDelete, trigger.isUndelete, 
                                                       trigger.old, trigger.oldMap,
                              						   trigger.new, trigger.newMap);

    } catch (customException e){

		trigger.new[0].addError(e, false);
    }
	
}