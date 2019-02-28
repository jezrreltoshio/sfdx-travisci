trigger Account_formatCNPJ on Account (before insert, before update) {
    
    if(trigger.isInsert){   AccountTriggers.formatCNPJ(trigger.new);    }
    
    if(trigger.isUpdate){   
        Map<Id,String> oldAcc = new Map<Id,String>();
        List<Account> lstAcc = new List<Account>();
        
        for(Account acc :trigger.old){
            if(acc.CNPJ__c != null) oldAcc.put(acc.Id,acc.CNPJ__c);
        }
        
        for(Account acc :trigger.new){
            if(oldAcc.containsKey(acc.Id)){
                if(acc.CNPJ__c != null && acc.CNPJ__c != oldAcc.get(acc.Id)) lstAcc.add(acc);
            }
        }
        if(lstAcc.size() > 0) AccountTriggers.formatCNPJ(lstAcc);
    }
}