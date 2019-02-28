/*
	@testClass Teste_DAO_Tipo_Registro

	@description DAO para o objeto: RecordType

	@author Renan Rocha
	@date 20/11/2018
	@JIRA KCA-9
*/

public class DAO_Tipo_Registro{

	private static String CLASS_NAME = 'DAO_Tipo_Registro';
	
	/*
		@description Retorna uma lista de Tipos de registro conforme o set de Id
		@param Set<Id> pSetId
		@return List<RecordType>
		
		@author Renan Rocha
		@date 20/11/2018
	*/
	public static List<RecordType> getTiposRegistroBySetId(Set<Id> pSetId){
		String METHOD_NAME = 'getTiposRegistroBySetId';
	
		return
			[SELECT Id
				  , DeveloperName 
				  , Name
			FROM RecordType 
			WHERE Id IN: pSetId];
	}
}