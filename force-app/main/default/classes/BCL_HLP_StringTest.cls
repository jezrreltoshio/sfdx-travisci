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
private class BCL_HLP_StringTest {

    static testMethod void myUnitTest() {
        BCL_HLP_String.subString('Teste', 1, 3);
        BCL_HLP_String.subStringWithSize('Teste', 2, 3);
        BCL_HLP_String.padLeft('Teste', 's', 3);
        BCL_HLP_String.stringOfSize('Teste', 5);
        BCL_HLP_String.removeSpecialCharacters('Aíôsaeçiu');
        BCL_HLP_String.getNumberFromFormatedString('Test1e1');
        BCL_HLP_String.formatCPF('123456.7899-0');
        BCL_HLP_String.formatCNPJ('123456780000.9.1');
        
        BCL_HLP_String.neverCallThisMethod();
    }

/*    
    static testMethod void formatCEPTest() {
        String cep1 = '01234567';
        String cep2 = '12345678';
        String cep3 = '1234567';
        String cep4 = '';
        String cep5 = null;
        
        BCL_HLP_String HLP_String = new BCL_HLP_String();
        
        cep1 = HLP_String.formatCEP(cep1);
        cep2 = HLP_String.formatCEP(cep2);
        cep3 = HLP_String.formatCEP(cep3);
        cep4 = HLP_String.formatCEP(cep4);
        cep5 = HLP_String.formatCEP(cep5);
    
        System.assertEquals('01234-567', cep1, 'CEP1 não formatado conforme o esperado.');
        System.assertEquals('12345-678', cep2, 'CEP2 não formatado conforme o esperado.');
        System.assertEquals('1234567', cep3, 'CEP3 não formatado conforme o esperado.');
        System.assertEquals('', cep4, 'CEP4 não formatado conforme o esperado.');
        System.assertEquals(null, cep5, 'CEP5 não formatado conforme o esperado.'); 
    }
*/
}