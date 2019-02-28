/*
	Classe de teste: Teste_Service_Lead
	Criado por: Mario Reis
	Data de criação: 02/10/2017
	Descrição: Classe com métodos para as funcionalidades da Trigger do Objeto Lead
	=====================================
	Refatoração adicionada no projeto Argentina
	Atualizado por: Mario Reis
	Data da alteração: 26/10/2017
	Descrição: Adicionado demais métodos utilizados nas triggers dos Leads

*/
public class Service_Lead {

	// Método que verifica a validação da CUIT
	public static void validacaoCUIT(List<Lead> listaLead) {

		System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - validacaoCUIT()] - Inicio...');
		System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - validacaoCUIT()] - listaLead: '+listaLead);

		if(listaLead != null && listaLead.size() > 0) {

			for(Lead lead : listaLead){

                System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - validacaoCUIT()] - lead.CUIT__c: '+lead.CUIT__c);

                if(lead.CUIT__c != null && lead.CUIT__c != '' && 
                   !Util_Validacoes.validarCUIT(lead.CUIT__c)){

					throw new customException(Label.MSG_ERRO_0008);
				}
			} // Fim for(Lead lead : listaLead)

		} else {

			throw new customException(Label.MSG_ERRO_0009);
        } // if(listaLead != null && listaLead.size() > 0)

	} // Fim validacaoCUIT


    // Método que verifica a validação do CPF
	public static void validacaoCPF(List<Lead> listaLead) {

		System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - validacaoCPF()] - Inicio...');
		System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - validacaoCPF()] - listaLead: '+listaLead);

		if(listaLead != null && listaLead.size() > 0) {

			for(Lead lead : listaLead){

                System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - validacaoCPF()] - lead.CPF__c: '+lead.CPF__c);

                if(lead.CPF__c != null && lead.CPF__c != ''){

					String cpfRetorno = Util_Validacoes.validarCPF(lead.CPF__c);

                    if(cpfRetorno != null) lead.CPF__c = cpfRetorno;
                    else throw new customException(Label.MSG_ERRO_0011);
				} // Fim if(lead.CPF__c != null && lead.CPF__c != '')

			} // Fim for(Lead lead : listaLead)

		} else {

			throw new customException(Label.MSG_ERRO_0012);
        } // if(listaLead != null && listaLead.size() > 0)

	} // Fim validacaoCPF


    // Método que verifica a validação do CPF
	public static void validacaoCNPJ(List<Lead> listaLead) {

		System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - validacaoCNPJ()] - Inicio...');
		System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - validacaoCNPJ()] - listaLead: '+listaLead);

		if(listaLead != null && listaLead.size() > 0) {

			for(Lead lead : listaLead){

                System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - validacaoCNPJ()] - lead.CNPJ__c: '+lead.CNPJ__c);

                if(lead.CNPJ__c != null && lead.CNPJ__c != ''){

					String cnpjRetorno = Util_Validacoes.validarCNPJ(lead.CNPJ__c);

                    System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - validacaoCNPJ()] - cnpjRetorno: '+cnpjRetorno);

					if(cnpjRetorno != null) lead.CNPJ__c = cnpjRetorno;
                    else throw new customException(Label.MSG_ERRO_0013);
				}
			} // Fim for(Lead lead : listaLead)

		} else {

			throw new customException(Label.MSG_ERRO_0014);
        } // if(listaLead != null && listaLead.size() > 0)

	} // Fim validacaoCNPJ


	// Método que formata Telefone
	public static void formataTelefone(List<Lead> listaLead) {

		System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - formataTelefone()] - Inicio...');
		System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - formataTelefone()] - listaLead: '+listaLead);

        try {

			if(listaLead != null && listaLead.size() > 0) {

                Util_Lead.carregarTipoRegistro();

				for(Lead lead : listaLead){

                	System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - formataTelefone()] - lead.CNPJ__c: '+lead.CNPJ__c);
                    System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - formataTelefone()] - lead.RecordType.Name: '+lead.RecordType.Name);

                    // Só faz a formatação se o Lead não for do mercosul
                    if(lead.RecordTypeId != Util_Lead.mercosul){

	                	if(lead.Phone != null && lead.Phone != ''){

							lead.Phone = Util_Organizacao.formatarTelefoneBrasil(lead.Phone);
						}

                    	if(lead.Telefone_celular__c != null && lead.Telefone_celular__c != ''){

							lead.Telefone_celular__c = Util_Organizacao.formatarTelefoneBrasil(lead.Telefone_celular__c);
						}

                    	if(lead.MobilePhone != null && lead.MobilePhone != ''){

							lead.MobilePhone = Util_Organizacao.formatarTelefoneBrasil(lead.MobilePhone);
						}

                        if(lead.Telefone_gestor_responsavel__c != null && lead.Telefone_gestor_responsavel__c != ''){

							lead.Telefone_gestor_responsavel__c = Util_Organizacao.formatarTelefoneBrasil(lead.Telefone_gestor_responsavel__c);
						}

                    } // Fim if(lead.RecordTypeId != Util_Lead.mercosul)

				} // Fim for(Lead lead : listaLead)

			} else {

				throw new customException(Label.MSG_ERRO_0015);
        	} // if(listaLead != null && listaLead.size() > 0)

		} catch(Exception e){

        	System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - formataTelefone()] - ERRO: '+e.getMessage());
            throw new customException(e.getMessage());
        } // Fim try/catch

	} // Fim formataTelefone


    // Método que preenche os campos do lead
	public static void preencheCamposLead(List<Lead> listaLead) {
        
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - preencheCamposLead()] - Inicio...');
		System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - preencheCamposLead()] - listaLead: '+listaLead);

        Util_Lead.carregarTipoRegistro();

		if(listaLead != null && listaLead.size() > 0) {

        	for(Lead lead : listaLead){

    			if(lead.RecordTypeId != null){

                    System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - preencheCamposLead()] - lead.RecordTypeId: ' + lead.RecordTypeId);
	    			System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - preencheCamposLead()] - lead: ' + lead);

			        if(lead.CNPJ__c != null && 
                       	String.valueOf(lead.RecordTypeId).subString(0,15) == Util_Lead.CORP){
	            		lead.VerificaDuplicidade__c = lead.CNPJ__c + 'CORP';
	        		}

                    else if(lead.RecordTypeId != null &&
                            String.valueOf(lead.RecordTypeId).subString(0,15) == Util_Lead.bluetec){

                        if(lead.CNPJ__c != null && lead.Tipo_de_pessoa__c == 'J-Jurídica'){
                            lead.VerificaDuplicidade__c = lead.CNPJ__c + 'Blue tec';
                            lead.CPF__c = null;
                        } else if(lead.CPF__c != null && lead.Tipo_de_pessoa__c == 'F-Física'){
                            lead.VerificaDuplicidade__c = lead.CPF__c + 'Blue tec';
                            lead.CNPJ__c = null;
                        }
                    }

                    else if(lead.CPF__c != null && lead.RecordTypeId != null &&
                            	String.valueOf(lead.RecordTypeId).subString(0,15) == Util_Lead.SIGGO){
                        lead.VerificaDuplicidade__c = lead.CPF__c + 'SIGGO';
                    }

                    else if(lead.CNPJ_CPF__c != null && lead.RecordTypeId != null &&
                            	String.valueOf(lead.RecordTypeId).subString(0,15) == Util_Lead.FRETEIRO){
                        lead.VerificaDuplicidade__c = lead.CNPJ_CPF__c + 'FRETEIRO';
                    }

                    else if(lead.CNPJ_CPF__c != null && lead.RecordTypeId != null &&
                            	String.valueOf(lead.RecordTypeId).subString(0,15) == Util_Lead.michelin){
                        lead.VerificaDuplicidade__c = lead.CNPJ_CPF__c + 'Michelin';
                    }

                    else if(lead.RecordTypeId != null && 
                            String.valueOf(lead.RecordTypeId).subString(0,15) == Util_Lead.cargoTracck){
                        if(lead.CNPJ__c != null && lead.Tipo_de_pessoa__c == 'J-Jurídica'){
                            lead.VerificaDuplicidade__c = lead.CNPJ__c + 'Cargo Tracck';
                            lead.CPF__c = null;
                        } else if(lead.CPF__c != null && lead.Tipo_de_pessoa__c == 'F-Física'){
                            lead.VerificaDuplicidade__c = lead.CPF__c + 'Cargo Tracck';
                            lead.CNPJ__c = null;
                        }
        
                    } // Fim ifs

    			} // Fim if(lead.RecordTypeId != null)

            } // Fim for(Lead lead : listaLead)

            System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - preencheCamposLead()] - listaLead: ' + listaLead);
            //if(listaLead != null && listaLead.size() > 0) update listaLead;

        } // FIm if(listaLead != null && listaLead.size() > 0)

	} // Fim método preencheCamposLead


	// Método que verifica a duplicidade do lead pelo tipo de registro
	public static void verificaDuplicidadeLead(List<lead> listaLead) {

		System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - verificaDuplicidadeLead()] - Inicio...');
		System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - verificaDuplicidadeLead()] - listaLead: '+listaLead);

        if(!Triggers__c.getOrgDefaults().Duplicidade_lead__c) return;

		if(listaLead != null && listaLead.size() > 0) {

            // Carrega as informações do tipo de registro do lead
            Util_Lead.carregarTipoRegistro();

			Set<Id> setIdLead = new Set<Id>();
			Set<String> setIdVerificaDuplicidade = new Set<String>();

			for(Lead lead : listaLead){

                if(Util_Lead.bluetec == lead.RecordTypeId) {
                    setIdLead.add(lead.Id);
                    if(lead.VerificaDuplicidade__c != null && lead.VerificaDuplicidade__c != '') 
                        setIdVerificaDuplicidade.add(lead.VerificaDuplicidade__c);
                }

                if(Util_Lead.CORP == lead.RecordTypeId) {
                    setIdLead.add(lead.Id);
                    if(lead.VerificaDuplicidade__c != null && lead.VerificaDuplicidade__c != '') 
                        setIdVerificaDuplicidade.add(lead.VerificaDuplicidade__c);
                }

                if(Util_Lead.michelin == lead.RecordTypeId) {
                    setIdLead.add(lead.Id);
                    if(lead.VerificaDuplicidade__c != null && lead.VerificaDuplicidade__c != '') 
                        setIdVerificaDuplicidade.add(lead.VerificaDuplicidade__c);
                }

                if(Util_Lead.SIGGO == lead.RecordTypeId) {
                    setIdLead.add(lead.Id);
                    if(lead.VerificaDuplicidade__c != null && lead.VerificaDuplicidade__c != '') 
                        setIdVerificaDuplicidade.add(lead.VerificaDuplicidade__c);
                }

                if(Util_Lead.cargoTracck == lead.RecordTypeId) {
                    setIdLead.add(lead.Id);
                    if(lead.VerificaDuplicidade__c != null && lead.VerificaDuplicidade__c != '') 
                        setIdVerificaDuplicidade.add(lead.VerificaDuplicidade__c);
                }

                if(Util_Lead.freteiro == lead.RecordTypeId) {
                    setIdLead.add(lead.Id);
                    if(lead.VerificaDuplicidade__c != null && lead.VerificaDuplicidade__c != '') 
                        setIdVerificaDuplicidade.add(lead.VerificaDuplicidade__c);
                }

			} // Fim for(Lead lead : listaLead)

			System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - verificaDuplicidadeConta()] - setIdLead: '+setIdLead);
            System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - verificaDuplicidadeConta()] - setIdVerificaDuplicidade: '+setIdVerificaDuplicidade);

			if(setIdLead != null && setIdLead.size() > 0 ){

				for(Lead lead : DAO_Lead.getLeadVerificaoDuplicidadePorId(setIdLead, setIdVerificaDuplicidade)){

                    String urlBase = String.valueof(URL.getSalesforceBaseUrl().toExternalForm());

                    String cpfCNPJ = '';
                    if(lead.CNPJ__c != null && lead.CNPJ__c != '') cpfCNPJ = lead.CNPJ__c;
                    if(lead.CNPJ_CPF__c != null && lead.CNPJ_CPF__c != '') cpfCNPJ = lead.CNPJ_CPF__c;
                    if(lead.CPF__c != null && lead.CPF__c != '') cpfCNPJ = lead.CPF__c;
					throw new customException(Label.MSG_ERRO_0020 + ' Nome do Lead: <a target=\'_blank\' href=\''+urlBase+'/'+lead.Id+'\'>'+lead.Name+'</a>');
				}
			}

		} else {

			throw new customException(Label.MSG_ERRO_0021);

        } // if(listaLead != null && listaLead.size() > 0)

	} // Fim verificaDuplicidadeLead


	// Método que faz a busca do CEP
	public static void buscaCEP(List<lead> listaLead) {

		System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - buscaCEP()] - Inicio...');
		System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - buscaCEP()] - listaLead: '+listaLead);

        if(!Servicos__c.getOrgDefaults().Busca_CEP_lead__c) return;

		if(listaLead != null && listaLead.size() > 0) {

			for(Lead lead : listaLead){

                System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - buscaCEP()] - lead : '+lead );
                System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - buscaCEP()] - System.IsBatch(): '+System.IsBatch());
                System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - buscaCEP()] - System.isFuture(): '+System.isFuture());

				if(System.IsBatch() == false && System.isFuture() == false) {
 					if(lead.PostalCode != null ){
    					Util_Organizacao.buscaCEP(lead.Id, lead.PostalCode, 'lead', null);
    				}
				}

			} // Fim for(Lead lead : listaLead)

        } // Fim if(listaLead != null && listaLead.size() > 0) 

	} // Fim buscaCEP


}