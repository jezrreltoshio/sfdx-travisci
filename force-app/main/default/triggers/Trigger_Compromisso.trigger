trigger Trigger_Compromisso on Event (before insert, before update, after insert, after update) {

    String req = String.valueOf(URL.getCurrentRequestUrl());
    if(req.contains('salesforce.com/services/Soap/u/')) return;

    try {
	
        	Boolean executou = Handler_Compromisso.verificacao(trigger.isBefore, trigger.isAfter, trigger.isInsert, trigger.isUpdate, 
                              trigger.isDelete, trigger.isUndelete, trigger.old, trigger.oldMap,
                              trigger.new, trigger.newMap);
        
    } catch (Exception e){

		trigger.new[0].addError(e, false);
    }
	
}