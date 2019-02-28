/*
    Classe de testes para cadastro do objeto WorkOrder
    Criado por: Mario Reis
    Data: 12/06/2018

*/
@isTest
public class Teste_Util_OS {

    //Método para criar uma OS padrao
    public static WorkOrder criarOSPadrao(String idStatus){

        WorkOrder OS = new WorkOrder();

        OS.Agendado_para__c = System.today();
        OS.Aging__c = 20;
        OS.Classe__c = 'classe';
        OS.Cliente_KA__c = true;
        OS.Cliente__c = 'cliente';
        OS.Codigo_Externo__c = 123456789;
        OS.Contato_fora_faixa__c = false;
        OS.Data_atualizacao_status_OS__c = System.today();
        OS.Data_direcionamento__c = System.today();
        OS.Data_ultima_acao__c = System.today();
        OS.Motivo_noshow__c = 'motivoNoShow';
        OS.OS_sem_acao__c = false;
        OS.OS_sem_agendamento_aging_85_dias__c = false;
        OS.Proximo_contato__c = System.today();
        OS.Quantidade_contato__c = 5;
        OS.Quantidade_servicos__c = 2;
        OS.Regra_direcionamento_OS__c = null;
        OS.StartDate = System.today();
        OS.EndDate = System.today();
        OS.Status_OS__c = idStatus;
        OS.Tipo_contrato__c = null;
        OS.Tipo_OS__c = null;
        OS.Ultima_acao_OS__c = 'ultimaAcaoOS';

		insert OS;
        return OS;
    }// Fim criarOSPadrao


    //Método para criar uma OS
    public static WorkOrder criarOS(Date agendadoPara, Integer aging, String classe, Boolean clienteKA, String cliente
									, Integer numeroOS, Boolean contatoForaFaixa, Date dataAtualizacaoStatusOS
									, Date dataDirecionamento, Date dataUltimaAcao, String motivoNoShow, Boolean osSemAcao
									, Boolean OsSemAgendamentoAging85dias, Datetime dataProximoContato, Integer quantidadeContato
									, Integer quantidadeServicos, String regraDirecionamentoOS, Datetime startDate, Datetime endDate
									, String statusOS, String tipoContrato, String tipoOS, String ultimaAcaoOS){

        WorkOrder OS = new WorkOrder();

        OS.Agendado_para__c = agendadoPara;
        OS.Aging__c = aging;
        OS.Classe__c = classe;
        OS.Cliente_KA__c = clienteKA;
        OS.Cliente__c = cliente;
        OS.Codigo_Externo__c = numeroOS;
        OS.Contato_fora_faixa__c = contatoForaFaixa;
        OS.Data_atualizacao_status_OS__c = dataAtualizacaoStatusOS;
        OS.Data_direcionamento__c = dataDirecionamento;
        OS.Data_ultima_acao__c = dataUltimaAcao;
        OS.Motivo_noshow__c = motivoNoShow;
        OS.OS_sem_acao__c = osSemAcao;
        OS.OS_sem_agendamento_aging_85_dias__c = OsSemAgendamentoAging85dias;
        OS.Proximo_contato__c = dataProximoContato;
        OS.Quantidade_contato__c = quantidadeContato;
        OS.Quantidade_servicos__c = quantidadeServicos;
        OS.Regra_direcionamento_OS__c = regraDirecionamentoOS;
        OS.StartDate = startDate;
        OS.EndDate = endDate;
        OS.Status_OS__c = statusOS;
        OS.Tipo_contrato__c = tipoContrato;
        OS.Tipo_OS__c = tipoOS;
        OS.Ultima_acao_OS__c = ultimaAcaoOS;

		insert OS;
        return OS;
    }// Fim criarOS

}