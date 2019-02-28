/*
	@testClass DAO_Historico_Lead

	@author Renan Rocha
	@date 19/11/2018
*/

@isTest
public class Teste_DAO_Historico_Lead{

	/*
		@author Renan Rocha
		@date 06/12/2018
	*/
	static testMethod void getHistoricoBySetIdLead(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		Lead lead = (Lead) mapBase.get('Lead');

		System.assertEquals(1, DAO_Historico_Lead.getHistoricoBySetIdLead(new Set<String>{lead.Id}).size());
	}
}