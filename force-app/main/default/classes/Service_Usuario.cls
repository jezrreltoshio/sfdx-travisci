public class Service_Usuario {
    
    public static void assignOnQueue(List<User> userList)
    {
        List<String> queues = new List<String>();
        List<Group> availableQueues = [SELECT Id, Name, DeveloperName FROM Group WHERE Type = 'Queue' AND DeveloperName LIKE 'MX%'];
        Map<String, Group> mapNomeFila = new Map<String, Group>();
        Map<Id, GroupMember> mapUserIdGMember = new Map<Id, GroupMember>();
        List<Id> groupIds = new List<Id>();
        List<GroupMember> groupMembersToAdd = new List<GroupMember>();
        List<GroupMember> gmToDelete = new List<GroupMember>();
        Set<Id> gmToDelete_Id = new Set<Id>();
        List<GroupMember> gmToMap = new List<GroupMember>();
        Map<Id, String> mapUserIdGroupDevName = new Map<Id, String>();
        List<Group> groupsToUpdate = new List<Group>();
        List<Id> userIds = new List<Id>();
        List<Id> usersToRemoveFromAllQueues = new List<Id>();
        User oldUser = new User();
        
        for(User u : userList)
        {
            userIds.add(u.Id);
        }
        
        if(availableQueues.size()>0)
        {
            for(Group g : availableQueues)
            {
                groupIds.add(g.Id);
                mapNomeFila.put(g.DeveloperName, g);
            }
        }
        
        gmToMap = [SELECT Id, GroupId, UserOrGroupId FROM GroupMember WHERE GroupId IN : groupIds AND UserOrGroupId IN : userIds];
        
        for(GroupMember gm : gmToMap)
        {
            mapUserIdGMember.put(gm.UserOrGroupId, gm);
        }
        
        for(User u : userList)
        {
            oldUser = (User) Trigger.oldMap.get(u.Id);
            
            if(u.Fila__c != null)
                System.debug('u.Fila__c: '+u.Fila__c);
            
            if(oldUser.Fila__c != null)
            	System.debug('oldUser.Fila__c: '+oldUser.Fila__c);
            
            if(u.Fila__c != null){
                
                if(u.Fila__c.Contains('MX_Administracao_de_SIMs'))
                {
                    GroupMember gm1 = new GroupMember();
                    gm1.UserOrGroupId = u.Id;
                    gm1.GroupId = mapNomeFila.get('MX_Administracao_de_SIMs').Id;
                    groupMembersToAdd.add(gm1);
                }
                
                if(u.Fila__c.Contains('MX_Analista_de_Plataforma'))
                {
                    GroupMember gm1 = new GroupMember();
                    gm1.UserOrGroupId = u.Id;
                    gm1.GroupId = mapNomeFila.get('MX_Analista_de_Plataforma').Id;
                    groupMembersToAdd.add(gm1);
                }
                
                if(u.Fila__c.Contains('MX_Atendimento_ao_Cliente'))
                {
                    GroupMember gm1 = new GroupMember();
                    gm1.UserOrGroupId = u.Id;
                    gm1.GroupId = mapNomeFila.get('MX_Atendimento_ao_Cliente').Id;
                    groupMembersToAdd.add(gm1);
                }
                
                if(u.Fila__c.Contains('MX_CAI'))
                {
                    GroupMember gm1 = new GroupMember();
                    gm1.UserOrGroupId = u.Id;
                    gm1.GroupId = mapNomeFila.get('MX_CAI').Id;
                    groupMembersToAdd.add(gm1);
                }
                
                if(u.Fila__c.Contains('MX_Cobranca'))
                {
                    GroupMember gm1 = new GroupMember();
                    gm1.UserOrGroupId = u.Id;
                    gm1.GroupId = mapNomeFila.get('MX_Cobranca').Id;
                    groupMembersToAdd.add(gm1);
                }
                
                if(u.Fila__c.Contains('MX_Desenvolvimento'))
                {
                    GroupMember gm1 = new GroupMember();
                    gm1.UserOrGroupId = u.Id;
                    gm1.GroupId = mapNomeFila.get('MX_Desenvolvimento').Id;
                    groupMembersToAdd.add(gm1);
                }
                
                
                if(u.Fila__c.Contains('MX_Executivos_de_Vendas'))
                {
                    GroupMember gm1 = new GroupMember();
                    gm1.UserOrGroupId = u.Id;
                    gm1.GroupId = mapNomeFila.get('MX_Executivos_de_Vendas').Id;
                    groupMembersToAdd.add(gm1);
                }
                if(u.Fila__c.Contains('MX_Faturamento'))
                {
                    GroupMember gm1 = new GroupMember();
                    gm1.UserOrGroupId = u.Id;
                    gm1.GroupId = mapNomeFila.get('MX_Faturamento').Id;
                    groupMembersToAdd.add(gm1);
                }
                
                if(u.Fila__c.Contains('MX_Infraestrutura'))
                {
                    GroupMember gm1 = new GroupMember();
                    gm1.UserOrGroupId = u.Id;
                    gm1.GroupId = mapNomeFila.get('MX_Infraestrutura').Id;
                    groupMembersToAdd.add(gm1);
                }
                
                if(u.Fila__c.Contains('MX_Instalacoes'))
                {
                    GroupMember gm1 = new GroupMember();
                    gm1.UserOrGroupId = u.Id;
                    gm1.GroupId = mapNomeFila.get('MX_Instalacoes').Id;
                    groupMembersToAdd.add(gm1);
                }
                
                if(u.Fila__c.Contains('MX_Laboratorio'))
                {
                    GroupMember gm1 = new GroupMember();
                    gm1.UserOrGroupId = u.Id;
                    gm1.GroupId = mapNomeFila.get('MX_Laboratorio').Id;
                    groupMembersToAdd.add(gm1);
                }
                
                if(u.Fila__c.Contains('MX_Operador_de_Plataforma'))
                {
                    GroupMember gm1 = new GroupMember();
                    gm1.UserOrGroupId = u.Id;
                    gm1.GroupId = mapNomeFila.get('MX_Operador_de_Plataforma').Id;
                    groupMembersToAdd.add(gm1);
                }
                
                if(u.Fila__c.Contains('MX_Telemarketing'))
                {
                    GroupMember gm1 = new GroupMember();
                    gm1.UserOrGroupId = u.Id;
                    gm1.GroupId = mapNomeFila.get('MX_Telemarketing').Id;
                    groupMembersToAdd.add(gm1);
                }
                
                if(u.Fila__c.Contains('MX_Treinamento_UC'))
                {
                    GroupMember gm1 = new GroupMember();
                    gm1.UserOrGroupId = u.Id;
                    gm1.GroupId = mapNomeFila.get('MX_Treinamento_UC').Id;
                    groupMembersToAdd.add(gm1);
                }
                
                if(oldUser.Fila__c != null)
                {
                    if(!u.Fila__c.Contains('MX_Administracao_de_SIMs') && oldUser.Fila__c.Contains('MX_Administracao_de_SIMs'))
                    {
                        mapUserIdGroupDevName.put(u.Id, 'MX_Administracao_de_SIMs');
                        gmToDelete_Id.add(u.Id);
                    }
                    
                    if(!u.Fila__c.Contains('MX_Analista_de_Plataforma') && oldUser.Fila__c.Contains('MX_Analista_de_Plataforma'))
                    {
                        mapUserIdGroupDevName.put(u.Id, 'MX_Administracao_de_SIMs');
                        //gmToDelete_Id.add(mapUserIdGMember.get(u.Id).Id);
                        gmToDelete_Id.add(u.Id);
                    }
                    
                    if(!u.Fila__c.Contains('MX_Atendimento_ao_Cliente') && oldUser.Fila__c.Contains('MX_Atendimento_ao_Cliente'))
                    {
                        mapUserIdGroupDevName.put(u.Id, 'MX_Atendimento_ao_Cliente');
                        gmToDelete_Id.add(u.Id);
                    }
                    
                    if(!u.Fila__c.Contains('MX_CAI') && oldUser.Fila__c.Contains('MX_CAI'))
                    {
                        mapUserIdGroupDevName.put(u.Id, 'MX_CAI');
                        gmToDelete_Id.add(u.Id);
                    }
                    
                    if(!u.Fila__c.Contains('MX_Cobranca') && oldUser.Fila__c.Contains('MX_Cobranca'))
                    {
                        mapUserIdGroupDevName.put(u.Id, 'MX_Cobranca');
                        gmToDelete_Id.add(u.Id);
                    }
                    
                    if(!u.Fila__c.Contains('MX_Desenvolvimento') && oldUser.Fila__c.Contains('MX_Desenvolvimento'))
                    {
                        mapUserIdGroupDevName.put(u.Id, 'MX_Desenvolvimento');
                        gmToDelete_Id.add(u.Id);
                    }
                    
                    if(!u.Fila__c.Contains('MX_Executivos_de_Vendas') && oldUser.Fila__c.Contains('MX_Executivos_de_Vendas'))
                    {
                        mapUserIdGroupDevName.put(u.Id, 'MX_Executivos_de_Vendas');
                        gmToDelete_Id.add(u.Id);
                    }
                    
                    if(!u.Fila__c.Contains('MX_Faturamento') && oldUser.Fila__c.Contains('MX_Faturamento'))
                    {
                        mapUserIdGroupDevName.put(u.Id, 'MX_Faturamento');
                        gmToDelete_Id.add(u.Id);
                    }
                    
                    if(!u.Fila__c.Contains('MX_Infraestrutura') && oldUser.Fila__c.Contains('MX_Infraestrutura'))
                    {
                        mapUserIdGroupDevName.put(u.Id, 'MX_Infraestrutura');
                        gmToDelete_Id.add(u.Id);
                    }
                    
                    if(!u.Fila__c.Contains('MX_Instalacoes') && oldUser.Fila__c.Contains('MX_Instalacoes'))
                    {
                        mapUserIdGroupDevName.put(u.Id, 'MX_Instalacoes');
                        gmToDelete_Id.add(u.Id);
                    }
                    
                    if(!u.Fila__c.Contains('MX_Laboratorio') && oldUser.Fila__c.Contains('MX_Laboratorio'))
                    {
                        mapUserIdGroupDevName.put(u.Id, 'MX_Laboratorio');
                        gmToDelete_Id.add(u.Id);
                    }
                    
                    if(!u.Fila__c.Contains('MX_Operador_de_Plataforma') && oldUser.Fila__c.Contains('MX_Operador_de_Plataforma'))
                    {
                        mapUserIdGroupDevName.put(u.Id, 'MX_Operador_de_Plataforma');
                        gmToDelete_Id.add(u.Id);
                    }
                    
                    if(!u.Fila__c.Contains('MX_Telemarketing') && oldUser.Fila__c.Contains('MX_Telemarketing'))
                    {
                        mapUserIdGroupDevName.put(u.Id, 'MX_Telemarketing');
                        gmToDelete_Id.add(u.Id);
                    }
                    
                    if(!u.Fila__c.Contains('MX_Treinamento_UC') && oldUser.Fila__c.Contains('MX_Treinamento_UC'))
                    {
                        mapUserIdGroupDevName.put(u.Id, 'MX_Treinamento_UC');
                        gmToDelete_Id.add(u.Id);
                    }
                }
            }
            else
            {
                usersToRemoveFromAllQueues.add(u.Id);
            }
        }
        
        insert groupMembersToAdd;
        
        
        if(gmToDelete_Id.size()>0)
        {
            List<GroupMember> groupMembersToRemove = new List<GroupMember>();
            List<String> groupDevNames = new List<String>();
            
            for(Id i : gmToDelete_Id)
                groupDevNames.add(mapUserIDGroupDevName.get(i));
            
            
            groupMembersToRemove = [SELECT Id, Group.DeveloperName, UserOrGroupId FROM GroupMember WHERE Group.DeveloperName IN : groupDevNames AND UserOrGroupId IN : gmToDelete_Id];
            
            delete groupMembersToRemove;
        }
        
        
        if(usersToRemoveFromAllQueues.size()>0)
        {
            
            List<GroupMember> deleteAllUserGroupMember = new List<GroupMember>();
            deleteAllUserGroupMember = [SELECT Id, Group.DeveloperName, UserOrGroupId FROM GroupMember WHERE Group.DeveloperName LIKE 'MX%' AND UserOrGroupId IN : usersToRemoveFromAllQueues];
            
            System.debug('deleteAllUserGroupMember: '+deleteAllUserGroupMember);
            
            delete deleteAllUserGroupMember;
        }
    }
    
}