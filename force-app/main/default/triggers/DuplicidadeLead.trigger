trigger DuplicidadeLead on Lead (before update) {
         for(Lead a:Trigger.new)
       { 
           List<Lead> le=[select Id, VerificaDuplicidade__c  from Lead
                                     where VerificaDuplicidade__c  != ''
                                     and  VerificaDuplicidade__c =:a.VerificaDuplicidade__c 
                                     limit 1];
            
            if(le.size()>0)
            {
                a.adderror('Lead com este CNPJ ou CPF já existe no sistema');
            }
        }
        
}