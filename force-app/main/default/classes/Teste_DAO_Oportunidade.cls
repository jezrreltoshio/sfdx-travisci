/*
    @testClass DAO_Oportunidade

    @author Renan Rocha
    @date 19/11/2018
*/

@isTest
public class Teste_DAO_Oportunidade{

    /*
        @author Renan Rocha
        @date 06/12/2018
    */
    static testMethod void getOportunidadePorFamiliaId(){
        Map<String, sObject> mapBase = Teste_Util.createMapBase();
        Opportunity oportunidade = (Opportunity) mapBase.get('Opportunity');

        System.assertEquals(oportunidade.Id, DAO_Oportunidade.getOportunidadePorFamiliaId(oportunidade.Id, null).Id);
    }

    /*
        @author Renan Rocha
        @date 06/12/2018
    */
    static testMethod void getOportunidadesByOwnerIdEStageName(){
        Map<String, sObject> mapBase = Teste_Util.createMapBase();
        Opportunity oportunidade = (Opportunity) mapBase.get('Opportunity');
        oportunidade.CloseDate = System.today().addDays(-1);
        update oportunidade;

        System.assertEquals(1, DAO_Oportunidade.getOportunidadesByOwnerIdEStageName(oportunidade.OwnerId, new Set<String>{'Teste'}).size());
    }

    /*
        @author Renan Rocha
        @date 06/12/2018
    */
    static testMethod void getOportunidadesBySetId(){
        Map<String, sObject> mapBase = Teste_Util.createMapBase();
        Opportunity oportunidade = (Opportunity) mapBase.get('Opportunity');

        System.assertEquals(1, DAO_Oportunidade.getOportunidadesBySetId(new Set<Id>{oportunidade.Id}).size());
    }

	/*
		@author Renan Rocha
		@date 12/12/2018
	*/
	static testMethod void getOppById(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		Opportunity oportunidade = (Opportunity) mapBase.get('Opportunity');

		System.assertEquals(oportunidade.Id, DAO_Oportunidade.getOppById(oportunidade.Id).Id);
	}
}