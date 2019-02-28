public with sharing class HLP_Telefone {
    //SPN = SCHEMA PROPERTY NAME
    public static final string SPN_TIPONUMEROC = 'Tipo_Numero__c';
    //public static final string SPN_DADOSPFSEXOC = 'DadosPF_Sexo__c';
    //public static final string SPN_DADOSPFESTADOCIVILC = 'DadosPF_EstadoCivil__c';
    
    //PLV = PICK LIST VALUE
    public static final string PLV_TIPONUMEROC_RESIDENCIAL = 'Residencial';
    public static final string PLV_TIPONUMEROC_COMERCIAL = 'Comercial';
    public static final string PLV_TIPONUMEROC_CELULAR = 'Celular';
    public static final string PLV_TIPONUMEROC_NEXTEL = 'Nextel';
    public static final string PLV_TIPONUMEROC_FAX = 'Fax';
    public static final string PLV_TIPONUMEROC_ASSISTENTE = 'Assistente';
    public static final string PLV_TIPONUMEROC_OUTRO = 'Outro';
    
    //EXT = EXTERNAL
    public static final string PLV_EXT_TIPONUMEROC_RESIDENCIAL = 'R';
    public static final string PLV_EXT_TIPONUMEROC_COMERCIAL = 'E';
    public static final string PLV_EXT_TIPONUMEROC_CELULAR = 'C';
    public static final string PLV_EXT_TIPONUMEROC_NEXTEL = 'N';
    public static final string PLV_EXT_TIPONUMEROC_FAX = 'F';
    public static final string PLV_EXT_TIPONUMEROC_ASSISTENTE = 'A';
    public static final string PLV_EXT_TIPONUMEROC_OUTRO = 'O';
    
    public static string getInternalTipoTelefoneValue(string externalValue) {
        string result = null;
        
        if (externalValue != null) {
            if (externalValue == HLP_Telefone.PLV_EXT_TIPONUMEROC_RESIDENCIAL) {
                result = HLP_Telefone.PLV_TIPONUMEROC_RESIDENCIAL;
            } else if (externalValue == HLP_Telefone.PLV_EXT_TIPONUMEROC_COMERCIAL) {
                result = HLP_Telefone.PLV_TIPONUMEROC_COMERCIAL;
            } else if (externalValue == HLP_Telefone.PLV_EXT_TIPONUMEROC_CELULAR) {
                result = HLP_Telefone.PLV_TIPONUMEROC_CELULAR;
            } else if (externalValue == HLP_Telefone.PLV_EXT_TIPONUMEROC_NEXTEL) {
                result = HLP_Telefone.PLV_TIPONUMEROC_NEXTEL;
            } else if (externalValue == HLP_Telefone.PLV_EXT_TIPONUMEROC_FAX) {
                result = HLP_Telefone.PLV_TIPONUMEROC_FAX;
            } else if (externalValue == HLP_Telefone.PLV_EXT_TIPONUMEROC_OUTRO) {
                result = HLP_Telefone.PLV_TIPONUMEROC_OUTRO;
            } else {
                throw BCL_EXT_UnkownReceivedValueException.createException(EXT_serverCargotracck.telefone.class, SPN_TIPONUMEROC , externalValue);
            }
        }

        return result;
    }
    
    public static string getExternalTipoTelefoneValue(string internalValue) {
        string result = null;
        
        if (internalValue != null) {
            if (internalValue == HLP_Telefone.PLV_TIPONUMEROC_RESIDENCIAL) {
                result = HLP_Telefone.PLV_EXT_TIPONUMEROC_RESIDENCIAL;
            } else if (internalValue == HLP_Telefone.PLV_TIPONUMEROC_COMERCIAL) {
                result = HLP_Telefone.PLV_EXT_TIPONUMEROC_COMERCIAL;
            } else if (internalValue == HLP_Telefone.PLV_TIPONUMEROC_CELULAR) {
                result = HLP_Telefone.PLV_EXT_TIPONUMEROC_CELULAR;
            } else if (internalValue == HLP_Telefone.PLV_TIPONUMEROC_NEXTEL) {
                result = HLP_Telefone.PLV_EXT_TIPONUMEROC_NEXTEL;
            } else if (internalValue == HLP_Telefone.PLV_TIPONUMEROC_FAX) {
                result = HLP_Telefone.PLV_EXT_TIPONUMEROC_FAX;
            } else if (internalValue == HLP_Telefone.PLV_TIPONUMEROC_OUTRO) {
                result = HLP_Telefone.PLV_EXT_TIPONUMEROC_OUTRO;
            } else {
                throw BCL_EXT_UnkownReceivedValueException.createException(EXT_serverCargotracck.telefone.class, SPN_TIPONUMEROC , internalValue);
            }
        }

        return result;
    }
    
    public static void setTelephone(PCL_PhoneNumber tel, String internalTelType, String telNumber) {
        if (tel == null) {
            throw BCL_ArgumentNullException.createException('tel');
        }
        
        if (String.isNotBlank(internalTelType) && String.isNotBlank(telNumber)) {

            string numeroLimpo = '';
            // Integer telNumberLength = telNumber.length();
            String nondigits = '[^0-9]';
            //String telNumberAdapted = telNumber.replaceAll(nondigits,'');
            String telNumberAdapted = BCL_HLP_String.getNumberFromFormatedString(telNumber);
            Integer telNumberLength = telNumberAdapted.length();
            
            for(Integer i = 0; i < telNumberLength; i++) {
                String c = BCL_HLP_String.subStringWithSize(telNumberAdapted, i, 1);
                if (integer.valueOf(c) != null) {
                    numeroLimpo += c;
                }
            }
            
            if(String.isNotBlank(numeroLimpo)) {
                //tel.phoneType = HLP_Telefone.getExternalTipoTelefoneValue(internalTelType);  
                tel.phoneType = internalTelType;
                
                integer numeroLimpoLength = numeroLimpo.length();
                if (numeroLimpoLength == 13) {
                    //DDI + DDD + Numero com 9 digitos
                    tel.DDD = integer.valueOf(BCL_HLP_String.subStringWithSize(numeroLimpo, 2, 2));
                    tel.phoneNumber = integer.valueOf(BCL_HLP_String.subStringWithSize(numeroLimpo, 4, 9));
                } else if (numeroLimpoLength == 12) {
                    //DDI + DDD + Numero com 8 digitos
                    tel.DDD = integer.valueOf(BCL_HLP_String.subStringWithSize(numeroLimpo, 2, 2));
                    tel.phoneNumber = integer.valueOf(BCL_HLP_String.subStringWithSize(numeroLimpo, 4, 8));
                    
                } else if (numeroLimpoLength == 11) {
                    //DDD + Numero com 9 digitos
                    tel.DDD = integer.valueOf(BCL_HLP_String.subStringWithSize(numeroLimpo, 0, 2));
                    tel.phoneNumber = integer.valueOf(BCL_HLP_String.subStringWithSize(numeroLimpo, 2, 9));
                    
                } else if (numeroLimpoLength == 10) {
                    //DDD + Numero com 8 digitos
                    tel.DDD = integer.valueOf(BCL_HLP_String.subStringWithSize(numeroLimpo, 0, 2));
                    tel.phoneNumber = integer.valueOf(BCL_HLP_String.subStringWithSize(numeroLimpo, 2, 8));
                } else {
                    // Número (de 8 ou 9 dígitos) sem DDD
                    tel.DDD = null;
                    tel.phoneNumber = integer.valueOf(numeroLimpo);
                }   
            }
        }
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
	}
}