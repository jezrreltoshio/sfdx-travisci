/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class AccountCleanBlankSpaceFieldsTest {

    /**
 	 * [MANTIS 7650] - ERRO AO SINCRONIZAR CONTA
 	 * Remove os espaços em brancos dos campos, pois ao enviar com o espaço em branco, o WS_Salesforce
 	 * retorna o seguinte erro: [-1400] String is not in UTF-8. Trigger executada before insert, before update.
 	 * @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
 	 * @sinze 07/10/2015
 	 */
	static testMethod void cleanBlankSpaceFieldsInsert(){
		test.startTest();
		
		Account acc = new Account();
		acc.Name = ' Bruno ';
		acc.DadosPF_RG__c = ' 502940955';		
		acc.CPF__c = ' 465.462.531-35 ';
		acc.DadosPF_NomeMae__c = ' Mãe do Bruno ';
		acc.Phone = ' (41) 3299-6159 ';
		acc.TelefoneCelular__c = ' (41) 3299-6159 ';
		acc.EMailNFE__c = ' bruno@bruno.test ';
		acc.EMail__c = ' bruno@bruno.test';
		acc.Enderecos_Cobranca_Logradouro__c = ' Rua Tent. Djalma Dutra ';		
		acc.Enderecos_Entrega_Logradouro__c = ' Rua Tent. Djalma Dutra ';
		acc.Enderecos_Principal_Logradouro__c = ' Rua Tent. Djalma Dutra ';
		acc.Enderecos_Cobranca_Complemento__c = ' Anexo ao Bradesco ';
		acc.Enderecos_Entrega_Complemento__c = ' Anexo ao Bradesco ';
		acc.Enderecos_Principal_Complemento__c = ' Anexo ao Bradesco ';
		acc.Enderecos_Cobranca_Bairro__c = ' Centro ';
		acc.Enderecos_Entrega_Bairro__c = ' Centro ';
		acc.Enderecos_Principal_Bairro__c = ' Centro ';
		acc.Enderecos_Cobranca_Cidade__c = ' Sao Jose dos Pinhais ';
		acc.Enderecos_Entrega_Cidade__c = ' Sao Jose dos Pinhais ';
		acc.Enderecos_Principal_Cidade__c = ' Sao Jose dos Pinhais ';
		acc.Cobranca_Cartao_Vcto__c = ' 1221 ';
		acc.Cobranca_Cartao_Numero_Cript__c = '6053599156877892';
		acc.Cobranca_Cartao_CodigoSeguranca_Cript__c = ' 001 ';
		acc.Agencia__c = ' 3959 ';
		acc.DebAut_NomeTitular__c = ' Bruno ';
		acc.Conta__c = ' 597959 ';
				
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
			
			insert acc;
										
		} catch(System.NullPointerException e){
			System.debug('Account - NullPointerException: '+ e);
		}
		
		test.stopTest();
    }
    
    /**
 	 * [MANTIS 7650] - ERRO AO SINCRONIZAR CONTA
 	 * Remove os espaços em brancos dos campos, pois ao enviar com o espaço em branco, o WS_Salesforce
 	 * retorna o seguinte erro: [-1400] String is not in UTF-8. Trigger executada before insert, before update.
 	 * @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
 	 * @sinze 07/10/2015
 	 */
	static testMethod void cleanBlankSpaceFieldsUpdate(){
		test.startTest();
		
		Account acc = new Account();
		acc.Name = ' Bruno ';
		acc.DadosPF_RG__c = ' 502940955';		
		acc.CPF__c = ' 465.462.531-35 ';
		acc.DadosPF_NomeMae__c = ' Mãe do Bruno ';
		acc.Phone = ' (41) 3299-6159 ';
		acc.TelefoneCelular__c = ' (41) 3299-6159 ';
		acc.EMailNFE__c = ' bruno@bruno.test ';
		acc.EMail__c = ' bruno@bruno.test ';
		acc.Enderecos_Cobranca_Logradouro__c = ' Rua Tent. Djalma Dutra ';		
		acc.Enderecos_Entrega_Logradouro__c = ' Rua Tent. Djalma Dutra ';
		acc.Enderecos_Principal_Logradouro__c = ' Rua Tent. Djalma Dutra ';
		acc.Enderecos_Cobranca_Complemento__c = ' Anexo ao Bradesco ';
		acc.Enderecos_Entrega_Complemento__c = ' Anexo ao Bradesco ';
		acc.Enderecos_Principal_Complemento__c = ' Anexo ao Bradesco ';
		acc.Enderecos_Cobranca_Bairro__c = ' Centro ';
		acc.Enderecos_Entrega_Bairro__c = ' Centro ';
		acc.Enderecos_Principal_Bairro__c = ' Centro ';
		acc.Enderecos_Cobranca_Cidade__c = ' Sao Jose dos Pinhais ';
		acc.Enderecos_Entrega_Cidade__c = ' Sao Jose dos Pinhais ';
		acc.Enderecos_Principal_Cidade__c = ' Sao Jose dos Pinhais ';
		acc.Cobranca_Cartao_Vcto__c = ' 1221 ';
		acc.Cobranca_Cartao_Numero_Cript__c = '6053599156877892';
		acc.Cobranca_Cartao_CodigoSeguranca_Cript__c = ' 001 ';
		acc.Agencia__c = ' 3959 ';
		acc.DebAut_NomeTitular__c = ' Bruno ';
		acc.Conta__c = ' 597959 ';
		
		insert acc;
		
		Account acc2 = acc;
		acc2.Name = ' Bruno 2 ';
		acc2.DadosPF_RG__c = ' 502940955';		
		acc2.CPF__c = ' 465.462.531-35 ';
		acc2.DadosPF_NomeMae__c = ' Mãe do Bruno 2 ';
		acc2.Phone = ' (41) 3299-6159 ';
		acc2.TelefoneCelular__c = ' (41) 3299-6159 ';
		acc2.EMailNFE__c = ' bruno2@bruno.test ';
		acc2.EMail__c = ' bruno2@bruno.test ';
		acc2.Enderecos_Cobranca_Logradouro__c = ' Rua Tent. Djalma Dutra ';		
		acc2.Enderecos_Entrega_Logradouro__c = ' Rua Tent. Djalma Dutra ';
		acc2.Enderecos_Principal_Logradouro__c = ' Rua Tent. Djalma Dutra ';
		acc2.Enderecos_Cobranca_Complemento__c = ' Anexo ao Bradesco ';
		acc2.Enderecos_Entrega_Complemento__c = ' Anexo ao Bradesco ';
		acc2.Enderecos_Principal_Complemento__c = ' Anexo ao Bradesco ';
		acc2.Enderecos_Cobranca_Bairro__c = ' Centro ';
		acc2.Enderecos_Entrega_Bairro__c = ' Centro ';
		acc2.Enderecos_Principal_Bairro__c = ' Centro ';
		acc2.Enderecos_Cobranca_Cidade__c = ' Sao Jose dos Pinhais ';
		acc2.Enderecos_Entrega_Cidade__c = ' Sao Jose dos Pinhais ';
		acc2.Enderecos_Principal_Cidade__c = ' Sao Jose dos Pinhais ';
		acc2.Cobranca_Cartao_Vcto__c = ' 1221 ';
		acc2.Cobranca_Cartao_Numero_Cript__c = '6053599156877892';
		acc2.Cobranca_Cartao_CodigoSeguranca_Cript__c = ' 001 ';
		acc2.Agencia__c = ' 3959 ';
		acc2.DebAut_NomeTitular__c = ' Bruno 2 ';
		acc2.Conta__c = ' 597959 ';
		
		try{
			//Aplicando .trim() para remover espaços em branco
			//no início e final do texto
			
			//CAMPOS UTILIZADOS NO LAYOUT SIGGO
			if(acc2.Name != null) acc2.Name = acc2.Name.trim();
			if(acc2.DadosPF_RG__c != null) acc2.DadosPF_RG__c = acc2.DadosPF_RG__c.trim();
			if(acc2.CPF__c != null) acc2.CPF__c = acc.CPF__c.trim();
			if(acc2.DadosPF_NomeMae__c != null) acc2.DadosPF_NomeMae__c = acc2.DadosPF_NomeMae__c.trim();
			if(acc2.Phone != null) acc2.Phone = acc2.Phone.trim();
			if(acc2.TelefoneCelular__c != null) acc2.TelefoneCelular__c = acc2.TelefoneCelular__c.trim();
			if(acc2.EMailNFE__c != null) acc2.EMailNFE__c = acc2.EMailNFE__c.trim();
			if(acc2.EMail__c != null) acc2.EMail__c = acc2.EMail__c.trim();
			if(acc2.Enderecos_Cobranca_Logradouro__c != null) acc2.Enderecos_Cobranca_Logradouro__c = acc2.Enderecos_Cobranca_Logradouro__c.trim();
			if(acc2.Enderecos_Entrega_Logradouro__c != null) acc2.Enderecos_Entrega_Logradouro__c = acc2.Enderecos_Entrega_Logradouro__c.trim();
			if(acc2.Enderecos_Principal_Logradouro__c != null) acc2.Enderecos_Principal_Logradouro__c = acc2.Enderecos_Principal_Logradouro__c.trim();
			if(acc2.Enderecos_Cobranca_Complemento__c != null) acc2.Enderecos_Cobranca_Complemento__c = acc2.Enderecos_Cobranca_Complemento__c.trim();
			if(acc2.Enderecos_Entrega_Complemento__c != null) acc2.Enderecos_Entrega_Complemento__c = acc2.Enderecos_Entrega_Complemento__c.trim();
			if(acc2.Enderecos_Principal_Complemento__c != null) acc2.Enderecos_Principal_Complemento__c = acc2.Enderecos_Principal_Complemento__c.trim();
			if(acc2.Enderecos_Cobranca_Bairro__c != null) acc2.Enderecos_Cobranca_Bairro__c = acc2.Enderecos_Cobranca_Bairro__c.trim();
			if(acc2.Enderecos_Entrega_Bairro__c != null) acc2.Enderecos_Entrega_Bairro__c = acc2.Enderecos_Entrega_Bairro__c.trim();
			if(acc2.Enderecos_Principal_Bairro__c != null) acc2.Enderecos_Principal_Bairro__c = acc2.Enderecos_Principal_Bairro__c.trim();
			if(acc2.Enderecos_Cobranca_Cidade__c != null) acc2.Enderecos_Cobranca_Cidade__c = acc2.Enderecos_Cobranca_Cidade__c.trim();
			if(acc2.Enderecos_Entrega_Cidade__c != null) acc2.Enderecos_Entrega_Cidade__c = acc2.Enderecos_Entrega_Cidade__c.trim();
			if(acc2.Enderecos_Principal_Cidade__c != null) acc2.Enderecos_Principal_Cidade__c = acc2.Enderecos_Principal_Cidade__c.trim();
			if(acc2.Cobranca_Cartao_Vcto__c != null) acc2.Cobranca_Cartao_Vcto__c = acc2.Cobranca_Cartao_Vcto__c.trim();			
			if(acc2.Cobranca_Cartao_Numero_Cript__c != null) acc2.Cobranca_Cartao_Numero_Cript__c = acc2.Cobranca_Cartao_Numero_Cript__c.trim();
			if(acc2.Cobranca_Cartao_CodigoSeguranca_Cript__c != null) acc2.Cobranca_Cartao_CodigoSeguranca_Cript__c = acc2.Cobranca_Cartao_CodigoSeguranca_Cript__c.trim();
			if(acc2.Agencia__c != null) acc2.Agencia__c = acc2.Agencia__c.trim();
			if(acc2.DebAut_NomeTitular__c != null) acc2.DebAut_NomeTitular__c = acc2.DebAut_NomeTitular__c.trim();
			if(acc2.Conta__c != null) acc2.Conta__c = acc2.Conta__c.trim();
										
		} catch(System.NullPointerException e){
			System.debug('Account - NullPointerException: '+ e);
		}
		
		update acc2;
		
		test.stopTest();
    }
}