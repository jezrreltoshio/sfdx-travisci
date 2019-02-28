/*
	@testClass Teste_Handler_Oportunidade

	@description Handler para o Objeto: Opportunity

	@author Renan Rocha
	@date 19/11/2018
	@JIRA KCA-9
*/

public class Handler_Oportunidade{

	private static String CLASS_NAME = 'Handler_Oportunidade';
	
	/*
		@description Ajusta as bandeiras dos cartões
		@param List<Opportunity> pListaOpp
		@return void
		
		@author Renan Rocha
		@date 19/11/2018
	*/
	public static void setBandeiraCartao(List<Opportunity> pListaOpp){
		String METHOD_NAME = 'setBandeiraCartao';

		System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - pListaOpp: '+ pListaOpp);
	
		for(Opportunity forOpp : pListaOpp) OpportunityBandeiraCartao.setBandeiraCartao(forOpp);
	}

	/*
		@description Verifica se o CPF ou CNPJ não está vazio
		@param List<Opportunity> pListaOpp
		@return void
		
		@author Renan Rocha
		@date 19/11/2018
	*/
	public static void checkCpfCnpjIsNotEmpty(List<Opportunity> pListaOpp){
		String METHOD_NAME = 'checkCpfCnpjIsNotEmpty';

		for(Opportunity forOpp : pListaOpp){
			//Recuperando o Record type name do objeto Oportunidade
	        String nomeTipoRegistro = Opportunity.SObjectType.getDescribe().getRecordTypeInfosById().get(forOpp.RecordTypeId).getName();
	        nomeTipoRegistro = nomeTipoRegistro.toUpperCase();

	        OpportunityCheckCpfCnpjIsNotEmpty.opportunityCheckCpfCnpjIsNotEmpty(forOpp, nomeTipoRegistro);
		}
	}

	/*
		@description Verifica alterações na Adesão
		@param List<Opportunity> pListaOpp
		@return void
		
		@author Renan Rocha
		@date 19/11/2018
	*/
	public static void verificarAlteracaoAdesao(List<Opportunity> pListaOpp){
		String METHOD_NAME = 'verificarAlteracaoAdesao';
	
		for(Opportunity forOpp : pListaOpp) VerificaAlteracaoAdesaoExecutivo.oppVerificarAlteracaoAdesao(forOpp);
	}

	/*
		@description Valida o nome do Portador
		@param List<Opportunity> pListaOppNew, Map<Id, Opportunity> pOldMap, Boolean pIsInsert, Boolean pIsUpda
		@return void
		
		@author Renan Rocha
	*/
	public static void validarNomePortador(List<Opportunity> pListaOppNew, Map<Id, Opportunity> pOldMap, Boolean pIsInsert, Boolean pIsUpdate){
		String METHOD_NAME = 'validarNomePortador';
	
		for(Opportunity forOpp : pListaOppNew){
			if(forOpp.RecordTypeId != null){
		    	String recordTypeName = Schema.getGlobalDescribe().get('Opportunity').getDescribe().getRecordTypeInfosById().get(forOpp.RecordTypeId).getName();
		    	OpportunityTriggers.validarNomePortador(forOpp, pOldMap, pIsInsert, pIsUpdate, recordTypeName);
		    }
		}
	}

