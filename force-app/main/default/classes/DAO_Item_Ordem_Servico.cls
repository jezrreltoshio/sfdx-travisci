/*
	@testClass Teste_DAO_Item_Ordem_Servico
	
	@description DAO para o objeto: Item_ordem_servico__c
	
	@author Renan Rocha
	@date 18/12/2018
	@JIRA KCA-86
	---------------------------------
	@author Renan Rocha
	@date 20/12/2018
	@description:
		- Retirado condicional do WHERE do método getListaItemOSRecente para verificar se os campos da OS foram alterados, o que não faz sentido devido o histórico ser filho direto da OS
		- Adicionado condicional para buscar os históricos do dia com base no campo de controle SELECT_Batch__c
		- Verificação dos criados e alterados agora são feitos com base na última hora
	@JIRA KCA-381
*/

public class DAO_Item_Ordem_Servico{
	private static String CLASS_NAME = 'DAO_Item_Ordem_Servico';
	
	/*
		@description Retorna uma lista das alterações recentes de histórico das OSs
		@param 
		@return List<Item_ordem_servico__c>
		
		@author Renan Rocha
		@date 18/12/2018
		@JIRA KCA-86
	*/
	public static List<Item_ordem_servico__c> getListaItemOSRecente(){
		String METHOD_NAME = 'getListaItemOSRecente';
		
		return
			[SELECT Id
				  , Item_ordem_servico__c.Ordem_servico__c
			FROM Item_ordem_servico__c
			WHERE SELECT_Batch__c = false 
			AND ((CreatedDate = TODAY AND HOUR_IN_DAY(CreatedDate) > 1) 
				OR (LastModifiedDate = TODAY AND HOUR_IN_DAY(LastModifiedDate) > 1))];
	}	

	/*
		@description Retorna uma string com a lista das alterações recentes de histórico das OSs
		@param 
		@return String
		
		@author Renan Rocha
		@date 03/01/2019
		@JIRA KCA-381
	*/
	public static String getQueryItemOSRecente(){
		String METHOD_NAME = 'getQueryItemOSRecente';
		
		return
			'SELECT Id'+
				 ', Item_ordem_servico__c.Ordem_servico__c'+
			' FROM Item_ordem_servico__c'+
			' WHERE SELECT_Batch__c = false'+
			' AND ((CreatedDate = TODAY AND HOUR_IN_DAY(CreatedDate) > 1)'+
			' OR (LastModifiedDate = TODAY AND HOUR_IN_DAY(LastModifiedDate) > 1))';
	}
}