public class AccountBandeiraCartao {
    //STI 86376 - Inclusao Bandeira Hipercard
    //Verifica a bandeira do cartão atraves do numero do mesmo e seleciona a bandeira no picklist
	public static void setBandeiraCartao(Account acc){
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
	}
}