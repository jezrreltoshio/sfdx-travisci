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
private class VerificaDuplicidadeTest {

    static testMethod void myUnitTestSiggo() {
        //Recuperando o record type name do objeto Conta
	    String recordType = 'Siggo';
	    recordType = recordType.touppercase();
	    
	    Account acct = new Account();	    
	    acct.Name = 'Teste Siggo';
	    acct.Tipo_de_pessoa__c = 'F-Física';
	    acct.CPF__c = '143.759.017-99';
	    acct.RecordTypeId = '01240000000YbfrAAC'; //Siggo desenv
	    acct.Phone = '(41) 3299-6159';
	    acct.FormaCobranca__c = '1-Boleto Bancário';
	    acct.Enderecos_Principal_UF__c = 'PR';
	    acct.Enderecos_Entrega_UF__c = 'PR';
	    acct.Enderecos_Cobranca_UF__c = 'PR';
	    
	    insert acct;
	    
	    Account acct2 = new Account();
	    acct2.Name = 'Teste Siggo';
	    acct2.Tipo_de_pessoa__c = 'F-Física';
	    acct2.CPF__c = '143.759.017-99';
	    acct2.RecordTypeId = '01240000000YbfrAAC'; //Siggo desenv
	    acct2.Phone = '(41) 3299-6159';
	    acct2.FormaCobranca__c = '1-Boleto Bancário';
	    acct2.Enderecos_Principal_UF__c = 'PR';
	    acct2.Enderecos_Entrega_UF__c = 'PR';
	    acct2.Enderecos_Cobranca_UF__c = 'PR';
	    
	    List<Account> TriggerAcc = new List<Account>();
	    TriggerAcc.add(acct2);
	    
	    List<Account> acc = new List<Account>();
	    
	    if(recordType == 'CORP' && TriggerAcc.get(0).CNPJ__c != null){
			//CNPJ__c
			acc = [SELECT
							Id, Name
						FROM
							Account
						WHERE
							CNPJ__c =:TriggerAcc.get(0).CNPJ__c
						AND
							RecordTypeId =:TriggerAcc.get(0).RecordTypeId
						limit 1];
			
			system.debug('VerificaDuplicidade on Account - CORP - acc: '+acc);
			
			if(acc.size() > 0){
				acct2.addError('Duplicidade - Já existe uma conta CORP com o CNPJ informado. Utilize a Conta existente: '+acc[0].Name);
			}
		} else if(recordType == 'FRETEIRO' && TriggerAcc.get(0).CNPJ_CPF__c != null){
			//CNPJ_CPF__c
			acc = [SELECT
							Id, Name
						FROM
							Account
						WHERE
							CNPJ_CPF__c =:TriggerAcc.get(0).CNPJ_CPF__c
						AND
							RecordTypeId =:TriggerAcc.get(0).RecordTypeId
						limit 1];
						
			system.debug('VerificaDuplicidade on Account - FRETEIRO - acc: '+acc);
			
			if(acc.size() > 0){
				acct2.addError('Duplicidade - Já existe uma conta FRETEIRO com o CPF informado. Utilize a Conta existente: '+acc[0].Name);
			}
		} else if(recordType == 'SIGGO' && TriggerAcc.get(0).CPF__c != null){
			//CPF__c
			acc = [SELECT
							Id, Name
						FROM
							Account
						WHERE
							CPF__c =: TriggerAcc.get(0).CPF__c
						AND
							RecordTypeId =:TriggerAcc.get(0).RecordTypeId
						limit 1];
			
			system.debug('VerificaDuplicidade on Account - SIGGO - acc: '+acc);
			
			if(acc.size() > 0){
				acct2.addError('Duplicidade - Já existe uma conta SIGGO com o CPF informado. Utilize a Conta existente: '+acc[0].Name);
			}
		}
        
    }
    
    static testMethod void myUnitTestFreteiro() {
        //Recuperando o record type name do objeto Conta
	    String recordType = 'Freteiro';
	    recordType = recordType.touppercase();
	    
	    Account acct = new Account();	    
	    acct.Name = 'Teste Freteiro';
	    acct.Tipo_de_pessoa__c = 'F-Física';
	    acct.CNPJ_CPF__c = '584.464.342-96';
	    acct.RecordTypeId = '01240000000YbfqAAC'; //Freteiro desenv
	    acct.Phone = '(41) 3299-6159';
	    acct.FormaCobranca__c = '1-Boleto Bancário';
	    acct.Enderecos_Principal_UF__c = 'PR';
	    acct.Enderecos_Entrega_UF__c = 'PR';
	    acct.Enderecos_Cobranca_UF__c = 'PR';
	    
	    insert acct;
	    
	    Account acct2 = new Account();
	    acct2.Name = 'Teste Siggo';
	    acct2.Tipo_de_pessoa__c = 'F-Física';
	    acct2.CNPJ_CPF__c = '584.464.342-96';
	    acct2.RecordTypeId = '01240000000YbfrAAC'; //Freteiro desenv
	    acct2.Phone = '(41) 3299-6159';
	    acct2.FormaCobranca__c = '1-Boleto Bancário';
	    acct2.Enderecos_Principal_UF__c = 'PR';
	    acct2.Enderecos_Entrega_UF__c = 'PR';
	    acct2.Enderecos_Cobranca_UF__c = 'PR';
	    
	    List<Account> TriggerAcc = new List<Account>();
	    TriggerAcc.add(acct2);
	    
	    List<Account> acc = new List<Account>();
	    
	    if(recordType == 'CORP' && TriggerAcc.get(0).CNPJ__c != null){
			//CNPJ__c
			acc = [SELECT
							Id, Name
						FROM
							Account
						WHERE
							CNPJ__c =:TriggerAcc.get(0).CNPJ__c
						AND
							RecordTypeId =:TriggerAcc.get(0).RecordTypeId
						limit 1];
			
			system.debug('VerificaDuplicidade on Account - CORP - acc: '+acc);
			
			if(acc.size() > 0){
				acct2.addError('Duplicidade - Já existe uma conta CORP com o CNPJ informado. Utilize a Conta existente: '+acc[0].Name);
			}
		} else if(recordType == 'FRETEIRO' && TriggerAcc.get(0).CNPJ_CPF__c != null){
			//CNPJ_CPF__c
			acc = [SELECT
							Id, Name
						FROM
							Account
						WHERE
							CNPJ_CPF__c =:TriggerAcc.get(0).CNPJ_CPF__c
						AND
							RecordTypeId =:TriggerAcc.get(0).RecordTypeId
						limit 1];
						
			system.debug('VerificaDuplicidade on Account - FRETEIRO - acc: '+acc);
			
			if(acc.size() > 0){
				acct2.addError('Duplicidade - Já existe uma conta FRETEIRO com o CPF informado. Utilize a Conta existente: '+acc[0].Name);
			}
		} else if(recordType == 'SIGGO' && TriggerAcc.get(0).CPF__c != null){
			//CPF__c
			acc = [SELECT
							Id, Name
						FROM
							Account
						WHERE
							CPF__c =: TriggerAcc.get(0).CPF__c
						AND
							RecordTypeId =:TriggerAcc.get(0).RecordTypeId
						limit 1];
			
			system.debug('VerificaDuplicidade on Account - SIGGO - acc: '+acc);
			
			if(acc.size() > 0){
				acct2.addError('Duplicidade - Já existe uma conta SIGGO com o CPF informado. Utilize a Conta existente: '+acc[0].Name);
			}
		}
        
    }
}