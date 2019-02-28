@isTest
private class OpportunityBandeiraCartaoTest {
	//Cartao Visa
	static testMethod void setBandeiraCartaoVisa(){
		test.startTest();
		
		Account acc = new Account();
		acc.Name = 'Cartao Visa';
		acc.Type = 'Novo Cliente';
		acc.CNPJ__c = '08.754.507/0001-42';
		acc.Phone = '(41) 3299-6159';
		acc.Telefone_2__c = '(41) 3299-6159';
		acc.Telefone_2__c = '(41) 3299-6159';
		acc.Regional__c = 'SUL';
		acc.Tipo_de_pessoa__c = 'J-Jurídica';
		acc.Cobranca_Cartao_Numero_Cript__c = '4929221255069033'; //Visa
		insert acc;
		
		Opportunity opp = new Opportunity();
		opp.Name = 'Opp Cartao Visa';
		opp.CartaoCredito_Numero_Cript__c = '4929221255069033'; //Visa
		opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c = '4929221255069033'; //Visa
		opp.Account = acc;
		opp.ProfissaoProprietario__c = '2-Advogado';
		opp.Canal_de_entrada__c = 'Ativo';
		opp.LeadSource = 'Chat Siggo';
		opp.Origem_Lead_Agrupado__c = 'Chat Siggo';
		opp.Parcelamento_da_instala_o__c = 2;
		opp.StageName = 'Abordagem inicial';
		opp.CloseDate = Date.today();
		opp.Siggo_TipoProposta__c = '14-Televendas';
		
		//Visa
		Pattern pVisa = Pattern.compile('(4[0-9]{12}(?:[0-9]{3}))');
		//Mastercard
		Pattern pMastercard = Pattern.compile('(5[1-5][0-9]{14})');
		//Hipercard
		Pattern pHipercard = Pattern.compile('(606282[0-9]{7,13}|3841[0-9]{9,15})');
	
		//Instalacao - Siggo
		if(opp.CartaoCredito_Numero_Cript__c != null){
			//Numero do cartao
			String card = (String) opp.CartaoCredito_Numero_Cript__c;
			
			//Valida no pattern
			Matcher mVisa = pVisa.matcher(card);		
			Matcher mMastercard = pMastercard.matcher(card);		
			Matcher mHipercard = pHipercard.matcher(card);
			
			if(mVisa.matches()){
				opp.Forma_de_pagamento_instala_o__c = '24-Cartão Visa';
			} else if(mMastercard.matches()){
				opp.Forma_de_pagamento_instala_o__c = '25-Cartão Mastercard';
			} else if(mHipercard.matches()){
				opp.Forma_de_pagamento_instala_o__c = '82-Cartão Hipercard';
			}
		}
		
		
		//Monitoramento - Siggo
		if(opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c != null){
			//Numero do cartao
			String card = (String) opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c;
			
			//Valida no pattern
			Matcher mVisa = pVisa.matcher(card);		
			Matcher mMastercard = pMastercard.matcher(card);		
			Matcher mHipercard = pHipercard.matcher(card);
			
			if(mVisa.matches()){
				opp.Forma_pagamento_monitoramento__c = '24-Cartão Visa';
                opp.Dia_vcto_monitoramento__c = '16';
			} else if(mMastercard.matches()){
				opp.Forma_pagamento_monitoramento__c = '25-Cartão Mastercard';
                opp.Dia_vcto_monitoramento__c = '16';
			} else if(mHipercard.matches()){
				opp.Forma_pagamento_monitoramento__c = '82-Cartão Hipercard';
                opp.Dia_vcto_monitoramento__c = '16';
			}
		}
		
		insert opp;
		test.stopTest();
	}
	
	//Cartao Mastercard
	static testMethod void setBandeiraCartaoMastercard(){
		test.startTest();
		
		Account acc = new Account();
		acc.Name = 'Cartao Mastercard';
		acc.Type = 'Novo Cliente';
		acc.CNPJ__c = '66.470.705/0001-80';
		acc.Phone = '(41) 3299-6159';
		acc.Telefone_2__c = '(41) 3299-6159';
		acc.Telefone_2__c = '(41) 3299-6159';
		acc.Regional__c = 'SUL';
		acc.Tipo_de_pessoa__c = 'J-Jurídica';
		acc.Cobranca_Cartao_Numero_Cript__c = '5520069124934485'; //Mastercard		
		insert acc;
		
		Opportunity opp = new Opportunity();
		opp.Name = 'Opp Cartao Visa';
		opp.CartaoCredito_Numero_Cript__c = '5520069124934485'; //Mastercard		
		opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c = '5520069124934485'; //Mastercard		
		opp.Account = acc;
		opp.ProfissaoProprietario__c = '2-Advogado';
		opp.Canal_de_entrada__c = 'Ativo';
		opp.LeadSource = 'Chat Siggo';
		opp.Origem_Lead_Agrupado__c = 'Chat Siggo';
		opp.Parcelamento_da_instala_o__c = 2;
		opp.StageName = 'Abordagem inicial';
		opp.CloseDate = Date.today();
		opp.Siggo_TipoProposta__c = '14-Televendas';
		
		//Visa
		Pattern pVisa = Pattern.compile('(4[0-9]{12}(?:[0-9]{3}))');
		//Mastercard
		Pattern pMastercard = Pattern.compile('(5[1-5][0-9]{14})');
		//Hipercard
		Pattern pHipercard = Pattern.compile('(606282[0-9]{7,13}|3841[0-9]{9,15})');
	
		//Instalacao - Siggo
		if(opp.CartaoCredito_Numero_Cript__c != null){
			//Numero do cartao
			String card = (String) opp.CartaoCredito_Numero_Cript__c;
			
			//Valida no pattern
			Matcher mVisa = pVisa.matcher(card);		
			Matcher mMastercard = pMastercard.matcher(card);		
			Matcher mHipercard = pHipercard.matcher(card);
			
			if(mVisa.matches()){
				opp.Forma_de_pagamento_instala_o__c = '24-Cartão Visa';
			} else if(mMastercard.matches()){
				opp.Forma_de_pagamento_instala_o__c = '25-Cartão Mastercard';
			} else if(mHipercard.matches()){
				opp.Forma_de_pagamento_instala_o__c = '82-Cartão Hipercard';
			}
		}
		
		
		//Monitoramento - Siggo
		if(opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c != null){
			//Numero do cartao
			String card = (String) opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c;
			
			//Valida no pattern
			Matcher mVisa = pVisa.matcher(card);		
			Matcher mMastercard = pMastercard.matcher(card);		
			Matcher mHipercard = pHipercard.matcher(card);
			
			if(mVisa.matches()){
				opp.Forma_pagamento_monitoramento__c = '24-Cartão Visa';
                opp.Dia_vcto_monitoramento__c = '16';
			} else if(mMastercard.matches()){
				opp.Forma_pagamento_monitoramento__c = '25-Cartão Mastercard';
                opp.Dia_vcto_monitoramento__c = '16';
			} else if(mHipercard.matches()){
				opp.Forma_pagamento_monitoramento__c = '82-Cartão Hipercard';
                opp.Dia_vcto_monitoramento__c = '16';
			}
		}
		
		insert opp;
		test.stopTest();
	}
	
