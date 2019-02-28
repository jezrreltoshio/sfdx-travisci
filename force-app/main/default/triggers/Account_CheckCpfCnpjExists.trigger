/**
 * [STI 85949] - [PRJ - SALESFORCE] - VALIDAR CPF/CNPJ OBJETO CONTA E OPORTUNIDADE
 * @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
 * @sinze 27/08/2015
 */
trigger Account_CheckCpfCnpjExists on Account (before insert, before update){
    /*if(Trigger.new[0].RecordTypeId != null){
        //Recuperando o record type name do objeto Conta
        String recordTypeName = Account.SObjectType.getDescribe().getRecordTypeInfosById().get(Trigger.new[0].RecordTypeId).getName();
        recordTypeName = recordTypeName.touppercase();
        
        //Verifica se foi acionada por uma operacao DML (insert)
        if(Trigger.isInsert){
            AccountCheckCpfCnpjExists.accountCheckCpfCnpjExists(Trigger.new[0], recordTypeName);
        } else{
            AccountCheckCpfCnpjExists.accountCheckCpfCnpjExists(Trigger.new[0], recordTypeName, Trigger.old[0]);
        }
    }*/
}