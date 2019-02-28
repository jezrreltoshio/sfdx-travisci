/*
    Classe de testes para as classes: 
		- OS_Atualizar_Informacoes - Cobertura 100%
		- OS_Atualizar_Informacoes_Batch - Cobertura 94%

	Criado por: Mario Reis
    Data: 05/12/2017
*/
@isTest
public class Teste_OS_Atualizar_Informacoes {

    
    // Método para teste da classe
    static testmethod void teste() {

        Status_OS__c statusPendente = Teste_Util_Status_OS.criarStatusAutorizadoPendente();

        Parametrizacao_faixa_aging__c parametrizacao = new Parametrizacao_faixa_aging__c();
        parametrizacao.Nome_faixa__c = 'D0 a D7';
        parametrizacao.Aging_de__c = 0;
        parametrizacao.Aging_ate__c =7;
        parametrizacao.Contatos_dias_distintos__c = true;
        parametrizacao.Quantidade_contatos__c = 1;
        parametrizacao.Tipo_Macro_OS__c = 'Sem motivo cadastrado';
		parametrizacao.Tipo_Micro_OS__c = 'Sem item cadastrado';
        insert parametrizacao;

		Test.startTest();

        WorkOrder OS = Teste_Util_OS.criarOSPadrao(statusPendente.Id);
        Historico_OS__c ho = Teste_Util_Historico_OS.criarHistoricoEfetivo(OS.Id);

        OS_Atualizar_Informacoes_Agendada sh1 = new OS_Atualizar_Informacoes_Agendada();      
        sh1.scheduleIt();
        // String sch = '0 57 13 * * ?';
        // System.schedule('Test check', sch, sh1);


        Test.stopTest();

    } // Fim teste
	
    
    // Método para teste da classe
    static testmethod void teste2() {

        Status_OS__c statusFinalizado = Teste_Util_Status_OS.criarStatusConcluidoFinalizado();

		Parametrizacao_faixa_aging__c parametrizacao = new Parametrizacao_faixa_aging__c();
        parametrizacao.Nome_faixa__c = 'D0 a D7';
        parametrizacao.Aging_de__c = 0;
        parametrizacao.Aging_ate__c =7;
        parametrizacao.Contatos_dias_distintos__c = true;
        parametrizacao.Quantidade_contatos__c = 1;
        parametrizacao.Tipo_Macro_OS__c = 'Sem motivo cadastrado';
		parametrizacao.Tipo_Micro_OS__c = 'Sem item cadastrado';
        insert parametrizacao;

        Test.startTest();

        WorkOrder OS = Teste_Util_OS.criarOSPadrao(statusFinalizado.Id);
        Historico_OS__c ho = Teste_Util_Historico_OS.criarHistoricoEfetivo(OS.Id);

        OS_Atualizar_Informacoes_Agendada sh1 = new OS_Atualizar_Informacoes_Agendada();      
        sh1.scheduleIt();
        // String sch = '0 57 13 * * ?';
        // System.schedule('Test check', sch, sh1);


        Test.stopTest();

    } // Fim teste

    
    // Método para teste da classe
    static testmethod void teste3() {

        Status_OS__c statusFinalizado = Teste_Util_Status_OS.criarStatusConcluidoFinalizado();
        statusFinalizado.Name = 'Ordem de serviço cancelada';
        update statusFinalizado;

		Parametrizacao_faixa_aging__c parametrizacao = new Parametrizacao_faixa_aging__c();
        parametrizacao.Nome_faixa__c = 'D0 a D7';
        parametrizacao.Aging_de__c = 0;
        parametrizacao.Aging_ate__c =7;
        parametrizacao.Contatos_dias_distintos__c = true;
        parametrizacao.Quantidade_contatos__c = 1;
        parametrizacao.Tipo_Macro_OS__c = 'Sem motivo cadastrado';
		parametrizacao.Tipo_Micro_OS__c = 'Sem item cadastrado';
        insert parametrizacao;

        Test.startTest();

        WorkOrder OS = Teste_Util_OS.criarOSPadrao(statusFinalizado.Id);
        Historico_OS__c ho = Teste_Util_Historico_OS.criarHistoricoEfetivo(OS.Id);

        OS_Atualizar_Informacoes_Agendada sh1 = new OS_Atualizar_Informacoes_Agendada();      
        // sh1.scheduleIt();
        String sch = '0 57 13 * * ?';
        System.schedule('Test check', sch, sh1);


        Test.stopTest();

    } // Fim teste

    
    // Método para teste da classe
    static testmethod void teste4() {

        Status_OS__c statusFinalizado = Teste_Util_Status_OS.criarStatusConcluidoFinalizado();
        statusFinalizado.Name = 'Ordem de serviço cancelada';
        update statusFinalizado;

		Parametrizacao_faixa_aging__c parametrizacao = new Parametrizacao_faixa_aging__c();
        parametrizacao.Nome_faixa__c = 'D0 a D7';
        parametrizacao.Aging_de__c = 0;
        parametrizacao.Aging_ate__c =7;
        parametrizacao.Contatos_dias_distintos__c = true;
        parametrizacao.Quantidade_contatos__c = 1;
        parametrizacao.Tipo_Macro_OS__c = 'Sem motivo cadastrado';
		parametrizacao.Tipo_Micro_OS__c = 'Sem item cadastrado';
        insert parametrizacao;

        Test.startTest();

        WorkOrder OS = Teste_Util_OS.criarOSPadrao(statusFinalizado.Id);
        Historico_OS__c ho = Teste_Util_Historico_OS.criarHistoricoSemAcao(OS.Id);

        OS_Atualizar_Informacoes_Agendada sh1 = new OS_Atualizar_Informacoes_Agendada();      
        // sh1.scheduleIt();
        String sch = '0 59 12 * * ?';
        System.schedule('Test check', sch, sh1);


        Test.stopTest();

    } // Fim teste

}