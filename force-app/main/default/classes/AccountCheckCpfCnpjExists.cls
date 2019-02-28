/**
 * [STI 85949] - [PRJ - SALESFORCE] - VALIDAR CPF/CNPJ OBJETO CONTA E OPORTUNIDADE
 * @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
 * @sinze 27/08/2015
 */
public class AccountCheckCpfCnpjExists{
/*    
     // [INSERT] Verifica se o CPF/CNPJ já está cadastrado.
     // @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
      
    public static void accountCheckCpfCnpjExists(Account account, String recordTypeName){           
        if(recordTypeName != 'MICHELIN KEY ACCOUNT'){
            //Variaveis
            String campo, valor, valorAtual, msg = 'Essa CONTA já está cadastrada.';
            Account[] accnt;
            
            if(recordTypeName == 'SIGGO'){
                campo = 'CPF__c';
                valor = applyMaskCpfCnpj(account, recordTypeName);
                valor = valor;
            } else if(recordTypeName == 'FRETEIRO'){
                campo = 'CNPJ_CPF__c';
                valor = applyMaskCpfCnpj(account, recordTypeName);
                valor = valor;
            } else if(recordTypeName == 'CORP'){
                campo = 'CNPJ__c';
                valor = applyMaskCpfCnpj(account, recordTypeName);
                valor = valor;
            }
                                
            //Verificando se o campo CPF/CNPJ não é nulo
            if(valor != null){
                if(campo == 'CPF__c'){
                    //Recuperando a conta com CPF informado.
                    accnt = [SELECT accnt.Id FROM Account accnt
                                                WHERE accnt.CPF__c =:valor
                                                    AND accnt.CPF__c != '' AND accnt.RecordType.Name != null];
                                                       // AND accnt.RecordTypeName =: account.RecordTypeName];
                } else if(campo == 'CNPJ_CPF__c'){
                    //Recuperando a conta com CPF/CNPJ informado.
                    accnt = [SELECT accnt.Id
                                            FROM Account accnt
                                                WHERE accnt.CNPJ_CPF__c =:valor
                                                    AND accnt.CNPJ_CPF__c != '' AND accnt.RecordType.Name != null];
                                                        //AND accnt.RecordTypeName =: account.RecordTypeName];
                } else if(campo == 'CNPJ__c'){
                    //Recuperando a conta com CNPJ informado.
                    accnt = [SELECT Id
                                            FROM Account accnt
                                                WHERE accnt.CNPJ__c =:valor
                                                    AND accnt.CNPJ__c != null AND accnt.RecordType.Name != null];
                                                        //AND accnt.RecordTypeName =: account.RecordTypeName];
                }
                                            
                //Verificando se retornou algum registro.
                //Se houver registro, é porque já está cadastrado.
                if(accnt.size() > 0){
                    if(campo == 'CPF__c'){
                        account.CPF__c.addError(msg);
                    } else if(campo == 'CNPJ_CPF__c'){
                        account.CNPJ_CPF__c.addError(msg);
                    } else if(campo == 'CNPJ__c'){
                        account.CNPJ__c.addError(msg);
                    }                   
                }
            }
        }
    }
    
    
     // [UPDATE] Verifica se o CPF/CNPJ já está cadastrado.
     // @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
     
    public static void accountCheckCpfCnpjExists(Account account, String recordTypeName, Account oldAccount){
        if(recordTypeName != 'MICHELIN KEY ACCOUNT'){
            //Variaveis
            String campo, valor, valorAtual, msg = 'Essa CONTA já está cadastrada.';
            Account[] accnt;
        
            if(recordTypeName == 'SIGGO'){
                campo = 'CPF__c';
                valor = applyMaskCpfCnpj(account, recordTypeName);
                valor = valor;
            } else if(recordTypeName == 'FRETEIRO'){
                campo = 'CNPJ_CPF__c';                         
                valor = applyMaskCpfCnpj(account, recordTypeName);
                valor = valor;
            } else if(recordTypeName == 'CORP'){
                campo = 'CNPJ__c';
                valor = applyMaskCpfCnpj(account, recordTypeName);
                valor = valor;
            }
            
            //Verificando se o campo CPF/CNPJ não é nulo
            if(valor != null){
                if(campo == 'CPF__c'){
                    //Recuperando a conta com CPF informado.
                    accnt = [SELECT accnt.Id
                                            FROM Account accnt
                                                WHERE accnt.CPF__c =:valor
                                                    AND accnt.CPF__c != null AND accnt.RecordTypeId != null
                                                        AND accnt.RecordTypeId =: account.RecordTypeId];
                } else if(campo == 'CNPJ_CPF__c'){
                    //Recuperando a conta com CPF/CNPJ informado.
                    accnt = [SELECT accnt.Id
                                            FROM Account accnt
                                                WHERE accnt.CNPJ_CPF__c =:valor
                                                    AND accnt.CNPJ_CPF__c != null AND accnt.RecordTypeId != null
                                                        AND accnt.RecordTypeId =: account.RecordTypeId];
                } else if(campo == 'CNPJ__c'){
                    //Recuperando a conta com CPF/CNPJ informado.
                    accnt = [SELECT accnt.Id
                                            FROM Account accnt
                                                WHERE accnt.CNPJ__c =:valor
                                                    AND accnt.CNPJ__c != null AND accnt.RecordTypeId != null
                                                        AND accnt.RecordTypeId =: account.RecordTypeId];
                }               
                
                if(campo == 'CPF__c'){
                    //valorAtual = applyMaskCpfCnpj(oldAccount, recordTypeName);
                    valorAtual = oldAccount.CPF__c;
                } else if(campo == 'CNPJ_CPF__c'){
                    //valorAtual = applyMaskCpfCnpj(oldAccount, recordTypeName);
                    valorAtual = oldAccount.CNPJ_CPF__c;
                } else if(campo == 'CNPJ__c'){
                    //valorAtual = applyMaskCpfCnpj(oldAccount, recordTypeName);
                    valorAtual = oldAccount.CNPJ__c;
                }
                
                //Aqui a trigger foi acionada por uma operação DML diferente de INSERT.
                //Comparando se o CPF/CNPJ atual é diferente do novo CPF/CNPJ informado.
                if(valorAtual != valor){
                    //Verificando se retornou algum registro.
                    //Se houver registro, é porque já está cadastrado.
                    if(accnt.size() > 0){
                        if(campo == 'CPF__c'){
                            account.CPF__c.addError(msg);
                        } else if(campo == 'CNPJ_CPF__c'){
                                account.CNPJ_CPF__c.addError(msg);
                        } else if(campo == 'CNPJ__c'){
                                account.CNPJ__c.addError(msg);
                        }
                    }
                }
            }
        }
    }
    
    
     // Verifica se o CPF/CNPJ é válido e aplica a mascara.
     // @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
      
    private static String applyMaskCpfCnpj(Account account, String recordTypeName){
        String msg, valor;
        
        if(recordTypeName == 'SIGGO'){
            account.CPF__c = BCL_HLP_String.getNumberFromFormatedString(account.CPF__c);
            msg = 'Insira um CPF válido.';
            
            if(account.CPF__c != null){
                if(account.CPF__c.length() == 11){
                    if(account.CPF__c == '00000000000' || account.CPF__c == '11111111111' || account.CPF__c == '22222222222' || account.CPF__c == '33333333333' || account.CPF__c == '44444444444' || account.CPF__c == '55555555555' || account.CPF__c == '66666666666' || account.CPF__c == '77777777777' || account.CPF__c == '88888888888' || account.CPF__c == '99999999999'){
                        account.CPF__c.addError(msg);
                    } else{
                        account.CPF__c = BCL_HLP_String.formatCPF(account.CPF__c);
                        valor = account.CPF__c;
                    }
                } else{
                    account.CPF__c.addError(msg);
                }
            }
        } else if(recordTypeName == 'FRETEIRO'){
            account.CNPJ_CPF__c = BCL_HLP_String.getNumberFromFormatedString(account.CNPJ_CPF__c);
            
            if(account.Tipo_de_pessoa__c.toUpperCase().trim() == 'F-FÍSICA'){
                msg = 'Insira um CPF válido.';
                
                if(account.CNPJ_CPF__c != null){    
                    if(account.CNPJ_CPF__c.length() == 11){
                        if(account.CNPJ_CPF__c == '00000000000' || account.CNPJ_CPF__c == '11111111111' || account.CNPJ_CPF__c == '22222222222' || account.CNPJ_CPF__c == '33333333333' || account.CNPJ_CPF__c == '44444444444' || account.CNPJ_CPF__c == '55555555555' || account.CNPJ_CPF__c == '66666666666' || account.CNPJ_CPF__c == '77777777777' || account.CNPJ_CPF__c == '88888888888' || account.CNPJ_CPF__c == '99999999999'){
                            account.CNPJ_CPF__c.addError(msg);
                        } else{
                            account.CNPJ_CPF__c = BCL_HLP_String.formatCPF(account.CNPJ_CPF__c);
                            valor = account.CNPJ_CPF__c;
                        }
                    } else{
                        account.CNPJ_CPF__c.addError(msg);
                    }
                }
            } else if(account.Tipo_de_pessoa__c.toUpperCase().trim() == 'J-JURÍDICA'){
                msg = 'Insira um CNPJ válido.';
                
                if(account.CNPJ_CPF__c != null){
                    if(account.CNPJ_CPF__c.length() == 14){
                        account.CNPJ_CPF__c = BCL_HLP_String.formatCNPJ(account.CNPJ_CPF__c);
                        valor = account.CNPJ_CPF__c;
                    } else{
                        account.CNPJ_CPF__c.addError(msg);
                    }
                }
            }
        } else if(recordTypeName == 'CORP'){
            account.CNPJ__c = BCL_HLP_String.getNumberFromFormatedString(account.CNPJ__c);
            msg = 'Insira um CNPJ válido.';
            
            if(account.CNPJ__c != null){
                if(account.CNPJ__c.length() == 14){
                    account.CNPJ__c = BCL_HLP_String.formatCNPJ(account.CNPJ__c);
                    valor = account.CNPJ__c;
                } else{
                    account.CNPJ__c.addError(msg);
                }
            }
        }
        
        return valor;
    }
 */   
}