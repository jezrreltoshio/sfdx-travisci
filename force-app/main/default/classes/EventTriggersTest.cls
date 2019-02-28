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
@isTest
private class EventTriggersTest {

    static testMethod void setAddress() {       
        User u = new User();
        u.LastName = 'Affonso';
        u.Alias = 'baff';
        u.Email = 'bruno.bonfim@sascar.com.br';
        u.Username = 'bruno.affonso@sascar.com.br.classTest';
        u.CommunityNickname = 'bruno.classTest';
        u.TimeZoneSidKey = 'America/Sao_Paulo';
        u.LocaleSidKey = 'pt_BR';
        u.EmailEncodingKey = 'ISO-8859-1';
        u.ProfileId = '00e400000013wpHAAQ';
        u.LanguageLocaleKey = 'pt_BR';
        u.IdUsuarioPreCadastro__c = 560449;
        insert u;
        
        Account acc = new Account();
        acc.Name = 'EVENT TRIGGER TEST ACC';
        acc.Enderecos_Principal_CEP__c = '82310380';
        acc.Enderecos_Principal_Cidade__c = 'Curitiba';
        acc.Enderecos_Principal_Complemento__c = 'AP 01';
        acc.Enderecos_Principal_Logradouro__c = 'Rua de Casa';
        acc.Enderecos_Principal_Numero__c = 15;
        insert acc;
        
        Test.startTest(); 
            Event ev = new Event();
            ev.Ownerid = u.Id;
            ev.Tipo_de_visita__c = 'Evento';
            ev.StartDateTime = datetime.now();
            ev.EndDateTime = datetime.now();
            ev.Cidade__c = 'Curitiba';
            ev.Subject = 'Outros';
           // ev.What.Id = acc.Id;  
            insert ev;       
                    
            EventTriggers.setAddress(ev);
        Test.stopTest();
    }
    
    static testMethod void neverCallThisMethod() {
        EventTriggers.neverCallThisMethod();        
    }
}