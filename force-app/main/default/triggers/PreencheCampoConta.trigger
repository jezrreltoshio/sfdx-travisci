// Trigger desativada, funcionalidade tratada na trigger "Trigger_Conta"
trigger PreencheCampoConta on Account (before insert, before update) {

    /*for(Account a:Trigger.new){

        if(a.RecordTypeId != null){

            Util_Conta.carregarTipoRegistro();

            String recordTypeName = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosById().get(a.RecordTypeId).getName();
            system.debug('recordTypeName: '+recordTypeName);
            system.debug('PreencheCampoConta: '+a);
            
            if(a.CNPJ__c != null && a.Id_registro__c == Util_Conta.CORP){
                a.VerificaDuplicidade__c = a.CNPJ__c + 'CORP';
                a.VerificaDuplicidade_2__c = a.CNPJ__c + 'CORP';
                //a.VerificaDuplicidade_3__c = a.CNPJ__c + 'CORP';
            }

            else if(a.CNPJ__c != null && a.Id_registro__c == Util_Conta.bluetec){
                a.VerificaDuplicidade__c = a.CNPJ__c + 'Bluetec';
                a.VerificaDuplicidade_2__c = a.CNPJ__c + 'Bluetec';
                a.VerificaDuplicidade_3__c = a.CNPJ__c + 'Bluetec';            
            }

            else if(a.CPF__c != null && a.Id_registro__c == Util_Conta.SIGGO){
                a.VerificaDuplicidade__c = a.CPF__c + 'SIGGO';
                a.VerificaDuplicidade_2__c = a.CPF__c + 'SIGGO';
                a.VerificaDuplicidade_3__c = a.CPF__c + 'SIGGO';            
            }
            
            else if(a.CNPJ_CPF__c != null && a.Id_registro__c == Util_Conta.FRETEIRO){
                a.VerificaDuplicidade__c = a.CNPJ_CPF__c + 'FRETEIRO';
                a.VerificaDuplicidade_2__c = a.CNPJ_CPF__c + 'FRETEIRO';
                a.VerificaDuplicidade_3__c = a.CNPJ_CPF__c + 'FRETEIRO';
            }
            
            else if(a.CNPJ_CPF__c != null && a.Id_registro__c == Util_Conta.michelin){
                a.VerificaDuplicidade__c = a.CNPJ_CPF__c + 'Michelin';
                a.VerificaDuplicidade_2__c = a.CNPJ_CPF__c + 'Michelin';
                a.VerificaDuplicidade_3__c = a.CNPJ_CPF__c + 'Michelin';
            }
            
            else if(recordTypeName == 'Cargo Tracck'){
                if(a.CNPJ__c != null && a.Tipo_de_pessoa__c == 'J-Jurídica'){
                    //a.VerificaDuplicidade__c = a.CNPJ__c + 'Cargo Tracck';
                    //a.VerificaDuplicidade_2__c = a.CNPJ__c + 'Cargo Tracck';
                    a.VerificaDuplicidade_3__c = a.CNPJ__c + 'Cargo Tracck';
                    a.CPF__c = null;
                } else if(a.CPF__c != null && a.Tipo_de_pessoa__c == 'F-Física'){
                    //a.VerificaDuplicidade__c = a.CPF__c + 'Cargo Tracck';
                    //a.VerificaDuplicidade_2__c = a.CPF__c + 'Cargo Tracck';
                    a.VerificaDuplicidade_3__c = a.CPF__c + 'Cargo Tracck';
                    a.CNPJ__c = null;
                }

            } // Fim ifs

        } // Fim if(a.RecordTypeId != null)

    } // Fim for(Account a:Trigger.new)
*/
}