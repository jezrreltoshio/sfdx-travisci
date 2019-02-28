/*
	@testClass DAO_Ordem_Servico
	
	@author Renan Rocha
	@date 04/12/2018
*/

@isTest
public class Teste_DAO_Ordem_Servico{
	
	/*
		@author Renan Rocha
		@date 04/12/2018
	*/
	static testMethod void  getListaOrdemServico(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		WorkOrder OS = (WorkOrder) mapBase.get('WorkOrder');

		System.assertEquals(1, DAO_Ordem_Servico.getListaOrdemServico(new Set<Id>{OS.Id}).size());
	}

	/*
		@author Renan Rocha
		@date 04/12/2018
	*/
	static testMethod void getQueryBatch(){
		System.assertNotEquals(null, DAO_Ordem_Servico.getQueryBatch(null));
	}

	/*
		@author Renan Rocha
		@date 05/12/2018
	*/
	static testMethod void getOrdemById(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		WorkOrder OS = (WorkOrder) mapBase.get('WorkOrder');

		System.assertEquals(OS.Id, DAO_Ordem_Servico.getOrdemById(OS.Id).Id);
	}

	static testMethod void getListaOS(){
                Status_OS__c statusPendente = Teste_Util_Status_OS.criarStatusAutorizadoPendente();
                Tipo_OS__c tipoOSInstalacao = Teste_Util_Tipo_OS.criarTipoOSAutorizado();

                TipoContrato__c tipoContrato = Teste_Util_Tipo_Contrato.criarTipoContratoPadrao();

                WorkOrder OS = Teste_Util_OS.criarOSPadrao(statusPendente.Id);

                Direcionamento_os__c direcionamentoOS = Teste_Util_Direcionamento.criarDirecionamentoOSPadrao();
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

                Test.startTest();

                DAO_Ordem_Servico.getListaOS(direcionamentoOS, new List<String>{OS.Cliente__c, OS.Cliente__c});
                DAO_Ordem_Servico.getListaOS(direcionamentoOSPreenchido, new List<String>{OS.Cliente__c, OS.Cliente__c});
                direcionamentoOSPreenchido.Ultima_acao_OS__c = 'Vazio';
                direcionamentoOSPreenchido.Aging_inicial__c = 5;
                direcionamentoOSPreenchido.Aging_final__c = null;
                direcionamentoOSPreenchido.Cliente_KA__c = 'Sim';
                update direcionamentoOSPreenchido;
                DAO_Ordem_Servico.getListaOS(direcionamentoOSPreenchido, new List<String>{OS.Cliente__c, OS.Cliente__c});
                direcionamentoOSPreenchido.Ultima_acao_OS__c = 'Autorizado (O.S.)';
                direcionamentoOSPreenchido.Aging_inicial__c = null;
                direcionamentoOSPreenchido.Aging_final__c = 5;
                direcionamentoOSPreenchido.Cliente_KA__c = 'Não';
                update direcionamentoOSPreenchido;
                DAO_Ordem_Servico.getListaOS(direcionamentoOSPreenchido, new List<String>{OS.Cliente__c, OS.Cliente__c});
                DAO_Ordem_Servico.getListaOsByUser(new Set<Id>{usuarioAtendimento.Id});

                Test.stopTest();
	}
}