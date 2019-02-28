/*
    Classe de testes para a classe "DAO_Direcionamento_OS"
    Criado por: Mario Reis
    Data: 12/06/2018
    Cobertura: 90%
*/

@isTest
public class Teste_DAO_Direcionamento_OS {
    
    /*
        @author Renan Rocha
        @date 07/01/2019
    */
    static testMethod void getDirecionamentoOsById(){
        Map<String, sObject> mapBase = Teste_Util.createMapBase();
        Direcionamento_os__c dirOS = (Direcionamento_os__c) mapBase.get('Direcionamento_os__c');

        System.assertEquals(dirOS.Id, DAO_Direcionamento_OS.getDirecionamentoOsById(dirOS.Id).Id);
    }

    /*
        @author Renan Rocha
        @date 07/01/2019
    */
    static testMethod void getListaDirecionamentoOS(){
        Map<String, sObject> mapBase = Teste_Util.createMapBase();

        System.assertEquals(1, DAO_Direcionamento_OS.getListaDirecionamentoOS().size());
    }

    /*
        @author Renan Rocha
        @date 07/01/2019
    */
    static testMethod void getQueryBatch(){
        System.assertNotEquals(null, DAO_Direcionamento_OS.getQueryBatch());
    }
}