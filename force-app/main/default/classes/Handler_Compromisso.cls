public class Handler_Compromisso {
    
    public static Boolean verificacao(Boolean isBefore, Boolean isAfter, Boolean isInsert,
                                  	Boolean isUpdate, Boolean isDelete, Boolean isUndelete, 
                                  	List<Event> oldList, Map<Id, Event> oldMap,
                                  	List<Event> newList, Map<Id, Event> newMap)
    {
        List<Event> compromissosConcluidos = new List<Event>();
        
        for(Event e : (List<Event>) Trigger.new)
        {
            
            if(!isInsert)
            {
                System.debug('evento criado: '+e);
                if(e.Id != null)
                {
                    Event oldEvent = (Event) Trigger.oldMap.get(e.Id);
                    if((e.Visita_Concluida__c != oldEvent.Visita_Concluida__c) && (e.Visita_Concluida__c == true))
                        compromissosConcluidos.add(e);
                    
                    System.debug('compromissosConcluidos: '+compromissosConcluidos);
                    
                    if(compromissosConcluidos.size()>0)
            			Service_Compromisso.preencheDataUltimaVisita(compromissosConcluidos);
                }
            }else{
                if(e.Visita_Concluida__c == true)
                    compromissosConcluidos.add(e);
            }
            
        }
        
        if(isBefore)
        {
                
            if(compromissosConcluidos.size()>0)
            	Service_Compromisso.preencheDataUltimaVisita(compromissosConcluidos);
        }
        
		return true;
    }

}