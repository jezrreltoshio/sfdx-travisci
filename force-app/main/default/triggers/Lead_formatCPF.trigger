trigger Lead_formatCPF on Lead (before insert, before update) {
    if(trigger.isInsert){   LeadTriggers.formatCPF(trigger.new);    }
    
    if(trigger.isUpdate){
        Map<Id,String> oldLead = new Map<Id,String>();
        List<Lead> lstLead = new List<Lead>();
        
        for(Lead l :trigger.old){
            if(l.CPF__c != null) oldLead.put(l.Id,l.CPF__c);
        }
        
        for(Lead l :trigger.new){
            if(oldLead.containsKey(l.Id)){
                if(l.CPF__c != null && l.CPF__c != oldLead.get(l.Id)) lstLead.add(l);
            }
        }
        if(lstLead.size() > 0) LeadTriggers.formatCPF(lstLead);
    }
 
}