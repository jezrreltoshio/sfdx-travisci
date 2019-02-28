trigger OppValidarNomePortador on Opportunity (before insert, before update) {
    if(Trigger.new[0].RecordTypeId != null){
        String recordTypeName = Schema.getGlobalDescribe().get('Opportunity').getDescribe().getRecordTypeInfosById().get(Trigger.new[0].RecordTypeId).getName();
        OpportunityTriggers.validarNomePortador(Trigger.new[0], Trigger.oldMap, Trigger.isInsert, Trigger.isUpdate, recordTypeName);
    }
}