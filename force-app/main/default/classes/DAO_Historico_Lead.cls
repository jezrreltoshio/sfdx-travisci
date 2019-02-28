/*
	@testClass Teste_DAO_Historico_Lead

	@description DAO para o objeto:

	@author Renan Rocha
	@date 19/11/2018
	@JIRA KCA-9
*/

public class DAO_Historico_Lead{

	private static String CLASS_NAME = 'DAO_Historico_Lead';
	
	/*
		@description 
		@param List<Id> pListaLeadId
		@return List<Historico_Lead__c>
		
		@author Renan Rocha
		@date 19/11/2018
	*/
	public static List<Historico_Lead__c> getHistoricoBySetIdLead(Set<String> pSetLeadId){
		String METHOD_NAME = 'getHistoricoByListaLead';
	
		return
			[SELECT Id
			      , Data_da_Alteracao__c
			      , Descricao__c
			      , Lead__c
			      , Name
			      , Usuario__c
         	FROM Historico_Lead__c
			WHERE Lead__c IN: pSetLeadId];
	}
}