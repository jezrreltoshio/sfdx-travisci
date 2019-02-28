/*
	@testClass DAO_ProcessInstance

	@author Renan Rocha
	@date 20/11/2018
*/

@isTest
public class Teste_DAO_ProcessInstance{

	/*
		@author Renan Rocha
		@date 06/12/2018
	*/
	static testMethod void getProcessInstancesByListId(){
		try {
		    List<ProcessInstance> processo = DAO_ProcessInstance.getProcessInstancesByListId(new List<Id>{null});
		} catch (Exception e) {
			
		}
	}
}