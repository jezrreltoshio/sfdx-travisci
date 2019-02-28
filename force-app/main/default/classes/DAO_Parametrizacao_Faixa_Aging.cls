/*
	@testClass Teste_DAO_Parametrizacao_Faixa_Aging

	@description DAO para o Objeto: Parametrizacao_faixa_aging__c

	@author Renan Rocha
	@date 03/12/2018
	@JIRA KCA-86
*/

public class DAO_Parametrizacao_Faixa_Aging{
	private static String CLASS_NAME = 'DAO_Parametrizacao_Faixa_Aging';

	/*
		@description Retorna todas as parametrizações cadastradas
		@return List<Parametrizacao_faixa_aging__c>
		
		@author Renan Rocha
		@date 03/12/2018
		@JIRA KCA-86
	*/
	public static List<Parametrizacao_faixa_aging__c> getListParametrizacaoFaixaAging(){
		String METHOD_NAME = 'getListParametrizacaoFaixaAging';
		
		return
			[SELECT Id
				  , Aging_ate__c
				  , Aging_de__c
				  , Contatos_dias_distintos__c
				  , Contatos_faixa__c
				  , Name
				  , Nome_faixa__c
				  , Quantidade_contatos__c
				  , Quantidade_minima_contatos_por_faixa__c
				  , Tipo_Macro_OS__c
				  , Tipo_Micro_OS__c
			FROM Parametrizacao_faixa_aging__c];
	}
}