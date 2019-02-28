// Trigger desativada , funcionalidade tratada na trigger "Trigger_Conta"
trigger VerificaDuplicidade on Account (before insert) {
    
    //Recuperando o record type name do objeto Conta
    /*String recordType = Account.SObjectType.getDescribe().getRecordTypeInfosById().get(Trigger.new[0].RecordTypeId).getName();
    recordType = recordType.touppercase();
    
    List<Account> acc = new List<Account>();
        
    system.debug('VerificaDuplicidade on Account');
    system.debug('VerificaDuplicidade on Account - recordType: '+recordType);
    system.debug('VerificaDuplicidade on Account - CNPJ__c: '+Trigger.new[0].CNPJ__c);
    system.debug('VerificaDuplicidade on Account - CNPJ_CPF__c: '+Trigger.new[0].CNPJ_CPF__c);
    system.debug('VerificaDuplicidade on Account - CPF__c: '+Trigger.new[0].CPF__c);
    system.debug(' URL.getSalesforceBaseUrl().toExternalForm(): '+ URL.getSalesforceBaseUrl().toExternalForm());
        
    if(recordType == 'CORP' && Trigger.new[0].CNPJ__c != null){
        //CNPJ__c
        acc = [SELECT
                        Id, Name
                    FROM
                        Account
                    WHERE
                        CNPJ__c =:Trigger.new[0].CNPJ__c
                    AND
                        RecordTypeId =:Trigger.new[0].RecordTypeId
                    limit 1];
        
        system.debug('VerificaDuplicidade on Account - CORP - acc: '+acc);
        
        if(acc.size() > 0){
            Trigger.new[0].addError('Duplicidade - Já existe uma conta CORP com o CNPJ informado. Utilize a Conta existente: '+acc[0].Name);
        }
    } else if(recordType == 'FRETEIRO' && Trigger.new[0].CNPJ_CPF__c != null){
        //CNPJ_CPF__c
        acc = [SELECT
                        Id, Name
                    FROM
                        Account
                    WHERE
                        CNPJ_CPF__c =:Trigger.new[0].CNPJ_CPF__c
                    AND
                        RecordTypeId =:Trigger.new[0].RecordTypeId
                    limit 1];
                    
        system.debug('VerificaDuplicidade on Account - FRETEIRO - acc: '+acc);
        
        if(acc.size() > 0){
            Trigger.new[0].addError('Duplicidade - Já existe uma conta FRETEIRO com o CPF informado. Utilize a Conta existente: '+acc[0].Name);
        }
    } else if(recordType == 'SIGGO' && Trigger.new[0].CPF__c != null){
        //CPF__c
        acc = [SELECT
                        Id, Name
                    FROM
                        Account
                    WHERE
                        CPF__c =: Trigger.new[0].CPF__c
                    AND
                        RecordTypeId =:Trigger.new[0].RecordTypeId
                    limit 1];
        
        system.debug('VerificaDuplicidade on Account - SIGGO - acc: '+acc);
        
        if(acc.size() > 0){
            Trigger.new[0].addError('Duplicidade - Já existe uma conta SIGGO com o CPF informado. Utilize a Conta existente: '+acc[0].Name);
        }
    }*/
}