	/*
		@description Ajusta o pagamento da Oportunidade
		@param List<Opportunity> pListaOppNew
		@return void
		
		@author Renan Rocha
	*/
	public static void adjustPayment(List<Opportunity> pListaOppNew, Boolean pIsInsert, Boolean pIsUpdate, Map<Id, Opportunity> pOldMap){
		String METHOD_NAME = 'adjustPayment';

	    Map<Id,RecordType> tipoRegistro = new Map<Id,RecordType>();
	    Map<Id,Account> acc = new Map<Id,Account>();
        String msgErro = '';
        List<Account> listaContaDAO = new List<Account>();
	    
	    // Check the type of the records
	    for(Opportunity opp: pListaOppNew) tipoRegistro.put(opp.RecordTypeId,null);
	    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - tipoRegistro.keySet(): '+ tipoRegistro.keySet());

	    List<RecordType> listaTipoRegistroDAO = DAO_Tipo_Registro.getTiposRegistroBySetId(tipoRegistro.keySet());
	    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaTipoRegistroDAO: '+ listaTipoRegistroDAO);
	    
	    for(RecordType rt : listaTipoRegistroDAO) tipoRegistro.put(rt.Id, rt);
	    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - tipoRegistro: '+ tipoRegistro);
	
        // Build account list
        for(Opportunity opp: pListaOppNew) {

            if (tipoRegistro.get(opp.RecordTypeId).Name == 'Siggo' && pIsInsert && opp.Siggo_AnalCred_ResultadoAnalise__c != 0 && 
                opp.Status_aprova_o_manual__c != 'Aprovada') {
                acc.put(opp.AccountId,null);
            } else if (tipoRegistro.get(opp.RecordTypeId).Name == 'Siggo' && pIsUpdate) {
                Opportunity oldOpp = pOldMap.get(opp.Id);
                
                if (oldOpp.Siggo_AnalCred_ResultadoAnalise__c != 0 && oldOpp.Status_aprova_o_manual__c != 'Aprovada'){
                    if(oldOpp.Forma_pagamento_monitoramento__c != opp.Forma_pagamento_monitoramento__c
                       && oldOpp.Dia_vcto_monitoramento__c != opp.Dia_vcto_monitoramento__c
                       && oldOpp.Agencia_para_D_A_do_monitoramento__c != opp.Agencia_para_D_A_do_monitoramento__c
                       && oldOpp.Conta_Corrente_para_DA_do_monitoramento__c != opp.Conta_Corrente_para_DA_do_monitoramento__c
                       && oldOpp.Nome_do_Tit_para_DA_do_monitoramento__c != opp.Nome_do_Tit_para_DA_do_monitoramento__c
                       && oldOpp.C_d_de_Seg_do_C_de_Cr_dito_do_monit__c != opp.C_d_de_Seg_do_C_de_Cr_dito_do_monit__c
                       && oldOpp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c != opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c
                       && oldOpp.Vcto_do_C_de_Cr_dito_do_monitoramento__c != opp.Vcto_do_C_de_Cr_dito_do_monitoramento__c
                      ){
                        acc.put(opp.AccountId,null);
                    }
                }
            }
        }

        if (acc.size() != 0){

        	listaContaDAO = DAO_Conta.getContasBySetId(acc.keySet());
        	System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaContaDAO: '+ listaContaDAO);

            for(Account ac : listaContaDAO) acc.put(ac.Id, ac);
            
            for(Opportunity opp: pListaOppNew) {

                if (tipoRegistro.get(opp.RecordTypeId).Name == 'Siggo' && opp.Siggo_AnalCred_ResultadoAnalise__c != 0 && opp.Status_aprova_o_manual__c != 'Aprovada'){
                    
                    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - opp.Usar_dados_da_conta__c: '+ opp.Usar_dados_da_conta__c);

                    // Copy data from account
                    if (opp.Usar_dados_da_conta__c) {
                        
                        //// INSTALAÇÃO
                        //try {
                        //    opp.Forma_de_pagamento_instala_o__c = acc.get(opp.AccountId).FormaCobranca__c;
                        //} catch (Exception e) {
                        //    msgErro = msgErro + 'Erro copiando campo "Forma de Pagamento instalação". Possivelmente, o valor selecionado em conta não é válido para oportunidade. ';
                        //}
                        //opp.CartaoCredito_Numero_Cript__c = acc.get(opp.AccountId).Cobranca_Cartao_Numero_Cript__c;
                        //opp.CartaoCredito_CodigoSeguranca_Cript__c = acc.get(opp.AccountId).Cobranca_Cartao_CodigoSeguranca_Cript__c;
                        //opp.CartaoCredito_Vencimento__c = acc.get(opp.AccountId).Cobranca_Cartao_Vcto__c;

                        // MONITORAMENTO
                        try {
                        	opp.Forma_pagamento_monitoramento__c = acc.get(opp.AccountId).FormaCobranca__c;
                        }catch (Exception e){ 
                        	msgErro = msgErro + 'Erro copiando campo "Forma de Pagamento monitoramento". Possivelmente, o valor selecionado em conta não é válido para oportunidade. ';
                        }
                        
                        opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c = acc.get(opp.AccountId).Cobranca_Cartao_Numero_Cript__c;
                        opp.C_d_de_Seg_do_C_de_Cr_dito_do_monit__c = acc.get(opp.AccountId).Cobranca_Cartao_CodigoSeguranca_Cript__c;
                        opp.Vcto_do_C_de_Cr_dito_do_monitoramento__c = acc.get(opp.AccountId).Cobranca_Cartao_Vcto__c;
                        
                        // Melhorias Siggo
                        if(String.isEmpty(acc.get(opp.AccountId).Dia_de_vencimento__c) || acc.get(opp.AccountId).Dia_de_vencimento__c == null) opp.Dia_vcto_monitoramento__c = String.valueOf(acc.get(opp.AccountId).Cobranca_DiaVcto__c);
                        else opp.Dia_vcto_monitoramento__c = acc.get(opp.AccountId).Dia_de_vencimento__c;
                        
                        opp.Agencia_para_D_A_do_monitoramento__c = acc.get(opp.AccountId).DebAut_Agencia__c;
                        opp.Conta_Corrente_para_DA_do_monitoramento__c = acc.get(opp.AccountId).DebAut_ContaCorrente__c;
                        opp.Nome_do_Tit_para_DA_do_monitoramento__c = acc.get(opp.AccountId).DebAut_NomeTitular__c;
                    }
                    
                    // Copy data from INSTALACAO to MONITORAMENTO
                    // if (!opp.Usar_dados_da_conta__c && opp.Usar_dados_de_pagamento_da_instala_o__c){
                    if (opp.Usar_dados_de_pagamento_da_instala_o__c){
                        opp.Forma_pagamento_monitoramento__c = opp.Forma_de_pagamento_instala_o__c;
                        
                        if (opp.Forma_de_pagamento__c == '24-Cartão Visa' || opp.Forma_de_pagamento__c == '25-Cartão Master' || opp.Forma_de_pagamento__c == '82-Cartão Hipercard'){
                            opp.C_d_de_Seg_do_C_de_Cr_dito_do_monit__c = opp.CartaoCredito_CodigoSeguranca_Cript__c;
                            opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c = opp.CartaoCredito_Numero_Cript__c;
                            opp.Vcto_do_C_de_Cr_dito_do_monitoramento__c = opp.CartaoCredito_Vencimento__c;
                        } else if (opp.Usar_dados_de_pagamento_da_instala_o__c && (opp.Forma_de_pagamento__c != '24-Cartão Visa' || opp.Forma_de_pagamento__c != '25-Cartão Master' || opp.Forma_de_pagamento__c != '82-Cartão Hipercard')){
                            opp.C_d_de_Seg_do_C_de_Cr_dito_do_monit__c = null;
                            opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c = null;
                            opp.Vcto_do_C_de_Cr_dito_do_monitoramento__c = null;
                        }
                    }
                    
                   // // Check rule for vencimento vs forma de pagamento
                   //  MODIFICATION - CARLOS PRATES - unnecessary check - 15/07/2014 18:39
                   // if (opp.Total_Produtos_com_Seguro__c > 0 && opp.Dia_vcto_monitoramento__c != '12' && 
                   //     (opp.Forma_pagamento_monitoramento__c == '24-Cartão Visa' || opp.Forma_pagamento_monitoramento__c == '25-Cartão Master')) {
                   //     msgErro = msgErro + 'O campo "Dia do vencimento do monitoramento" deve ser 12 para pagamento com cartão de crédito e produto com seguro.';
                   //} else if (opp.Total_Produtos_com_Seguro__c == 0 && opp.Dia_vcto_monitoramento__c != '16' && 
                   //     (opp.Forma_pagamento_monitoramento__c == '24-Cartão Visa' || opp.Forma_pagamento_monitoramento__c == '25-Cartão Master')){
                   //     msgErro = msgErro + 'O campo "Dia do vencimento do monitoramento" deve ser 16 para pagamento com cartão de crédito e produto sem seguro.';
                   //}
                   // END MODIFICATION - CARLOS PRATES - unnecessary check - 15/07/2014 18:39 
                    
                    // Returns the error to the user
                    if (!String.isEmpty(msgErro)) opp.addError(msgErro);
                    
                    /*
                     * Copy data from "monitoramento" to account fields, when UPDATING the Opportunity and when 
                     * 
                     */
                    if (pIsUpdate){

                        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - acc.get(opp.AccountId): '+ acc.get(opp.AccountId));

                        if(!String.isEmpty(opp.Forma_pagamento_monitoramento__c))
                            acc.get(opp.AccountId).FormaCobranca__c = opp.Forma_pagamento_monitoramento__c;
                        
                        // Melhorias Siggo
                        if(!String.isEmpty(opp.Dia_vcto_monitoramento__c))
                            acc.get(opp.AccountId).Dia_de_vencimento__c = opp.Dia_vcto_monitoramento__c;
                        
                        if(!String.isEmpty(String.valueOf(opp.Agencia_para_D_A_do_monitoramento__c)))
                            acc.get(opp.AccountId).DebAut_Agencia__c = opp.Agencia_para_D_A_do_monitoramento__c;
                        
                        if(!String.isEmpty(String.valueOf(opp.Conta_Corrente_para_DA_do_monitoramento__c)))
                            acc.get(opp.AccountId).DebAut_ContaCorrente__c = opp.Conta_Corrente_para_DA_do_monitoramento__c;
                        
                        if(!String.isEmpty(opp.Nome_do_Tit_para_DA_do_monitoramento__c))
                            acc.get(opp.AccountId).DebAut_NomeTitular__c = opp.Nome_do_Tit_para_DA_do_monitoramento__c;
                        
                        if(!String.isEmpty(opp.C_d_de_Seg_do_C_de_Cr_dito_do_monit__c))
                            acc.get(opp.AccountId).Cobranca_Cartao_CodigoSeguranca_Cript__c = opp.C_d_de_Seg_do_C_de_Cr_dito_do_monit__c;
                        
                        if(!String.isEmpty(opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c))
                            acc.get(opp.AccountId).Cobranca_Cartao_Numero_Cript__c = opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c;
                        
                        if(!String.isEmpty(opp.Vcto_do_C_de_Cr_dito_do_monitoramento__c))
                            acc.get(opp.AccountId).Cobranca_Cartao_Vcto__c = opp.Vcto_do_C_de_Cr_dito_do_monitoramento__c;
                    }
                }
            }
            if (pIsUpdate) {
                if (acc.size() > 0) update acc.values();
            }
        }    
	}

