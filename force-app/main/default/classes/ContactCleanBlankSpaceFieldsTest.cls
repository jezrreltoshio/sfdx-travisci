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
private class ContactCleanBlankSpaceFieldsTest {

    /**
 	 * [MANTIS 7650] - ERRO AO SINCRONIZAR CONTA
 	 * Remove os espaços em brancos dos campos, pois ao enviar com o espaço em branco, o WS_Salesforce
 	 * retorna o seguinte erro: [-1400] String is not in UTF-8. Trigger executada before insert, before update.
 	 * @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
 	 * @sinze 07/10/2015
 	 */
	static testMethod void cleanBlankSpaceFieldsInsert(){
		test.startTest();
		
		Contact contact = new Contact();
		contact.FirstName = ' Bruno ';
		contact.LastName = ' Affonso ';		
		contact.Title = ' Sei lá ';
		contact.Tipo_de_registro_Lead__c = ' Siggo ';
		contact.RG__c = ' 459016441 ';
		contact.CPF__c = ' 053.270.387-18 ';
		contact.Phone = '  (41) 3299-6159';
		contact.HomePhone = ' (41) 3299-6159';
		contact.MobilePhone = ' (41) 3299-6159 ';		
		contact.AssistantPhone = ' (41) 3299-6159 ';
		contact.Email = ' bruno@bruno.test ';
		contact.Telefone_2__c = '(41) 3299-6159 ';
		contact.Telefone_3__c = ' (41) 3299-6159 ';
		contact.Telefone_4__c = ' (41) 3299-6159 ';
		contact.Description = ' Teste ';
						
		try{
			//Aplicando .trim() para remover espaços em branco
			//no início e final do texto
			if(contact.FirstName != null) contact.FirstName = contact.FirstName.trim();
			if(contact.LastName != null) contact.LastName = contact.LastName.trim();
			if(contact.Title != null) contact.Title = contact.Title.trim();
			if(contact.Tipo_de_registro_Lead__c != null) contact.Tipo_de_registro_Lead__c = contact.Tipo_de_registro_Lead__c.trim();
			if(contact.RG__c != null) contact.RG__c = contact.RG__c.trim();
			if(contact.CPF__c != null) contact.CPF__c = contact.CPF__c.trim();
			if(contact.Phone != null) contact.Phone = contact.Phone.trim();			
			if(contact.HomePhone != null) contact.HomePhone = contact.HomePhone.trim();
			if(contact.MobilePhone != null) contact.MobilePhone = contact.MobilePhone.trim();
			if(contact.AssistantPhone != null) contact.AssistantPhone = contact.AssistantPhone.trim();
			if(contact.Email != null) contact.Email = contact.Email.trim();
			if(contact.Telefone_2__c != null) contact.Telefone_2__c = contact.Telefone_2__c.trim();
			if(contact.Telefone_3__c != null) contact.Telefone_3__c = contact.Telefone_3__c.trim();
			if(contact.Telefone_4__c != null) contact.Telefone_4__c = contact.Telefone_4__c.trim();
			if(contact.Description != null) contact.Description = contact.Description.trim();
			
			insert contact;
																						
		} catch(System.NullPointerException e){
			System.debug('Contact - NullPointerException: '+ e);
		}
		
		test.stopTest();
    }
    
    /**
 	 * [MANTIS 7650] - ERRO AO SINCRONIZAR CONTA
 	 * Remove os espaços em brancos dos campos, pois ao enviar com o espaço em branco, o WS_Salesforce
 	 * retorna o seguinte erro: [-1400] String is not in UTF-8. Trigger executada before insert, before update.
 	 * @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
 	 * @sinze 07/10/2015
 	 */
	static testMethod void cleanBlankSpaceFieldsUpdate(){
		test.startTest();
		
		Contact contact = new Contact();
		contact.FirstName = ' Bruno ';
		contact.LastName = ' Affonso ';		
		contact.Title = ' Sei lá ';
		contact.Tipo_de_registro_Lead__c = ' Siggo ';
		contact.RG__c = ' 459016441 ';
		contact.CPF__c = ' 053.270.387-18 ';
		contact.Phone = '  (41) 3299-6159';
		contact.HomePhone = ' (41) 3299-6159';
		contact.MobilePhone = ' (41) 3299-6159 ';		
		contact.AssistantPhone = ' (41) 3299-6159 ';
		contact.Email = ' bruno@bruno.test ';
		contact.Telefone_2__c = '(41) 3299-6159 ';
		contact.Telefone_3__c = ' (41) 3299-6159 ';
		contact.Telefone_4__c = ' (41) 3299-6159 ';
		contact.Description = ' Teste ';
		
		insert contact;
		
		Contact contact2 = contact;
		contact2.FirstName = ' Bruno ';
		contact2.LastName = ' Affonso2 ';		
		contact2.Title = ' Sei lá ';
		contact2.Tipo_de_registro_Lead__c = ' Siggo ';
		contact2.RG__c = ' 459016441 ';
		contact2.CPF__c = ' 053.270.387-18 ';
		contact2.Phone = '  (41) 3299-6159';
		contact2.HomePhone = ' (41) 3299-6159';
		contact2.MobilePhone = ' (41) 3299-6159 ';		
		contact2.AssistantPhone = ' (41) 3299-6159 ';
		contact2.Email = ' bruno2@bruno.test ';
		contact2.Telefone_2__c = '(41) 3299-6159 ';
		contact2.Telefone_3__c = ' (41) 3299-6159 ';
		contact2.Telefone_4__c = ' (41) 3299-6159 ';
		contact2.Description = ' Teste ';
						
		try{
			//Aplicando .trim() para remover espaços em branco
			//no início e final do texto
			if(contact2.FirstName != null) contact2.FirstName = contact2.FirstName.trim();
			if(contact2.LastName != null) contact2.LastName = contact2.LastName.trim();
			if(contact2.Title != null) contact2.Title = contact2.Title.trim();
			if(contact2.Tipo_de_registro_Lead__c != null) contact2.Tipo_de_registro_Lead__c = contact2.Tipo_de_registro_Lead__c.trim();
			if(contact2.RG__c != null) contact2.RG__c = contact2.RG__c.trim();
			if(contact2.CPF__c != null) contact2.CPF__c = contact2.CPF__c.trim();
			if(contact2.Phone != null) contact2.Phone = contact2.Phone.trim();			
			if(contact2.HomePhone != null) contact2.HomePhone = contact2.HomePhone.trim();
			if(contact2.MobilePhone != null) contact2.MobilePhone = contact2.MobilePhone.trim();
			if(contact2.AssistantPhone != null) contact2.AssistantPhone = contact2.AssistantPhone.trim();
			if(contact2.Email != null) contact2.Email = contact2.Email.trim();
			if(contact2.Telefone_2__c != null) contact2.Telefone_2__c = contact2.Telefone_2__c.trim();
			if(contact2.Telefone_3__c != null) contact2.Telefone_3__c = contact2.Telefone_3__c.trim();
			if(contact2.Telefone_4__c != null) contact2.Telefone_4__c = contact2.Telefone_4__c.trim();
			if(contact2.Description != null) contact2.Description = contact2.Description.trim();
			
			update contact2;
																						
		} catch(System.NullPointerException e){
			System.debug('Contact - NullPointerException: '+ e);
		}
		
		test.stopTest();
    }
}