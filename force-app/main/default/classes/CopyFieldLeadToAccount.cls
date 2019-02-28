/**
 * [STI 85892] - Novos campos objeto LEADs e CONTA.
 * @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
 * @sinze 20/08/2015
 */
public class CopyFieldLeadToAccount {
	
	/**
	 * Copia os dados atualizados do Lead para a Conta.
	 */
	public static void copyFieldLeadToAccount(Lead oldLead, Lead newLead){
		//Verificando se o Lead está convertido
	    if(oldLead.isConverted == false && newLead.isConverted == true){
	        // Verifica se o ID da conta existe, conta existente.
	        if(newLead.ConvertedAccountId != null){
	        	//Recupera informações da Conta.
	            Account accnt = [Select accnt.Possui_Escolta_Armada__c, accnt.agregado__c, accnt.Qual_empresa_esta_agregando__c
	                                From Account accnt
	                                    Where accnt.Id = :newLead.ConvertedAccountId];
	                                    
	            //Recupera informações do Lead                                    
	            Lead lead = [Select lead.state, lead.Possui_Escolta_Armada__c, lead.agregado__c, lead.Qual_empresa_esta_agregando__c
	                            From Lead lead
	                                Where lead.Id = :newLead.Id];
                
                System.debug('Preenchendo campos na conversão. lead: '+lead);
	                                
	            //Atualizando os dados da Conta
	        	accnt.Possui_Escolta_Armada__c = lead.Possui_Escolta_Armada__c;
	            accnt.agregado__c = lead.agregado__c;
	            accnt.Qual_empresa_esta_agregando__c = lead.Qual_empresa_esta_agregando__c;
                accnt.Enderecos_Principal_UF__c = lead.state;
	            update accnt;
	        }
	    }
	}
}