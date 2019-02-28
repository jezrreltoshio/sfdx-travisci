/*
    Classe de testes para cadastro do objeto Historico da OS
    Criado por: Mario Reis
    Data: 27/06/2018
*/
@isTest
public class Teste_Util_Historico_OS {


    //Método para criar HistoricoEfetivo
    public static Historico_OS__c criarHistoricoEfetivo(String idOS){

        Acao_historico_OS__c acao = new Acao_historico_OS__c();
        acao.Name = 'Ordem de serviço cancelada';
        acao.Categoria_contato__c = 'Não efetivo';
        acao.Codigo_externo__c = '123456';
        acao.Pais_referencia__c = 'BRA';
        insert acao;

       	Historico_OS__c ho = new Historico_OS__c();
        ho.Codigo_externo__c = '1';
        ho.Data_agenda__c = System.now();
        ho.Data__c = System.now();
        ho.Observacao__c = 'Observação';
        ho.Ordem_servico__c = idOS;
        ho.Status__c = acao.Id;
        insert ho;
        return ho;

    }// Fim criarHistoricoEfetivo


    //Método para criar HistoricoEfetivo
    public static Historico_OS__c criarHistoricoSemAcao(String idOS){

       	Historico_OS__c ho = new Historico_OS__c();
        ho.Codigo_externo__c = '1';
        ho.Data_agenda__c = System.now();
        ho.Observacao__c = 'Ordem de serviço cancelada';
        ho.Ordem_servico__c = idOS;
        insert ho;
        return ho;

    }// Fim criarHistoricoEfetivo

}