	//Cartao Hipercard
	static testMethod void setBandeiraCartaoHipercard(){
		test.startTest();
		
		Account acc = new Account();
		acc.Name = 'Cartao Hipercard';
		acc.Type = 'Novo Cliente';
		acc.CNPJ__c = '36.107.535/0001-03';
		acc.Phone = '(41) 3299-6159';
		acc.Telefone_2__c = '(41) 3299-6159';
		acc.Telefone_2__c = '(41) 3299-6159';
		acc.Regional__c = 'SUL';
		acc.Tipo_de_pessoa__c = 'J-Jurídica';
		//acc.Cobranca_Cartao_Numero_Cript__c = '6062824055364306'; //Hipercard
		acc.Cobranca_Cartao_Numero_Cript__c = '3841001111222233334'; //Hipercard
		insert acc;
		
		Opportunity opp = new Opportunity();
		opp.Name = 'Opp Cartao Visa';
		opp.CartaoCredito_Numero_Cript__c = '3841001111222233334'; //Hipercard		
		opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c = '3841001111222233334'; //Hipercard	
		opp.Account = acc;
		opp.ProfissaoProprietario__c = '2-Advogado';
		opp.Canal_de_entrada__c = 'Ativo';
		opp.LeadSource = 'Chat Siggo';
		opp.Origem_Lead_Agrupado__c = 'Chat Siggo';
		opp.Parcelamento_da_instala_o__c = 2;
		opp.StageName = 'Abordagem inicial';
		opp.CloseDate = Date.today();
		opp.Siggo_TipoProposta__c = '14-Televendas';
		
		//Visa
		Pattern pVisa = Pattern.compile('(4[0-9]{12}(?:[0-9]{3}))');
		//Mastercard
		Pattern pMastercard = Pattern.compile('(5[1-5][0-9]{14})');
		//Hipercard
		Pattern pHipercard = Pattern.compile('(606282[0-9]{7,13}|3841[0-9]{9,15})');
	
		//Instalacao - Siggo
		if(opp.CartaoCredito_Numero_Cript__c != null){
			//Numero do cartao
			String card = (String) opp.CartaoCredito_Numero_Cript__c;
			
			//Valida no pattern
			Matcher mVisa = pVisa.matcher(card);		
			Matcher mMastercard = pMastercard.matcher(card);		
			Matcher mHipercard = pHipercard.matcher(card);
			
			if(mVisa.matches()){
				opp.Forma_de_pagamento_instala_o__c = '24-Cartão Visa';
			} else if(mMastercard.matches()){
				opp.Forma_de_pagamento_instala_o__c = '25-Cartão Mastercard';
			} else if(mHipercard.matches()){
				opp.Forma_de_pagamento_instala_o__c = '82-Cartão Hipercard';
			}
		}
		
		
		//Monitoramento - Siggo
		if(opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c != null){
			//Numero do cartao
			String card = (String) opp.N_mero_do_C_de_Cr_dito_do_Monitoramento__c;
			
			//Valida no pattern
			Matcher mVisa = pVisa.matcher(card);		
			Matcher mMastercard = pMastercard.matcher(card);		
			Matcher mHipercard = pHipercard.matcher(card);
			
			if(mVisa.matches()){
				opp.Forma_pagamento_monitoramento__c = '24-Cartão Visa';
                opp.Dia_vcto_monitoramento__c = '16';
			} else if(mMastercard.matches()){
				opp.Forma_pagamento_monitoramento__c = '25-Cartão Mastercard';
                opp.Dia_vcto_monitoramento__c = '16';
			} else if(mHipercard.matches()){
				opp.Forma_pagamento_monitoramento__c = '82-Cartão Hipercard';
                opp.Dia_vcto_monitoramento__c = '16';
			}
		}
		
		insert opp;
		test.stopTest();
	}
}