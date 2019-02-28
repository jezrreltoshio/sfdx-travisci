@isTest
public class ContactTriggersTest {
    static testMethod void formatCPFTest() {
        Account acc = new Account();
        acc.TelefoneCelular__c = '(11) 9876-5432';
        acc.Phone = '(11) 9876-5432';
        acc.Name = 'Teste';
        acc.CPF__c = '519.992.229-70';
        insert acc;
        
        Contact c = new Contact();
        c.LastName = 'Teste RG CPF';
        c.AccountId = acc.Id;
        c.CPF__c = '519.992.229-70';
        insert c;
        
        try{
            c.CPF__c = '111.111.111-11';
            update c;
        }catch(Exception e){}
        
        c.CPF__c = '862.164.186-02';
        update c;
        
        ContactTriggers.neverCallThisMethod();
        
    }

/*    
    static testMethod void formatCepValido(){
        BCL_HLP_String HLP_String = new BCL_HLP_String();
                
        Contact con = new Contact();
        con.LastName = 'Teste RG CPF';
        con.CPF__c = '519.992.229-70';
        con.MailingPostalCode = '81.280-270';
        
        insert con;
        
        if (!String.isEmpty(con.MailingPostalCode)){
            String str = BCL_HLP_String.getNumberFromFormatedString(con.MailingPostalCode);
            
            if(str.length() < 7 || str.length() > 8){
                con.MailingPostalCode.addError('CEP Inválido! Insira um valor válido.');
            } else{
                con.MailingPostalCode = HLP_String.formatCEP(con.MailingPostalCode);
            }
        }
    }
    
    static testMethod void formatCepInvalido(){
        BCL_HLP_String HLP_String = new BCL_HLP_String();
                
        Contact con = new Contact();
        con.LastName = 'Teste RG CPF';
        con.CPF__c = '519.992.229-70';
        con.MailingPostalCode = '03.303-000';
        
        insert con;
        
        if (!String.isEmpty(con.MailingPostalCode)){
            String str = BCL_HLP_String.getNumberFromFormatedString(con.MailingPostalCode);
            
            if(str.length() < 7 || str.length() > 8){
                con.MailingPostalCode.addError('CEP Inválido! Insira um valor válido.');
            } else{
                con.MailingPostalCode = HLP_String.formatCEP(con.MailingPostalCode);
            }
        }
    }
*/

     

}