/*
 * Classe de teste: Teste_Util_ContaT
 * Criado por: Mario Reis
 * Data de criação: 24/08/2017
 * Descrição: Classe com métodos uteis para o objeto Conta
 * 
 * Alteração: Rafael Silva
 * Data de Alteração: 05/07/2018
 * Descrição: Correção de erros da classe, e unificação das triggers de contas.
 * 
*/
public class Util_Conta {

	// Definição do nome de API dos tipos de registro
	public static String bluetec; // Blue_tec
	public static String cargoTracck; // Cargo_Tracck
	public static String CORP; // CORP
	public static String FRETEIRO; // FRETEIRO
	public static String grupoEconomico; // Grupo_economico
	public static String michelin; // Michelin
	public static String SIGGO; // SIGGO
    public static String mercosul; // Mercosul
    
    public static String argentina; // Argentina
    public static String corp_exec; // CORP-Executivo
    public static String corp_tele; // CORP-Televendas
    
    // Mensagens de regras de validação da conta
    public static String cargoTracckValidarCNPJ = 'Para pessoa jurídica, informe o CNPJ';
    public static String cargoTracckValidarCPF = 'Para pessoa física, informe o CPF';
    public static String verificarCPFTipoPessoa = 'Verifique se o CNPJ/CPF está de acordo com o Tipo de Pessoa informada';

    public static String cnpjValidoMichelin = 'CNPJ inválido, por favor inserir um número de CNPJ válido'; // rbasilva 08-06-2018: por que Michelin?
    public static String cnpjValido = 'Insira um CNPJ válido';
    public static String cpfValido = 'Favor de verificar o CPF é inválido na Conta';
    
	// Metodo que vai chamar consulta no banco e gravar o Id do tipo do registro correspondente
	public static void carregarTipoRegistro(){

		System.debug(LoggingLevel.ERROR, '__ [cls Util_Conta - carregarTipoRegistro()] - Inicio...');

		Map<String, String> mapTipoRegistro = new Map<String, String>();

		try {

			mapTipoRegistro = DAO_Conta.getMapTipoRegistro();

			System.debug(LoggingLevel.ERROR, '__ [cls Util_Conta - carregarTipoRegistro()] - mapTipoRegistro: '+mapTipoRegistro);

			bluetec = mapTipoRegistro.get('Blue_tec');
			cargoTracck = mapTipoRegistro.get('Cargo_Tracck');
			CORP = mapTipoRegistro.get('CORP');
			FRETEIRO = mapTipoRegistro.get('FRETEIRO');
			grupoEconomico = mapTipoRegistro.get('Grupo_economico');
			michelin = mapTipoRegistro.get('Michelin');
			SIGGO = mapTipoRegistro.get('SIGGO');
            mercosul = mapTipoRegistro.get('Mercosul');
            
            //rbasilva 08-06-2018: inclusão dos tipos de registro que faltam para conseguirmos tratar a base.
            argentina = mapTipoRegistro.get('ARGENTINA');
        	corp_exec = mapTipoRegistro.get('CORP_Executivo');	
    		corp_tele = mapTipoRegistro.get('CORP_Televendas');

		} catch (Exception e){

			System.debug(LoggingLevel.ERROR, '__ [cls Util_Conta - carregarTipoRegistro()] - ERRO: '+e.getMessage());
			throw new customException(Label.MSG_ERRO_0003);

		} // Fim try/catch

	} // Fim carregarTipoRegistro


