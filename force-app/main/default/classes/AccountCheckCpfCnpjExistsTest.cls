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
 * 
 * [STI 85949] - [PRJ - SALESFORCE] - VALIDAR CPF/CNPJ OBJETO CONTA E OPORTUNIDADE
 * @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
 * @sinze 27/08/2015
 *
 */
@isTest
private class AccountCheckCpfCnpjExistsTest{
 /*   
     //
     // [INSERT] Record type: SIGGO
     //
   
    static testMethod void accountCheckCpfCnpjExistsInsertSiggo(){
        test.startTest();
        
        String recordTypeId = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByName().get('SIGGO').getRecordTypeId();
                
        //Criando a Conta
        //SIGGO
        Account acc = new Account();
        acc.Name = 'Nome Siggo Insert Ltda';
        acc.CPF__c = '240.302.331-04';
        acc.CNPJ__c = '35.658.338/0001-10';
        acc.CNPJ_CPF__c = '35.658.338/0001-10';     
        acc.RecordTypeId = recordTypeId; //Siggo
        
        insert acc;
        
        Account acc2 = new Account();
        acc2.Name = 'Nome Siggo Insert Ltda';
        acc2.CPF__c = '226.811.653-00';
        acc2.CNPJ__c = '35.658.338/0001-10';
        acc2.CNPJ_CPF__c = '35.658.338/0001-10';
        acc2.RecordTypeId = recordTypeId; //Siggo
        
        insert acc2;
        
        //Recuperando informacoes da conta
        Account account = [SELECT Id, CNPJ__c, CNPJ_CPF__c, CPF__c, RecordTypeId FROM Account WHERE Id =:acc2.Id];
        
        //Record type name do objeto Conta
        String recordTypeName = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosById().get(recordTypeId).getName();
        recordTypeName = recordTypeName.touppercase();
        
        if(recordTypeName != 'MICHELIN KEY ACCOUNT'){
            //Variaveis
            String campo, valor, valorAtual, msg = 'Essa CONTA já está cadastrada.';
            Account[] accnt;
        
            if(recordTypeName == 'SIGGO'){
                campo = 'CPF__c';
                valor = account.CPF__c;
                valor = '240.302.331-04';
            } else if(recordTypeName == 'FRETEIRO'){
                campo = 'CNPJ_CPF__c';
                valor = account.CNPJ_CPF__c;
            } else{
                campo = 'CNPJ__c';
                valor = account.CNPJ__c;
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
                } else{
                    //Recuperando a conta com CNPJ informado.
                    accnt = [SELECT accnt.Id
                                            FROM Account accnt
                                                WHERE accnt.CNPJ__c =:valor
                                                    AND accnt.CNPJ__c != null AND accnt.RecordTypeId != null
                                                        AND accnt.RecordTypeId =: account.RecordTypeId];
                }
                                            
                //Verificando se retornou algum registro.
                //Se houver registro, é porque já está cadastrado.
                if(accnt.size() > 0){
                    if(campo == 'CPF__c'){
                        account.CPF__c.addError(msg);
                    } else if(campo == 'CNPJ_CPF__c'){
                        account.CNPJ_CPF__c.addError(msg);
                    } else{
                        account.CNPJ__c.addError(msg);
                    }                   
                }
            }
        }
                
        test.stopTest();        
    }
    
        // [INSERT] Record type: FRETEIRO
        
    static testMethod void accountCheckCpfCnpjExistsInsertFreteiro(){
        test.startTest();
        
        String recordTypeId = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByName().get('FRETEIRO').getRecordTypeId();
        
        //Criando a Conta
        //FRETEIRO
        Account acc = new Account();
        acc.Name = 'Nome Freteiro Insert Ltda';
        acc.CPF__c = '814.316.245-19';
        acc.CNPJ__c = '25.844.767/0001-28';
        acc.CNPJ_CPF__c = '25.844.767/0001-28';
        acc.RecordTypeId = recordTypeId; //Freteiro
        acc.Tipo_de_pessoa__c = 'J-JURÍDICO';
        
        insert acc;
        
        Account acc2 = new Account();
        acc2.Name = 'Nome Freteiro Insert Ltda';
        acc2.CPF__c = '814.316.245-19';
        acc2.CNPJ__c = '25.844.767/0001-28';
        acc2.CNPJ_CPF__c = '96.774.945/0001-30';
        acc2.RecordTypeId = recordTypeId; //Freteiro
        acc2.Tipo_de_pessoa__c = 'J-JURÍDICO';
        
        insert acc2;
        
        //Recuperando informacoes da conta
        Account account = [SELECT Id, CNPJ__c, CNPJ_CPF__c, CPF__c, RecordTypeId FROM Account WHERE Id =:acc2.Id];
        
        //Record type name do objeto Conta
        String recordTypeName = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosById().get(recordTypeId).getName();
        recordTypeName = recordTypeName.touppercase();
        
        if(recordTypeName != 'MICHELIN KEY ACCOUNT'){
            //Variaveis
            String campo, valor, valorAtual, msg = 'Essa CONTA já está cadastrada.';
            Account[] accnt;
            
            if(recordTypeName == 'SIGGO'){
                campo = 'CPF__c';
                valor = account.CPF__c;
            } else if(recordTypeName == 'FRETEIRO'){
                campo = 'CNPJ_CPF__c';
                valor = account.CNPJ_CPF__c;
                valor = '25.844.767/0001-28';
            } else{
                campo = 'CNPJ__c';
                valor = account.CNPJ__c;
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
                } else{
                    //Recuperando a conta com CNPJ informado.
                    accnt = [SELECT accnt.Id
                                            FROM Account accnt
                                                WHERE accnt.CNPJ__c =:valor
                                                    AND accnt.CNPJ__c != null AND accnt.RecordTypeId != null
                                                        AND accnt.RecordTypeId =: account.RecordTypeId];
                }
                                            
                //Verificando se retornou algum registro.
                //Se houver registro, é porque já está cadastrado.
                if(accnt.size() > 0){
                    if(campo == 'CPF__c'){
                        account.CPF__c.addError(msg);
                    } else if(campo == 'CNPJ_CPF__c'){
                        account.CNPJ_CPF__c.addError(msg);
                    } else{
                        account.CNPJ__c.addError(msg);
                    }                   
                }
            }
        }
                
        test.stopTest();        
    }
    
    // [INSERT] Record type: CORP
    
    static testMethod void accountCheckCpfCnpjExistsInsertCorp(){
        test.startTest();
        
        String recordTypeId = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByName().get('CORP').getRecordTypeId();
        
        //Criando a Conta
        //CORP
        Account acc = new Account();
        acc.Name = 'Nome Corp Insert Ltda';
        acc.CPF__c = '063.137.054-40';
        acc.CNPJ__c = '60.148.627/0001-16';
        acc.CNPJ_CPF__c = '60.148.627/0001-16';
        acc.RecordTypeId = recordTypeId; //Corp
        
        insert acc;
        
        Account acc2 = new Account();
        acc2.Name = 'Nome Corp Insert2 Ltda';
        acc2.CPF__c = '063.137.054-40';
        acc2.CNPJ__c = '06.106.388/0001-96';
        acc2.CNPJ_CPF__c = '60.148.627/0001-16';
        acc2.RecordTypeId = recordTypeId; //Corp
        
        insert acc2;
        
        //Recuperando informacoes da conta
        Account account = [SELECT Id, CNPJ__c, CNPJ_CPF__c, CPF__c, RecordTypeId FROM Account WHERE Id =:acc2.Id];      
        
        //Record type name do objeto Conta
        String recordTypeName = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosById().get(recordTypeId).getName();
        recordTypeName = recordTypeName.touppercase();
        
        if(recordTypeName != 'MICHELIN KEY ACCOUNT'){
            //Variaveis
            String campo, valor, valorAtual, msg = 'Essa CONTA já está cadastrada.';
            Account[] accnt;
        
            if(recordTypeName == 'SIGGO'){
                campo = 'CPF__c';
                valor = account.CPF__c;
            } else if(recordTypeName == 'FRETEIRO'){
                campo = 'CNPJ_CPF__c';
                valor = account.CNPJ_CPF__c;
            } else{
                campo = 'CNPJ__c';
                valor = account.CNPJ__c;
                valor = '60.148.627/0001-16';
            }
            
            //Verificando se o campo CPF/CNPJ não é nulo
            if(valor != null){
                if(campo == 'SIGGO'){
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
                } else{
                    //Recuperando a conta com CNPJ informado.
                    accnt = [SELECT accnt.Id
                                            FROM Account accnt
                                                WHERE accnt.CNPJ__c =:valor
                                                    AND accnt.CNPJ__c != null AND accnt.RecordTypeId != null
                                                        AND accnt.RecordTypeId =: account.RecordTypeId];
                }
                                            
                //Verificando se retornou algum registro.
                //Se houver registro, é porque já está cadastrado.
                if(accnt.size() > 0){
                    if(campo == 'CPF__c'){
                        account.CPF__c.addError(msg);
                    } else if(campo == 'CNPJ_CPF__c'){
                        account.CNPJ_CPF__c.addError(msg);
                    } else{
                        account.CNPJ__c.addError(msg);
                    }                   
                }
            }
        }
                
        test.stopTest(); 
    }
    
    // [UPDATE] Record type: SIGGO
    
    static testMethod void accountCheckCpfCnpjExistsUpdateSiggo(){
        test.startTest();
        
        String recordTypeId = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByName().get('SIGGO').getRecordTypeId();
        
        //Criando a Conta
        //SIGGO
        Account acc = new Account();
        acc.Name = 'Nome Siggo Update Ltda';
        acc.CPF__c = '581.255.478-19';
        acc.CNPJ__c = '13.038.517/0001-11';
        acc.CNPJ_CPF__c = '13.038.517/0001-11';
        acc.RecordTypeId = recordTypeId; //Siggo
        
        insert acc;
        
        //Recuperando as informacoes da conta inserida
        Account oldAccount = [SELECT Id, CNPJ__c, CNPJ_CPF__c, RecordTypeId FROM Account WHERE Id =:acc.Id];
        
        //Criando outra conta com mesmo CPF/CNPJ
        //SIGGO
        Account acc2 = new Account();
        acc2.Name = 'Nome Siggo2 Update Ltda';
        acc2.CPF__c = '988.026.868-74';
        acc2.CNPJ__c = '78.529.850/0001-79';
        acc2.CNPJ_CPF__c = '78.529.850/0001-79';
        acc2.RecordTypeId = recordTypeId; //Siggo
        
        insert acc2;
        
        //Atualizando a primeira Conta
        Account acc3 = oldAccount;
        acc3.CPF__c = '743.221.614-21';
        acc3.CNPJ__c = '78.529.850/0001-79';
        acc3.CNPJ_CPF__c = '78.529.850/0001-79';
        acc3.RecordTypeId = recordTypeId;
        
        update acc3;
        
        //Recuperando as informacoes da primeira conta inserida
        Account account = [SELECT Id, CNPJ__c, CNPJ_CPF__c, CPF__c, RecordTypeId FROM Account WHERE Id =:acc3.Id];
            
        //Record type name do objeto Conta
        String recordTypeName = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosById().get(recordTypeId).getName();
        recordTypeName = recordTypeName.touppercase();
        
        if(recordTypeName != 'MICHELIN KEY ACCOUNT'){
            //Variaveis
            String campo, valor, valorAtual, msg = 'Essa CONTA já está cadastrada.';
            Account[] accnt;
            
            if(recordTypeName == 'SIGGO'){
                campo = 'CPF__c';
                valor = account.CPF__c;
                valor = '988.026.868-74';
            } else if(recordTypeName == 'FRETEIRO'){
                campo = 'CNPJ_CPF__c';
                valor = account.CNPJ_CPF__c;
            } else{
                campo = 'CNPJ__c';
                valor = account.CNPJ__c;
            }
            
            //Verificando se o campo CPF/CNPJ não é nulo
            if(valor != null){
                if(campo == 'CPF__c'){
                    //Recuperando a conta com CPF/CNPJ informado.
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
                } else{
                    //Recuperando a conta com CNPJ informado.
                    accnt = [SELECT accnt.Id
                                            FROM Account accnt
                                                WHERE accnt.CNPJ__c =:valor
                                                    AND accnt.CNPJ__c != null AND accnt.RecordTypeId != null
                                                        AND accnt.RecordTypeId =: account.RecordTypeId];
                }
                
                if(campo == 'CPF__c'){
                    valorAtual = oldAccount.CPF__c;
                } else if(campo == 'CNPJ_CPF__c'){
                    valorAtual = oldAccount.CNPJ_CPF__c;
                } else{
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
                        } else{
                            account.CNPJ__c.addError(msg);
                        }
                    }
                }
            }
        }
                
        test.stopTest();        
    }
    
    // [UPDATE] Record type: FRETEIRO
     
    static testMethod void accountCheckCpfCnpjExistsUpdateFreteiro(){
        test.startTest();
        
        String recordTypeId = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByName().get('FRETEIRO').getRecordTypeId();
        
        //Criando a Conta
        //FRETEIRO
        Account acc = new Account();
        acc.Name = 'Nome Freteiro Update Ltda';
        acc.CPF__c = '581.255.478-19';
        acc.CNPJ__c = '13.038.517/0001-11';
        acc.CNPJ_CPF__c = '13.038.517/0001-11';
        acc.RecordTypeId = recordTypeId; //Freteiro
        acc.Tipo_de_pessoa__c = 'J-JURÍDICO';
        
        insert acc;
        
        //Recuperando as informacoes da conta inserida
        Account oldAccount = [SELECT Id, CNPJ__c, CNPJ_CPF__c, CPF__c, RecordTypeId FROM Account WHERE Id =:acc.Id];
        
        //Criando outra conta com mesmo CPF/CNPJ
        //FRETEIRO
        Account acc2 = new Account();
        acc2.Name = 'Nome Freteiro2 Update Ltda';
        acc2.CPF__c = '988.026.868-74';
        acc2.CNPJ__c = '78.529.850/0001-79';
        acc2.CNPJ_CPF__c = '78.529.850/0001-79';
        acc2.RecordTypeId = recordTypeId; //Freteiro
        acc2.Tipo_de_pessoa__c = 'J-JURÍDICO';
        
        insert acc2;
        
        //Atualizando a primeira Conta
        Account acc3 = oldAccount;
        acc3.CPF__c = '988.026.868-74';
        acc3.CNPJ__c = '78.529.850/0001-79';
        acc3.CNPJ_CPF__c = '70.143.654/0001-50';
        acc3.RecordTypeId = recordTypeId;
        acc3.Tipo_de_pessoa__c = 'J-JURÍDICO';
        
        update acc3;
        
        //Recuperando as informacoes da primeira conta inserida
        Account account = [SELECT Id, CNPJ__c, CNPJ_CPF__c, CPF__c, RecordTypeId FROM Account WHERE Id =:acc3.Id];
            
        //Record type name do objeto Conta
        String recordTypeName = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosById().get(recordTypeId).getName();
        recordTypeName = recordTypeName.touppercase();
        
        if(recordTypeName != 'MICHELIN KEY ACCOUNT'){
            //Variaveis
            String campo, valor, valorAtual, msg = 'Essa CONTA já está cadastrada.';
            Account[] accnt;
            
            if(recordTypeName == 'SIGGO'){
                campo = 'CPF__c';
                valor = account.CPF__c;
            } else if(recordTypeName == 'FRETEIRO'){
                campo = 'CNPJ_CPF__c';
                valor = account.CNPJ_CPF__c;
                valor = '78.529.850/0001-79';
            } else{
                campo = 'CNPJ__c';
                valor = account.CNPJ__c;
            }
            
            //Verificando se o campo CPF/CNPJ não é nulo
            if(valor != null){
                if(campo == 'CPF__c'){
                    //Recuperando a conta com CPF/CNPJ informado.
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
                } else{
                    //Recuperando a conta com CNPJ informado.
                    accnt = [SELECT accnt.Id
                                            FROM Account accnt
                                                WHERE accnt.CNPJ__c =:valor
                                                    AND accnt.CNPJ__c != null AND accnt.RecordTypeId != null
                                                        AND accnt.RecordTypeId =: account.RecordTypeId];
                }
                
                if(campo == 'CPF__c'){
                    valorAtual = oldAccount.CPF__c;
                } else if(campo == 'CNPJ_CPF__c'){
                    valorAtual = oldAccount.CNPJ_CPF__c;
                } else{
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
                        } else{
                            account.CNPJ__c.addError(msg);
                        }
                    }
                }
            }
        }
                
        test.stopTest();        
    }
    
    // [UPDATE] Record type: CORP
     
    static testMethod void accountCheckCpfCnpjExistsUpdateCorp(){
        test.startTest();
        
        String recordTypeId = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByName().get('CORP').getRecordTypeId();
        
        //Criando a Conta
        //CORP
        Account acc = new Account();
        acc.Name = 'Nome Corp Update Ltda';
        acc.CPF__c = '581.255.478-19';
        acc.CNPJ__c = '13.038.517/0001-11';
        acc.CNPJ_CPF__c = '13.038.517/0001-11';
        acc.RecordTypeId = recordTypeId; //Corp
        
        insert acc;
        
        //Recuperando as informacoes da conta inserida
        Account oldAccount = [SELECT Id, CNPJ__c, CNPJ_CPF__c, CPF__c, RecordTypeId FROM Account WHERE Id =:acc.Id];
        
        //Criando outra conta com mesmo CPF/CNPJ
        //CORP
        Account acc2 = new Account();
        acc2.Name = 'Nome Corp2 Update Ltda';
        acc2.CPF__c = '988.026.868-74';
        acc2.CNPJ__c = '78.529.850/0001-79';
        acc2.CNPJ_CPF__c = '78.529.850/0001-79';
        acc2.RecordTypeId = recordTypeId; //Corp
        
        insert acc2;
        
        //Atualizando a primeira Conta
        Account acc3 = oldAccount;
        acc3.CPF__c = '988.026.868-74';
        acc3.CNPJ__c = '74.426.423/0001-04';
        acc3.CNPJ_CPF__c = '78.529.850/0001-79';
        acc3.RecordTypeId = recordTypeId; //Corp
        
        update acc3;
        
        //Recuperando as informacoes da segunda conta inserida
        Account account = [SELECT Id, CNPJ__c, CNPJ_CPF__c, CPF__c, RecordTypeId FROM Account WHERE Id =:acc3.Id];
            
        //Record type name do objeto Conta
        String recordTypeName = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosById().get(recordTypeId).getName();
        recordTypeName = recordTypeName.touppercase();
        
        if(recordTypeName != 'MICHELIN KEY ACCOUNT'){
            //Variaveis
            String campo, valor, valorAtual, msg = 'Essa CONTA já está cadastrada.';
            Account[] accnt;
            
            if(recordTypeName == 'SIGGO'){
                campo = 'CPF__c';
                valor = account.CPF__c;
            } else if(recordTypeName == 'FRETEIRO'){
                campo = 'CNPJ_CPF__c';
                valor = account.CNPJ_CPF__c;
            } else{
                campo = 'CNPJ__c';
                valor = account.CNPJ__c;
                valor = '78.529.850/0001-79';
            }
            
            //Verificando se o campo CPF/CNPJ não é nulo
            if(valor != null){
                if(campo == 'CPF__c'){
                    //Recuperando a conta com CPF/CNPJ informado.
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
                } else{
                    //Recuperando a conta com CNPJ informado.
                    accnt = [SELECT accnt.Id
                                            FROM Account accnt
                                                WHERE accnt.CNPJ__c =:valor
                                                    AND accnt.CNPJ__c != null AND accnt.RecordTypeId != null
                                                        AND accnt.RecordTypeId =: account.RecordTypeId];
                }
                
                if(campo == 'CPF__c'){
                    valorAtual = oldAccount.CPF__c;
                } else if(campo == 'CNPJ_CPF__c'){
                    valorAtual = oldAccount.CNPJ_CPF__c;
                } else{
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
                        } else{
                            account.CNPJ__c.addError(msg);
                        }
                    }
                }
            }
        }
                
        test.stopTest();        
    }
    
    // [INSERT] 
    // Verifica se o CPF/CNPJ é válido e aplica a mascara.
    // @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
      
    static testMethod void applyMaskCpfCnpjInsertSiggo(){
        test.startTest();
        
        String recordTypeId = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByName().get('SIGGO').getRecordTypeId();
        String recordTypeName = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosById().get(recordTypeId).getName();
        
        String msg, valor;  
        
        //Criando a Conta
        //SIGGO
        Account acc = new Account();
        acc.Name = 'Nome Siggo Insert Ltda';
        acc.CPF__c = '240.302.331-04';
        acc.CNPJ__c = '35.658.338/0001-10';
        acc.CNPJ_CPF__c = '35.658.338/0001-10';
        acc.RecordTypeId = recordTypeId;
        
        insert acc;
        
        //Recuperando informacoes da conta
        Account account = [SELECT Id, CNPJ__c, CNPJ_CPF__c, CPF__c, RecordTypeId FROM Account WHERE Id =:acc.Id];
                
        if(recordTypeName == 'SIGGO'){
            account.CPF__c = BCL_HLP_String.getNumberFromFormatedString(account.CPF__c);
            msg = 'Insira um CPF válido.';
                        
            if(account.CPF__c.length() == 11){
                if(account.CPF__c == '00000000000' || account.CPF__c == '11111111111' || account.CPF__c == '22222222222' || account.CPF__c == '33333333333' || account.CPF__c == '44444444444' || account.CPF__c == '55555555555' || account.CPF__c == '66666666666' || account.CPF__c == '77777777777' || account.CPF__c == '88888888888' || account.CPF__c == '99999999999'){
                    account.CPF__c.addError(msg);
                } else{
                    valor = BCL_HLP_String.formatCPF(account.CPF__c);
                }
            } else{
                account.CPF__c.addError(msg);
            }
        } else if(recordTypeName == 'FRETEIRO'){
            account.CNPJ_CPF__c = BCL_HLP_String.getNumberFromFormatedString(account.CNPJ_CPF__c);
            
            if(account.Tipo_de_pessoa__c.toUpperCase() == 'F-FÍSICA'){
                msg = 'Insira um CPF válido.';
                
                if(account.CNPJ_CPF__c.length() == 11){
                    if(account.CNPJ_CPF__c == '00000000000' || account.CNPJ_CPF__c == '11111111111' || account.CNPJ_CPF__c == '22222222222' || account.CNPJ_CPF__c == '33333333333' || account.CNPJ_CPF__c == '44444444444' || account.CNPJ_CPF__c == '55555555555' || account.CNPJ_CPF__c == '66666666666' || account.CNPJ_CPF__c == '77777777777' || account.CNPJ_CPF__c == '88888888888' || account.CNPJ_CPF__c == '99999999999'){
                        account.CNPJ_CPF__c.addError(msg);
                    } else{
                        valor = BCL_HLP_String.formatCPF(account.CNPJ_CPF__c);
                    }
                } else{
                    account.CNPJ_CPF__c.addError(msg);
                }
            } else if(account.Tipo_de_pessoa__c.toUpperCase() == 'J-JURÍDICA'){
                msg = 'Insira um CNPJ válido.';
                
                if(account.CNPJ_CPF__c.length() == 14){
                    valor = BCL_HLP_String.formatCNPJ(account.CNPJ_CPF__c);
                } else{
                    account.CNPJ_CPF__c.addError(msg);
                }
            }
        } else if(recordTypeName == 'CORP'){
            account.CNPJ__c = BCL_HLP_String.getNumberFromFormatedString(account.CNPJ__c);
            msg = 'Insira um CNPJ válido.';
            
            if(account.CNPJ__c.length() == 14){
                valor = BCL_HLP_String.formatCNPJ(account.CNPJ__c);
            } else{
                account.CNPJ__c.addError(msg);
            }
        }
        
        System.debug(valor);
        
        test.stopTest();
    }
    
    // [UPDATE] 
    // Verifica se o CPF/CNPJ é válido e aplica a mascara.
    // @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
      
    static testMethod void applyMaskCpfCnpjUpdateSiggo(){
        test.startTest();
        
        String recordTypeId = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByName().get('SIGGO').getRecordTypeId();
        String recordTypeName = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosById().get(recordTypeId).getName();
        
        String msg, valor;
                
        //Criando a Conta
        //SIGGO
        Account acc = new Account();
        acc.Name = 'Nome Siggo Update Ltda';
        acc.CPF__c = '581.255.478-19';
        acc.CNPJ__c = '13.038.517/0001-11';
        acc.CNPJ_CPF__c = '13.038.517/0001-11';
        acc.RecordTypeId = recordTypeId; //Siggo
        
        insert acc;
        
        //Recuperando as informacoes da conta inserida
        Account oldAccount = [SELECT Id, CNPJ__c, CNPJ_CPF__c, RecordTypeId FROM Account WHERE Id =:acc.Id];
        
        //Criando outra conta com mesmo CPF/CNPJ
        //SIGGO
        Account acc2 = new Account();
        acc2.Name = 'Nome Siggo2 Update Ltda';
        acc2.CPF__c = '988.026.868-74';
        acc2.CNPJ__c = '78.529.850/0001-79';
        acc2.CNPJ_CPF__c = '78.529.850/0001-79';
        acc2.RecordTypeId = recordTypeId; //Siggo
        
        insert acc2;
        
        //Atualizando a primeira Conta
        Account acc3 = oldAccount;
        acc3.CPF__c = '674.959.605-31';
        acc3.CNPJ__c = '78.529.850/0001-79';
        acc3.CNPJ_CPF__c = '78.529.850/0001-79';
        acc3.RecordTypeId = recordTypeId; //Siggo
        
        update acc3;
        
        //Recuperando as informacoes da primeira conta inserida
        Account account = [SELECT Id, CNPJ__c, CNPJ_CPF__c, CPF__c, RecordTypeId FROM Account WHERE Id =:acc3.Id];
                        
        if(recordTypeName == 'SIGGO'){
            account.CPF__c = BCL_HLP_String.getNumberFromFormatedString('988.026.868-74');
            msg = 'Insira um CPF válido.';
                        
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
        } else if(recordTypeName == 'FRETEIRO'){
            account.CNPJ_CPF__c = BCL_HLP_String.getNumberFromFormatedString(account.CNPJ_CPF__c);
            
            if(account.Tipo_de_pessoa__c.toUpperCase() == 'F-FÍSICA'){
                msg = 'Insira um CPF válido.';
                
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
            } else if(account.Tipo_de_pessoa__c.toUpperCase() == 'J-JURÍDICA'){
                msg = 'Insira um CNPJ válido.';
                
                if(account.CNPJ_CPF__c.length() == 14){
                    account.CNPJ_CPF__c = BCL_HLP_String.formatCNPJ(account.CNPJ_CPF__c);
                    valor = account.CNPJ_CPF__c;
                } else{
                    account.CNPJ_CPF__c.addError(msg);
                }
            }
        } else if(recordTypeName == 'CORP'){
            account.CNPJ__c = BCL_HLP_String.getNumberFromFormatedString(account.CNPJ__c);
            msg = 'Insira um CNPJ válido.';
            
            if(account.CNPJ__c.length() == 14){
                account.CNPJ__c = BCL_HLP_String.formatCNPJ(account.CNPJ__c);
                valor = account.CNPJ__c;
            } else{
                account.CNPJ__c.addError(msg);
            }
        }
        
        System.debug(valor);
        
        test.stopTest();
    }
    
    // [INSERT] 
    // Verifica se o CPF/CNPJ é válido e aplica a mascara.
    // @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
     
    static testMethod void applyMaskCpfCnpjInsertFisicaFreteiro(){
        test.startTest();
        
        String recordTypeId = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByName().get('FRETEIRO').getRecordTypeId();
        String recordTypeName = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosById().get(recordTypeId).getName();
        
        String msg, valor;  
        
        //Criando a Conta
        //SIGGO
        Account acc = new Account();
        acc.Name = 'Nome Siggo Insert Ltda';
        acc.CPF__c = '744.022.441-88';
        acc.CNPJ__c = '35.658.338/0001-10';
        acc.CNPJ_CPF__c = '744.022.441-88';
        acc.RecordTypeId = recordTypeId;
        acc.Tipo_de_pessoa__c = 'F-FÍSICA';
        
        insert acc;
        
        //Recuperando informacoes da conta
        Account account = [SELECT Id, CNPJ__c, CNPJ_CPF__c, CPF__c, RecordTypeId, Tipo_de_pessoa__c FROM Account WHERE Id =:acc.Id];
                
        if(recordTypeName == 'SIGGO'){
            account.CPF__c = BCL_HLP_String.getNumberFromFormatedString(account.CPF__c);
            msg = 'Insira um CPF válido.';
                        
            if(account.CPF__c.length() == 11){
                if(account.CPF__c == '00000000000' || account.CPF__c == '11111111111' || account.CPF__c == '22222222222' || account.CPF__c == '33333333333' || account.CPF__c == '44444444444' || account.CPF__c == '55555555555' || account.CPF__c == '66666666666' || account.CPF__c == '77777777777' || account.CPF__c == '88888888888' || account.CPF__c == '99999999999'){
                    account.CPF__c.addError(msg);
                } else{
                    valor = BCL_HLP_String.formatCPF(account.CPF__c);
                }
            } else{
                account.CPF__c.addError(msg);
            }
        } else if(recordTypeName == 'FRETEIRO'){
            account.CNPJ_CPF__c = BCL_HLP_String.getNumberFromFormatedString(account.CNPJ_CPF__c);
            
            if(account.Tipo_de_pessoa__c.toUpperCase() == 'F-FÍSICA'){
                msg = 'Insira um CPF válido.';
                
                if(account.CNPJ_CPF__c.length() == 11){
                    if(account.CNPJ_CPF__c == '00000000000' || account.CNPJ_CPF__c == '11111111111' || account.CNPJ_CPF__c == '22222222222' || account.CNPJ_CPF__c == '33333333333' || account.CNPJ_CPF__c == '44444444444' || account.CNPJ_CPF__c == '55555555555' || account.CNPJ_CPF__c == '66666666666' || account.CNPJ_CPF__c == '77777777777' || account.CNPJ_CPF__c == '88888888888' || account.CNPJ_CPF__c == '99999999999'){
                        account.CNPJ_CPF__c.addError(msg);
                    } else{
                        valor = BCL_HLP_String.formatCPF(account.CNPJ_CPF__c);
                    }
                } else{
                    account.CNPJ_CPF__c.addError(msg);
                }
            } else if(account.Tipo_de_pessoa__c.toUpperCase() == 'J-JURÍDICA'){
                msg = 'Insira um CNPJ válido.';
                
                if(account.CNPJ_CPF__c.length() == 14){
                    valor = BCL_HLP_String.formatCNPJ(account.CNPJ_CPF__c);
                } else{
                    account.CNPJ_CPF__c.addError(msg);
                }
            }
        } else if(recordTypeName == 'CORP'){
            account.CNPJ__c = BCL_HLP_String.getNumberFromFormatedString(account.CNPJ__c);
            msg = 'Insira um CNPJ válido.';
            
            if(account.CNPJ__c.length() == 14){
                valor = BCL_HLP_String.formatCNPJ(account.CNPJ__c);
            } else{
                account.CNPJ__c.addError(msg);
            }
        }
        
        System.debug(valor);
        
        test.stopTest();
    }
    
    // [INSERT] 
    // Verifica se o CPF/CNPJ é válido e aplica a mascara.
    // @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
      
    static testMethod void applyMaskCpfCnpjInsertJuridicaFreteiro(){
        test.startTest();
        
        String recordTypeId = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByName().get('FRETEIRO').getRecordTypeId();
        String recordTypeName = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosById().get(recordTypeId).getName();
        
        String msg, valor;  
        
        //Criando a Conta
        //SIGGO
        Account acc = new Account();
        acc.Name = 'Nome Siggo Insert Ltda';
        acc.CPF__c = '240.302.331-04';
        acc.CNPJ__c = '35.658.338/0001-10';
        acc.CNPJ_CPF__c = '35.658.338/0001-10';
        acc.RecordTypeId = recordTypeId;
        acc.Tipo_de_pessoa__c = 'J-JURÍDICA';
        
        insert acc;
        
        //Recuperando informacoes da conta
        Account account = [SELECT Id, CNPJ__c, CNPJ_CPF__c, CPF__c, RecordTypeId, Tipo_de_pessoa__c FROM Account WHERE Id =:acc.Id];
                
        if(recordTypeName == 'SIGGO'){
            account.CPF__c = BCL_HLP_String.getNumberFromFormatedString(account.CPF__c);
            msg = 'Insira um CPF válido.';
                        
            if(account.CPF__c.length() == 11){
                if(account.CPF__c == '00000000000' || account.CPF__c == '11111111111' || account.CPF__c == '22222222222' || account.CPF__c == '33333333333' || account.CPF__c == '44444444444' || account.CPF__c == '55555555555' || account.CPF__c == '66666666666' || account.CPF__c == '77777777777' || account.CPF__c == '88888888888' || account.CPF__c == '99999999999'){
                    account.CPF__c.addError(msg);
                } else{
                    valor = BCL_HLP_String.formatCPF(account.CPF__c);
                }
            } else{
                account.CPF__c.addError(msg);
            }
        } else if(recordTypeName == 'FRETEIRO'){
            account.CNPJ_CPF__c = BCL_HLP_String.getNumberFromFormatedString(account.CNPJ_CPF__c);
            
            if(account.Tipo_de_pessoa__c.toUpperCase() == 'F-FÍSICA'){
                msg = 'Insira um CPF válido.';
                
                if(account.CNPJ_CPF__c.length() == 11){
                    if(account.CNPJ_CPF__c == '00000000000' || account.CNPJ_CPF__c == '11111111111' || account.CNPJ_CPF__c == '22222222222' || account.CNPJ_CPF__c == '33333333333' || account.CNPJ_CPF__c == '44444444444' || account.CNPJ_CPF__c == '55555555555' || account.CNPJ_CPF__c == '66666666666' || account.CNPJ_CPF__c == '77777777777' || account.CNPJ_CPF__c == '88888888888' || account.CNPJ_CPF__c == '99999999999'){
                        account.CNPJ_CPF__c.addError(msg);
                    } else{
                        valor = BCL_HLP_String.formatCPF(account.CNPJ_CPF__c);
                    }
                } else{
                    account.CNPJ_CPF__c.addError(msg);
                }
            } else if(account.Tipo_de_pessoa__c.toUpperCase() == 'J-JURÍDICA'){
                msg = 'Insira um CNPJ válido.';
                
                if(account.CNPJ_CPF__c.length() == 14){
                    valor = BCL_HLP_String.formatCNPJ(account.CNPJ_CPF__c);
                } else{
                    account.CNPJ_CPF__c.addError(msg);
                }
            }
        } else if(recordTypeName == 'CORP'){
            account.CNPJ__c = BCL_HLP_String.getNumberFromFormatedString(account.CNPJ__c);
            msg = 'Insira um CNPJ válido.';
            
            if(account.CNPJ__c.length() == 14){
                valor = BCL_HLP_String.formatCNPJ(account.CNPJ__c);
            } else{
                account.CNPJ__c.addError(msg);
            }
        }
        
        System.debug(valor);
        
        test.stopTest();
    }
    
    // [INSERT] 
    // Verifica se o CPF/CNPJ é válido e aplica a mascara.
    // @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
      
    static testMethod void applyMaskCpfCnpjInsertCorp(){
        test.startTest();
        
        String recordTypeId = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByName().get('CORP').getRecordTypeId();
        String recordTypeName = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosById().get(recordTypeId).getName();
        
        String msg, valor;  
        
        //Criando a Conta
        //SIGGO
        Account acc = new Account();
        acc.Name = 'Nome Siggo Insert Ltda';
        acc.CPF__c = '240.302.331-04';
        acc.CNPJ__c = '35.658.338/0001-10';
        acc.CNPJ_CPF__c = '35.658.338/0001-10';
        acc.RecordTypeId = recordTypeId;
        
        insert acc;
        
        //Recuperando informacoes da conta
        Account account = [SELECT Id, CNPJ__c, CNPJ_CPF__c, CPF__c, RecordTypeId FROM Account WHERE Id =:acc.Id];
                
        if(recordTypeName == 'SIGGO'){
            account.CPF__c = BCL_HLP_String.getNumberFromFormatedString(account.CPF__c);
            msg = 'Insira um CPF válido.';
                        
            if(account.CPF__c.length() == 11){
                if(account.CPF__c == '00000000000' || account.CPF__c == '11111111111' || account.CPF__c == '22222222222' || account.CPF__c == '33333333333' || account.CPF__c == '44444444444' || account.CPF__c == '55555555555' || account.CPF__c == '66666666666' || account.CPF__c == '77777777777' || account.CPF__c == '88888888888' || account.CPF__c == '99999999999'){
                    account.CPF__c.addError(msg);
                } else{
                    valor = BCL_HLP_String.formatCPF(account.CPF__c);
                }
            } else{
                account.CPF__c.addError(msg);
            }
        } else if(recordTypeName == 'FRETEIRO'){
            account.CNPJ_CPF__c = BCL_HLP_String.getNumberFromFormatedString(account.CNPJ_CPF__c);
            
            if(account.Tipo_de_pessoa__c.toUpperCase() == 'F-FÍSICA'){
                msg = 'Insira um CPF válido.';
                
                if(account.CNPJ_CPF__c.length() == 11){
                    if(account.CNPJ_CPF__c == '00000000000' || account.CNPJ_CPF__c == '11111111111' || account.CNPJ_CPF__c == '22222222222' || account.CNPJ_CPF__c == '33333333333' || account.CNPJ_CPF__c == '44444444444' || account.CNPJ_CPF__c == '55555555555' || account.CNPJ_CPF__c == '66666666666' || account.CNPJ_CPF__c == '77777777777' || account.CNPJ_CPF__c == '88888888888' || account.CNPJ_CPF__c == '99999999999'){
                        account.CNPJ_CPF__c.addError(msg);
                    } else{
                        valor = BCL_HLP_String.formatCPF(account.CNPJ_CPF__c);
                    }
                } else{
                    account.CNPJ_CPF__c.addError(msg);
                }
            } else if(account.Tipo_de_pessoa__c.toUpperCase() == 'J-JURÍDICA'){
                msg = 'Insira um CNPJ válido.';
                
                if(account.CNPJ_CPF__c.length() == 14){
                    valor = BCL_HLP_String.formatCNPJ(account.CNPJ_CPF__c);
                } else{
                    account.CNPJ_CPF__c.addError(msg);
                }
            }
        } else if(recordTypeName == 'CORP'){
            account.CNPJ__c = BCL_HLP_String.getNumberFromFormatedString(account.CNPJ__c);
            msg = 'Insira um CNPJ válido.';
            
            if(account.CNPJ__c.length() == 14){
                valor = BCL_HLP_String.formatCNPJ(account.CNPJ__c);
            } else{
                account.CNPJ__c.addError(msg);
            }
        }
        
        System.debug(valor);
        
        test.stopTest();
    } 
*/
}