@isTest
private class AccountBandeiraCartaoTest {
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
		
		//Visa
		Pattern pVisa = Pattern.compile('(4[0-9]{12}(?:[0-9]{3}))');
		//Mastercard
		Pattern pMastercard = Pattern.compile('(5[1-5][0-9]{14})');
		//Hipercard
		Pattern pHipercard = Pattern.compile('(606282[0-9]{7,13}|3841[0-9]{9,15})');
	
		if(acc.Cobranca_Cartao_Numero_Cript__c != null){
			//Numero do cartao
			String card = (String) acc.Cobranca_Cartao_Numero_Cript__c;
			
			//Valida no pattern
			Matcher mVisa = pVisa.matcher(card);		
			Matcher mMastercard = pMastercard.matcher(card);		
			Matcher mHipercard = pHipercard.matcher(card);
			
			if(mVisa.matches()){
				acc.Tipo_cartao__c = 'Visa';
				acc.FormaCobranca__c = '24-Cartão Visa';
				acc.Dia_de_vencimento__c = '16';
			} else if(mMastercard.matches()){
				acc.Tipo_cartao__c = 'Mastercard';
				acc.FormaCobranca__c = '25-Cartão Mastercard';
				acc.Dia_de_vencimento__c = '16';
			} else if(mHipercard.matches()){
				acc.Tipo_cartao__c = 'Hipercard';
				acc.FormaCobranca__c = '82-Cartão Hipercard';
				acc.Dia_de_vencimento__c = '16';
			}
		}
		
		insert acc;
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
		
		//Visa
		Pattern pVisa = Pattern.compile('(4[0-9]{12}(?:[0-9]{3}))');
		//Mastercard
		Pattern pMastercard = Pattern.compile('(5[1-5][0-9]{14})');
		//Hipercard
		Pattern pHipercard = Pattern.compile('(606282[0-9]{7,13}|3841[0-9]{9,15})');
	
		if(acc.Cobranca_Cartao_Numero_Cript__c != null){
			//Numero do cartao
			String card = (String) acc.Cobranca_Cartao_Numero_Cript__c;
			
			//Valida no pattern
			Matcher mVisa = pVisa.matcher(card);		
			Matcher mMastercard = pMastercard.matcher(card);		
			Matcher mHipercard = pHipercard.matcher(card);
			
			if(mVisa.matches()){
				acc.Tipo_cartao__c = 'Visa';
				acc.FormaCobranca__c = '24-Cartão Visa';
				acc.Dia_de_vencimento__c = '16';
			} else if(mMastercard.matches()){
				acc.Tipo_cartao__c = 'Mastercard';
				acc.FormaCobranca__c = '25-Cartão Mastercard';
				acc.Dia_de_vencimento__c = '16';
			} else if(mHipercard.matches()){
				acc.Tipo_cartao__c = 'Hipercard';
				acc.FormaCobranca__c = '82-Cartão Hipercard';
				acc.Dia_de_vencimento__c = '16';
			}
		}
		
		insert acc;
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
		
		//Visa
		Pattern pVisa = Pattern.compile('(4[0-9]{12}(?:[0-9]{3}))');
		//Mastercard
		Pattern pMastercard = Pattern.compile('(5[1-5][0-9]{14})');
		//Hipercard
		Pattern pHipercard = Pattern.compile('(606282[0-9]{7,13}|3841[0-9]{9,15})');
	
		if(acc.Cobranca_Cartao_Numero_Cript__c != null){
			//Numero do cartao
			String card = (String) acc.Cobranca_Cartao_Numero_Cript__c;
			
			//Valida no pattern
			Matcher mVisa = pVisa.matcher(card);		
			Matcher mMastercard = pMastercard.matcher(card);		
			Matcher mHipercard = pHipercard.matcher(card);
			
			if(mVisa.matches()){
				acc.Tipo_cartao__c = 'Visa';
				acc.FormaCobranca__c = '24-Cartão Visa';
				acc.Dia_de_vencimento__c = '16';
			} else if(mMastercard.matches()){
				acc.Tipo_cartao__c = 'Mastercard';
				acc.FormaCobranca__c = '25-Cartão Mastercard';
				acc.Dia_de_vencimento__c = '16';
			} else if(mHipercard.matches()){
				acc.Tipo_cartao__c = 'Hipercard';
				acc.FormaCobranca__c = '82-Cartão Hipercard';
				acc.Dia_de_vencimento__c = '16';
			}
		}
		
		insert acc;
		test.stopTest();
	}
}