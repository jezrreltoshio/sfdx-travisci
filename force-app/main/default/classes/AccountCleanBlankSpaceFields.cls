public class AccountCleanBlankSpaceFields {
	/**
 	 * [MANTIS 7650] - ERRO AO SINCRONIZAR CONTA
 	 * Remove os espaços em brancos dos campos, pois ao enviar com o espaço em branco, o WS_Salesforce
 	 * retorna o seguinte erro: [-1400] String is not in UTF-8. Trigger executada before insert, before update.
 	 * @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
 	 * @sinze 05/10/2015
 	 */
	public static void cleanBlankSpaceFields(Account acc){
		try{
			//Aplicando .trim() para remover espaços em branco
			//no início e final do texto
			
			//CAMPOS UTILIZADOS NO LAYOUT SIGGO
			if(acc.Name != null) acc.Name = acc.Name.trim();
			if(acc.DadosPF_RG__c != null) acc.DadosPF_RG__c = acc.DadosPF_RG__c.trim();
			if(acc.CPF__c != null) acc.CPF__c = acc.CPF__c.trim();
			if(acc.DadosPF_NomeMae__c != null) acc.DadosPF_NomeMae__c = acc.DadosPF_NomeMae__c.trim();
			if(acc.Phone != null) acc.Phone = acc.Phone.trim();
			if(acc.TelefoneCelular__c != null) acc.TelefoneCelular__c = acc.TelefoneCelular__c.trim();
			if(acc.EMailNFE__c != null) acc.EMailNFE__c = acc.EMailNFE__c.trim();
			if(acc.EMail__c != null) acc.EMail__c = acc.EMail__c.trim();
			if(acc.Enderecos_Cobranca_Logradouro__c != null) acc.Enderecos_Cobranca_Logradouro__c = acc.Enderecos_Cobranca_Logradouro__c.trim();
			if(acc.Enderecos_Entrega_Logradouro__c != null) acc.Enderecos_Entrega_Logradouro__c = acc.Enderecos_Entrega_Logradouro__c.trim();
			if(acc.Enderecos_Principal_Logradouro__c != null) acc.Enderecos_Principal_Logradouro__c = acc.Enderecos_Principal_Logradouro__c.trim();
			if(acc.Enderecos_Cobranca_Complemento__c != null) acc.Enderecos_Cobranca_Complemento__c = acc.Enderecos_Cobranca_Complemento__c.trim();
			if(acc.Enderecos_Entrega_Complemento__c != null) acc.Enderecos_Entrega_Complemento__c = acc.Enderecos_Entrega_Complemento__c.trim();
			if(acc.Enderecos_Principal_Complemento__c != null) acc.Enderecos_Principal_Complemento__c = acc.Enderecos_Principal_Complemento__c.trim();
			if(acc.Enderecos_Cobranca_Bairro__c != null) acc.Enderecos_Cobranca_Bairro__c = acc.Enderecos_Cobranca_Bairro__c.trim();
			if(acc.Enderecos_Entrega_Bairro__c != null) acc.Enderecos_Entrega_Bairro__c = acc.Enderecos_Entrega_Bairro__c.trim();
			if(acc.Enderecos_Principal_Bairro__c != null) acc.Enderecos_Principal_Bairro__c = acc.Enderecos_Principal_Bairro__c.trim();
			if(acc.Enderecos_Cobranca_Cidade__c != null) acc.Enderecos_Cobranca_Cidade__c = acc.Enderecos_Cobranca_Cidade__c.trim();
			if(acc.Enderecos_Entrega_Cidade__c != null) acc.Enderecos_Entrega_Cidade__c = acc.Enderecos_Entrega_Cidade__c.trim();
			if(acc.Enderecos_Principal_Cidade__c != null) acc.Enderecos_Principal_Cidade__c = acc.Enderecos_Principal_Cidade__c.trim();
			if(acc.Cobranca_Cartao_Vcto__c != null) acc.Cobranca_Cartao_Vcto__c = acc.Cobranca_Cartao_Vcto__c.trim();			
			if(acc.Cobranca_Cartao_Numero_Cript__c != null) acc.Cobranca_Cartao_Numero_Cript__c = acc.Cobranca_Cartao_Numero_Cript__c.trim();
			if(acc.Cobranca_Cartao_CodigoSeguranca_Cript__c != null) acc.Cobranca_Cartao_CodigoSeguranca_Cript__c = acc.Cobranca_Cartao_CodigoSeguranca_Cript__c.trim();
			if(acc.Agencia__c != null) acc.Agencia__c = acc.Agencia__c.trim();
			if(acc.DebAut_NomeTitular__c != null) acc.DebAut_NomeTitular__c = acc.DebAut_NomeTitular__c.trim();
			if(acc.Conta__c != null) acc.Conta__c = acc.Conta__c.trim();
										
		} catch(System.NullPointerException e){
			System.debug('Account - NullPointerException: '+ e);
		}
    }
}