	/*
		@description Chama a função updateOwner
		@param List<Opportunity> pListaOppNew, List<Opportunity> pListaOppOld, Boolean pIsInsert
		@return void
		
		@author Renan Rocha
	*/
	public static void updateOwner(List<Opportunity> pListaOppNew, List<Opportunity> pListaOppOld, Boolean pIsInsert){
		String METHOD_NAME = 'updateOwner';

		Map<Id,RecordType> tipoRegistro = new Map<Id,RecordType>();
	    
	    // Check the type of the records
	    for(Opportunity opp: pListaOppNew) tipoRegistro.put(opp.RecordTypeId,null);
	    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - tipoRegistro.keySet(): '+ tipoRegistro.keySet());

	    List<RecordType> listaTipoRegistroDAO = DAO_Tipo_Registro.getTiposRegistroBySetId(tipoRegistro.keySet());
	    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaTipoRegistroDAO: '+ listaTipoRegistroDAO);
	    
	    for(RecordType rt : listaTipoRegistroDAO) tipoRegistro.put(rt.Id, rt);
	    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - tipoRegistro: '+ tipoRegistro);
	
		if(pIsInsert) OpportunityTriggers.UpdateOwner(pListaOppNew, null, tipoRegistro);
		else OpportunityTriggers.UpdateOwner(pListaOppNew, pListaOppOld, tipoRegistro);
	}

