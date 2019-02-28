trigger PreencheCampoLead on Lead (before insert, before update) {
    for(Lead a:Trigger.new){
        if(a.RecordTypeId != null){
            String recordTypeName = Schema.getGlobalDescribe().get('Lead').getDescribe().getRecordTypeInfosById().get(a.RecordTypeId).getName();
            system.debug('recordTypeName: '+recordTypeName);
            system.debug('PreencheCampoLead: '+a);
        
            if(a.CNPJ__c != null && a.Id_registro__c == '01240000000UZVb'){
                a.VerificaDuplicidade__c = a.CNPJ__c + 'CORP';
            }
            
            else if(a.CPF__c != null && a.Id_registro__c == '01240000000UZVc'){
                a.VerificaDuplicidade__c = a.CPF__c + 'SIGGO';
            }
            
            else if(a.CNPJ_CPF__c != null && a.Id_registro__c == '01240000000UbRz'){
                a.VerificaDuplicidade__c = a.CNPJ_CPF__c + 'FRETEIRO';
            }
            
            else if(a.CNPJ_CPF__c != null && a.Id_registro__c == '012400000009m8w'){
                a.VerificaDuplicidade__c = a.CNPJ_CPF__c + 'Michelin';
            }
            
            else if(recordTypeName == 'Cargo Tracck'){
                if(a.CNPJ__c != null && a.Tipo_de_pessoa__c == 'J-Jurídica'){
                    a.VerificaDuplicidade__c = a.CNPJ__c + 'Cargo Tracck';
                    a.CPF__c = null;
                } else if(a.CPF__c != null && a.Tipo_de_pessoa__c == 'F-Física'){
                    a.VerificaDuplicidade__c = a.CPF__c + 'Cargo Tracck';
                    a.CNPJ__c = null;
                }
            }
        }
    }
}