/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest (SeeAllData=true)
global class OpportunityTriggersTest {
    
    public static Opportunity createOppty() {
        Opportunity opp = new Opportunity();
        
        // opp.CartaoCredito_Numero__c = 5555;// - Desabilitado para uso do campo Criptografado - Carlos Prates 05/02/2014 18:00
        opp.CartaoCredito_Numero_Cript__c = '1111444477778884';
        //opp.CartaoCredito_CodigoSeguranca__c = 123; //- Desabilitado para uso do campo Criptografado - Carlos Prates 06/02/2014 15:00
        opp.CartaoCredito_CodigoSeguranca_Cript__c = '123';
        opp.CartaoCredito_Vencimento__c = '1012';
        
        opp.name = 'Opp 1';
        opp.StageName = 'Abordagem inicial';
        opp.CloseDate = Date.today();
        opp.Description = 'Teste';
        opp.OwnerId = UserInfo.getUserId();
        
        return opp;
    }
    
    public static Account createAccount() {
        Account acc = new Account();

        acc.TelefoneCelular__c = '1198765432';
        acc.Phone = '1198765432';
        acc.Name = 'Teste';
        
        return acc;
    }
    
    public static Map<String,Id> findRecordType() {
        Map<String,Id> mapRT = new Map<String,Id>();
        for(RecordType rt :[SELECT Id, SObjectType, DeveloperName FROM RecordType]){
            mapRT.put(rt.SObjectType+'_'+rt.DeveloperName,rt.Id);
        }
        return mapRT;
    }
    
    global static Map<String,Id> rectype = findRecordType();
    
    public static Lead createLead() {
     Lead l = new Lead();
     //l.RecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Lead' AND Name = 'Siggo'].Id;
     l.RecordTypeId = rectype.get('Lead_Siggo');
     l.FirstName = 'Lead';
     l.LastName = 'Teste';
     l.Company = 'Empresa Teste';
     l.Status = 'Em aberto';
     l.Email = 'teste@teste.com';
     l.Phone = '1122224455';
     l.MobilePhone = '11965439876';
     l.Canal_de_entrada__c = 'Ativo';
     l.LeadSource = 'Internet';
     l.Description = 'Teste';
     return l;
    }

    static testMethod void myUnitTest() {
        Opportunity opp = CreateOppty();
        
        insert opp;
    }
    
    static testMethod void TestAbasteceHistoricoDetalhes() {
        Opportunity opp = CreateOppty();
        insert opp;
    
        opp.Description = 'Teste Histórico Descrição';
        update opp;
    }
    
    static testMethod void TestImportaHistoricoDetalhes() {
        Lead l = CreateLead();
        insert l;
        
        l.Description = 'Teste Histórico Descrição';
        update l;
        System.Debug('DEBUG LEAD ID: ' + l.Id);
        
        Opportunity opp = CreateOppty();
        opp.IdLeadForOpp__c = string.ValueOf(l.Id).substring(0,15);
        insert opp;
        //System.Debug('DEBUG LEAD ID IN OPP: ' + opp.IdLeadForOpp__c);
    }
    
    static testMethod void TestMapLeadDetector(){
        Account acc = CreateAccount();
        acc.IdExternoClienteIndicador__c = 121212;
        acc.Type = 'Parceiro';
        acc.Circuito__c = '1';
        acc.Cadencia__c = '2';
        insert acc;
        
        Lead l = CreateLead();
        l.Indicador__c = acc.Id;
        insert l;
        
        Opportunity opp = CreateOppty();
        opp.IdLeadForOpp__c = string.ValueOf(l.Id).substring(0,15);
        opp.StageName = 'Abordagem inicial';
        insert opp;
    }
    
    static testMethod void TestBloquear1() {
     Opportunity opp = CreateOppty();
     opp.Aprova_o__c = 'Aprovado';
     //opp.RecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Opportunity' AND Name = 'CORP'].Id;
     opp.RecordTypeId = rectype.get('Opportunity_CORP');
     insert opp;
     
     opp.Name = 'Opp 1 Teste';
     try{ update opp; }catch(Exception e){ e.getMessage();}
    }
    
    static testMethod void TestBloquear2() {
     Opportunity opp = CreateOppty();
     opp.Aprova_o__c = 'Aprovado';
     //opp.RecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Opportunity' AND Name = 'CORP'].Id;
     opp.RecordTypeId = rectype.get('Opportunity_CORP');
     opp.Motivo_da_perda__c = 'Valor da Multa';
        opp.StageName = 'Abordagem inicial';
     insert opp;
     
     opp.Motivo_da_perda__c = 'Tecnologia';
     try{ update opp; }catch(Exception e){ e.getMessage();}
    }
    
    static testMethod void TestUpdateOwner() {
     Id UserId = [SELECT Id, UserRole.Name FROM User WHERE UserRole.Name LIKE '%TELEVENDAS%' AND Id <> :UserInfo.getUserId()  LIMIT 1].Id;
        
     Opportunity opp = CreateOppty();
     opp.Aprova_o__c = 'Aprovado';
     opp.OwnerId = UserId;
     opp.RecordTypeId = rectype.get('Opportunity_CORP');
     opp.StageName = 'Abordagem inicial';
     opp.Executivo_de_vendas_new__c = UserInfo.getUserId();
        try{insert opp;}catch(Exception e){}
     
     opp.OwnerId = UserId;
     opp.Executivo_de_vendas_new__c = UserInfo.getUserId();
        try{update opp;}catch(Exception e){}
     
     opp.Executivo_de_vendas_new__c = UserId;
     opp.OwnerId = UserInfo.getUserId();
        try{update opp;}catch(Exception e){}
             
     opp.Executivo_de_vendas_new__c = null;
     opp.OwnerId = UserId;
        try{update opp;}catch(Exception e){}
     
     opp.OwnerId = UserId;
     opp.Executivo_de_vendas_new__c = UserInfo.getUserId();
        try{update opp;}catch(Exception e){}
     
     opp.OwnerId = UserId;
     opp.Executivo_de_vendas_new__c = UserInfo.getUserId();
        try{update opp;}catch(Exception e){}
             
    }
    
    static testMethod void TestBlockOpportunityCreation() {
     Integer i=0;
     Date data = Date.today();
     List<Opportunity> lstOpp = new List<Opportunity>();
     for(i=0; i < 9; i++){
         Opportunity opp = CreateOppty();
         opp.Name = 'Opp ' + i;
         opp.CloseDate = date.valueOf('2014-01-01');
         opp.RecordTypeId = rectype.get('Opportunity_CORP');
         opp.StageName = 'Abordagem inicial';
         lstOpp.add(opp);
     } 
     insert lstOpp;
     
     Opportunity opp = CreateOppty();
     opp.Name = 'Opp Final';
     opp.CloseDate = date.valueOf('2014-01-01');
     opp.RecordTypeId = rectype.get('Opportunity_CORP');
     opp.StageName = 'Abordagem inicial';
     try{ insert opp; }catch(Exception e){ /*Insert needed to cover line that displays error*/ }
    }
}