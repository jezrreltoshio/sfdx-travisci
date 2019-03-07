/*
	@testClass Handler_Oportunidade

	@author Renan Rocha
	@date 20/11/2018
*/

@isTest
public class Teste_Handler_Oportunidade{

	/*
		@author Renan Rocha
		@date 06/12/2018
	*/
	static testMethod void setBandeiraCartao(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		Opportunity oportunidade = (Opportunity) mapBase.get('Opportunity');

		Handler_Oportunidade.setBandeiraCartao(new List<Opportunity>{oportunidade});
	}

	/*
		@author Renan Rocha
		@date 06/12/2018
	*/
	static testMethod void checkCpfCnpjIsNotEmpty(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		Opportunity oportunidade = (Opportunity) mapBase.get('Opportunity');

		Handler_Oportunidade.checkCpfCnpjIsNotEmpty(new List<Opportunity>{oportunidade});
	}

	/*
		@author Renan Rocha
		@date 06/12/2018
	*/
	static testMethod void verificarAlteracaoAdesao(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		Opportunity oportunidade = (Opportunity) mapBase.get('Opportunity');

		Handler_Oportunidade.verificarAlteracaoAdesao(new List<Opportunity>{oportunidade});
	}

	/*
		@author Renan Rocha
		@date 06/12/2018
	*/
	static testMethod void validarNomePortador(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();

		Opportunity oportunidadeOld = (Opportunity) mapBase.get('Opportunity');
		
		Handler_Oportunidade.validarNomePortador(new List<Opportunity>{oportunidadeOld}, null, true, false);

		Opportunity oportunidade = (Opportunity) mapBase.get('Opportunity');
		oportunidade.CloseDate = System.today().addDays(10);
		update oportunidade;

		Handler_Oportunidade.validarNomePortador(new List<Opportunity>{oportunidade}, new Map<Id, Opportunity>{oportunidade.Id => oportunidadeOld}, false, true);
	}

	/*
		@author Renan Rocha
		@date 06/12/2018
	*/
	static testMethod void adjustPayment(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();

		Account conta = (Account) mapBase.get('Account');
		Opportunity oportunidadeOld = Teste_Util.newOpportunity(conta.Id);
		oportunidadeOld.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Siggo').getRecordTypeId();
		oportunidadeOld.Siggo_AnalCred_ResultadoAnalise__c = 10;
		oportunidadeOld.Status_aprova_o_manual__c = 'Nova';
		oportunidadeOld.Forma_pagamento_monitoramento__c = '24-Cartão Visa';
		oportunidadeOld.Dia_vcto_monitoramento__c = '15';
		oportunidadeOld.Agencia_para_D_A_do_monitoramento__c = 6;
		oportunidadeOld.Conta_Corrente_para_DA_do_monitoramento__c = 11;
		oportunidadeOld.Nome_do_Tit_para_DA_do_monitoramento__c = 'Nome antigo';
		oportunidadeOld.C_d_de_Seg_do_C_de_Cr_dito_do_monit__c = '145';
		oportunidadeOld.N_mero_do_C_de_Cr_dito_do_Monitoramento__c = '5456465456457876';
		oportunidadeOld.Vcto_do_C_de_Cr_dito_do_monitoramento__c = '1212';
		update oportunidadeOld;
		
		Handler_Oportunidade.adjustPayment(new List<Opportunity>{oportunidadeOld}, true, false, null);

		Opportunity oportunidade = (Opportunity) mapBase.get('Opportunity');
		oportunidade.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Siggo').getRecordTypeId();
		oportunidade.CloseDate = System.today().addDays(10);
		oportunidade.Siggo_AnalCred_ResultadoAnalise__c = 20;
		oportunidade.Status_aprova_o_manual__c = 'Nova';
		oportunidade.Forma_pagamento_monitoramento__c = '1-Boleto Bancário';
		oportunidade.Dia_vcto_monitoramento__c = '7';
		oportunidade.Agencia_para_D_A_do_monitoramento__c = 5;
		oportunidade.Conta_Corrente_para_DA_do_monitoramento__c = 10;
		oportunidade.Nome_do_Tit_para_DA_do_monitoramento__c = 'Nome';
		oportunidade.C_d_de_Seg_do_C_de_Cr_dito_do_monit__c = '001';
		oportunidade.N_mero_do_C_de_Cr_dito_do_Monitoramento__c = '5456465456456';
		oportunidade.Vcto_do_C_de_Cr_dito_do_monitoramento__c = '1012';
		oportunidade.Usar_dados_da_conta__c = false;
		oportunidade.Usar_dados_de_pagamento_da_instala_o__c = true;
		update oportunidade;

		Handler_Oportunidade.adjustPayment(new List<Opportunity>{oportunidade}, false, true, new Map<Id, Opportunity>{oportunidade.Id => oportunidadeOld});
		
		oportunidade.Forma_de_pagamento__c = '24-Cartão Visa';
		update oportunidade;

		Handler_Oportunidade.adjustPayment(new List<Opportunity>{oportunidade}, false, true, new Map<Id, Opportunity>{oportunidade.Id => oportunidadeOld});
		
		oportunidade.Forma_pagamento_monitoramento__c = null;
		oportunidade.Dia_vcto_monitoramento__c = null;
		oportunidade.Agencia_para_D_A_do_monitoramento__c = null;
		oportunidade.Conta_Corrente_para_DA_do_monitoramento__c = null;
		oportunidade.Nome_do_Tit_para_DA_do_monitoramento__c = null;
		update oportunidade;

		conta.FormaCobranca__c = '1-Boleto Bancário';
		conta.Dia_de_vencimento__c = '7';
		conta.DebAut_Agencia__c = 5;
		conta.DebAut_ContaCorrente__c = 10;
		conta.DebAut_NomeTitular__c = 'Nome teste';
		update conta;

		Handler_Oportunidade.adjustPayment(new List<Opportunity>{oportunidade}, false, true, new Map<Id, Opportunity>{oportunidade.Id => oportunidadeOld});
	}

