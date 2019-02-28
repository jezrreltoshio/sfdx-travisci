trigger Contact_formatCPF on Contact (before insert, before update) {
 
    if(trigger.isInsert){   ContactTriggers.formatCPF(trigger.new); }
    
    if(trigger.isUpdate){
        Map<Id,String> oldContact = new Map<Id,String>();
        List<Contact> lstContact = new List<Contact>();
        
        for(Contact c :trigger.old){
            if(c.CPF__c != null) oldContact.put(c.Id,c.CPF__c);
        }
        
        for(Contact c :trigger.new){
            if(oldContact.containsKey(c.Id)){
                if(c.CPF__c != null && c.CPF__c != oldContact.get(c.Id)) lstContact.add(c);
            }
        }
        if(lstContact.size() > 0) ContactTriggers.formatCPF(lstContact);
    }
}