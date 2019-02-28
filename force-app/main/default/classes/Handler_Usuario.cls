public class Handler_Usuario {
    
    public static Boolean verificacao(Boolean isBefore, Boolean isAfter, Boolean isInsert,
                                  	Boolean isUpdate, Boolean isDelete, Boolean isUndelete, 
                                  	List<User> oldList, Map<Id, User> oldMap,
                                  	List<User> newList, Map<Id, User> newMap)
    {
        
        List<User> usersToAssignOnQueue = new List<User>();
        
        for(User u : (List<User>) Trigger.new)
        {
            if(!isInsert)
            {
            User oldUser = (User) Trigger.oldMap.get(u.Id);
            if(u.Fila__c != oldUser.Fila__c)
            	usersToAssignOnQueue.add(u);
            }
            
            if(isInsert && u.Fila__c != null)
                u.addError('Você não pode atribuir um usuário a uma fila antes de criá-lo.');
        }
        
        if(isBefore)
        {
            if(usersToAssignOnQueue.size()>0)
            	Service_Usuario.assignOnQueue(usersToAssignOnQueue);
        }
        
        
        
        return true;    
    }

}