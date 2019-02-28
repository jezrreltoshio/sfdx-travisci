/*
    Classe de testes para classe: Util_Direcionamento
    Criado por: Mario Reis
    Data: 11/06/2018

*/
@isTest
public class Teste_Util_Direcionamento {

    //Método para criar um direcionamento de OS
    public static Direcionamento_OS__c criarDirecionamentoOSPadrao(){

		Direcionamento_OS__c direcionamentoOS = new Direcionamento_OS__c();

        direcionamentoOS.Name = 'Direcionamento OS';

		insert direcionamentoOS;
        return direcionamentoOS;
    } // Fim criarDirecionamentoOS


    //Método para criar um direcionamento de OS preenchido
    public static Direcionamento_OS__c criarDirecionamentoOSPreenchido(String idStatusOS, 
                                                                       String idTipoContrato, 
                                                                       String idTipoOS){

		Direcionamento_OS__c direcionamentoOS = new Direcionamento_OS__c();

        direcionamentoOS.Name = 'Direcionamento OS';
        direcionamentoOS.Cliente__c = 'cliente';
        direcionamentoOS.Numero_OS__c = '123456';
        direcionamentoOS.OS_sem_agendamento_aging_85_dias__c = true;
        direcionamentoOS.Contato_fora_faixa__c = true;
        direcionamentoOS.OS_com_agendamento__c = true;
        direcionamentoOS.Ultima_acao_OS__c = 'Autorizado (O.S.);Vazio';
        direcionamentoOS.Motivo_noshow__c = 'Motivo no show';
        direcionamentoOS.Status_OS__c = idStatusOS;
        direcionamentoOS.Tipo_contrato__c = idTipoContrato;
        direcionamentoOS.Classe__c = 'SASTM';
        direcionamentoOS.Cliente_KA__c = 'Todos';
        direcionamentoOS.OS_sem_servico__c = true;
        direcionamentoOS.OS_sem_direcionamento__c = true;
        direcionamentoOS.Aging_inicial__c = 0;
        direcionamentoOS.Aging_final__c = 5;
        direcionamentoOS.Tipo_OS__c = idTipoOS;
        // direcionamentoOS.Motivo__c = 'idMotivo';
        direcionamentoOS.Item__c = 'idItem';
        direcionamentoOS.Quantidade_OS__c = 0;

		insert direcionamentoOS;
        return direcionamentoOS;
    } // Fim criarDirecionamentoOSPreenchido


    //Método para criar um atendente do direcionamento
    public static Atendente_Direcionamento_OS__c criarAtendenteDirecionamento(String idDirecionamento, 
                                                                              String idUsuario){

        Atendente_Direcionamento_OS__c atendente = new Atendente_Direcionamento_OS__c();
        atendente.Direcionamento_OS__c = idDirecionamento;
		atendente.Usuario__c = idUsuario;

		insert atendente;
		return atendente;

    } // Fim criarAtendenteDirecionamento

}