	/*
		@description Verifica o processo de aprovação
		@param List<Opportunity> pListaOpp
		@return void
		
		@author Renan Rocha
	*/
	public static void verifyApprovalProcess(List<Opportunity> pListaOpp, Map<Id, Opportunity> pOldMap){
		String METHOD_NAME = 'verifyApprovalProcess';
	
        Map<Id, Opportunity> aprovacoes = new Map<Id, Opportunity>();
        Map<Id, Profile> perfisMap = new Map<Id, Profile>();
        Map<Id, UserRole> papeisMap = new Map<Id, UserRole>();
        Map<Id,RecordType> tipoRegistro = new Map<Id,RecordType>();
        List<UserRole> listaPapelUsuarioDAO = new List<UserRole>();
	    
	    // Check the type of the records
	    for(Opportunity opp: pListaOpp) tipoRegistro.put(opp.RecordTypeId,null);
	    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - tipoRegistro.keySet(): '+ tipoRegistro.keySet());

	    List<RecordType> listaTipoRegistroDAO = DAO_Tipo_Registro.getTiposRegistroBySetId(tipoRegistro.keySet());
	    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaTipoRegistroDAO: '+ listaTipoRegistroDAO);
	    
	    for(RecordType rt : listaTipoRegistroDAO) tipoRegistro.put(rt.Id, rt);
	    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - tipoRegistro: '+ tipoRegistro);
        
        List<Profile> listaPerfisDAO = DAO_Perfil.getPerfisById(UserInfo.getProfileId());
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaPerfisDAO: '+ listaPerfisDAO);

        for(Profile forPerfil : listaPerfisDAO) perfisMap.put(forPerfil.Id, forPerfil);
        
        if (!String.isEmpty(UserInfo.getUserRoleId())) {
        	listaPapelUsuarioDAO = DAO_Papel_Usuario.getPapeisUsuarioById(UserInfo.getUserRoleId());
        	System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaPapelUsuarioDAO: '+ listaPapelUsuarioDAO);
            
            for(UserRole u : listaPapelUsuarioDAO) papeisMap.put(u.Id, u);
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - papeisMap: '+ papeisMap); 
        }
            
        for(Opportunity opp: pListaOpp) {
            Opportunity oldOpp = pOldMap.get(opp.Id);
          
            // Verifies the payment methos to see if they're ok
            if (tipoRegistro.get(opp.RecordTypeId).Name == 'Siggo') {
                String perfil = perfisMap.get(UserInfo.getProfileId()).Name;
                String papel = '';
                
                if (!String.isEmpty(UserInfo.getUserRoleId())) papel = papeisMap.get(UserInfo.getUserRoleId()).Name;

                // Verify if it's trying to save an approved record without "proposta"
                if(opp.Siggo_PersProp_AguardandoRetorno__c != true){
                    if (opp.Status_aprova_o_manual__c != 'Reiniciada' && String.isEmpty(opp.Siggo_PersProp_NumeroProposta__c) && 
                        (oldOpp.Siggo_PersProp_AguardandoRetorno__c == opp.Siggo_PersProp_AguardandoRetorno__c) && 
                        (oldOpp.Siggo_AnalCred_ResultadoAnalise__c == 0 || oldOpp.Status_aprova_o_manual__c == 'Aprovada')){
                        opp.addError('Você não pode editar uma oportunidade aprovada. Gere a proposta, finalizando a oportunidade ou reinicie a análise de crédito.');
                    }
                }

                // Verify if it's trying to change an approved oppty with a generated proposal;
                // only fields "Fase" and "Data de fechamento" should be updatable for SIGGO oppties
                // and all fields for ADMIN/Supervisor
                if (!String.isEmpty(opp.Siggo_PersProp_NumeroProposta__c) && perfil != 'Administrador do sistema' && papel != 'SUPERVISOR SIGGO' && papel != 'Databasemkt' && 
                    UserInfo.getUserEmail() != Parametros_ORG__c.getOrgDefaults().Email_admin_comercial_1__c &&
                    UserInfo.getUserEmail() != Parametros_ORG__c.getOrgDefaults().Email_admin_comercial_2__c &&
                    (oldOpp.Siggo_AnalCred_ResultadoAnalise__c == 0 || oldOpp.Status_aprova_o_manual__c == 'Aprovada')){
                   if (papel == 'TELEVENDAS SIGGO' || Test.isRunningTest()){
                        if (oldOpp.RecordTypeId != opp.RecordTypeId || oldOpp.OwnerId != opp.OwnerId || oldOpp.Indicador__c != opp.Indicador__c || 
                         oldOpp.Motivo_de_n_o_venda__c != opp.Motivo_de_n_o_venda__c || oldOpp.Name != opp.Name || 
                         oldOpp.CampaignId != opp.CampaignId || oldOpp.Canal_de_entrada__c != opp.Canal_de_entrada__c || oldOpp.LeadSource != opp.LeadSource ||
                         oldOpp.AccountId != opp.AccountId || oldOpp.Siggo_TipoProposta__c != opp.Siggo_TipoProposta__c || oldOpp.Description != opp.Description ||
                         oldOpp.Forma_de_pagamento_instala_o__c != opp.Forma_de_pagamento_instala_o__c || oldOpp.Parcelamento_da_instala_o__c != opp.Parcelamento_da_instala_o__c ||
                            
                         (oldOpp.CartaoCredito_Numero_Cript__c != opp.CartaoCredito_Numero_Cript__c && 
                            opp.CartaoCredito_Numero_Cript__c != '') || 
                         (oldOpp.CartaoCredito_CodigoSeguranca_Cript__c != opp.CartaoCredito_CodigoSeguranca_Cript__c && 
                            opp.CartaoCredito_CodigoSeguranca_Cript__c != '') ||
                            
                         oldOpp.CartaoCredito_Vencimento__c != opp.CartaoCredito_Vencimento__c || 
                         oldOpp.Usar_dados_de_pagamento_da_instala_o__c != opp.Usar_dados_de_pagamento_da_instala_o__c ||
                         oldOpp.Forma_pagamento_monitoramento__c != opp.Forma_pagamento_monitoramento__c || 
                            
                         (oldOpp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c != opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c &&
                            opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c != '') ||
                         (oldOpp.C_d_de_Seg_do_C_de_Cr_dito_do_monit__c != opp.C_d_de_Seg_do_C_de_Cr_dito_do_monit__c &&
                            opp.C_d_de_Seg_do_C_de_Cr_dito_do_monit__c != '') ||
                            
                         oldOpp.Agencia_para_D_A_do_monitoramento__c != opp.Agencia_para_D_A_do_monitoramento__c || 
                         oldOpp.Conta_Corrente_para_DA_do_monitoramento__c != opp.Conta_Corrente_para_DA_do_monitoramento__c || 
                         oldOpp.Vcto_do_C_de_Cr_dito_do_monitoramento__c != opp.Vcto_do_C_de_Cr_dito_do_monitoramento__c || 
                         oldOpp.Nome_do_Tit_para_DA_do_monitoramento__c != opp.Nome_do_Tit_para_DA_do_monitoramento__c || oldOpp.ProfissaoProprietario__c != opp.ProfissaoProprietario__c ||
                         oldOpp.PEP1__c != opp.PEP1__c || oldOpp.PEP2__c != opp.PEP2__c || oldOpp.Valor_da_instala_o__c != opp.Valor_da_instala_o__c || 
                         oldOpp.Justificativa_an_lise_manual_cr_dito__c != opp.Justificativa_an_lise_manual_cr_dito__c) {
    
                        opp.addError('Você só pode modificar os campos FASE e DATA DE FECHAMENTO após gerar a proposta.');
                       }
                    } else {
                        opp.addError('Você não tem acesso a modificar uma oportunidade cuja proposta já foi gerada.');
                    }
                }
            }
            
            /* Verify it's starting a process after a return of 2 ("Em análise") 
            * in the automatic credit analysis process. */
            if (oldOpp.Siggo_AnalCred_ResultadoAnalise__c != 2 && opp.Siggo_AnalCred_ResultadoAnalise__c == 2)
                opp.Justificativa_an_lise_manual_cr_dito__c = 'Envio automático';
        
            // Verifies that it's trying to approve or deny the opportunity
            if (oldOpp.Status_aprova_o_manual__c == 'Em análise' && 
                (opp.Status_aprova_o_manual__c == 'Negada' || opp.Status_aprova_o_manual__c == 'Aprovada')) 
                    aprovacoes.put(opp.Id, opp); 
        }

        //Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
        if (!aprovacoes.isEmpty()) {
                
            // UPDATE 2/1/2014: Get the most recent approval process instance for the object.
            // If there are some approvals to be reviewed for approval, then
            // get the most recent process instance for each object.
            List<Id> processInstanceIds = new List<Id>();
            List<Opportunity> listaOppDAO = DAO_Oportunidade.getOportunidadesBySetId(aprovacoes.keySet());
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaOppDAO: '+ listaOppDAO);
            
            for(Opportunity opps : listaOppDAO) processInstanceIds.add(opps.ProcessInstances[0].Id);
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - processInstanceIds: '+ processInstanceIds);
          
            // Now that we have the most recent process instances, we can check
            // the most recent process steps for comments.  
            Set<Id> oppIdForResumoSet = new Set<Id>();
            
            for(Opportunity opp: pListaOpp) oppIdForResumoSet.add(opp.Id);
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - oppIdForResumoSet: '+ oppIdForResumoSet);
            
            Map<String, Resumo_analise_manual_oportunidade__c> mapResumo = new Map<String, Resumo_analise_manual_oportunidade__c>();
            
            List<Resumo_analise_manual_oportunidade__c> listaResumoAnaliseManualOppDAO = DAO_ResumoAnaliseManualOpp.getResumoAnaliseManualOppBySetId(oppIdForResumoSet);
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaResumoAnaliseManualOppDAO: '+ listaResumoAnaliseManualOppDAO);
            
            for(Resumo_analise_manual_oportunidade__c resumo : listaResumoAnaliseManualOppDAO) mapResumo.put(resumo.Oportunidade__c,resumo);
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - mapResumo: '+ mapResumo);

            List<ProcessInstance> listaProcessInstanceDAO = DAO_ProcessInstance.getProcessInstancesByListId(processInstanceIds);
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaProcessInstanceDAO: '+ listaProcessInstanceDAO);
            
            for (ProcessInstance pi : listaProcessInstanceDAO) {                 
                if ((pi.Steps[0].Comments == null || 
                    pi.Steps[0].Comments.trim().length() == 0)){
                    aprovacoes.get(pi.TargetObjectId).addError(
                      '<span style="text-weight:bold;size:20pt;color:red;">Ocorreu um erro, você deve preencher o campo de comentários.</span>');
                } else {
            
                    // Log the status change of approval in the custom object for reporting purposes
                    try{
                        Resumo_analise_manual_oportunidade__c resumo = mapResumo.get(aprovacoes.get(pi.TargetObjectId).Id);                   
                        resumo.Resultado_do_processo__c = aprovacoes.get(pi.TargetObjectId).Status_aprova_o_manual__c;
                        resumo.T_rmino_do_processo_em__c = DateTime.now();
                        resumo.Aprovador__c = UserInfo.getUserId();
                        update resumo;
                    }catch(Exception e){ /*needed to fix bug*/ }
                }
            }
        }
        //END Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
	}

