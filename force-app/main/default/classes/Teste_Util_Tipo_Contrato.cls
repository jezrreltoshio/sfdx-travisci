/*
    Classe de testes para cadastro do objeto Tipo de Contrato
    Criado por: Mario Reis
    Data: 12/06/2018
*/
@isTest
public class Teste_Util_Tipo_Contrato {

    //Método para criar Status Concluido Finalizado
    public static TipoContrato__c criarTipoContratoPadrao(){

        TipoContrato__c tipoContrato = new TipoContrato__c();
        tipoContrato.Name = 'Contrato Padrao';
        tipoContrato.Codigo_Externo__c = '1';
        tipoContrato.Ativo__c = true;
        tipoContrato.Pais_Referencia__c = 'BRA';

		insert tipoContrato;
        return tipoContrato;
    }// Fim criarTipoOSInstalacao

}