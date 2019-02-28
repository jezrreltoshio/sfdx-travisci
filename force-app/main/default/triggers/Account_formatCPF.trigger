trigger Account_formatCPF on Account (before insert, before update) {
    
    if(trigger.isInsert){   AccountTriggers.formatCPF(trigger.new); }
    
    if(trigger.isUpdate){
        Map<Id,String> oldAcc = new Map<Id,String>();
        List<Account> lstAcc = new List<Account>();
        
        for(Account acc :trigger.old){
            if(acc.CPF__c != null) oldAcc.put(acc.Id,acc.CPF__c);
        }
        
        for(Account acc :trigger.new){
            if(oldAcc.containsKey(acc.Id)){
                if(acc.CPF__c != null && acc.CPF__c != oldAcc.get(acc.Id)) lstAcc.add(acc);
            }
        }
        if(lstAcc.size() > 0) AccountTriggers.formatCPF(lstAcc);
    }
    
}