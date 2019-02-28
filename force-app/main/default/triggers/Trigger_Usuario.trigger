trigger Trigger_Usuario on User (before insert, before update, before delete, after insert, after update, after delete) {

    System.debug(LoggingLevel.ERROR, '__ [trg DuplicidadeConta ] - Inicio...');
    System.debug(LoggingLevel.ERROR, '__ [trg DuplicidadeConta ] - Parametros_ORG__c.getOrgDefaults().Email_usuario_pentaho__c: '+Parametros_ORG__c.getOrgDefaults().Email_usuario_pentaho__c);
    System.debug(LoggingLevel.ERROR, '__ [trg DuplicidadeConta ] - UserInfo.getUserEmail(): '+UserInfo.getUserEmail());

    System.debug(LoggingLevel.ERROR, '__ [trg DuplicidadeConta ] - System.IsBatch(): '+System.IsBatch());
    System.debug(LoggingLevel.ERROR, '__ [trg DuplicidadeConta ] - System.isScheduled(): '+System.isScheduled());
    System.debug(LoggingLevel.ERROR, '__ [trg DuplicidadeConta ] - System.isQueueable(): '+System.isQueueable());
    //System.debug(LoggingLevel.ERROR, '__ [trg DuplicidadeConta ] - Boolean.valueOf(event.data.get(isApi)): '+Boolean.valueOf(Event.data.get('isApi')));
    System.debug(LoggingLevel.ERROR, '__ [trg DuplicidadeConta ] - String.valueOf(URL.getCurrentRequestUrl()): '+String.valueOf(URL.getCurrentRequestUrl()));
    
    if(UserInfo.getUserEmail() == Parametros_ORG__c.getOrgDefaults().Email_usuario_pentaho__c) return;
    if(!Triggers__c.getOrgDefaults().Trigger_conta__c) return;

    String req = String.valueOf(URL.getCurrentRequestUrl());
    if(req.contains('salesforce.com/services/Soap/u/')) return;

    try {

        Boolean executou = Handler_Usuario.verificacao(trigger.isBefore, trigger.isAfter, trigger.isInsert, trigger.isUpdate, 
                              trigger.isDelete, trigger.isUndelete, trigger.old, trigger.oldMap,
                              trigger.new, trigger.newMap);

    } catch (Exception e){

		trigger.new[0].addError(e, false);
    }
	
}