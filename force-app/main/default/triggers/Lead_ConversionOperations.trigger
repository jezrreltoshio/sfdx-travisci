trigger Lead_ConversionOperations on Lead (before update) {
    
    Map<Id,RecordType> tipoRegistro = new Map<Id,RecordType>();
    Map<Id,String> leadCelular = new Map<Id,String>();
    Map<Id,String> leadEmail = new Map<Id,String>();
    
    // Check the type of the records
    for(Lead le: trigger.new) {
        if (le.RecordTypeId != null){
            tipoRegistro.put(le.RecordTypeId,null);
        }
    }
    if (tipoRegistro.size() > 0){ 
        for (RecordType rt : [select Id, Name from RecordType where Id in :tipoRegistro.keySet()]) {
            tipoRegistro.put(rt.Id, rt);
        }
    
        for (Lead lead : Trigger.new) {
            
            // Check if lead is converted
            if (tipoRegistro.get(lead.RecordTypeId).Name == 'Siggo' && lead.IsConverted) {
                leadCelular.put(lead.ConvertedAccountId, lead.Telefone_celular__c);
                leadEmail.put(lead.ConvertedAccountId, lead.Email);
            }
        }
        
        // Check if there is any info to get copied
        if(leadCelular != null && leadCelular.size() > 0){
            
            List<Account> lsAcc = [select Id from account where id in : leadCelular.keySet()];
            
            // Select related account and update related fields
            if (lsAcc.size() > 0) {
                for (Account ac : lsAcc) {
                    ac.TelefoneCelular__c = leadCelular.get(ac.Id);
                    ac.EMail__c = leadEmail.get(ac.Id);
                    ac.EMailNFE__c = leadEmail.get(ac.Id);
                }
                
                update lsAcc;
            }
        }
    }
}