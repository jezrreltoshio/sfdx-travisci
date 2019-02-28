/*
    Classe de testes para Classe controladora da página de Dados de veículos OS e Itens do contrato.
    Criado por: Juliano Szlachta
    Data: 26/06/2018

*/
public class Controller_Dados_Veiculo {
	/*
    @AuraEnabled
    public static Itens_contrato__c getItem(Id idItemContrato) {
        System.debug(LoggingLevel.ERROR, 'idItemContrato: '+idItemContrato);
        return [SELECT Id 
                        , Tipo_veiculo__c
                        , Modelo_veiculo__c
                        , Marca_veiculo__c
                        , Cor_veiculo__c
                        , Chassi_veiculo__c
                        , Frota_veiculo__c
                        , Placa__c
                        , Ano_veiculo__c
                        , Renavam__c
                        , Proprietario__c
                        , Ger_1__c
                        , Telefone_ger1__c
                        , Ger_2__c
                        , Telefone_ger2__c
                        , Ger_3__c
                        , Telefone_ger3__c
                        , Motivo_retirada__c
                        , Numero_serie__c
                        , Servico_basico__c
                        , Servico_basico_migracao__c
                        , Telefone_equipamento__c
                        , Status_linha__c
                        , Versao__c
                        , Modelo_versao__c
                        , Antena_satelital__c
                        , Status_fornecedor_antena_satelital__c
                        , Familia_produto__c
                        , Operadora__c
                FROM Itens_contrato__c 
                WHERE Id =: idItemContrato LIMIT 1];
    }
    */
    @AuraEnabled
    public static WorkOrder getOS(Id idOS) {
        System.debug(LoggingLevel.ERROR, 'idOS: '+idOS);
        return [SELECT Id 
                       /* , Numero_serie__c
                        , Codigo_produto__c
                        , Nome_produto__c
                        , NF__c
                        , Data_compra__c
                        , Numero_contrato__c
                        , StartDate
                        , Modalidade__c
                        , Inicio_vigencia__c
                        , Classe__c
                        , Marca__c
                        , Modelo__c
                        , Placa__c
                        , Cor__c
                        , Frota__c
                        , Ano__c
                        , Renavam__c
                        , Chassi__c*/
                FROM WorkOrder 
                WHERE Id =: idOS LIMIT 1];
    }

}