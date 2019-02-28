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
 * [STI 85960] - [PRJ - SALESFORCE] - DESBUROCRATIZAÇÃO DA OPORTUNIDADE
 * @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
 * @sinze 30/10/2015
 *
 */
@isTest
private class ModifyApprovalProcessTest {

    static testMethod void unlockOpportunity() {
    	Boolean result = false;
		String status, oppId;
		Date myDate = Date.newInstance(integer.valueOf('2015'), integer.valueOf('11'), integer.valueOf('05'));
		
		system.debug('myDate: ' + myDate);
		
		//Criando a conta
    	Account account = new Account();
    	account.Name = 'Conta Corp Ltda';
    	account.CNPJ__c = '58.527.056/0001-89';
    	
    	insert account;
    	
    	Account acc = [SELECT Id FROM Account WHERE Id =:account.Id];
    	
    	system.debug('acc: ' + acc.Id);
				
		Opportunity opportunity = new Opportunity();
    	opportunity.Name = 'Opp Corp Ltda';
    	opportunity.AccountId = acc.Id;
    	opportunity.StageName = 'Abordagem Inicial';
    	opportunity.CloseDate = myDate;
    	opportunity.Taxa_de_ades_o__c = 'Sim';
  		opportunity.Valor_da_taxa_de_ades_o__c = 100;
    	
    	insert opportunity;
    	
    	List<Opportunity> oppntId = [SELECT Id FROM Opportunity WHERE Id=:opportunity.Id];
    	oppId = oppntId[0].Id;
    	
    	system.debug('oppId: ' + oppId);
				
		//Recuperando os dados do processo de aprovação atual.
		//List<ProcessInstance> PI = [SELECT Id, TargetObjectId, Status FROM ProcessInstance WHERE TargetObjectId =:oppId order by CreatedDate desc limit 1];		
 		//status = PI[0].Status;
 		
 		String status2 = 'Approved';
 		status = status2;
 		
 		system.debug('status: ' + status);
 		
 		//Verifica de existe alguma solicitação APROVADA.
 		if(status == 'Approved'){
 			//The new Approval.UnlockResult class contains methods that show
			//the results of record unlocks by System.Approval.unlock() methods.
			//A Boolean value that is set to true if the unlock operation is successful
			//for this object, or false otherwise.
			result = System.Approval.unlock(oppId).isSuccess();
			
			system.debug('result: ' + result);
					
			if(result){
				system.debug('entrou no result: ' + result);
				//Reiniciando a aprovacao manual.
				Opportunity opp = [SELECT Id, Aprova_o__c FROM Opportunity WHERE Id =:oppId];
				opp.Aprova_o__c = null;
				update opp;
			}
 		}
		
		system.debug(result);
    }
}