	/*
		@author Renan Rocha
		@date 06/12/2018
	*/
	static testMethod void updateOwner(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();

		Opportunity oportunidadeOld = (Opportunity) mapBase.get('Opportunity');
		
		Handler_Oportunidade.updateOwner(new List<Opportunity>{oportunidadeOld}, null, true);

		Opportunity oportunidade = (Opportunity) mapBase.get('Opportunity');
		oportunidade.CloseDate = System.today().addDays(10);
		update oportunidade;

		Handler_Oportunidade.updateOwner(new List<Opportunity>{oportunidade}, new List<Opportunity>{oportunidadeOld}, false);
	}

	/*
		@author Renan Rocha
		@date 06/12/2018
	*/
	static testMethod void verifyApprovalProcess(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();

		Opportunity oportunidadeOld = (Opportunity) mapBase.get('Opportunity');
		oportunidadeOld.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Siggo').getRecordTypeId();
		oportunidadeOld.Siggo_AnalCred_ResultadoAnalise__c = 0;	
		oportunidadeOld.Status_aprova_o_manual__c  = 'Aprovada';	
		update oportunidadeOld;

		Opportunity oportunidade = (Opportunity) mapBase.get('Opportunity');
		oportunidade.CloseDate = System.today().addDays(10);
		oportunidade.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Siggo').getRecordTypeId();
		oportunidade.Siggo_PersProp_NumeroProposta__c = '546564564';
		update oportunidade;

		User usuario = (User) mapBase.get('User');

		System.runAs(usuario) {
			Handler_Oportunidade.verifyApprovalProcess(new List<Opportunity>{oportunidade}, new Map<Id, Opportunity>{oportunidade.Id => oportunidadeOld});
		}
	}

	/*
		@author Renan Rocha
		@date 07/12/2018
	*/
	static testMethod void pgtoProdutoSeguro(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		Opportunity oportunidade = (Opportunity) mapBase.get('Opportunity');
		oportunidade.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Siggo').getRecordTypeId();
		oportunidade.Forma_de_pagamento_instala_o__c = '1-Boleto Bancário';
		oportunidade.Parcelamento_da_instala_o__c = 4;
		oportunidade.Parcelamento_da_instala_o__c = 0;
		oportunidade.Tipo_proposta__c = '5 Upgrade';
		update oportunidade;

		OpportunityLineItem oppLi = (OpportunityLineItem) mapBase.get('OpportunityLineItem');
		oppLi.Classe_do_contrato__c = 121;
		update oppLi;

		Handler_Oportunidade.pgtoProdutoSeguro(new List<Opportunity>{oportunidade});

		oportunidade.Forma_de_pagamento_instala_o__c = '3 - Débito Automático HSBC';
		oportunidade.Usar_dados_de_pagamento_da_instala_o__c  = true;
		update oportunidade;

		Handler_Oportunidade.pgtoProdutoSeguro(new List<Opportunity>{oportunidade});
	}

	/*
		@author Renan Rocha
		@date 07/12/2018
	*/
	static testMethod void logApprovalProcess(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();

		Opportunity oportunidadeOld = (Opportunity) mapBase.get('Opportunity');

		Opportunity oportunidade = (Opportunity) mapBase.get('Opportunity');
		oportunidade.CloseDate = System.today().addDays(10);
		update oportunidade;

		Handler_Oportunidade.logApprovalProcess(new List<Opportunity>{oportunidade}, new Map<Id, Opportunity>{oportunidade.Id => oportunidadeOld});
	}

	/*
		@author Renan Rocha
		@date 07/12/2018
	*/
	static testMethod void abasteceHistoricoDetalhes(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();

		Opportunity oportunidadeOld = (Opportunity) mapBase.get('Opportunity');
		
		Handler_Oportunidade.abasteceHistoricoDetalhes(new List<Opportunity>{oportunidadeOld}, null, true, false);

		Opportunity oportunidade = (Opportunity) mapBase.get('Opportunity');
		oportunidade.CloseDate = System.today().addDays(10);
		update oportunidade;

		Handler_Oportunidade.abasteceHistoricoDetalhes(new List<Opportunity>{oportunidade}, new List<Opportunity>{oportunidadeOld}, false, true);
	}

	/*
		@author Renan Rocha
		@date 14/01/2019
	*/
	static testMethod void atualizaPontuacao(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		Opportunity oportunidade = (Opportunity) mapBase.get('Opportunity');
		
		Handler_Oportunidade.atualizaPontuacao(new List<Opportunity>{oportunidade});
	}

	/*
		@author Renan Rocha
		@date 16/01/2019
	*/
	static testMethod void atualizaTipoContratoId(){
		Map<String, sObject> mapBase = Teste_Util.createMapBase();
		Opportunity oportunidade = (Opportunity) mapBase.get('Opportunity');
		oportunidade.Tipo_contrato__c = 'TESTE_#01';
		update oportunidade;
		
		Handler_Oportunidade.atualizaTipoContratoId(new List<Opportunity>{oportunidade});
	}
}