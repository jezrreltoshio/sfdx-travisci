/*
    Classe de testes para cadastro do objeto Tipo OS
    Criado por: Mario Reis
    Data: 12/06/2018
*/
@isTest
public class Teste_Util_Tipo_OS {


    //Método para criar Tipo de OS Autorizado
    public static Tipo_OS__c criarTipoOSAutorizado(){

        Tipo_OS__c tipoOS = new Tipo_OS__c();
        tipoOS.Name = 'INSTALAÇÃO';
        tipoOS.Codigo_Externo__c = '1';
        tipoOS.Ativo__c = true;
        tipoOS.Pais_Referencia__c = 'BRA';

        insert tipoOS;
        return tipoOS;
    }// Fim criarTipoOSAutorizado

}