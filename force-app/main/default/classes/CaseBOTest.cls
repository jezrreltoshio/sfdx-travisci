@isTest
private class CaseBOTest {
    
    private static Case caso;
    private static User userOuvidoria;
    private static User userCobranca;
    
    static{
        
        User thisUser = [ SELECT Id FROM User WHERE Id = :UserInfo.getUserId() ];
        
        System.runAs ( thisUser ) {
            
            // busca a fila ouvidoria
            List<Group> filaOuvidoria = [
                SELECT DeveloperName,DoesIncludeBosses,DoesSendEmailToMembers,Email,Name,RelatedId,Type 
                FROM Group 
                WHERE DeveloperName = 'OUVIDORIA2'
            ];
            
            // cria lista para inserir usuarios
            List<User> insertUser = new List<User>();
            
            // cria usuario ouvidoria
            userOuvidoria = UserBuild.newUser();
            insertUser.add(userOuvidoria);
            
            // cria usuario cobrança
            userCobranca = UserBuild.newUser();
            userCobranca.Alias = 'standt2';
            userCobranca.Email='sascarTest2class@sascar.com.test';
            userCobranca.LastName='Testing2';
            userCobranca.UserName='sascarTest2class@sascar.com.test';
            userCobranca.IdUsuarioPreCadastro__c = 1241420352;
            insertUser.add(userCobranca);
            
            Insert insertUser;
            
            // Lista de filas
            List<GroupMember> cpMList = new List<GroupMember>();
            
            // colocando o userOuvidoria na fila Ouvidoria
            GroupMember membroFila = new GroupMember();
            membroFila.GroupId = filaOuvidoria.get(0).Id;
            membroFila.UserOrGroupId = userOuvidoria.Id;
            cpMList.add(membroFila);
            
            /* criando segundo membro da fila
GroupMember membroFila2 = new GroupMember();
membroFila2.GroupId = filaOuvidoria.get(0).Id;
membroFila2.UserOrGroupId  = userOuvidoria.Id;
cpMList.add(membroFila2);*/
            
            insert cpMList;
            
        }
        
        RecordType recordType = [SELECT Id FROM RecordType WHERE DeveloperName = 'Reclamacao'];
        caso = CaseBuild.newCase(recordType.Id);
        Database.insert(caso);
        
        CaseComment caseComem = new CaseComment();
        caseComem.CommentBody = 'teste';
        caseComem.ParentId = caso.Id;
        Insert caseComem;
        
        Account acc = AccountBuild.newAccount();
        Insert acc;
        
    }
    
    /*private static testMethod void transferCaseWithComment() {
        
        Test.startTest();
        
        System.runAs(userOuvidoria){
            caso.OwnerId = userCobranca.Id;
            Database.update(caso);
        }
        
        Test.stopTest();
    }*/
    
    private static testMethod void caseJuridico() {
        
        Test.startTest();
        
        RecordType recordType = [SELECT Id FROM RecordType WHERE DeveloperName = 'Juridico'];
        
        System.runAs(userOuvidoria){
            caso.Id = null;
            caso.recordTypeId = recordType.Id;
            caso.MotivoReclamacao__c = 'Informações contratuais e comerciais';
            //Database.Insert(caso);
        }
        
        Test.stopTest();
    }
    
    private static testMethod void caseProcon() {
        
        Test.startTest();
        
        RecordType recordType = [SELECT Id FROM RecordType WHERE DeveloperName = 'Procon'];
        
        System.runAs(userOuvidoria){
            caso.Id = null;
            caso.recordTypeId = recordType.Id;
            caso.MotivoReclamacao__c = 'Cancelamento/Downgrade de contrato não concluído';
            //Database.Insert(caso);
        }
        
        Test.stopTest();
    }
    
}