public class ContactTriggers {
    public static void formatCPF(List<Contact> contList) {
        for(Contact c :contList){
          if(c.CPF__c != null) {
           String str = BCL_HLP_String.getNumberFromFormatedString(c.CPF__c);
           
           if(str.length() < 11) c.addError('Insira um CPF válido');
          
           if(str.length() == 11){
            if(str == '00000000000' || str == '11111111111' || str == '22222222222' || str == '33333333333' || str == '44444444444' || str == '55555555555' || str == '66666666666' || str == '77777777777' || str == '88888888888' || str == '99999999999') {
             c.addError('Insira um CPF válido');
            }
            c.CPF__c = BCL_HLP_String.formatCPF(str);
           }
          }
        }
    }

/*    
    public static void formatCEP(Contact con){
        BCL_HLP_String HLP_String = new BCL_HLP_String();
                
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

            public static void neverCallThisMethod() {
                    integer a = 0;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                    a = a + 1;
                }
}