	// Metodo que copia para a conta os campos do Lead
    @future
    public static void copiarCamposLeadConta(String idConta) {

        System.debug(LoggingLevel.ERROR, '__ [cls Util_Conta - copiarCamposLeadConta()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Util_Conta - copiarCamposLeadConta()] - idConta: '+idConta);

		try {

            if(idConta != null){

                Lead lead = DAO_Lead.getLeadPorContaId(idConta);

                Util_Lead.carregarTipoRegistro();
                carregarTipoRegistro();

                if(lead != null){

	                System.debug(LoggingLevel.ERROR, '__ [cls Util_Conta - copiarCamposLeadConta()] - lead: '+lead);
    	            System.debug(LoggingLevel.ERROR, '__ [cls Util_Conta - copiarCamposLeadConta()] - lead.PostalCode: '+lead.PostalCode);
        	        System.debug(LoggingLevel.ERROR, '__ [cls Util_Conta - copiarCamposLeadConta()] - lead.Street: '+lead.Street);
            	    System.debug(LoggingLevel.ERROR, '__ [cls Util_Conta - copiarCamposLeadConta()] - lead.State: '+lead.State);
                	System.debug(LoggingLevel.ERROR, '__ [cls Util_Conta - copiarCamposLeadConta()] - lead.City: '+lead.City);
                	System.debug(LoggingLevel.ERROR, '__ [cls Util_Conta - copiarCamposLeadConta()] - lead.Country: '+lead.Country);

                    Account conta = DAO_Conta.getContaPorId(idConta);
                    if(lead.Cadencia__c != null) conta.Cadencia__c = lead.Cadencia__c;
                    if(lead.MobilePhone != null) conta.TelefoneCelular__c = lead.MobilePhone;
                    if(lead.Circuito__c != null) conta.Circuito__c = lead.Circuito__c;
                    if(lead.CNPJ__c != null) conta.CNPJ__c = lead.CNPJ__c;
                    if(lead.Consultor_indicacao__c != null) conta.Consultor_indicacao__c = lead.Consultor_indicacao__c;
                    if(lead.CPF__c != null) conta.CPF__c = lead.CPF__c;
                    if(lead.CUIT__c != null) conta.CUIT__c = lead.CUIT__c;
                    if(lead.Description != null) conta.Description = lead.Description;
                    if(lead.DNI__c != null) conta.DNI__c = lead.DNI__c;
                    if(lead.Email != null) conta.EMail__c = lead.Email;
                    if(lead.Email != null) conta.EMailNFE__c = lead.Email;
                    if(lead.PostalCode != null && conta.Enderecos_Principal_CEP__c == null) conta.Enderecos_Principal_CEP__c = lead.PostalCode;
                    if(lead.Street != null && conta.Enderecos_Principal_Logradouro__c == null) conta.Enderecos_Principal_Logradouro__c = lead.Street;
                    if(lead.State != null && conta.Enderecos_Principal_Estado__c == null) conta.Enderecos_Principal_Estado__c = lead.State;
                    if(lead.Bairro_endereco__c != null && conta.Enderecos_Principal_Bairro__c == null) conta.Enderecos_Principal_Bairro__c = lead.Bairro_endereco__c;
                    if(lead.City != null && conta.Enderecos_Principal_Cidade__c == null) conta.Enderecos_Principal_Cidade__c = lead.City;
                    if(lead.Country != null && conta.Enderecos_Principal_Pais__c == null) conta.Enderecos_Principal_Pais__c = lead.Country;
                    if(lead.Gerenciador_de_risco__c != null) conta.GR__c = lead.Gerenciador_de_risco__c;
                    if(lead.Indicador__c != null) conta.Indicador__c = lead.Indicador__c;
                    if(lead.J_utilizou_rastreador__c != null) conta.Ja_utilizou_rastreador__c = lead.J_utilizou_rastreador__c;
                    if(lead.Marca_do_concorrente__c != null) conta.Marca_do_concorrente__c = lead.Marca_do_concorrente__c;
                    //conta.Name = lead.Name;
                    if(lead.Nome_fantasia__c != null) conta.Nome_fantasia__c = lead.Nome_fantasia__c;
                    if(lead.Origem_Lead_Agrupado__c != null) conta.Origem_Lead_Agrupado__c = lead.Origem_Lead_Agrupado__c;
                    if(lead.Outro_GR__c != null) conta.Outro_GR__c = lead.Outro_GR__c;
                    if(lead.Outro_Segmento__c != null) conta.Outro_Segmento__c = lead.Outro_Segmento__c;
                    if(lead.Possui_Escolta_Armada__c != null) conta.Possui_Escolta_Armada__c = lead.Possui_Escolta_Armada__c;
                    if(lead.Qual_a_outra_marca__c != null) conta.Qual_a_outra_marca__c = lead.Qual_a_outra_marca__c;
                    //conta.Quantidade_de_ve_culos__c = String.valueOf(lead.Quantidade_de_ve_culos__c);
                    //conta.Quantidade_Ve_culos_Leves__c = lead.Quantidade_ve_culos_leves__c;
                    //conta.Quantidade_Ve_culos_Pesados__c = lead.Quantidade_veiculos_pesados__c;
                    if(lead.Segmento__c != null) conta.Segmento__c = lead.Segmento__c;
                    if(lead.Website != null) conta.Website = lead.Website;
                    if(lead.Tem_ve_culos_leves__c != null) conta.Tem_veiculos_leves__c = lead.Tem_ve_culos_leves__c;
                    if(lead.Tem_veiculos_pesados__c != null) conta.Tem_veiculos_pesados__c = lead.Tem_veiculos_pesados__c;
                    if(lead.Tipo_de_cliente__c != null) conta.Tipo_de_cliente__c = lead.Tipo_de_cliente__c;
                    if(lead.Tipo_de_pessoa__c != null) conta.Tipo_de_pessoa__c = lead.Tipo_de_pessoa__c;
                    if(lead.Utiliza_concorrente__c != null) conta.Utiliza_rastreador_do_concorrente__c = lead.Utiliza_concorrente__c;
                    if(lead.Phone != null) conta.Phone = lead.Phone;
                    if(lead.MobilePhone != null) conta.TelefoneCelular__c = lead.MobilePhone;
                    if(lead.Telefone_2__c != null) conta.Telefone_2__c = lead.Telefone_2__c;
                    if(lead.Telefone_3__c != null) conta.Telefone_3__c = lead.Telefone_3__c;
                    if(lead.Telefone_4__c != null) conta.Telefone_4__c = lead.Telefone_4__c;
                    //conta.Enderecos_Cobranca_UsarPrincial__c = true;

                    if(lead.RecordTypeId == Util_Lead.bluetec) conta.RecordTypeId = Util_Conta.bluetec;
                    if(lead.RecordTypeId == Util_Lead.CORP) conta.RecordTypeId = Util_Conta.CORP;
                    if(lead.RecordTypeId == Util_Lead.cargoTracck) conta.RecordTypeId = Util_Conta.cargoTracck;
                    if(lead.RecordTypeId == Util_Lead.freteiro) conta.RecordTypeId = Util_Conta.FRETEIRO;
                    if(lead.RecordTypeId == Util_Lead.mercosul) conta.RecordTypeId = Util_Conta.mercosul;
                    if(lead.RecordTypeId == Util_Lead.michelin) conta.RecordTypeId = Util_Conta.michelin;
                    if(lead.RecordTypeId == Util_Lead.siggo) conta.RecordTypeId = Util_Conta.SIGGO;

                    System.debug(LoggingLevel.ERROR, '__ [cls Util_Conta - copiarCamposLeadConta()] - conta.Enderecos_Cobranca_CEP__c: '+conta.Enderecos_Cobranca_CEP__c);
                    System.debug(LoggingLevel.ERROR, '__ [cls Util_Conta - copiarCamposLeadConta()] - conta.Enderecos_Cobranca_Logradouro__c: '+conta.Enderecos_Cobranca_Logradouro__c);
                    System.debug(LoggingLevel.ERROR, '__ [cls Util_Conta - copiarCamposLeadConta()] - conta.Enderecos_Cobranca_UF__c: '+conta.Enderecos_Cobranca_UF__c);
                    System.debug(LoggingLevel.ERROR, '__ [cls Util_Conta - copiarCamposLeadConta()] - conta.Enderecos_Cobranca_Cidade__c: '+conta.Enderecos_Cobranca_Cidade__c);
                    System.debug(LoggingLevel.ERROR, '__ [cls Util_Conta - copiarCamposLeadConta()] - conta.Enderecos_Cobranca_Pais__c: '+conta.Enderecos_Cobranca_Pais__c);

                	update conta;

            	}

            } // Fim if(idConta != null)

		} catch (Exception e){

			System.debug(LoggingLevel.ERROR, '__ [cls Util_Conta - copiarCamposLeadConta()] - ERRO: '+e.getMessage());
			throw new customException(Label.MSG_ERRO_0023);

		} // Fim try/catch

    } // Fim copiarCamposLeadConta
	
    //Novo copiarCamposLeadConta
   /* @future
    public static void copiarCamposListaLeadConta(List<Id> ids) {
        
        System.debug(LoggingLevel.ERROR, '__ [cls Util_Conta - copiarCamposListaLeadConta()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Util_Conta - copiarCamposListaLeadConta()] - ids: '+ids);

    }*/

}