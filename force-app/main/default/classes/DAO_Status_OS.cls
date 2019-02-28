/*
	@testClass Teste_DAO_Status_OS
	
	@description Classe para o Objeto: Status_OS__c
	
	@author Renan Rocha
	@date 07/01/2019
	@JIRA KCA-59
*/

public class DAO_Status_OS{
	private static String CLASS_NAME = 'DAO_Status_OS';
	
	// Método que retorna todos os Status de OS Ativos
    public static List<Status_OS__c> getListaStatusOS(){
        String METHOD_NAME = 'getListaStatusOS';

        return
            [SELECT Id
                  , Ativo__c
                  , Name
            FROM Status_OS__c 
            WHERE Ativo__c = true AND Pais_referencia__c = 'BRA'
            ORDER BY Name];
    } // Fim método getListaStatusOS
}