	/*
		@description Ajusta o pagamento de produto seguro
		@param List<Opportunity> pListaOpp
		@return void
		
		@author Renan Rocha
	*/
	public static void pgtoProdutoSeguro(List<Opportunity> pListaOpp){
		String METHOD_NAME = 'pgtoProdutoSeguro';

		Map<Id,RecordType> tipoRegistro = new Map<Id,RecordType>();
	    
	    // Check the type of the records
	    for(Opportunity opp: pListaOpp) tipoRegistro.put(opp.RecordTypeId,null);
	    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - tipoRegistro.keySet(): '+ tipoRegistro.keySet());

	    List<RecordType> listaTipoRegistroDAO = DAO_Tipo_Registro.getTiposRegistroBySetId(tipoRegistro.keySet());
	    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaTipoRegistroDAO: '+ listaTipoRegistroDAO);
	    
	    for(RecordType rt : listaTipoRegistroDAO) tipoRegistro.put(rt.Id, rt);
	    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - tipoRegistro: '+ tipoRegistro);
	
        Set<String> pgtosInstal = new Set<String>();
        Set<String> pgtosMonitoram = new Set<String>();
        
        // Get picklist values for payment methods
        Schema.DescribeFieldResult pgtoInstal = Opportunity.Forma_de_pagamento_instala_o__c.getDescribe();
        List<Schema.PicklistEntry> lsPgtoInstal = pgtoInstal.getPicklistValues();
        
        for (Schema.PicklistEntry itPgtoInstal : lsPgtoInstal) { 
            if (itPgtoInstal.getValue().contains('Boleto')) pgtosInstal.add(itPgtoInstal.getValue());
        }
        
        Schema.DescribeFieldResult pgtoMonitoram = Opportunity.Forma_pagamento_monitoramento__c.getDescribe();
        List<Schema.PicklistEntry> lsPgtoMonitoram = pgtoMonitoram.getPicklistValues();
        
        for (Schema.PicklistEntry itPgtoMonitoram : lsPgtoMonitoram) { 
            if (itPgtoMonitoram.getValue().contains('Cartão') || itPgtoMonitoram.getValue().contains('Débito')) pgtosMonitoram.add(itPgtoMonitoram.getValue());
        }
    
        for(Opportunity opp: pListaOpp) {

            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - opp.Total_Produtos_com_Seguro__c: '+ opp.Total_Produtos_com_Seguro__c);
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - tipoRegistro.get(opp.RecordTypeId).Name: '+ tipoRegistro.get(opp.RecordTypeId).Name);

            // Verifies if it's trying to pay for a product with insurance
            if (tipoRegistro.get(opp.RecordTypeId).Name == 'Siggo' && opp.Total_Produtos_com_Seguro__c > 0){

                System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - opp.Forma_de_pagamento_instala_o__c: '+ opp.Forma_de_pagamento_instala_o__c);
                System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - pgtosInstal: '+ pgtosInstal);
                System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - opp.Parcelamento_da_instala_o__c: '+ opp.Parcelamento_da_instala_o__c);
                System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - opp.Parcelamento_da_instala_o__c: '+ opp.Parcelamento_da_instala_o__c);
                
                // Enforces the rule for "instalação", paying with "boleto bancário": can only do one payment
                if (!String.isEmpty(opp.Forma_de_pagamento_instala_o__c) && pgtosInstal.contains(opp.Forma_de_pagamento_instala_o__c) && 
                    opp.Parcelamento_da_instala_o__c > 3 && opp.Parcelamento_da_instala_o__c < 1) {
                    opp.addError('Para produto com seguro, o pagamento com boleto bancário só pode ser em até 3 parcelas. Por favor, corrija e tente novamente.');
                }
                
                // Enforces the rule for "monitoramento": can only pay with "Cartão" or "Débito"
                if (/* Using "dados de pagamento da instalação" */ 
                    (opp.Usar_dados_de_pagamento_da_instala_o__c && !String.isEmpty(opp.Forma_de_pagamento_instala_o__c) && 
                    !pgtosMonitoram.contains(opp.Forma_de_pagamento_instala_o__c))
                    || 
                    /* NOT using "dados de pagamento da instalação" */
                    (!opp.Usar_dados_de_pagamento_da_instala_o__c && !pgtosMonitoram.contains(opp.Forma_pagamento_monitoramento__c))
                ) {
                    opp.addError('Para produto com seguro, selecione cartão de crédito ou débito automático como forma de pagamento do monitoramento.');
                }
            }
        }
	}

