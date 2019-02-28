trigger ContaLeadDuplicada on Lead (before insert, before update) {
    for(Lead a:Trigger.new)
        {          
            List<Account> acc=[select Id, VerificaDuplicidade__c from account 
                                     where VerificaDuplicidade__c != ''
                                     AND VerificaDuplicidade__c =:a.VerificaDuplicidade__c
                                     limit 1];
                                     
            if(acc.size()>0)
            {
                a.adderror('Conta com este CNPJ ou CPF já cadastrado no sistema');
            }
         }  

}