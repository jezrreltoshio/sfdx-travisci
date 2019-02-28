trigger Lead_formatCNPJ on Lead (before insert, before update) {
    
    if(trigger.isInsert){   LeadTriggers.formatCNPJ(trigger.new);   }
    
    if(trigger.isUpdate){   
        Map<Id,String> oldLead = new Map<Id,String>();
        List<Lead> lstLead = new List<Lead>();
        
        for(Lead l :trigger.old){
            if(l.CNPJ__c != null) oldLead.put(l.Id,l.CNPJ__c);
        }
        
        for(Lead l :trigger.new){
            if(oldLead.containsKey(l.Id)){
                if(l.CNPJ__c != null && l.CNPJ__c != oldLead.get(l.Id)) lstLead.add(l);
            }
        }
        if(lstLead.size() > 0) LeadTriggers.formatCNPJ(lstLead);
    }
    
}