	/*
		@description Cria o resumo de análise manual da oportunidade
		@param List<Opportunity> pListaOpp, Map<Id, Opportunity> pOldMap
		@return void
		
		@author Renan Rocha
	*/
	public static void logApprovalProcess(List<Opportunity> pListaOpp, Map<Id, Opportunity> pOldMap){
		String METHOD_NAME = 'logApprovalProcess';
	
        Map<Id, Opportunity> aprovacoes = new Map<Id, Opportunity>{};
            
        //END Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
        Set<Id> OppIds = new Set<Id>();
        for(Opportunity opp: pListaOpp) {
            if(opp.Status_aprova_o_manual__c != null && opp.Status_aprova_o_manual__c != ''){
                OppIds.add(opp.Id);
            }
        }
        Map<Id,Resumo_analise_manual_oportunidade__c> mapResumos = new Map<Id,Resumo_analise_manual_oportunidade__c>();
        if(OppIds.size() > 0){
            for(Resumo_analise_manual_oportunidade__c resumo :[SELECT   Oportunidade__c, Resultado_do_processo__c
                                                               , T_rmino_do_processo_em__c, Aprovador__c
                                                               FROM Resumo_analise_manual_oportunidade__c
                                                               WHERE Oportunidade__c IN :OppIds]){
                                                                   mapResumos.put(resumo.Oportunidade__c,resumo);
                                                               }
        }
        //END Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
        
        for(Opportunity opp: pListaOpp) {
            Opportunity oldOpp = pOldMap.get(opp.Id);
            
            // Verify that it's starting a new approval process and inserts the value in the custom object
            if ((oldOpp.Status_aprova_o_manual__c == '' || oldOpp.Status_aprova_o_manual__c == 'Nova' || oldOpp.Status_aprova_o_manual__c == null) && 
                opp.Status_aprova_o_manual__c == 'Em análise'){
                    Resumo_analise_manual_oportunidade__c resumo = 
                        new Resumo_analise_manual_oportunidade__c(
                            Oportunidade__c = opp.Id,
                            Resultado_analise_automatica__c = opp.Siggo_AnalCred_ResultadoAnalise__c,
                            Resultado_do_processo__c = 'Em análise',
                            T_rmino_do_processo_em__c = DateTime.now(),
                            Aprovador__c = UserInfo.getUserId());
                    insert resumo;
                }
            
            if (oldOpp.Status_aprova_o_manual__c == 'Reiniciada' && opp.Status_aprova_o_manual__c == 'Em análise'){
                Resumo_analise_manual_oportunidade__c resumo = 
                    new Resumo_analise_manual_oportunidade__c(
                        Oportunidade__c = opp.Id,
                        Resultado_analise_automatica__c = opp.Siggo_AnalCred_ResultadoAnalise__c,
                        Resultado_do_processo__c = 'Em análise',
                        T_rmino_do_processo_em__c = DateTime.now(),
                        Aprovador__c = UserInfo.getUserId());
                insert resumo;
            }
            
            // Verify that it's recalling a approval process 
            if (oldOpp.Status_aprova_o_manual__c == 'Em análise' && opp.Status_aprova_o_manual__c == 'Recall'){
                //Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
                // Resumo_analise_manual_oportunidade__c resumo = 
                //  [SELECT Oportunidade__c, Resultado_do_processo__c, T_rmino_do_processo_em__c, Aprovador__c
                //     FROM Resumo_analise_manual_oportunidade__c WHERE Oportunidade__c = :opp.Id];
                if(mapResumos.containsKey(opp.Id)){
                    Resumo_analise_manual_oportunidade__c resumo = mapResumos.get(opp.Id);
                    resumo.Resultado_do_processo__c = 'Recall';
                    resumo.T_rmino_do_processo_em__c = DateTime.now();
                    resumo.Aprovador__c = UserInfo.getUserId();
                    update resumo;
                }
                //END Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
            }
            
            // Verify that it's starting a new approval process AFTER a recall
            if (oldOpp.Status_aprova_o_manual__c == 'Recall' && opp.Status_aprova_o_manual__c == 'Em análise'){
                //Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
                // Resumo_analise_manual_oportunidade__c resumo = 
                //  [SELECT Oportunidade__c, Resultado_do_processo__c, T_rmino_do_processo_em__c, Aprovador__c
                //     FROM Resumo_analise_manual_oportunidade__c WHERE Oportunidade__c = :opp.Id];
                if(mapResumos.containsKey(opp.Id)){
                    Resumo_analise_manual_oportunidade__c resumo = mapResumos.get(opp.Id);
                    resumo.Resultado_do_processo__c = 'Em análise';
                    resumo.T_rmino_do_processo_em__c = DateTime.now();
                    resumo.Aprovador__c = UserInfo.getUserId();
                    update resumo;
                }
                //END Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
            }
            
            // Verify it's trying again a denied process
            if (oldOpp.Status_aprova_o_manual__c == 'Negada' && opp.Status_aprova_o_manual__c == 'Em análise'){
                //Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
                // Resumo_analise_manual_oportunidade__c resumo = 
                //  [SELECT Oportunidade__c, Resultado_do_processo__c, T_rmino_do_processo_em__c, Aprovador__c
                //     FROM Resumo_analise_manual_oportunidade__c WHERE Oportunidade__c = :opp.Id];
                if(mapResumos.containsKey(opp.Id)){
                    Resumo_analise_manual_oportunidade__c resumo = mapResumos.get(opp.Id);
                    resumo.Resultado_do_processo__c = 'Em análise';
                    resumo.T_rmino_do_processo_em__c = DateTime.now();
                    resumo.Aprovador__c = UserInfo.getUserId();
                    update resumo;
                }
                //END Modification Carlos Prates - adjustment to avoid exception limit SOQL query - 29/07/2014
            }
            
            /* Verify it's starting a process after a return of 2 ("Em análise") 
             * in the automatic credit analysis process. */
            if (oldOpp.Siggo_AnalCred_ResultadoAnalise__c != 2 && opp.Siggo_AnalCred_ResultadoAnalise__c == 2) {
                
                // Resending to approval
                Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                req1.setComments('Envio automático.');
                req1.setObjectId(opp.Id);
                Approval.ProcessResult result = Approval.process(req1);
            }
        }
	}

