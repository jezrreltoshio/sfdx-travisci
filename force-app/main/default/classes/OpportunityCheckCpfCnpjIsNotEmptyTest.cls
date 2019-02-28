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
 * @sinze 03/09/2015
 */
@isTest
private class OpportunityCheckCpfCnpjIsNotEmptyTest{
	
    static testMethod void opportunityCheckCpfCnpjIsNotEmptyCorp(){
    	Date myDate = Date.newInstance(integer.valueOf('2015'), integer.valueOf('11'), integer.valueOf('05'));
    	
    	//Criando a conta
    	Account account = new Account();
    	account.Name = 'Conta Corp Ltda';
    	account.CNPJ_CPF__c = '778.718.844-84';
    	account.CNPJ__c = '58.527.056/0001-89';
    	
    	insert account;
    	
    	Account acc = [SELECT Id FROM Account WHERE Id =:account.Id];
    	
    	//Criando a oportunidade
    	Opportunity opportunity = new Opportunity();
    	opportunity.Name = 'Opp Corp Ltda';
    	opportunity.AccountId = acc.Id;
    	opportunity.StageName = 'Abordagem inicial';
    	opportunity.CloseDate = myDate;
    	opportunity.Taxa_de_ades_o__c = 'Não';
    	//opportunity.RecordTypeId = '01240000000UZVd'; //CORP
    	    	    	
    	insert opportunity;
    	
		//Recuperando os dados da oportunidade
    	Opportunity oppty = [SELECT Id, AccountId, StageName FROM Opportunity WHERE Id =:opportunity.Id];
		
		//Inicio do TESTE
		test.startTest();
		    	    	
    	//Recuperando o Record type name do objeto Oportunidade
		String recordTypeName =	'CORP';
		recordTypeName = recordTypeName.touppercase();
    	
    	//Fase
		String fase = oppty.StageName.touppercase();
		
		//Verifica se a Fase foi alterado pra Fechado
		if(fase == 'FECHADO' || fase == 'VENDA FECHADA'){
			//Verificando se existe uma conta vinculada na Oportunidade
			if(oppty.AccountId != null){
				if(recordTypeName != 'SIGGO' && recordTypeName != 'MICHELIN'){
					//Variaveis
					String msg, valor;
					Account accnt = [SELECT CNPJ_CPF__c, CNPJ__c FROM Account WHERE Id =:oppty.AccountId];
				
					if(recordTypeName == 'FRETEIRO'){
						msg = 'Por favor, preencha o CPF na CONTA.';
						valor = accnt.CNPJ_CPF__c;						
					} else{
						msg = 'Por favor, preencha o CNPJ na CONTA.';
						valor = accnt.CNPJ__c;
					}
					
					valor = null;		
					//Verificando se o campo CPF/CNPJ está vazio
					if(valor == null){
						oppty.AccountId.addError(msg);
					}
				}			
			}
		}
		
		test.stopTest(); 
    }
    
    static testMethod void opportunityCheckCpfCnpjIsNotEmptyFreteiro(){
    	Date myDate = Date.newInstance(integer.valueOf('2015'), integer.valueOf('11'), integer.valueOf('05'));
    	
    	//Criando a conta
    	Account account = new Account();
    	account.Name = 'Conta Freteiro Ltda';
    	account.CNPJ_CPF__c = '141.121.867-11';
    	account.CNPJ__c = '55.375.458/0001-17';
    	
    	insert account;
    	
    	Account acc = [SELECT Id FROM Account WHERE Id =:account.Id];
    	
    	//Criando a oportunidade
    	Opportunity opportunity = new Opportunity();
    	opportunity.Name = 'Opp Freteiro Ltda';
    	opportunity.AccountId = acc.Id;
    	opportunity.StageName = 'Abordagem inicial';
    	opportunity.CloseDate = myDate;
    	//opportunity.RecordTypeId = '01240000000UbS0'; //Freteiro
    	    	    	
    	insert opportunity;
    	
		//Recuperando os dados da oportunidade
    	Opportunity oppty = [SELECT Id, AccountId, StageName FROM Opportunity WHERE Id =:opportunity.Id];
    	
    	//Inicio do TESTE
    	test.startTest();
    	
    	//Recuperando o Record type name do objeto Oportunidade
		String recordTypeName =	'FRETEIRO';
		recordTypeName = recordTypeName.touppercase();
    	
    	//Fase
		String fase = oppty.StageName.touppercase();
		
		//Verifica se a Fase foi alterado pra Fechado
		if(fase == 'FECHADO' || fase == 'VENDA FECHADA'){
			//Verificando se existe uma conta vinculada na Oportunidade
			if(oppty.AccountId != null){
				if(recordTypeName != 'SIGGO' && recordTypeName != 'MICHELIN'){
					//Variaveis
					String msg, valor;
					Account accnt = [SELECT CNPJ_CPF__c, CNPJ__c FROM Account WHERE Id =:oppty.AccountId];
				
					if(recordTypeName == 'FRETEIRO'){
						msg = 'Por favor, preencha o CPF na CONTA.';
						valor = accnt.CNPJ_CPF__c;
					} else{
						msg = 'Por favor, preencha o CNPJ na CONTA.';
						valor = accnt.CNPJ__c;
					}
					
					valor = null;		
					//Verificando se o campo CPF/CNPJ está vazio
					if(valor == null){
						oppty.AccountId.addError(msg);
					}
				}			
			}
		}
		
		test.stopTest(); 
    }
}