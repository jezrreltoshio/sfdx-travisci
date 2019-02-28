/*
    Classe de testes para cadastro do objeto Status OS
    Criado por: Mario Reis
    Data: 12/06/2018
*/
@isTest
public class Teste_Util_Status_OS {


    //Método para criar Status Autorizado Pendente
    public static Status_OS__c criarStatusAutorizadoPendente(){

        Status_OS__c statusOS = new Status_OS__c();
        statusOS.Name = 'Autorizado';
        statusOS.Codigo_Externo__c = '4';
        statusOS.Ativo__c = true;
        statusOS.Pais_Referencia__c = 'BRA';
        statusOS.Tipo__c = 'Pendente';

        insert statusOS;
        return statusOS;
    }// Fim criarStatusAutorizadoPendente


    //Método para criar Status Concluido Finalizado
    public static Status_OS__c criarStatusConcluidoFinalizado(){

        Status_OS__c statusOS = new Status_OS__c();
        statusOS.Name = 'Concluído';
        statusOS.Codigo_Externo__c = '3';
        statusOS.Ativo__c = true;
        statusOS.Pais_Referencia__c = 'BRA';
        statusOS.Tipo__c = 'Finalizado';

        insert statusOS;
        return statusOS;
    }// Fim criarStatusConcluidoFinalizado


}