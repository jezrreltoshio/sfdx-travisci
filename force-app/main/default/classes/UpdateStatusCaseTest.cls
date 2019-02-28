@isTest
public class UpdateStatusCaseTest {
    
    public static Case caso;
    
    static{
        
        Id recordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'Reclamacao'].Id;
        caso = caseBuild.newCase(recordTypeId);
        Insert caso;
        
    }
    
    static testMethod void testUpdateStatusResponse(){
        
        Test.startTest();
        
        System.assertEquals('Sucesso!', UpdateStatusCase.updateStatusResponse(caso.Id));
        
        Case caso2 = [SELECT Id, StatusResposta__c FROM Case WHERE Id =: caso.Id LIMIT 1];
        
        System.assertEquals('Em andamento aguardando cliente', caso2.StatusResposta__c);
        
        Test.stopTest();
        
    }
    
    static testMethod void testUpdateStatusResponse2(){
        
        Test.startTest();
        
        caso.StatusResposta__c = 'Atrasada';
        update caso;
        
        System.assertEquals('Sucesso!', UpdateStatusCase.updateStatusResponse(caso.Id));
        
        Case caso2 = [SELECT Id, StatusResposta__c FROM Case WHERE Id =: caso.Id LIMIT 1];
        
        System.assertEquals('Atrasado aguardando cliente', caso2.StatusResposta__c);
        
        Test.stopTest();
        
    }
    
    static testMethod void testUpdateStatusResponse3(){
        
        Test.startTest();
        
        caso.StatusResposta__c = 'Concluída';
        update caso;
        
        System.assertEquals('Esta resposta está Concluída.', UpdateStatusCase.updateStatusResponse(caso.Id));
       
        Case caso2 = [SELECT Id, StatusResposta__c FROM Case WHERE Id =: caso.Id LIMIT 1];
        
        System.assertEquals('Concluída', caso2.StatusResposta__c);
        
        Test.stopTest();
        
    }
    
    static testMethod void testUpdateStatusSolution(){
        
        Test.startTest();
        
        System.assertEquals('Sucesso!', UpdateStatusCase.updateStatusSolution(caso.Id));
        
        Case caso2 = [SELECT Id, StatusSolucao__c FROM Case WHERE Id =: caso.Id LIMIT 1];
        
        System.assertEquals('Em andamento aguardando cliente', caso2.StatusSolucao__c);
        
        Test.stopTest();
        
    }
    
    static testMethod void testUpdateStatusSolution2(){
        
        Test.startTest();
        
        caso.StatusSolucao__c = 'Atrasada';
        update caso;
        
        System.assertEquals('Sucesso!', UpdateStatusCase.updateStatusSolution(caso.Id));
        
        Case caso2 = [SELECT Id, StatusSolucao__c FROM Case WHERE Id =: caso.Id LIMIT 1];
        
        System.assertEquals('Atrasado aguardando cliente', caso2.StatusSolucao__c);
        
        Test.stopTest();
        
    }
    
    static testMethod void testUpdateStatusSolution3(){
        
        Test.startTest();
        
        caso.StatusSolucao__c = 'Concluída';
        update caso;
        
        System.assertEquals('Esta solução está Concluída.', UpdateStatusCase.updateStatusSolution(caso.Id));
       
        Case caso2 = [SELECT Id, StatusSolucao__c FROM Case WHERE Id =: caso.Id LIMIT 1];
        
        System.assertEquals('Concluída', caso2.StatusSolucao__c);
        
        Test.stopTest();
        
    }

}