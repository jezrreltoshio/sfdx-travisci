public class Service_Compromisso {
    
    public static void preencheDataUltimaVisita(List<Event> events)
    {
        List<Account> contasRelacionadas = new List<Account>();
        List<Lead> leadsRelacionados = new List<Lead>();
        List<Id> idsToQuery = new List<Id>();
        Map<Id, Date> mapIdActivityDate = new Map<Id,Date>();
        Map<Id, Id> mapEventOwnerId = new Map<Id, Id>();
        Map<Id, Id> mapIdActivityIdAccount = new Map<Id, Id>();
        
        for(Event e : events)
        {
            if(e.WhatId != null)
            {
				idsToQuery.add(e.WhatId);   
                mapIdActivityDate.put(e.WhatId, e.ActivityDate);
                mapEventOwnerId.put(e.Id, e.OwnerId);
                mapIdActivityIdAccount.put(e.WhatId, e.Id);
            }
            /*
            if(e.WhoId != null)
            {
                if(String.valueOf(e.WhatId).startsWith('00Q'))
                {
                    idsToQuery.add(e.WhoId);
                    mapIdActivityDate.put(e.WhoId, e.ActivityDate);
                    mapEventOwnerId.put(e.Id, e.OwnerId);
                }
            }*/
        }
        
        System.debug('mapIdActivityDate: '+mapIdActivityDate);
        
        contasRelacionadas = [SELECT Id, Data_da_Ultima_Visita__c, Visitas_no_ano__c, OwnerId FROM Account WHERE Id IN : idsToQuery];
        leadsRelacionados = [SELECT Id, Data_da_Ultima_Visita__c, OwnerId FROM Lead WHERE Id IN : idsToQuery];
        
        System.debug('contasRelacionadas: '+contasRelacionadas);
        
        if(contasRelacionadas.size()>0)
        {
            if(!ProcessorControl.isRecursive)
            {
                for(Account a : contasRelacionadas){
                    if(a.OwnerId == mapEventOwnerId.get(mapIdActivityIdAccount.get(a.Id)))
                    {
                        a.Data_da_Ultima_Visita__c = Date.valueOf(mapIdActivityDate.get(a.Id));
                        System.debug('entrou aqui'+a.Data_da_Ultima_Visita__c);
                        if(a.Visitas_no_ano__c == null)
                            a.Visitas_no_ano__c = 0;
                        a.Visitas_no_ano__c = a.Visitas_no_ano__c + 1 ;
                        System.debug('a.Data_da_Ultima_Visita__c: '+a.Data_da_Ultima_Visita__c);
                        System.debug('a.Visitas_no_ano__c: '+a.Visitas_no_ano__c);
                        System.debug('mapIdActivityDate.get(a.Id): '+mapIdActivityDate.get(a.Id));
                    }
                }
                ProcessorControl.isRecursive = true;
            }
            update contasRelacionadas;
        }
        
        if(leadsRelacionados.size()>0)
        {
            for(Lead l : leadsRelacionados){
                if(l.OwnerId == mapEventOwnerId.get(mapIdActivityIdAccount.get(l.Id)))
                {
                    l.Data_da_Ultima_Visita__c = Date.valueOf(mapIdActivityDate.get(l.Id));
                    System.debug('l.Data_da_Ultima_Visita__c: '+l.Data_da_Ultima_Visita__c);
                    System.debug('mapIdActivityDate.get(l.Id): '+mapIdActivityDate.get(l.Id));
                }
                
            }
            update leadsRelacionados;
        }
        
        
    }

}