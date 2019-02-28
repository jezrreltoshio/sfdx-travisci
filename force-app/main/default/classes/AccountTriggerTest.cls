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
private class AccountTriggerTest {

    static testMethod void myUnitTest() {
        Account acc = new Account();
        
        acc.TelefoneCelular__c = '(11) 9876-5432';
        acc.Phone = '(11) 9876-5432';
        acc.Name = 'Teste';
        
        insert acc;
    }
    
    static testMethod void updateTelefoneCelularTest() {
        List<Account> accList = new List<Account>();

        Account acc = new Account();

        acc.Phone = '(11) 9876-5432';
        acc.Name = 'Teste1';
        accList.Add(acc);
        
        acc = new Account();
        
        acc.Phone = '(11) 9876-5432';
        acc.Name = 'Teste2';
        accList.Add(acc);

        AccountTriggers.updateTelefoneCelular(accList);
    }

/*    
    static testMethod void formatCEPTest() {
        List<Account> accList = new List<Account>();

        Account acc = new Account();

        acc.Enderecos_Principal_CEP__c = '04120100';
        acc.Enderecos_Cobranca_CEP__c = '11533220';
        acc.Enderecos_Entrega_CEP__c = '123456789';
        accList.Add(acc);

        AccountTriggers.formatCEP(accList);
        
        System.assertEquals('04120-100', acc.Enderecos_Principal_CEP__c, 'CEP Principal não formatado conforme esperado.');
        System.assertEquals('11533-220', acc.Enderecos_Cobranca_CEP__c, 'CEP de Cobrança não formatado conforme esperado.');
        System.assertEquals('123456789', acc.Enderecos_Entrega_CEP__c, 'CEP de Entrega não formatado conforme esperado.');
    }
    
    static testMethod void formatCEPTest2() {
        List<Account> accList = new List<Account>();

        Account acc = new Account();

        acc.Enderecos_Principal_CEP__c = '120100';
        acc.Enderecos_Cobranca_CEP__c = '115332201';
        acc.Enderecos_Entrega_CEP__c = '1234567891';
        accList.Add(acc);

        AccountTriggers.formatCEP(accList);
    }
*/
    
    static testMethod void updateRelatedContactsTest() {
    
        Account acc = new Account();
        acc.TelefoneCelular__c = '(11) 9876-5432';
        acc.Phone = '(11) 9876-5432';
        acc.Name = 'Teste';
        insert acc;
        
        Contact c = new Contact();
        c.LastName = 'Teste RG CPF';
        c.AccountId = acc.Id;
        insert c;
        
        acc.DadosPF_RG__c = '123456789';
        acc.CPF__c = '519.992.229-70';
        update acc;
    }
    
    static testMethod void formatCNPJTest() {
        Account acc = new Account();
        acc.TelefoneCelular__c = '(11) 9876-5432';
        acc.Phone = '(11) 9876-5432';
        acc.Name = 'Teste';
        acc.CNPJ__c = '24.848.704/0001-87';
        insert acc;
        
        acc.CNPJ__c = '12.131.281/0001-09';
        update acc;
    }
    
    static testMethod void formatCPFTest() {
        Account acc = new Account();
        acc.TelefoneCelular__c = '(11) 9876-5432';
        acc.Phone = '(11) 9876-5432';
        acc.Name = 'Teste';
        acc.CPF__c = '519.992.229-70';
        insert acc;
        
        acc.CPF__c = '862.164.186-02';
        update acc;
    }
    
    static testMethod void validarCircuitoCadencia(){
    	Test.startTest();
    	
    	Account accnt = new Account();
		accnt.Name = 'Test 0123';
		accnt.CNPJ__c = '';
		accnt.TelefoneCelular__c = '(11) 9876-5432';
        accnt.Phone = '(11) 9876-5432';
        accnt.RecordTypeId = '01240000000YbdLAAS';
        accnt.Circuito__c = null;
        accnt.Cadencia__c = null;
        
    	List<Account> listAcc = new List<Account>();
		String userRoleId = '00E400000013PKaEAM';
        listAcc.add(accnt);
        
        AccountTriggers.validarCircuitoCadencia(listAcc, userRoleId);
        
        Account acc = new Account();
		acc.Name = 'Test 0123';
		acc.CNPJ__c = '';
		acc.TelefoneCelular__c = '(11) 9876-5432';
        acc.Phone = '(11) 9876-5432';
        acc.RecordTypeId = '01240000000YbdLAAS';
        acc.Circuito__c = '1';
        acc.Cadencia__c = null;
        
    	List<Account> listAcc1 = new List<Account>();
        listAcc1.add(acc);
        
        AccountTriggers.validarCircuitoCadencia(listAcc1, userRoleId);
			
		Test.stopTest();
    }
}