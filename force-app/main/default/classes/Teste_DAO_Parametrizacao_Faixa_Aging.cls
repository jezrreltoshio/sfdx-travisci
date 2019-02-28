/*
	@testClass DAO_Parametrizacao_Faixa_Aging

	@author Renan Rocha
	@date 03/12/2018
*/

@isTest
public class Teste_DAO_Parametrizacao_Faixa_Aging{

	/*
		@author Renan Rocha
		@date 04/12/2018
	*/
	static testMethod void getListParametrizacaoFaixaAging(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();

		Parametrizacao_faixa_aging__c paramAg = (Parametrizacao_faixa_aging__c) mapBase.get('Parametrizacao_faixa_aging__c');

		System.assertEquals(1, DAO_Parametrizacao_Faixa_Aging.getListParametrizacaoFaixaAging().size());
	}
}