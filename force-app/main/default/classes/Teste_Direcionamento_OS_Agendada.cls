/*
	@testClass Direcionamento_OS_Agendada
	
	@author Renan Rocha
	@date 07/01/2019
*/

@isTest
public class Teste_Direcionamento_OS_Agendada{
	
	/*
		@author Renan Rocha
		@date 07/01/2019
	*/
	static testMethod void execute(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();

		String hour = String.valueOf(Datetime.now().hour());
        String min = String.valueOf(Datetime.now().minute() + 1); 
        String ss = String.valueOf(Datetime.now().second());

        //parse to cron expression
        String nextFireTime = ss + ' ' + min + ' ' + hour + ' * * ?';

        Direcionamento_OS_Agendada s = new Direcionamento_OS_Agendada(); 
        System.schedule('Job Direcionamento_OS_Agendada ' + String.valueOf(Datetime.now()), nextFireTime, s);
	}
}