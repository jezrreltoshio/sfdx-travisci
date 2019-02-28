public class OpportunityBandeiraCartao {
    //STI 86376 - Inclusao Bandeira Hipercard
    //Verifica a bandeira do cartão atraves do numero do mesmo e seleciona a bandeira no picklist
	public static void setBandeiraCartao(Opportunity opp){
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
	}
}