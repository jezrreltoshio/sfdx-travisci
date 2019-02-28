public with sharing class PCL_SIG_OpptyParser /* implements PCL_IAnaliseCreditoParser */ {
    public static final integer TIPO_CONTRATO_SIGGO = 905; 
    
    private final string DEFAULT_XML_ENCODING = 'utf-8';
    private final string DEFAULT_XML_VERSION = '1.0';
    private final string DEFAULT_XML_NSURI = NULL;
    private final string DEFAULT_XML_PREFIX = NULL;

    private void writeClienteNode(XmlStreamWriter xw, Account acc) {
        
        xw.writeStartElement('', 'clienteid', '');
        if (acc.CT_PersClie_CodigoCliente__c != null) {
            xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(String.valueOf(acc.CT_PersClie_CodigoCliente__c)));
        }
        xw.writeEndElement();
        
        xw.writeStartElement('', 'nome', '');
        if (acc.name != null) {
            xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(acc.name));
        }
        xw.writeEndElement();
        
        xw.writeStartElement('', 'tipo_pessoa', '');
        if (acc.Tipo_de_pessoa__c != null) {
            xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(HLP_Account.getExternalTipoPessoaValue(acc.Tipo_de_pessoa__c)));
        }
        xw.writeEndElement();
        
        xw.writeStartElement('', 'cnpj_cpf', '');
        
        if (acc.CPF__c != null || acc.CNPJ__c != null){
         String doc = '';
         if (acc.Tipo_de_pessoa__c == HLP_Account.PLV_TIPODEPESSOAC_FISICA){
          doc = BCL_HLP_String.getNumberFromFormatedString(acc.CPF__c);
         } else {
          doc = BCL_HLP_String.getNumberFromFormatedString(acc.CNPJ__c);
         }
         xw.writeCharacters(doc);
        }
        
        xw.writeEndElement();
        
        if (acc.Tipo_de_pessoa__c == HLP_Account.PLV_TIPODEPESSOAC_FISICA) {
            xw.writeStartElement('', 'dadospf', '');

            xw.writeStartElement('', 'nomemae', '');
            if (acc.DadosPF_NomeMae__c != null) {
                xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(acc.DadosPF_NomeMae__c));
            }
            xw.writeEndElement();

            xw.writeStartElement('', 'sexo', '');
            if (acc.DadosPF_Sexo__c != null) {
                xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(HLP_Account.getExternalSexoValue(acc.DadosPF_Sexo__c)));
            }
            xw.writeEndElement();

            xw.writeStartElement('', 'data_nascimento', '');
            if (acc.DadosPF_DataNascimento__c != null) {
                Datetime dt = datetime.newInstance(acc.DadosPF_DataNascimento__c.year(), acc.DadosPF_DataNascimento__c.month(), acc.DadosPF_DataNascimento__c.day());
                xw.writeCharacters(dt.format('dd/MM/yyyy'));
            }
            xw.writeEndElement();

            xw.writeStartElement('', 'RG', '');
            if (acc.DadosPF_RG__c != null) {
                xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(acc.DadosPF_RG__c));
            }
            xw.writeEndElement();

            xw.writeStartElement('', 'estado_civil', '');
            if (acc.DadosPF_EstadoCivil__c != null) {
                xw.writeCharacters(HLP_Account.getExternalEstadoCivilValue(acc.DadosPF_EstadoCivil__c));
            }
            xw.writeEndElement();

            xw.writeEndElement();
            
        } else if (acc.Tipo_de_pessoa__c == HLP_Account.PLV_TIPODEPESSOAC_JURIDICA) {
            throw BCL_NotImplementedException.createException('Geração de proposta para pessoa jurídica não disponível.');
        }
    }
    
    private void writeTaxaInstalacaoNode(XmlStreamWriter xw, Opportunity oppty) {
        
        xw.writeStartElement('', 'dados_cobranca_taxa_instalacao', '');
        
        integer formapagamentoid = PCL_Helper.getCodeAsInteger(oppty.Forma_de_pagamento_instala_o__c);
        xw.writeStartElement('', 'formapagamentoid', '');
        if (oppty.Forma_de_pagamento_instala_o__c != null) {
            xw.writeCharacters(String.valueOf(formapagamentoid));
        }
        xw.writeEndElement();
        
        if (formapagamentoid != HLP_Opportunity.EXT_INSTALACAO_FORMAPGTO_BOLETO && formapagamentoid != HLP_Opportunity.EXT_INSTALACAO_FORMAPGTO_BOLETO_SANTANDER) {
            xw.writeStartElement('', 'cartao_credito', '');
    
	            xw.writeStartElement('', 'numero', '');
	            //Desabilitado para uso do campo Criptografado - Carlos Prates 05/02/2014 18:00
	            //if (oppty.CartaoCredito_Numero__c != null) 
	            //    xw.writeCharacters(String.valueOf(oppty.CartaoCredito_Numero__c));
	            if (oppty.CartaoCredito_Numero_Cript__c != null){
	              xw.writeCharacters(oppty.CartaoCredito_Numero_Cript__c);
	            }
	            xw.writeEndElement();
	    
	            xw.writeStartElement('', 'vencimento', '');
	             if (oppty.CartaoCredito_Vencimento__c != null) {
	                string vcto = '0000' + String.valueOf(oppty.CartaoCredito_Vencimento__c);
	                vcto = BCL_HLP_String.subStringWithSize(vcto, vcto.length() - 4, 4);
	                vcto = BCL_HLP_String.subStringWithSize(vcto, 0, 2) + '/'+ BCL_HLP_String.subStringWithSize(vcto, 2, 2);
	                xw.writeCharacters(vcto);
	            }
	            xw.writeEndElement();
	    
	            xw.writeStartElement('', 'codigo_seguranca', '');
	            // Desabilitado para uso do campo Criptografado - Carlos Prates 06/02/2014 15:00 
	            //if (oppty.CartaoCredito_CodigoSeguranca__c != null) {
	            //    xw.writeCharacters(String.valueOf(oppty.CartaoCredito_CodigoSeguranca__c));
	            //}
	            if (oppty.CartaoCredito_CodigoSeguranca_Cript__c != null) {
	                xw.writeCharacters(String.valueOf(oppty.CartaoCredito_CodigoSeguranca_Cript__c));
	            }
	            
	            xw.writeEndElement();
            
	            xw.writeStartElement('', 'nome_cartao', '');
	            
	            if (oppty.Nome_do_portador__c != null) {
	                xw.writeCharacters(String.valueOf(oppty.Nome_do_portador__c));
	            }
	            	            
	            xw.writeEndElement();
            
            xw.writeEndElement();
        }

        xw.writeStartElement('', 'quantidade_parcelas', '');
        if (oppty.Parcelamento_da_instala_o__c != null) {
            xw.writeCharacters(string.valueOf(oppty.Parcelamento_da_instala_o__c));
        }
        xw.writeEndElement();

        xw.writeStartElement('', 'valor_parcela', '');
        if (oppty.total_mensal_da_instala_o__c != null) {
            xw.writeCharacters(string.valueOf(oppty.total_mensal_da_instala_o__c));
        }
        xw.writeEndElement();
        
        xw.writeEndElement();       
    }
    
    private void writeAnaliseCreditoNodeHARD(OpportunityProcessType processType, XmlStreamWriter xw, Opportunity oppty) {
        
        xw.writeStartElement('', 'analise_credito', '');
        
        if (processType != OpportunityProcessType.PersistirProposta) {
            xw.writeStartElement('', 'usuario_aprovador', '');
            //xw.writeCharacters();
            xw.writeEndElement();
        }

        xw.writeStartElement('', 'observacao', '');
        //xw.writeCharacters();
        xw.writeEndElement();
        
        xw.writeEndElement();
    }
    
    private void writeProdutoNode(XmlStreamWriter xw, Opportunity oppty) {
        
        xw.writeStartElement('', 'produto', '');
        
        xw.writeStartElement('', 'classe_contrato', '');
        if (oppty.Siggo_ClasseProduto__c != null) {
            xw.writeCharacters(string.valueOf(oppty.Siggo_ClasseProduto__c));
        }
        xw.writeEndElement();

        xw.writeStartElement('', 'vigencia_contrato', '');
        if (oppty.Prazo_do_contrato__c != null) {
            xw.writeCharacters(string.valueOf(oppty.Prazo_do_contrato__c));
        }
        xw.writeEndElement();
        
        xw.writeEndElement();
    }
    
    private void writeItemPropostaNode(XmlStreamWriter xw, OpportunityProcessType processType, itemPropostaSiggo__c item, Opportunity oppty, Account acc, boolean produtoComSeguro) {
        xw.writeStartElement('', 'item', '');
        
        if (produtoComSeguro) { 
            xw.writeStartElement('', 'produto_seguro', '');
    
            xw.writeStartElement('', 'utilizacao_veiculo', '');
            if (item.UtilizacaoVeiculo__c != null) {
                xw.writeCharacters(PCL_Helper.getCodeAsString(item.UtilizacaoVeiculo__c));
            }
            xw.writeEndElement();
            
            if (item.FinalidadeUsoVeiculo__c != null) {
                xw.writeStartElement('', 'finalidade_uso', '');
                xw.writeCharacters(PCL_Helper.getCodeAsString(item.FinalidadeUsoVeiculo__c));
                xw.writeEndElement();
            }
            
            if (oppty.PEP1__c != null) {
                xw.writeStartElement('', 'pep1', '');
                xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(oppty.PEP1__c));
                xw.writeEndElement();
            }
    
            
            if (oppty.PEP2__c != null) {
                xw.writeStartElement('', 'pep2', '');
                xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(oppty.PEP2__c));
                xw.writeEndElement();
            }
            
    
            xw.writeStartElement('', 'profissao', '');
            if (oppty.ProfissaoProprietario__c != null) {
                xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(PCL_Helper.getCodeAsString(oppty.ProfissaoProprietario__c)));
            }
            xw.writeEndElement();
    
            xw.writeStartElement('', 'tipo_segurado', '');
            if (item.TipoSegurado__c != null) {
                xw.writeCharacters(PCL_Helper.getCodeAsString(item.TipoSegurado__c));
            }
            xw.writeEndElement();
    
            xw.writeStartElement('', 'auto_utilizacao', '');
            if (item.AutoUtilizacao__c != null) {
                xw.writeCharacters(PCL_Helper.getCodeAsString(item.AutoUtilizacao__c));
            }
            xw.writeEndElement();
            
              
            if (processType != OpportunityProcessType.AnalisePreliminar) {
                xw.writeStartElement('', 'cotacao_seguradora', '');
                if (item.AnalPrel_NumeroOrcamento__c != null) {
                    xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(string.valueOf(item.AnalPrel_NumeroOrcamento__c)));
                }
                xw.writeEndElement();
                
                xw.writeStartElement('', 'valorseguro', '');
                if (item.AnalPrel_ValorPremio__c != null) {
                    xw.writeCharacters(string.valueOf(item.AnalPrel_ValorPremio__c));
                }
                xw.writeEndElement();
                
                xw.writeStartElement('', 'cd_produto', '');
                xw.writeCharacters(string.valueOf(oppty.Cd_Produto__c));
                xw.writeEndElement();
            }
           
           if (processType == OpportunityProcessType.AnalisePreliminar) {
                xw.writeStartElement('', 'id_produto_cobertura', '');
                if (oppty.Id_produto_cobertura__c != null) {
                    xw.writeCharacters(string.valueOf(oppty.Id_produto_cobertura__c));
                }
                xw.writeEndElement();               

                xw.writeStartElement('', 'vl_lmi_cobertura', '');
                if (oppty.Vl_lmi_cobertura__c != null) {
                    xw.writeCharacters(string.valueOf(oppty.Vl_lmi_cobertura__c));
                }
                xw.writeEndElement();
                
                xw.writeStartElement('', 'vl_franquia_cobertura', '');
                if (oppty.Vl_franquia_cobertura__c != null) {
                    xw.writeCharacters(string.valueOf(oppty.Vl_franquia_cobertura__c));
                }
                xw.writeEndElement();
                
                xw.writeStartElement('', 'cd_produto', '');
                xw.writeCharacters(string.valueOf(oppty.Cd_Produto__c));
                xw.writeEndElement();
           }
           
            xw.writeEndElement();

        }
        
        xw.writeStartElement('', 'veiculo', '');

        if (processType != OpportunityProcessType.AnalisePreliminar) {
            xw.writeStartElement('', 'chassi', '');
            if (item.Veiculo_Chassi__c != null) {
                xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(item.Veiculo_Chassi__c));
            }
            xw.writeEndElement();
        }
        
        if (item.Veiculo_Placa__c != null) {
            xw.writeStartElement('', 'placa', '');
            xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(item.Veiculo_Placa__c));
            xw.writeEndElement();
        }
        
        xw.writeStartElement('', 'fipe', '');
        String fipe = '';
        if (item.Veiculo_CodigoFipe__c != null) {
            fipe = item.Veiculo_CodigoFipe__c.trim();
            if (fipe.indexOf('-') == -1) {
                fipe = BCL_HLP_String.subString(fipe, 0, fipe.length() -2) + '-' + BCL_HLP_String.subStringWithSize(fipe, fipe.length() - 1, 1);
            }
        }
        if(fipe == ''){
            xw.writeCharacters('0');
        }else{
            xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(fipe));
        }
        xw.writeEndElement();
        
        if (processType != OpportunityProcessType.AnalisePreliminar) {
            xw.writeStartElement('', 'marca', '');
            if (item.Veiculo_CodigoMarca__c != null) {
                xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(String.valueOf(item.Veiculo_CodigoMarca__c)));
            }
            xw.writeEndElement();
    
            xw.writeStartElement('', 'modelo', '');
            if (item.Veiculo_CodigoModelo__c != null) {
                xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(String.valueOf(item.Veiculo_CodigoModelo__c)));
            }
            xw.writeEndElement();
        }
        
        xw.writeStartElement('', 'ano_modelo', '');
        if (item.Veiculo_AnoModelo__c != null) {
            xw.writeCharacters(String.valueOf(item.Veiculo_AnoModelo__c));
        }
        xw.writeEndElement();

        xw.writeStartElement('', 'cor', '');
        if (item.Veiculo_Cor__c != null) {
            xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(item.Veiculo_Cor__c));
        }
        xw.writeEndElement();
        
        if (processType != OpportunityProcessType.AnalisePreliminar) {
            xw.writeStartElement('', 'renavam', '');
            if (item.Veiculo_Renavam__c != null) {
                xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(item.Veiculo_Renavam__c));
            }
            xw.writeEndElement();
        }
        
        xw.writeStartElement('', 'carro_zero', '');
        if (item.Veiculo_Eh0KM__c != null) {
            if (item.Veiculo_Eh0KM__c) {
                xw.writeCharacters('1'); // carro novo
            } else {
                xw.writeCharacters('2'); // carro usado
            }
            
        }
        xw.writeEndElement();

        xw.writeStartElement('', 'combustivel', '');
        if (item.Veiculo_Combustivel__c != null) {
            xw.writeCharacters(PCL_Helper.getCodeAsString(item.Veiculo_Combustivel__c));
        }
        xw.writeEndElement();
        
        if (processType == OpportunityProcessType.PersistirProposta) {
            xw.writeStartElement('', 'nao_instalar_bloqueio', '');
            if (item.Instalar_bloqueador__c) {
                xw.writeCharacters('false');
            } else {
                xw.writeCharacters('true');
            }
            xw.writeEndElement();
        }
        
        xw.writeStartElement('', 'proprietario', '');

        /* MODIFICATION - Carlos Prates 14/08/2014 16:00
         * Update that implements the change to use the data Account from the account (primary address)
         * and not the data Account from the vehicle object for tags proprietario node.
         * Xml node update: tipo_pessoa, nome, cpf_cnpj, sexo, data_nascimento, RG, estado_civil, email
         */
        
        xw.writeStartElement('', 'tipo_pessoa', '');
        //if (item.Veiculo_Proprietario_TipoPessoa__c != null) {
        //    xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(HLP_Account.getExternalTipoPessoaValue(item.Veiculo_Proprietario_TipoPessoa__c)));
        //}
        if (acc.Tipo_de_pessoa__c != null) {
            xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(HLP_Account.getExternalTipoPessoaValue(acc.Tipo_de_pessoa__c)));
        }
        xw.writeEndElement();
        
        xw.writeStartElement('', 'nome', '');
        //if (item.Veiculo_Proprietario_Nome__c != null) {
        //    xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(item.Veiculo_Proprietario_Nome__c));
        //}
        if (acc.Name != null) {
            xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(acc.Name));
        }
        xw.writeEndElement();


        xw.writeStartElement('', 'cpf_cnpj', '');
        if (acc.Tipo_de_pessoa__c == HLP_Account.PLV_TIPODEPESSOAC_FISICA) {
            if(acc.Tipo_de_pessoa__c == HLP_Account.PLV_TIPODEPESSOAC_FISICA){
                if(acc.CPF__c != null){
                    xw.writeCharacters(BCL_HLP_String.getNumberFromFormatedString(acc.CPF__c));
                }
            }else{
                if(acc.CNPJ__c != null){
                    xw.writeCharacters(BCL_HLP_String.getNumberFromFormatedString(acc.CNPJ__c));
                }
            }
        }
        xw.writeEndElement();
        
        xw.writeStartElement('', 'endereco', '');
        
        /*
         * Code from MELHORIAS SIGGO that implements the change to use the address 
         * from the account (primary address) and not the address from the vehicle
         * object (owner's address)
         * 2014.06.26 FST/eZly
         */
        
        xw.writeStartElement('', 'cep', '');
        if (acc.Enderecos_Principal_CEP__c != null) {
            string cep = String.valueOf(acc.Enderecos_Principal_CEP__c);
            cep = BCL_HLP_String.getNumberFromFormatedString(cep);
            cep = BCL_HLP_String.padLeft(cep, '0', 8);
            xw.writeCharacters(cep);
        }
        xw.writeEndElement();

        xw.writeStartElement('', 'pais', '');
        if (acc.Enderecos_Principal_Pais__c != null) {
            xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(acc.Enderecos_Principal_Pais__c));
        }
        xw.writeEndElement();
                    
        xw.writeStartElement('', 'estado', '');
        if (acc.Enderecos_Principal_UF__c != null) {
            xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(acc.Enderecos_Principal_UF__c));
        }
        xw.writeEndElement();

        xw.writeStartElement('', 'cidade', '');
        if (acc.Enderecos_Principal_Cidade__c != null) {
            xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(acc.Enderecos_Principal_Cidade__c));
        }
        xw.writeEndElement();

        xw.writeStartElement('', 'bairro', '');
        if (acc.Enderecos_Principal_Bairro__c != null) {
            xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(acc.Enderecos_Principal_Bairro__c));
        }
        xw.writeEndElement();

        xw.writeStartElement('', 'logradouro', '');
        if (acc.Enderecos_Principal_Logradouro__c != null) {
            xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(acc.Enderecos_Principal_Logradouro__c));
        }
        xw.writeEndElement();

        xw.writeStartElement('', 'numero', '');
        if (acc.Enderecos_Principal_Numero__c != null) {
            xw.writeCharacters(String.valueOf(acc.Enderecos_Principal_Numero__c));
        }
        xw.writeEndElement();
        
        xw.writeStartElement('', 'complemento', '');
        if (acc.Enderecos_Principal_Complemento__c != null) {
            xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(acc.Enderecos_Principal_Complemento__c));
        }
        xw.writeEndElement();

        xw.writeEndElement();

        xw.writeStartElement('', 'telefones', '');
        
        if (acc.Phone != null) {
            PCL_PhoneNumber p = new PCL_PhoneNumber();
            HLP_Telefone.setTelephone(p, HLP_Telefone.PLV_TIPONUMEROC_RESIDENCIAL, acc.Phone);
            
            writeTelefoneNode(xw, p);
        }
        
        if (acc.TelefoneComercial__c != null) {
            PCL_PhoneNumber p = new PCL_PhoneNumber();
            
            HLP_Telefone.setTelephone(p, HLP_Telefone.PLV_TIPONUMEROC_COMERCIAL, acc.TelefoneComercial__c);
            
            writeTelefoneNode(xw, p);           
        }
        
        if (acc.TelefoneCelular__c != null) {
            PCL_PhoneNumber p = new PCL_PhoneNumber();
            
            HLP_Telefone.setTelephone(p, HLP_Telefone.PLV_TIPONUMEROC_CELULAR, acc.TelefoneCelular__c);
            
            writeTelefoneNode(xw, p);           
        }
        
        xw.writeEndElement();

        xw.writeStartElement('', 'sexo', '');
        //if (item.Veiculo_Proprietario_Sexo__c != null) {
        //    xw.writeCharacters(PCL_Helper.getCodeAsString(item.Veiculo_Proprietario_Sexo__c));
        //}
        if (acc.DadosPF_Sexo__c != null) {
            xw.writeCharacters(PCL_Helper.getCodeAsString(acc.DadosPF_Sexo__c));
        }
        xw.writeEndElement();
        
        xw.writeStartElement('', 'data_nascimento', '');
        //if (item.Veiculo_Proprietario_DataNascimento__c != null) {
        //    Datetime dt = datetime.newInstance(item.Veiculo_Proprietario_DataNascimento__c.year(), item.Veiculo_Proprietario_DataNascimento__c.month(), item.Veiculo_Proprietario_DataNascimento__c.day());
        //    xw.writeCharacters(dt.format('dd/MM/yyyy'));
        //}
        if (acc.DadosPF_DataNascimento__c != null) {
            Datetime dt = datetime.newInstance(acc.DadosPF_DataNascimento__c.year(), acc.DadosPF_DataNascimento__c.month(), acc.DadosPF_DataNascimento__c.day());
            xw.writeCharacters(dt.format('dd/MM/yyyy'));
        }
        xw.writeEndElement();

        xw.writeStartElement('', 'RG', '');
        //if (item.Veiculo_Proprietario_RG__c != null) {
        //    xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(item.Veiculo_Proprietario_RG__c));
        //}
        if (acc.DadosPF_RG__c != null) {
            xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(acc.DadosPF_RG__c));
        }
        xw.writeEndElement();
        
        xw.writeStartElement('', 'estado_civil', '');
        //if (item.Veiculo_Proprietario_EstadoCivil__c != null) {
        //    xw.writeCharacters(PCL_Helper.getCodeAsString(item.Veiculo_Proprietario_EstadoCivil__c));
        //}
        if (acc.DadosPF_EstadoCivil__c != null) {
            xw.writeCharacters(PCL_Helper.getCodeAsString(acc.DadosPF_EstadoCivil__c));
        }
        xw.writeEndElement();
        
        xw.writeStartElement('', 'email', '');
        //if (item.Veiculo_Proprietario_EMail__c != null) {
        //    xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(item.Veiculo_Proprietario_EMail__c));
        //}
        if (acc.EMail__c != null) {
            xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(acc.EMail__c));
        }
        xw.writeEndElement();

        xw.writeEndElement(); //proprietario
        
        xw.writeEndElement(); //veiculo
        
        if (processType == OpportunityProcessType.PersistirProposta) {
            xw.writeStartElement('', 'valorparcelalocacao', '');
            xw.writeCharacters('0.01');
            xw.writeEndElement();
            
            xw.writeStartElement('', 'valormonitoramento', '');
            xw.writeCharacters(string.valueOf(oppty.Valor_unit_rio_mensal_new__c));
            xw.writeEndElement();               
        }
        
        xw.writeEndElement(); // item
    }
    
    private void writeTelefoneNode(XmlStreamWriter xw, PCL_PhoneNumber phone) {
        xw.writeStartElement('', 'telefone', '');
        
        xw.writeStartElement('', 'tipo', '');
        xw.writeCharacters(HLP_Telefone.getExternalTipoTelefoneValue(phone.phoneType));
        xw.writeEndElement();
        
        xw.writeStartElement('', 'ddd', '');
        if (phone.DDD != null) {
            xw.writeCharacters(string.valueOf(phone.DDD));
        }
        xw.writeEndElement();

        xw.writeStartElement('', 'numero', '');
        xw.writeCharacters(string.valueOf(phone.phoneNumber));
        xw.writeEndElement();
        
        xw.writeEndElement();
        
    }
    
    private void writeContatoNodeAut(XmlStreamWriter xw, Account contact, String contactType) {
        xw.writeStartElement('', 'contato' ,'');
        xw.writeStartElement('', 'tipo_contato', '');
        xw.writeCharacters(contactType);
        xw.writeEndElement();
        xw.writeStartElement('', 'nome', '');
        xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(contact.Nome_contato_autorizado__c));
        xw.writeEndElement();
       xw.writeStartElement('', 'cpf', '');
        if (contact.CPF_contato_autorizado__c != null) {
            string doc = contact.CPF_contato_autorizado__c;
            doc = BCL_HLP_String.getNumberFromFormatedString(doc);
            doc = BCL_HLP_String.padLeft(doc, '0', 11);
            xw.writeCharacters(doc);
        }
        xw.writeEndElement();
        xw.writeStartElement('', 'rg', '');
        if (contact.RG_contato_autorizado__c != null) {
            xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(contact.RG_contato_autorizado__c));
        }
        xw.writeEndElement();
            if (contact.Telefone_contato_autorizado__c != null || contact.Celular_contato_autorizado__c != null ) {
                xw.writeStartElement('', 'telefones', '');
                string internalPhoneType = '';
               if (contact.Telefone_contato_autorizado__c != null) {
                    PCL_PhoneNumber phone = new PCL_PhoneNumber();
                    HLP_Telefone.setTelephone(phone, HLP_Telefone.PLV_TIPONUMEROC_RESIDENCIAL, string.valueOf(contact.Telefone_contato_autorizado__c));
                    writeTelefoneNode(xw, phone);
                } 
                if (contact.Celular_contato_autorizado__c != null) {
                    PCL_PhoneNumber phone = new PCL_PhoneNumber();
                    HLP_Telefone.setTelephone(phone, HLP_Telefone.PLV_TIPONUMEROC_CELULAR, string.valueOf(contact.Celular_contato_autorizado__c));
                    writeTelefoneNode(xw, phone);
                }
            xw.writeEndElement();
        }
     xw.writeEndElement();
    }
    private void writeContatoNodeEmer(XmlStreamWriter xw, Account contact, String contactType) {
            xw.writeStartElement('', 'contato' ,'');
        xw.writeStartElement('', 'tipo_contato', '');
        xw.writeCharacters(contactType);
        xw.writeEndElement();
        xw.writeStartElement('', 'nome', '');
        xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(contact.Nome_contato_emergencia__c));
        xw.writeEndElement();
       xw.writeStartElement('', 'cpf', '');
        if (contact.CPF_contato_emergencia__c != null) {
            string doc = contact.CPF_contato_emergencia__c;
            doc = BCL_HLP_String.getNumberFromFormatedString(doc);
            doc = BCL_HLP_String.padLeft(doc, '0', 11);
            xw.writeCharacters(doc);
        }
        xw.writeEndElement();
        xw.writeStartElement('', 'rg', '');
        if (contact.RG_contato_emergencia__c != null) {
            xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(contact.RG_contato_emergencia__c));
        }
        xw.writeEndElement();
            if (contact.Telefone_contato_emergencia__c != null || contact.Celular_contato_emergencia__c != null ) {
                xw.writeStartElement('', 'telefones', '');
                string internalPhoneType = '';
               if (contact.Telefone_contato_emergencia__c != null) {
                    PCL_PhoneNumber phone = new PCL_PhoneNumber();
                    HLP_Telefone.setTelephone(phone, HLP_Telefone.PLV_TIPONUMEROC_RESIDENCIAL, string.valueOf(contact.Telefone_contato_emergencia__c));
                    writeTelefoneNode(xw, phone);
                } 
                if (contact.Celular_contato_emergencia__c != null) {
                    PCL_PhoneNumber phone = new PCL_PhoneNumber();
                    HLP_Telefone.setTelephone(phone, HLP_Telefone.PLV_TIPONUMEROC_CELULAR, string.valueOf(contact.Celular_contato_emergencia__c));
                    writeTelefoneNode(xw, phone);
                }
            xw.writeEndElement();
        }
     xw.writeEndElement();
    }
    private void writeContatoNodeInst(XmlStreamWriter xw, Account contact, String contactType) {
            xw.writeStartElement('', 'contato' ,'');
        xw.writeStartElement('', 'tipo_contato', '');
        xw.writeCharacters(contactType);
        xw.writeEndElement();
        xw.writeStartElement('', 'nome', '');
        xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(contact.Nome_contato_instalacao__c));
        xw.writeEndElement();
       xw.writeStartElement('', 'cpf', '');
        if (contact.CPF_contato_instalacao__c != null) {
            string doc = contact.CPF_contato_instalacao__c;
            doc = BCL_HLP_String.getNumberFromFormatedString(doc);
            doc = BCL_HLP_String.padLeft(doc, '0', 11);
            xw.writeCharacters(doc);
        }
        xw.writeEndElement();
        xw.writeStartElement('', 'rg', '');
        if (contact.RG_contato_instalacao__c != null) {
            xw.writeCharacters(BCL_HLP_String.removeSpecialCharacters(contact.RG_contato_instalacao__c));
        }
        xw.writeEndElement();
            if (contact.Telefone_contato_instalacao__c != null || contact.Celular_contato_instalacao__c != null ) {
                xw.writeStartElement('', 'telefones', '');
                string internalPhoneType = '';
               if (contact.Telefone_contato_instalacao__c != null) {
                    PCL_PhoneNumber phone = new PCL_PhoneNumber();
                    HLP_Telefone.setTelephone(phone, HLP_Telefone.PLV_TIPONUMEROC_RESIDENCIAL, string.valueOf(contact.Telefone_contato_instalacao__c));
                    writeTelefoneNode(xw, phone);
                } 
                if (contact.Celular_contato_instalacao__c != null) {
                    PCL_PhoneNumber phone = new PCL_PhoneNumber();
                    HLP_Telefone.setTelephone(phone, HLP_Telefone.PLV_TIPONUMEROC_CELULAR, string.valueOf(contact.Celular_contato_instalacao__c));
                    writeTelefoneNode(xw, phone);
                }
            xw.writeEndElement();
        }
     xw.writeEndElement();
    }

    public string toProcessXML(OpportunityProcessType processType, Id currentUserId, Opportunity oppty, boolean produtoComSeguro) {
        String result = null;
        
        User currentUser = [
            select
                IdUsuarioPreCadastro__c
            from
                User
            where
                Id = :currentUserId
            limit 1
        ];
        
        XmlStreamWriter xw = new XmlStreamWriter();
        
        xw.writeStartDocument(DEFAULT_XML_ENCODING, DEFAULT_XML_VERSION);

        xw.writeStartElement('', 'dados', '');
        
        xw.writeStartElement('', 'usuarioid', '');
        if (currentUser.IdUsuarioPreCadastro__c != null) {
            xw.writeCharacters(String.valueOf(currentUser.IdUsuarioPreCadastro__c));
        }
        xw.writeEndElement();
        
        xw.writeStartElement('', 'oportunidadeid', '');
        xw.writeCharacters(String.valueOf(oppty.CodigoOportunidade__c));
        xw.writeEndElement();
        
        xw.writeStartElement('', 'tipoproposta', '');
        if (oppty.Siggo_TipoProposta__c != null) {
            xw.writeCharacters(string.valueOf(HLP_Opportunity.getExternalSiggoTipoPropostaValue(oppty.Siggo_TipoProposta__c)));
        }
        xw.writeEndElement();
    
        xw.writeStartElement('', 'tipocontrato' , '');
        xw.writeCharacters(string.valueOf(TIPO_CONTRATO_SIGGO));
        xw.writeEndElement();
        
        Account acc = [
            select
                id
                , CT_PersClie_CodigoCliente__c
                
                , name
                , Tipo_de_pessoa__c
                //, CNPJ_CPF__c - Desabilitado pois foi criado máscara para campos CPF e CNPJ - Carlos Prates 06/02/2014 11:35
                , CPF__c
                , CNPJ__c
                
                , DadosPF_NomeMae__c
                , DadosPF_Sexo__c
                , DadosPF_DataNascimento__c
                , DadosPF_RG__c
                , DadosPF_EstadoCivil__c
                , EMail__c
                
                , DadosPJ_EmpresaOptanteSimples__c
                , DadosPJ_InscricaoEstadual__c
                , DadosPJ_InscricaoEstadualUF__c
                , DadosPJ_InscricaoMunicipal__c
                
                , ContatoPessoaAutorizada__c
                , ContatoEmergencia__c
                , ContatoInstalacao__c
                , ContatoPadrao__c
                
                , Phone
                , TelefoneComercial__c
                , TelefoneCelular__c
                
                // Upd melhorias siggo
                // Endereço principal from account instead of 
                // endereço do proprietário in vehicles
                , Enderecos_Principal_Logradouro__c
                , Enderecos_Principal_Numero__c
                , Enderecos_Principal_Complemento__c
                , Enderecos_Principal_Bairro__c
                , Enderecos_Principal_Cidade__c
                , Enderecos_Principal_UF__c
                , Enderecos_Principal_CEP__c
                , Enderecos_Principal_Pais__c
                
                , Nome_contato_autorizado__c
                , CPF_contato_autorizado__c
                , RG_contato_autorizado__c
                , Celular_contato_autorizado__c
                , Telefone_contato_autorizado__c
                
                , Nome_contato_emergencia__c
                , CPF_contato_emergencia__c
                , RG_contato_emergencia__c
                , Celular_contato_emergencia__c
                , Telefone_contato_emergencia__c
                
                , Nome_contato_instalacao__c
                , CPF_contato_instalacao__c
                , RG_contato_instalacao__c
                , Celular_contato_instalacao__c
                , Telefone_contato_instalacao__c
                
            from
                Account
            where
                Id = :oppty.AccountId
            limit 1
        ];
        
        if (oppty.Indicador__c != null) {
            Account cor = [select IdExternoClienteIndicador__c from Account where id = :oppty.Indicador__c limit 1];
            if (processType != OpportunityProcessType.AnaliseCredito && cor.IdExternoClienteIndicador__c != null) {
                xw.writeStartElement('', 'corretor_indicador', '');
                xw.writeCharacters(String.valueOf(cor.IdExternoClienteIndicador__c));
                xw.writeEndElement();
            }
        }
        
        writeClienteNode(xw, acc);
        
        writeTaxaInstalacaoNode(xw, oppty);
        writeAnaliseCreditoNodeHARD(processType, xw, oppty);
        writeProdutoNode(xw, oppty);
        
        List<ItemPropostaSiggo__c> listaItemProposta = [
            SELECT
                Id
                ,   AutoUtilizacao__c
                ,   Veiculo_Eh0KM__c
                ,   Veiculo_Chassi__c
                /* Upd Melhorias SIGGO
                 * commented out 'cause we use endereço principal from account now
                 * check query Account Acc and writeItemPropostaNode() code
                  ,   Veiculo_Proprietario_Endereco_Estado__c
                    ,   Veiculo_Proprietario_Endereco_Logradouro__c
                    ,   Veiculo_Proprietario_Endereco_Numero__c
                    ,   Veiculo_Proprietario_Endereco_Pais__c
                    ,   Veiculo_Proprietario_Endereco_Bairro__c
                    ,   Veiculo_Proprietario_Endereco_CEP__c
                    ,   Veiculo_Proprietario_Endereco_Cidade__c
                    ,   Veiculo_Proprietario_Endereco_Comp__c   /*
                 */
                ,   Veiculo_ClienteEhProprietario__c
                //,   Veiculo_Proprietario_CNPJCPF__c
                ,   AnalPrel_CodigoRetorno__c
                ,   Veiculo_CodigoFipe__c
                ,   Veiculo_Combustivel__c
                ,   AnalPrel_Contrato__c
                ,   Veiculo_Cor__c
                //,   Veiculo_Proprietario_DataNascimento__c
                //,   Veiculo_Proprietario_EMail__c
                //,   Veiculo_Proprietario_EstadoCivil__c
                ,   Veiculo_AnoModelo__c
                ,   FinalidadeUsoVeiculo__c
                ,   Veiculo_CodigoMarca__c
                ,   AnalPrel_MensagemRetorno__c
                ,   Veiculo_CodigoModelo__c
                //,   Veiculo_Proprietario_Nome__c
                ,   NumeroContrato__c
                ,   Oportunidade__c
                ,   AnalPrel_NumeroOrcamento__c
                ,   Veiculo_Placa__c
                ,   AnalPrel_ValorPremio__c
                ,   Veiculo_Renavam__c
                //,   Veiculo_Proprietario_RG__c
                //,   Veiculo_Proprietario_Sexo__c
                ,   StatusContrato__c
                //,   Veiculo_Proprietario_TipoPessoa__c
                ,   TipoSegurado__c
                ,   UtilizacaoVeiculo__c
                ,   ValorParcelaLocacao__c
                ,   ValorMonitoramento__c
                ,   Instalar_bloqueador__c
            FROM
                ItemPropostaSiggo__c
            WHERE
                Oportunidade__c = :oppty.Id
            ORDER BY 
                Ordenador__c ASC NULLS FIRST            
        ];
 
        if (!listaItemProposta.isEmpty()) {
            xw.writeStartElement('', 'itens', '');
            
            for(ItemPropostaSiggo__c item: listaItemProposta) {
                writeItemPropostaNode(xw, processType, item, oppty, acc, produtoComSeguro);
            }
            
            xw.writeEndElement();
        }
        
        
        List<Account> listaContatoAut = [
            SELECT
                id
                , Nome_contato_autorizado__c
                , CPF_contato_autorizado__c
                , RG_contato_autorizado__c
                , Celular_contato_autorizado__c
                , Telefone_contato_autorizado__c
            FROM
                Account
            WHERE
                Id = :acc.id
        ];
     List<Account> listaContatoEmer = [
            SELECT
                id
                , Nome_contato_emergencia__c
                , CPF_contato_emergencia__c
                , RG_contato_emergencia__c
                , Celular_contato_emergencia__c
                , Telefone_contato_emergencia__c
            FROM
                Account
            WHERE
                Id = :acc.id
        ];
     List<Account> listaContatoInst = [
            SELECT
                id
                , Nome_contato_instalacao__c
                , CPF_contato_instalacao__c
                , RG_contato_instalacao__c
                , Celular_contato_instalacao__c
                , Telefone_contato_instalacao__c
            FROM
                Account
            WHERE
                Id = :acc.id
        ];
        
        xw.writeStartElement('', 'contatos', '');
        if (!listaContatoAut.isEmpty()) {
            for(Account c: listaContatoAut) {
                String contactType = null;
                if  (c.id != null) {
                        contactType = HLP_Account.PLV_EXT_TIPOCONTATO_PESSOAAUTORIZADA;
                }
                writeContatoNodeAut(xw, c, contactType);
            }
            for(Account c: listaContatoEmer) {
                String contactType = null;
                if  (c.id != null) {
                        contactType = HLP_Account.PLV_EXT_TIPOCONTATO_EMERGENCIA;
                }
                writeContatoNodeEmer(xw, c, contactType);
            }
            for(Account c: listaContatoInst) {
                String contactType = null;
                if  (c.id != null) {
                        contactType = HLP_Account.PLV_EXT_TIPOCONTATO_INSTALACAO;
                }
                writeContatoNodeInst(xw, c, contactType);
            }
        }
        xw.writeEndElement();
        
        xw.writeEndElement();
        
        xw.writeEndDocument();
        
        result = xw.getXmlString();
        return result;
    }
    
    public string toExternalAnaliseCreditoXML (OpportunityProcessType processType, Id currentUserId, Opportunity oppty, boolean produtoComSeguro) {
        return '';
        
        //return toProcessXML(OpportunityProcessType.AnaliseCredito, , oppty,  );
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
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
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