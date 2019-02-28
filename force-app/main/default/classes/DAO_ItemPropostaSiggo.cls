/*
	@testClass Teste_DAO_ItemPropostaSiggo
	
	@description DAO para o objeto:
	
	@author Renan Rocha
	@date 12/12/2018
	@JIRA KCA-10
*/

public class DAO_ItemPropostaSiggo{
	private static String CLASS_NAME = 'DAO_ItemPropostaSiggo';
	
	/*
		@description Retorna um Item de proposta siggo conforme o id da oportunidade
		@param String pOppId
		@return List<ItemPropostaSiggo__c>
		
		@author Renan Rocha
		@date 12/12/2018
		@JIRA KCA-10
	*/
	public static List<ItemPropostaSiggo__c> getItemPropostaByOppId(String pOppId){
		String METHOD_NAME = 'getItemPropostaByOppId';
		
		return
			[SELECT Id
				  , AnalPrel_CodigoRetorno__c
				  , AnalPrel_MensagemRetorno__c
				  , AnalPrel_NumeroOrcamento__c
				  , AnalPrel_ValorPremio__c
			FROM ItemPropostaSiggo__c
			WHERE Oportunidade__c =: pOppId];	
	}

	/*
		@description Retorna um Item de proposta siggo conforme o id da oportunidade
		@param String pOppId, Boolean pNull
		@return List<ItemPropostaSiggo__c>
		
		@author Renan Rocha
		@date 12/12/2018
		@JIRA KCA-10
	*/
	public static List<ItemPropostaSiggo__c> getItemPropostaByOppId(String pOppId, Boolean pNull){
		String METHOD_NAME = 'getItemPropostaByOppId';
		
		return
			[SELECT Id
				  , AnalPrel_CodigoRetorno__c
				  , AnalPrel_MensagemRetorno__c
				  , AnalPrel_NumeroOrcamento__c
				  , AnalPrel_ValorPremio__c
				  , NumeroContrato__c
				  , StatusContrato__c
			FROM ItemPropostaSiggo__c
			WHERE Oportunidade__c =: pOppId
			ORDER BY Ordenador__c ASC NULLS FIRST];	
	}
}