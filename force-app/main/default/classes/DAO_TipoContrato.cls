/*
	@testClass Teste_DAO_TipoContrato
	
	@description Classe para o Objeto: TipoContrato__c
	
	@author Renan Rocha
	@date 07/01/2019
	@JIRA KCA-59
*/

public class DAO_TipoContrato{
	private static String CLASS_NAME = 'DAO_TipoContrato';
	
	// Método que retorna todos os Tipos de contrato
    public static List<TipoContrato__c> getListaTipoContrato(){
        String METHOD_NAME = 'getListaTipoContrato';

        return
            [SELECT Id
                  , Ativo__c
                  , Name
            FROM TipoContrato__c 
            WHERE Ativo__c = true 
            AND Pais_referencia__c = 'BRA'
            ORDER BY Name];
    } // Fim método getListaTipoContrato
}