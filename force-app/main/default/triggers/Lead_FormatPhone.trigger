trigger Lead_FormatPhone on Lead (before insert, before update) {
    Set<Id> rtIds = new Set<Id>();
    BCL_HLP_String HLP_String = new BCL_HLP_String();
    
    // Check the id of the recordtype
    for(Lead le :Trigger.new){
        rtIds.add(le.RecordTypeId);
    }
    
    // Add RecordTypes on the MAP
    Map<Id,RecordType> tipoRegistro = new Map<Id,RecordType>([SELECT Id, DeveloperName FROM RecordType WHERE Id IN :rtIds]);
            
    //Format de Phones
    for(Lead le :Trigger.new){
        if(tipoRegistro.containsKey(le.RecordTypeId)){
            if (tipoRegistro.get(le.RecordTypeId).DeveloperName == 'Siggo') {
                if (!String.isEmpty(le.Phone)){
                    le.Phone = HLP_String.formatPhone(le.Phone);
                }
                
                if (!String.isEmpty(le.Telefone_celular__c)){
                    le.Telefone_celular__c = HLP_String.formatPhone(le.Telefone_celular__c);
                }
                
                if (!String.isEmpty(le.MobilePhone)){
                    le.MobilePhone = HLP_String.formatPhone(le.MobilePhone);
                }
            }
        }
    }
}