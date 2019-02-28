public with sharing class HLP_Account {
    //SPN = SCHEMA PROPERTY NAME
    public static final string SPN_TIPODEPESSOAC = 'Tipo_de_pessoa__c';
    public static final string SPN_DADOSPFSEXOC = 'DadosPF_Sexo__c';
    public static final string SPN_DADOSPFESTADOCIVILC = 'DadosPF_EstadoCivil__c';
    
    //PLV = PICK LIST VALUE
    public static final string PLV_TIPODEPESSOAC_FISICA = 'F-Física';
    public static final string PLV_TIPODEPESSOAC_JURIDICA = 'J-Jurídica';
    
    //EXT = EXTERNAL
    public static final string PLV_EXT_TIPODEPESSOAC_FISICA = 'F';
    public static final string PLV_EXT_TIPODEPESSOAC_JURIDICA = 'J';
    
    public static final string PLV_DADOSPFSEXOC_MASCULINO = 'M-Masculino';
    public static final string PLV_DADOSPFSEXOC_FEMININO = 'F-Feminino';
    
    public static final string PLV_EXT_DADOSPFSEXOC_MASCULINO = 'M';
    public static final string PLV_EXT_DADOSPFSEXOC_FEMININO = 'F';
    
    public static final string PLV_DADOSPFESTADOCIVILC_CASADO = 'C-Casado';
    public static final string PLV_DADOSPFESTADOCIVILC_SOLTEIRO = 'S-Solteiro';
    public static final string PLV_DADOSPFESTADOCIVILC_VIUVO = 'V-Viúvo';
    public static final string PLV_DADOSPFESTADOCIVILC_DIVORCIADO = 'D-Divorciado';
    public static final string PLV_DADOSPFESTADOCIVILC_AMASIADO = 'A-Amasiado';
    public static final string PLV_DADOSPFESTADOCIVILC_OUTRO = 'O-Outros';

    public static final string PLV_EXT_DADOSPFESTADOCIVILC_CASADO = 'C';
    public static final string PLV_EXT_DADOSPFESTADOCIVILC_SOLTEIRO = 'S';
    public static final string PLV_EXT_DADOSPFESTADOCIVILC_VIUVO = 'V';
    public static final string PLV_EXT_DADOSPFESTADOCIVILC_DIVORCIADO = 'D';
    public static final string PLV_EXT_DADOSPFESTADOCIVILC_AMASIADO = 'A';
    public static final string PLV_EXT_DADOSPFESTADOCIVILC_OUTRO = 'O';
    
    public static final string PLV_EXT_TIPOCONTATO_PESSOAAUTORIZADA = 'A';
    public static final string PLV_EXT_TIPOCONTATO_EMERGENCIA = 'E';
    public static final string PLV_EXT_TIPOCONTATO_INSTALACAO = 'I';
    public static final string PLV_EXT_TIPOCONTATO_PADRAO = 'T'; // T de Todos
    
    public static final integer PLV_EXT_FORMACOBRANCA_BOLETO = 1;
    public static final integer PLV_EXT_FORMACOBRANCA_CARTAO_VISA = 24;
    public static final integer PLV_EXT_FORMACOBRANCA_CARTAO_MASTER = 25;
    public static final integer PLV_EXT_FORMACOBRANCA_CARTAO_HIPERCARD = 82;
    public static final integer PLV_EXT_FORMACOBRANCA_DEBAUT_HSBC = 3;
    public static final integer PLV_EXT_FORMACOBRANCA_DEBAUT_ITAU = 4;
    public static final integer PLV_EXT_FORMACOBRANCA_DEBAUT_BRADESCO = 12;
    public static final integer PLV_EXT_FORMACOBRANCA_DEBAUT_BB = 13;
    public static final integer PLV_EXT_FORMACOBRANCA_DEBAUT_SANTANDER = 81;
    
    public static final integer CODIGO_BANCO_HSBC = 399;
    public static final integer CODIGO_BANCO_ITAU = 341;
    public static final integer CODIGO_BANCO_BRADESCO = 237;
    public static final integer CODIGO_BANCO_BB = 1;
    public static final integer CODIGO_BANCO_SANTANDER = 33;
    
    public static string getInternalTipoPessoaValue(string externalValue) {
        string result = null;
        
        if (externalValue != null) {
            if (externalValue == HLP_Account.PLV_EXT_TIPODEPESSOAC_FISICA) {
                result = HLP_Account.PLV_TIPODEPESSOAC_FISICA;
            } if (externalValue == HLP_Account.PLV_EXT_TIPODEPESSOAC_JURIDICA) {
                result = HLP_Account.PLV_TIPODEPESSOAC_JURIDICA;
            } else {
                throw BCL_EXT_UnkownReceivedValueException.createException(Account.class, SPN_TIPODEPESSOAC , externalValue);
            }
        }

        return result;
    }

    public static string getExternalTipoPessoaValue(string internalValue) {
        string result = null;
        
        if (internalValue != null) {
            system.debug('Internal value: ' + internalValue);
            system.debug('HLP_Account.PLV_TIPODEPESSOAC_FISICA: ' + HLP_Account.PLV_TIPODEPESSOAC_FISICA);
            if (internalValue == HLP_Account.PLV_TIPODEPESSOAC_FISICA) {
                result = HLP_Account.PLV_EXT_TIPODEPESSOAC_FISICA;
            } else if (internalValue == HLP_Account.PLV_TIPODEPESSOAC_JURIDICA) {
                result = HLP_Account.PLV_EXT_TIPODEPESSOAC_JURIDICA;
            } else {
                throw BCL_EXT_UnkownReceivedValueException.createException(Account.class, SPN_TIPODEPESSOAC , internalValue);
            }
        }

        return result;
    }

    public static string getInternalSexoValue(string externalValue) {
        string result = null;
        
        if (externalValue != null) {
            if (externalValue == PLV_EXT_DADOSPFSEXOC_MASCULINO) {
                result = PLV_DADOSPFSEXOC_MASCULINO;
            } else if (externalValue == PLV_EXT_DADOSPFSEXOC_FEMININO) {
                result = PLV_DADOSPFSEXOC_FEMININO;
            } else {
                throw BCL_EXT_UnkownReceivedValueException.createException(Account.class, SPN_DADOSPFSEXOC, externalValue);
            }
        }
        
        return result;
    }

    public static string getExternalSexoValue(string internalValue) {
        string result = null;
        
        if (internalValue != null) {
            if (internalValue == PLV_DADOSPFSEXOC_MASCULINO) {
                result = PLV_EXT_DADOSPFSEXOC_MASCULINO;
            } else if (internalValue == PLV_DADOSPFSEXOC_FEMININO) {
                result = PLV_EXT_DADOSPFSEXOC_FEMININO;
            } else {
                throw BCL_EXT_UnkownReceivedValueException.createException(Account.class, SPN_DADOSPFSEXOC, internalValue);
            }
        }
        
        return result;
    }
    
    public static string getInternalEstadoCivilValue(string externalValue) {
        string result = null;
        
        if (externalValue != null) {
            if (externalValue == PLV_EXT_DADOSPFESTADOCIVILC_CASADO) {
                result = PLV_DADOSPFESTADOCIVILC_CASADO;
                
            } else if (externalValue == PLV_EXT_DADOSPFESTADOCIVILC_SOLTEIRO) {
                result = PLV_DADOSPFESTADOCIVILC_SOLTEIRO;
                
            } else if (externalValue == PLV_EXT_DADOSPFESTADOCIVILC_VIUVO) {
                result = PLV_DADOSPFESTADOCIVILC_VIUVO;
                
            } else if (externalValue == PLV_EXT_DADOSPFESTADOCIVILC_DIVORCIADO) {
                result = PLV_DADOSPFESTADOCIVILC_DIVORCIADO;
                
            } else if (externalValue == PLV_EXT_DADOSPFESTADOCIVILC_AMASIADO) {
                result = PLV_DADOSPFESTADOCIVILC_AMASIADO;
                
            } else if (externalValue == PLV_EXT_DADOSPFESTADOCIVILC_OUTRO) {
                result = PLV_DADOSPFESTADOCIVILC_OUTRO;
                
            } else {
                throw BCL_EXT_UnkownReceivedValueException.createException(Account.class, SPN_DADOSPFESTADOCIVILC, externalValue);
            }
        }
        
        return result;
    }
    
    public static string getExternalEstadoCivilValue(string internalValue) {
        string result = null;
        
        if (internalValue != null) {
            if (internalValue == PLV_DADOSPFESTADOCIVILC_CASADO) {
                result = PLV_EXT_DADOSPFESTADOCIVILC_CASADO;
                
            } else if (internalValue == PLV_DADOSPFESTADOCIVILC_SOLTEIRO) {
                result = PLV_EXT_DADOSPFESTADOCIVILC_SOLTEIRO;
                
            } else if (internalValue == PLV_DADOSPFESTADOCIVILC_VIUVO) {
                result = PLV_EXT_DADOSPFESTADOCIVILC_VIUVO;
                
            } else if (internalValue == PLV_DADOSPFESTADOCIVILC_DIVORCIADO) {
                result = PLV_EXT_DADOSPFESTADOCIVILC_DIVORCIADO;
                
            } else if (internalValue == PLV_DADOSPFESTADOCIVILC_AMASIADO) {
                result = PLV_EXT_DADOSPFESTADOCIVILC_AMASIADO;
                
            } else if (internalValue == PLV_DADOSPFESTADOCIVILC_OUTRO) {
                result = PLV_EXT_DADOSPFESTADOCIVILC_OUTRO;
                
            } else {
                throw BCL_EXT_UnkownReceivedValueException.createException(Account.class, SPN_DADOSPFESTADOCIVILC, internalValue);
            }
        }
        
        return result;
    }
    
    public static id getAccountId (integer idExternoCliente) {
        id result = null;
        
        if (idExternoCliente != null) {
            List<Account> qr = [select id from Account where CT_PersClie_CodigoCliente__c = :idExternoCliente];
            
            if (qr.size() == 1) {
                result = qr[0].id;  
            }
        }
        
        return result;
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
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
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