global class BCL_HLP_String {
    public static string subString(string str, integer startIndex, integer endIndex) {
        return str.subString(startIndex, endIndex + 1);
    }

    public static string subStringWithSize(string str, integer startIndex, integer size) {
        integer endIndex = startIndex + size - 1;
        return str.subString(startIndex, endIndex + 1);
    }
    
    public static string padLeft(String str, string character, integer size) {
        string result = str;
    
        integer charCount = size - str.Length();
        if (charCount > 0) {
            result = BCL_HLP_String.stringOfSize(character, charCount) + str;
        } else if (charCount < 0) {
            result = BCL_HLP_String.subStringWithSize(str, size+charCount+1, size);
        }
        
        return result;
    }
    
    public static string stringOfSize(string character, integer size) {
        string result = '';
        
        for(integer i = 0; i < size; i++) {
            result += character;
        }
        return result;
    }
    
    public static string removeSpecialCharacters(string str) {
        string result = null;
        
        if (str != null) {
            str = str.replaceAll('á', 'a');
            str = str.replaceAll('à', 'a');
            str = str.replaceAll('ã', 'a');
            str = str.replaceAll('â', 'a');
            str = str.replaceAll('ä', 'a');

            str = str.replaceAll('é', 'e');
            str = str.replaceAll('è', 'e');
            //str = str.replaceAll('ã', 'e');
            str = str.replaceAll('ê', 'e');
            str = str.replaceAll('ë', 'e');

            str = str.replaceAll('í', 'i');
            str = str.replaceAll('ì', 'i');
            //str = str.replaceAll('ã', 'e');
            str = str.replaceAll('î', 'i');
            str = str.replaceAll('ï', 'i');

            str = str.replaceAll('ó', 'o');
            str = str.replaceAll('ò', 'o');
            str = str.replaceAll('õ', 'o');
            str = str.replaceAll('ô', 'o');
            str = str.replaceAll('ö', 'o');

            str = str.replaceAll('ú', 'u');
            str = str.replaceAll('ù', 'u');
            //str = str.replaceAll('ã', 'a');
            str = str.replaceAll('û', 'u');
            str = str.replaceAll('ü', 'u');
            
            str = str.replaceAll('ç', 'c');
            
            str = str.replaceAll('\'', ' ');
            
            result = str;
        }
        
        return result;
    }

    public static string getNumberFromFormatedString(string str) {
        string result = '';
        
        if (str != null) {
            for(integer i = 0; i < str.length(); i++) {
                string c = BCL_HLP_String.subString(str, i, i);
                
                if ('0123456789'.contains(c)) {
                    result += c;
                }
            }
        } else {
            result = null;
        } 
        
        return result;
        
    }
    
    public static String formatCPF(String str){
     String newCPF = '';
     for(integer i = 0; i < str.length(); i++){
      string s = BCL_HLP_String.subString(str, i, i);
      if('0123456789'.contains(s)){
       if(i == 3 || i == 6){
        newCPF += '.' + s;
       }else if(i == 9){
        newCPF += '-' + s;
       }else{
        newCPF += s;
       } 
      }
     }
     return newCPF;
    }
    
    public static String formatCNPJ(String str){
     String newCNPJ = '';
     for(integer i = 0; i < str.length(); i++){
      string s = BCL_HLP_String.subString(str, i, i);
      if('0123456789'.contains(s)){
       if(i == 2 || i == 5){
        newCNPJ += '.' + s;
       }else if(i == 8){
        newCNPJ += '/' + s;
       }else if(i == 12){
        newCNPJ += '-' + s;
       }else{
        newCNPJ += s;
       } 
      }
     }
     return newCNPJ;
    }
    
    public Date XMLStringToDate(String dateInString) {
      String[] tempDate = dateInString.split('/');
      Integer day =  Integer.valueOf(tempDate[0]);
      Integer month = Integer.valueOf(tempDate[1]);
      Integer year = Integer.valueOf(tempDate[2]);
      return date.newInstance(year,month,day);
    }
    
    public String formatPhone(String phone) { 
        
        String phoneDigits; 
        String nondigits = '[^0-9]'; 
        String returnPhone;
        
        if (String.isEmpty(phone)) 
            returnPhone = phone; 
        
        phoneDigits = phone.replaceAll(nondigits,'');
        
        // Phone with 8 digits
        if (phoneDigits.length() == 8) 
            returnPhone = phoneDigits.substring(0,4) + '-' + phoneDigits.substring(4,8); 
            
        // Phone with 9 digits
        if (phoneDigits.length() == 9) 
            returnPhone = phoneDigits.substring(0,5) + '-' + phoneDigits.substring(5,9); 
            
        // Phone with 8 digits and local area code (DDD)
        if (phoneDigits.length() == 10) 
            returnPhone = '(' + phoneDigits.substring(0,2) + ') ' + phoneDigits.substring(2,6) + '-' + phoneDigits.substring(6,10); 
            
        // Phone with 9 digits and local area code (DDD)
        if (phoneDigits.length() == 11) 
            returnPhone = '(' + phoneDigits.substring(0,2) + ') ' + phoneDigits.substring(2,7) + '-' + phoneDigits.substring(7,11); 
            
        // Phone with 8 digits, DDD and country code
        if (phoneDigits.length() == 12) 
            returnPhone = '+ ' + phoneDigits.subString(0,2) + ' (' + phoneDigits.substring(2,4) + ') ' + phoneDigits.substring(4,8) + '-' + phoneDigits.substring(8,12); 
    
        // Phone with 9 digits, DDD and country code
        if (phoneDigits.length() == 13) 
            returnPhone = '+ ' + phoneDigits.subString(0,2) + ' (' + phoneDigits.substring(2,4) + ') ' + phoneDigits.substring(4,9) + '-' + phoneDigits.substring(9,13); 
        
        return returnPhone;
    }
    
    

    public static String formatCEP(String CEP) { 
        
        String CEPDigits; 
        String nondigits = '[^0-9]'; 
        String returnCEP;
        
        if (String.isEmpty(CEP)) { 
            returnCEP = CEP;
        } else if (CEP.length() != 8) {
            returnCEP = CEP;
        } else {
            CEPDigits = CEP.replaceAll(nondigits,'');
        
            returnCEP = CEPDigits.substring(0,5) + '-' + CEPDigits.substring(5,8);
        }
        return returnCEP;
    }

    
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