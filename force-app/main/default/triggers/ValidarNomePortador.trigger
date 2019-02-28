trigger ValidarNomePortador on Account (before insert, before update) {
    if(Trigger.new[0].RecordTypeId != null){
        String recordTypeName = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosById().get(Trigger.new[0].RecordTypeId).getName();
        AccountTriggers.validarNomePortador(Trigger.new[0], Trigger.old, Trigger.isInsert, Trigger.isUpdate, recordTypeName);
    }
}