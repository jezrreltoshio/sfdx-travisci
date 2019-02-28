public class ContactCleanBlankSpaceFields {
	/**
 	 * [MANTIS 7650] - ERRO AO SINCRONIZAR CONTA
 	 * Remove os espaços em brancos dos campos, pois ao enviar com o espaço em branco, o WS_Salesforce
 	 * retorna o seguinte erro: [-1400] String is not in UTF-8. Trigger executada before insert, before update.
 	 * @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
 	 * @sinze 07/10/2015
 	 */
	public static void cleanBlankSpaceFields(Contact contact){
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
																						
		} catch(System.NullPointerException e){
			System.debug('Contact - NullPointerException: '+ e);
		}
    }
}