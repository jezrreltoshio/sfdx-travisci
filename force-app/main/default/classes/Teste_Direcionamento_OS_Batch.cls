/*
    @testClass Direcionamento_OS_Batch
    
    @author Renan Rocha
    @date 07/01/2019
*/

@isTest
public class Teste_Direcionamento_OS_Batch{
    
    /*
        @author Renan Rocha
        @date 07/01/2019
    */
    static testMethod void teste(){
        Map<String, sObject> mapBase = Teste_Util.createMapBase();

        Database.executeBatch(new Direcionamento_OS_Batch(null), 1);
    }
}