	/*
		@description Abastece o histórico de detalhes
		@param List<Opportunity> pListaOpp, Boolean pIsInsert, Boolean pIsUpdate
		@return void
		
		@author Renan Rocha
	*/
	public static void abasteceHistoricoDetalhes(List<Opportunity> pListaOppNew, List<Opportunity> pListaOppOld, Boolean pIsInsert, Boolean pIsUpdate){
		String METHOD_NAME = 'abasteceHistoricoDetalhes';

        List<Opportunity> lstOpp = new List<Opportunity>();
        
        if(pIsInsert){
            for(Opportunity o : pListaOppNew){
                if(o.IdLeadForOpp__c != null) lstOpp.add(o);
            }
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - lstOpp: '+ lstOpp);
            
            if(lstOpp.size() > 0) OpportunityTriggers.ImportaHistoricoDetalhes(lstOpp);
        }
        
        if(pIsUpdate){
            Map<String,String> mapNew = new Map<String, String>();
            for(Opportunity o : pListaOppNew) mapNew.put(o.Id, o.Description);
        	System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - mapNew: '+ mapNew);

            if(lstOpp.size() > 0) lstOpp.clear();
            
            for(Opportunity o : pListaOppOld){
                if(mapNew.containsKey(o.Id)){
                    if(mapNew.get(o.Id) != o.description && o.description != null) lstOpp.add(o);
                }
            }

            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - lstOpp: '+ lstOpp);

            if(lstOpp.size() > 0) OpportunityTriggers.AbasteceHistoricoDetalhes(lstOpp);
        }
	}
}