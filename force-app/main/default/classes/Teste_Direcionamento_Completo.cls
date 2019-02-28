/*
    Classe de testes para funcionalidades do Direcionamento de OS
        Classes:
            - Direcionamento_OS
            - Direcionamento_OS_Agendada
            - Direcionamento_OS_Batch
            - Util_Direcionamento_OS
            - Util_Direcionamento: Cobertura 77%
    Criado por: Mario Reis
    Data: 13/06/2018

*/
@isTest
public class Teste_Direcionamento_Completo {
    
    // Método para classe Util_Direcionamento
    static testmethod void testeUtilDirecionamento() {

        Status_OS__c statusPendente = Teste_Util_Status_OS.criarStatusAutorizadoPendente();
        Tipo_OS__c tipoOSInstalacao = Teste_Util_Tipo_OS.criarTipoOSAutorizado();

        TipoContrato__c tipoContrato = Teste_Util_Tipo_Contrato.criarTipoContratoPadrao();

        Test.startTest();

        Util_Direcionamento.getStatusSolicitacaoEquipamento();
        Util_Direcionamento.getStatusOS();
        Util_Direcionamento.getUltimaAcaoOS();
        Util_Direcionamento.getTipoOS();
        Util_Direcionamento.getListaItem();
        Util_Direcionamento.getTipoContrato();
        Util_Direcionamento.getListaClasse();
        Util_Direcionamento.getMotivoNoshowOS();
        Util_Direcionamento.getClienteKA();
        Util_Direcionamento.getStatusCriarDirecionamento();
        Util_Direcionamento.getRegiaoComercial();
        Util_Direcionamento.getTipoOSMacro();
        Util_Direcionamento.getTipoOSMicro();
                
        Util_Direcionamento.getListaMotivo(null, null);
        
        Test.stopTest();

    } // Fim testeUtilDirecionamento

    // Método para classe Util_Direcionamento_OS
    static testmethod void testeUtilDirecionamentoOS() {

        Test.startTest();

        Status_OS__c statusPendente = Teste_Util_Status_OS.criarStatusAutorizadoPendente();
        Status_OS__c statusConcluido = Teste_Util_Status_OS.criarStatusConcluidoFinalizado();

        Tipo_OS__c tipoOSInstalacao = Teste_Util_Tipo_OS.criarTipoOSAutorizado();
        TipoContrato__c tipoContrato = Teste_Util_Tipo_Contrato.criarTipoContratoPadrao();

        WorkOrder OS = Teste_Util_OS.criarOSPadrao(statusPendente.Id);

        Direcionamento_os__c direcionamentoOS = Teste_Util_Direcionamento.criarDirecionamentoOSPadrao();

        Util_Direcionamento_OS.direcionarOS(direcionamentoOS);

        Direcionamento_os__c direcionamentoOSPreenchido = Teste_Util_Direcionamento.criarDirecionamentoOSPreenchido(
                                                            statusPendente.Id, tipoContrato.Id, tipoOSInstalacao.Id);
        Profile perfil = Teste_Util_Usuario.getPerfilPorNome('Administrador do Sistema');
        User usuario = Teste_Util_Usuario.criaNovoUsuarioBR(perfil.Id, 'testedaodirecionamento@tt.com', 454654);
        direcionamentoOS.OwnerId = usuario.Id;
        direcionamentoOS.Quantidade_OS__c = 0;
        update direcionamentoOS;

        Profile perfilAtendimento = Teste_Util_Usuario.getPerfilPorNome('Atendimento');
        User usuarioAtendimento = Teste_Util_Usuario.criaNovoUsuarioBR(perfilAtendimento.Id, 'testedaoatendimento@tt.com', 454655);
        Teste_Util_Direcionamento.criarAtendenteDirecionamento(direcionamentoOS.Id, usuarioAtendimento.Id);

        OS.OwnerId = usuarioAtendimento.Id;
        update OS;

        Util_Direcionamento_OS.direcionarOS(direcionamentoOS);
        Util_Direcionamento_OS.direcionarOS(direcionamentoOSPreenchido);

        User usuarioAtendimento2 = Teste_Util_Usuario.criaNovoUsuarioBR(perfilAtendimento.Id, 'testedaoatendimento2@tt.com', 4546552);
        Teste_Util_Direcionamento.criarAtendenteDirecionamento(direcionamentoOS.Id, usuarioAtendimento2.Id);

        OS.Regra_direcionamento_OS__c = direcionamentoOS.Id;
        update OS;

        direcionamentoOS.Quantidade_OS__c = 1;
        update direcionamentoOS;
        Util_Direcionamento_OS.direcionarOS(direcionamentoOS);

        
        
        // Util_Direcionamento_OS.removerOSRegra(new Set<Id>(), OS.Regra_direcionamento_OS__c);
        Util_Direcionamento_OS.atualizarInformacoesOS(new List<WorkOrder>{OS});

        
        Test.stopTest();

    } // Fim testeUtilDirecionamento
}