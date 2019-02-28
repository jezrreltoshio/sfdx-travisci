/*
	@testClass Teste_DAO_ProcessInstance

	@description DAO para o objeto: ProcessInstance

	@author Renan Rocha
	@date 20/11/2018
	@JIRA KCA-9
*/

public class DAO_ProcessInstance{

	private static String CLASS_NAME = 'DAO_ProcessInstance';
	
	/*
		@description Retorna uma lista conforme os ids informados
		@param List<Id> pListaPI
		@return List<ProcessInstance>
		
		@author Renan Rocha
	*/
	public static List<ProcessInstance> getProcessInstancesByListId(List<Id> pListaPI){
		String METHOD_NAME = 'getProcessInstancesByListId';
	
		return
			[SELECT TargetObjectId
			      , (SELECT Id
			      	      , StepStatus
			      	      , Comments 
	      	        FROM Steps 
	      	        ORDER BY CreatedDate DESC 
	      	        LIMIT 1)
         	FROM ProcessInstance
        	WHERE Id IN: pListaPI
         	ORDER BY CreatedDate DESC];
	}
}