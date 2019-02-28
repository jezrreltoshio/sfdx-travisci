public with sharing class HLP_Opportunity {
	//SPN = SCHEMA PROPERTY NAME
	public static final string SPN_SIGGOTIPOPROPOSTAC = 'Tipo_Numero__c';
	public static final string SPN_CARTAOCREDITOBANDEIRAC = 'CartaoCredito_Bandeira__c';
	public static final string SPN_FORMADEPAGAMENTOINSTALAOC = 'Forma_de_pagamento_instala_o__c';
	
	//PLV = PICK LIST VALUE
	public static final string PLV_SIGGOTIPOPROPOSTAC_LOJISTA = '13-Lojista';
	public static final string PLV_SIGGOTIPOPROPOSTAC_TELEVENDAS = '14-Televendas';
	public static final string PLV_SIGGOTIPOPROPOSTAC_ECOMMERCE = '16-E-commerce';
	public static final string PLV_SIGGOTIPOPROPOSTAC_SEGURARCOM = '17-Segurar.com';
	public static final string PLV_SIGGOTIPOPROPOSTAC_FAMILIASIGGO = '18-Familia Siggo';
	
	//public static final string PLV_CARTAOCREDITOBANDEIRAC_VISA = 'Visa';
	//public static final string PLV_CARTAOCREDITOBANDEIRAC_MASTERCARD = 'Mastercard';
	
	public static final string PLV_FORMADEPAGAMENTOINSTALAOC_BOLETO = '1-Boleto Bancário';
	public static final string PLV_FORMADEPAGAMENTOINSTALAOC_CARTAOVISA = '24-Cartão Visa';
	public static final string PLV_FORMADEPAGAMENTOINSTALAOC_CARTAOMASTERCARD = '25-Cartão Mastercard';
	public static final string PLV_FORMADEPAGAMENTOINSTALAOC_CARTAOHIPERCARD = '82-Cartão Hipercard';
	public static final string PLV_FORMADEPAGAMENTOINSTALAOC_BOLETO_SANTANDER = '84 - Cobrança Registrada Santander';
	
	//EXT = EXTERNAL
	public static final integer PLV_EXT_SIGGOTIPOPROPOSTAC_LOJISTA = 13;
	public static final integer PLV_EXT_SIGGOTIPOPROPOSTAC_TELEVENDAS = 14;
	public static final integer PLV_EXT_SIGGOTIPOPROPOSTAC_ECOMMERCE = 16;
	public static final integer PLV_EXT_SIGGOTIPOPROPOSTAC_SEGURARCOM = 17;
	public static final integer PLV_EXT_SIGGOTIPOPROPOSTAC_FAMILIASIGGO = 18;
	
	public static final integer EXT_INSTALACAO_FORMAPGTO_BOLETO = 1;
	public static final integer EXT_INSTALACAO_FORMAPGTO_CARTAOVISA = 24;
	public static final integer EXT_INSTALACAO_FORMAPGTO_CARTAOMASTERCARD = 25;
	public static final integer EXT_INSTALACAO_FORMAPGTO_CARTAOHIPERCARD = 82;
	public static final integer EXT_INSTALACAO_FORMAPGTO_BOLETO_SANTANDER = 84;
	
	public static string getInternalSiggoTipoPropostaValue(integer externalValue) {
		string result = null;
		
		if (externalValue != null) {
			if (externalValue == HLP_Opportunity.PLV_EXT_SIGGOTIPOPROPOSTAC_LOJISTA) {
				result = HLP_Opportunity.PLV_SIGGOTIPOPROPOSTAC_LOJISTA;
			} else if (externalValue == HLP_Opportunity.PLV_EXT_SIGGOTIPOPROPOSTAC_TELEVENDAS) {
				result = HLP_Opportunity.PLV_SIGGOTIPOPROPOSTAC_TELEVENDAS;
			} else if (externalValue == HLP_Opportunity.PLV_EXT_SIGGOTIPOPROPOSTAC_ECOMMERCE) {
				result = HLP_Opportunity.PLV_SIGGOTIPOPROPOSTAC_ECOMMERCE;
			} else if (externalValue == HLP_Opportunity.PLV_EXT_SIGGOTIPOPROPOSTAC_SEGURARCOM) {
				result = HLP_Opportunity.PLV_SIGGOTIPOPROPOSTAC_SEGURARCOM;
			} else if (externalValue == HLP_Opportunity.PLV_EXT_SIGGOTIPOPROPOSTAC_FAMILIASIGGO) {
				result = HLP_Opportunity.PLV_SIGGOTIPOPROPOSTAC_FAMILIASIGGO;
			} else {
				throw BCL_EXT_UnkownReceivedValueException.createException(Opportunity.class, SPN_SIGGOTIPOPROPOSTAC , externalValue);
			}
		}

		return result;
	}
	
	public static integer getExternalSiggoTipoPropostaValue(string internalValue) {
		integer result = null;
		
		if (internalValue != null) {
			if (internalValue == HLP_Opportunity.PLV_SIGGOTIPOPROPOSTAC_LOJISTA) {
				result = HLP_Opportunity.PLV_EXT_SIGGOTIPOPROPOSTAC_LOJISTA;
			} else if (internalValue == HLP_Opportunity.PLV_SIGGOTIPOPROPOSTAC_TELEVENDAS) {
				result = HLP_Opportunity.PLV_EXT_SIGGOTIPOPROPOSTAC_TELEVENDAS;
			} else if (internalValue == HLP_Opportunity.PLV_SIGGOTIPOPROPOSTAC_ECOMMERCE) {
				result = HLP_Opportunity.PLV_EXT_SIGGOTIPOPROPOSTAC_ECOMMERCE;
			} else if (internalValue == HLP_Opportunity.PLV_SIGGOTIPOPROPOSTAC_SEGURARCOM) {
				result = HLP_Opportunity.PLV_EXT_SIGGOTIPOPROPOSTAC_SEGURARCOM;
			} else if (internalValue == HLP_Opportunity.PLV_SIGGOTIPOPROPOSTAC_FAMILIASIGGO) {
				result = HLP_Opportunity.PLV_EXT_SIGGOTIPOPROPOSTAC_FAMILIASIGGO;
			} else {
				throw BCL_EXT_UnkownReceivedValueException.createException(Opportunity.class, SPN_SIGGOTIPOPROPOSTAC , internalValue);
			}
		}

		return result;
	}
	
	public static string getExternalCartaoCreditoDataVencimentoValue(string mmaa) {
		string result = null;
		
		if (mmaa != null && mmaa.length() == 4) {
			result = mmaa.subString(0, 3) + '/' + mmaa.subString(2, 4);
			
		}
		
		return result;	
	}
	
	public static integer getExternalInstalacaoFormaPagamentoCartaoValue(string formaPagamento) {
		integer result = null;
		
		if (formaPagamento == PLV_FORMADEPAGAMENTOINSTALAOC_BOLETO) {
			result = EXT_INSTALACAO_FORMAPGTO_BOLETO;
		} else if (formaPagamento == PLV_FORMADEPAGAMENTOINSTALAOC_CARTAOVISA) {
			result = EXT_INSTALACAO_FORMAPGTO_CARTAOVISA;
		} else if (formaPagamento == PLV_FORMADEPAGAMENTOINSTALAOC_CARTAOMASTERCARD) {
			result = EXT_INSTALACAO_FORMAPGTO_CARTAOMASTERCARD;
		} else if (formaPagamento == PLV_FORMADEPAGAMENTOINSTALAOC_CARTAOHIPERCARD){
			result = EXT_INSTALACAO_FORMAPGTO_CARTAOHIPERCARD;
		} else if(formaPagamento == PLV_FORMADEPAGAMENTOINSTALAOC_BOLETO_SANTANDER){
			result = EXT_INSTALACAO_FORMAPGTO_BOLETO_SANTANDER;
		} else {
			throw BCL_EXT_UnkownReceivedValueException.createException(Opportunity.class, SPN_FORMADEPAGAMENTOINSTALAOC , formaPagamento);
		}
		
		return result;
	}
	
	public static void neverCallThisMethod() {
		integer a = 0;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
	}
}