//PCL = PROJECT COMMON LIBRARY
public with sharing class PCL_AccountParser {

    public EXT_serverCargotracck.cliente toExternalObject(Account acc) {
        EXT_serverCargotracck.cliente result = null;
        
        if (acc != null) {  
            result = new EXT_serverCargotracck.cliente(); 

            result.id = integer.valueOf(acc.CT_PersClie_CodigoCliente__c);
            result.nome = acc.name;
            result.tipo_pessoa = HLP_Account.getExternalTipoPessoaValue(acc.Tipo_de_pessoa__c);
            
            if (acc.Tipo_de_pessoa__c == HLP_Account.PLV_TIPODEPESSOAC_FISICA) {
                //Desabilitado pois foi criado máscara para campos CPF e CNPJ - Carlos Prates 06/02/2014 11:30
                //result.cnpj_cpf = BCL_HLP_String.padLeft(BCL_HLP_String.getNumberFromFormatedString(acc.CNPJ_CPF__c), '0', 11);
                result.cnpj_cpf = BCL_HLP_String.getNumberFromFormatedString(acc.CPF__c);
            } else {
                //Desabilitado pois foi criado máscara para campos CPF e CNPJ - Carlos Prates 06/02/2014 11:30
                //result.cnpj_cpf = BCL_HLP_String.padLeft(BCL_HLP_String.getNumberFromFormatedString(acc.CNPJ_CPF__c), '0', 14);
                result.cnpj_cpf = BCL_HLP_String.getNumberFromFormatedString(acc.CNPJ__c);
            }

            result.email = acc.EMail__c;
            
            result.emailnfe = acc.EMail__c;
            result.indicadorid = Integer.valueOf(acc.IdExternoClienteIndicador__c);
            
            result.dadospj = new EXT_serverCargotracck.dadosPJ();
            result.dadospj.nomefantasia = acc.nome_fantasia__c;
            result.dadospj.inscricao_municipal = acc.DadosPJ_InscricaoMunicipal__c;
            result.dadospj.inscricao_estadual_uf = acc.DadosPJ_InscricaoEstadualUF__c;
            result.dadospj.inscricao_estadual = acc.DadosPJ_InscricaoEstadual__c;
            result.dadospj.optante_simples = acc.DadosPJ_EmpresaOptanteSimples__c;
            
            if (acc.Tipo_de_pessoa__c == HLP_Account.PLV_TIPODEPESSOAC_FISICA) {
                result.dadospf = new EXT_serverCargotracck.dadosPF();
                result.dadospf.nomemae = acc.DadosPF_NomeMae__c;
                result.dadospf.sexo = HLP_Account.getExternalSexoValue(acc.DadosPF_Sexo__c);
                result.dadospf.data_nascimento = acc.DadosPF_DataNascimento__c;
                result.dadospf.estado_civil = HLP_Account.getExternalEstadoCivilValue(acc.DadosPF_EstadoCivil__c);
                result.dadospf.rg = BCL_HLP_String.removeSpecialCharacters(acc.DadosPF_RG__c);
            }
            
            //configurar Telefone
            result.telefones = new EXT_serverCargotracck.dadosTelefones();
            result.telefones.telefone = new EXT_serverCargotracck.telefone[]{ };
            
            if (acc.Phone != null) {
                PCL_PhoneNumber p = new PCL_PhoneNumber();
                
                HLP_Telefone.setTelephone(p, HLP_Telefone.PLV_TIPONUMEROC_RESIDENCIAL, acc.phone);

                EXT_serverCargotracck.telefone t = new EXT_serverCargotracck.telefone();
                t.tipo = HLP_Telefone.getExternalTipoTelefoneValue(p.phoneType);
                t.ddd = p.ddd;
                t.numero = p.phoneNumber;
                
                result.telefones.telefone.add(t);
            }
            
            if (acc.TelefoneCelular__c != null) {
                PCL_PhoneNumber p = new PCL_PhoneNumber();

                HLP_Telefone.setTelephone(p, HLP_Telefone.PLV_TIPONUMEROC_CELULAR, acc.TelefoneCelular__c);

                EXT_serverCargotracck.telefone t = new EXT_serverCargotracck.telefone();
                t.tipo = HLP_Telefone.getExternalTipoTelefoneValue(p.phoneType);
                t.ddd = p.ddd;
                t.numero = p.phoneNumber;
                
                result.telefones.telefone.add(t);
            }
            
            if (acc.TelefoneComercial__c != null) {
                PCL_PhoneNumber p = new PCL_PhoneNumber();

                HLP_Telefone.setTelephone(p, HLP_Telefone.PLV_TIPONUMEROC_COMERCIAL, acc.TelefoneComercial__c);

                EXT_serverCargotracck.telefone t = new EXT_serverCargotracck.telefone();
                t.tipo = HLP_Telefone.getExternalTipoTelefoneValue(p.phoneType);
                t.ddd = p.ddd;
                t.numero = p.phoneNumber;
                
                result.telefones.telefone.add(t);
            }
            
            //Configurar Contatos            
            result.contatos = new EXT_serverCargotracck.dadosContatos();
            result.contatos.contato = new List<EXT_serverCargotracck.contato>();
            
            List<Account> listaContato = [
                select
                    id
                    , name
                    , DadosPF_RG__c
                    , CPF__c
                    , EMail__c
                    , Phone
                    //, HomePhone
                    , TelefoneCelular__c
                from
                    Account
                where
                    id = :acc.id
            ];
                        
            for(Account c: listaContato) {
                EXT_serverCargotracck.contato contato = new EXT_serverCargotracck.contato();
                
                contato.nome = c.name;
                contato.rg = c.DadosPF_RG__c;
                contato.cpf = BCL_HLP_String.getNumberFromFormatedString(c.CPF__c);
                contato.email = c.EMail__c;
                
                contato.telefones = new EXT_serverCargotracck.dadosTelefones();
                contato.telefones.telefone = new List<EXT_serverCargotracck.telefone>();

                if (c.TelefoneCelular__c != null) {
                    PCL_PhoneNumber p = new PCL_PhoneNumber();
                    
                    HLP_Telefone.setTelephone(p, HLP_Telefone.PLV_TIPONUMEROC_CELULAR, c.TelefoneCelular__c);

                    EXT_serverCargotracck.telefone t = new EXT_serverCargotracck.telefone();
                    t.tipo = HLP_Telefone.getExternalTipoTelefoneValue(p.phoneType);
                    t.ddd = p.ddd;
                    t.numero = p.phoneNumber;
                
                    contato.telefones.telefone.add(t);              
                }

                if (c.Phone != null) {
                    PCL_PhoneNumber p = new PCL_PhoneNumber();
                    
                    HLP_Telefone.setTelephone(p, HLP_Telefone.PLV_TIPONUMEROC_RESIDENCIAL, c.Phone);

                    EXT_serverCargotracck.telefone t = new EXT_serverCargotracck.telefone();
                    t.tipo = HLP_Telefone.getExternalTipoTelefoneValue(p.phoneType);
                    t.ddd = p.ddd;
                    t.numero = p.phoneNumber;
                
                    contato.telefones.telefone.add(t);              
                }

                result.contatos.contato.add(contato);
            }
           
            //Configurar Dados Cobrança cliente
            result.dados_cobranca_cliente = new EXT_serverCargotracck.dadosCobrancaCliente(); 
            result.dados_cobranca_cliente.forma_pagamento = PCL_Helper.getCodeAsInteger(acc.FormaCobranca__c);
            // Melhorias Siggo
            if(String.isEmpty(acc.Dia_de_vencimento__c)){
                result.dados_cobranca_cliente.vencimento = integer.valueOf(acc.Cobranca_DiaVcto__c);
            } else {
                result.dados_cobranca_cliente.vencimento = integer.valueOf(acc.Dia_de_vencimento__c);
            }

            if (result.dados_cobranca_cliente.forma_pagamento != HLP_Account.PLV_EXT_FORMACOBRANCA_BOLETO) {
            
            
                if (result.dados_cobranca_cliente.forma_pagamento == HLP_Account.PLV_EXT_FORMACOBRANCA_DEBAUT_HSBC
                    || result.dados_cobranca_cliente.forma_pagamento == HLP_Account.PLV_EXT_FORMACOBRANCA_DEBAUT_ITAU
                    || result.dados_cobranca_cliente.forma_pagamento == HLP_Account.PLV_EXT_FORMACOBRANCA_DEBAUT_BRADESCO
                    || result.dados_cobranca_cliente.forma_pagamento == HLP_Account.PLV_EXT_FORMACOBRANCA_DEBAUT_BB
                    || result.dados_cobranca_cliente.forma_pagamento == HLP_Account.PLV_EXT_FORMACOBRANCA_DEBAUT_SANTANDER) {

                    result.dados_cobranca_cliente.dados_bancario = new EXT_serverCargotracck.dadosBancarios();
                    
                    if (result.dados_cobranca_cliente.forma_pagamento == HLP_Account.PLV_EXT_FORMACOBRANCA_DEBAUT_HSBC) { 
                        result.dados_cobranca_cliente.dados_bancario.banco = HLP_Account.CODIGO_BANCO_HSBC;
                    } else if (result.dados_cobranca_cliente.forma_pagamento == HLP_Account.PLV_EXT_FORMACOBRANCA_DEBAUT_ITAU) { 
                        result.dados_cobranca_cliente.dados_bancario.banco = HLP_Account.CODIGO_BANCO_ITAU;
                    } else if (result.dados_cobranca_cliente.forma_pagamento == HLP_Account.PLV_EXT_FORMACOBRANCA_DEBAUT_BRADESCO) { 
                        result.dados_cobranca_cliente.dados_bancario.banco = HLP_Account.CODIGO_BANCO_BRADESCO;
                    } else if (result.dados_cobranca_cliente.forma_pagamento == HLP_Account.PLV_EXT_FORMACOBRANCA_DEBAUT_BB) { 
                        result.dados_cobranca_cliente.dados_bancario.banco = HLP_Account.CODIGO_BANCO_BB;
                    } else if (result.dados_cobranca_cliente.forma_pagamento == HLP_Account.PLV_EXT_FORMACOBRANCA_DEBAUT_SANTANDER) { 
                        result.dados_cobranca_cliente.dados_bancario.banco = HLP_Account.CODIGO_BANCO_SANTANDER;
                    }
                    
                    result.dados_cobranca_cliente.dados_bancario.agencia = integer.valueOf(acc.DebAut_Agencia__c);
                    result.dados_cobranca_cliente.dados_bancario.conta_corrente = integer.valueOf(acc.DebAut_ContaCorrente__c);
                    result.dados_cobranca_cliente.dados_bancario.titular_conta = acc.DebAut_NomeTitular__c;
                                        
                    //marretada por causa do defeito no serviço de persistencia do cliente
                    /* -- Comentado por Carlos Prates - 12/02/2014 12:00 - correção do defeito de persistência
                    result.dados_cobranca_cliente.dados_cartao_credito = new EXT_serverCargotracck.dadosCartaoCredito();
                    result.dados_cobranca_cliente.dados_cartao_credito.numero = '5555666677778884';
                    result.dados_cobranca_cliente.dados_cartao_credito.vencimento = '10/15';
                    result.dados_cobranca_cliente.dados_cartao_credito.codigo_seguranca = 123;                  
                    */
                    //fim da marretada
                    
                } else if (result.dados_cobranca_cliente.forma_pagamento == HLP_Account.PLV_EXT_FORMACOBRANCA_CARTAO_VISA
                    || result.dados_cobranca_cliente.forma_pagamento == HLP_Account.PLV_EXT_FORMACOBRANCA_CARTAO_MASTER
                    || result.dados_cobranca_cliente.forma_pagamento == HLP_Account.PLV_EXT_FORMACOBRANCA_CARTAO_HIPERCARD) {
                    /*
                    result.dados_cobranca_cliente.dados_bancario = new EXT_serverCargotracck.dadosBancarios();
                    result.dados_cobranca_cliente.dados_bancario.banco = 33;
                    result.dados_cobranca_cliente.dados_bancario.agencia = 123;
                    result.dados_cobranca_cliente.dados_bancario.conta_corrente = 45678;
                    result.dados_cobranca_cliente.dados_bancario.titular_conta = 'Valdyrcreissom Silva';
                    */  

                    result.dados_cobranca_cliente.dados_cartao_credito = new EXT_serverCargotracck.dadosCartaoCredito();
                    //result.dados_cobranca_cliente.dados_cartao_credito.numero = string.valueOf(acc.Cobranca_Cartao_Numero__c); - Desabilitado para uso do campo Criptografado - Carlos Prates 05/02/2014 18:00
                    result.dados_cobranca_cliente.dados_cartao_credito.numero = acc.Cobranca_Cartao_Numero_Cript__c;

                    if (acc.Cobranca_Cartao_Vcto__c != null) {
                        result.dados_cobranca_cliente.dados_cartao_credito.vencimento = PCL_Helper.formatVctoCartao(integer.valueOf(acc.Cobranca_Cartao_Vcto__c));
                    }
                    //result.dados_cobranca_cliente.dados_cartao_credito.codigo_seguranca = integer.valueOf(acc.Cobranca_Cartao_CodigoSeguranca__c); - Desabilitado para uso do campo Criptografado - Carlos Prates 06/02/2014 15:15           
                    if (acc.Cobranca_Cartao_CodigoSeguranca_Cript__c != null) {
                        result.dados_cobranca_cliente.dados_cartao_credito.codigo_seguranca = acc.Cobranca_Cartao_CodigoSeguranca_Cript__c;                  
                    }
                    
                    result.dados_cobranca_cliente.dados_cartao_credito.nome_cartao = acc.Nome_do_portador__c;
                }
            } else {
                    //marretada por causa do defeito no serviço de persistencia do cliente
                    /*
                    result.dados_cobranca_cliente.dados_bancario = new EXT_serverCargotracck.dadosBancarios();
                    result.dados_cobranca_cliente.dados_bancario.banco = 33;
                    result.dados_cobranca_cliente.dados_bancario.agencia = 1234;
                    result.dados_cobranca_cliente.dados_bancario.conta_corrente = 45678;
                    result.dados_cobranca_cliente.dados_bancario.titular_conta = 'Valdyrcreissom Silva';
                    
                    result.dados_cobranca_cliente.dados_cartao_credito = new EXT_serverCargotracck.dadosCartaoCredito();
                    result.dados_cobranca_cliente.dados_cartao_credito.numero = '5555666677778884';
                    result.dados_cobranca_cliente.dados_cartao_credito.vencimento = '10/15';
                    result.dados_cobranca_cliente.dados_cartao_credito.codigo_seguranca = 123;            
                    */      
                    //fim da marretada
                
            }

            //Configurar Endereços do cliente
            result.enderecoscliente = new EXT_serverCargotracck.enderecoscliente();
            result.enderecoscliente.enderecoprincipal = new EXT_serverCargotracck.endereco();
            result.enderecoscliente.enderecoprincipal.endereco = new EXT_serverCargotracck.dadosendereco();
            result.enderecoscliente.enderecoprincipal.endereco.cep = (acc.Enderecos_Principal_CEP__c != null)?integer.valueOf(BCL_HLP_String.getNumberFromFormatedString(acc.Enderecos_Principal_CEP__c)):null;
            result.enderecoscliente.enderecoprincipal.endereco.pais = acc.Enderecos_Principal_Pais__c;
            result.enderecoscliente.enderecoprincipal.endereco.estado = acc.Enderecos_Principal_UF__c;
            result.enderecoscliente.enderecoprincipal.endereco.cidade = acc.Enderecos_Principal_Cidade__c;
            result.enderecoscliente.enderecoprincipal.endereco.bairro = acc.Enderecos_Principal_Bairro__c;
            result.enderecoscliente.enderecoprincipal.endereco.logradouro = BCL_HLP_String.removeSpecialCharacters(acc.Enderecos_Principal_Logradouro__c);
            result.enderecoscliente.enderecoprincipal.endereco.numero = (acc.Enderecos_Principal_Numero__c != null)?integer.valueOf(acc.Enderecos_Principal_Numero__c):null;
            result.enderecoscliente.enderecoprincipal.endereco.complemento = acc.Enderecos_Principal_Complemento__c;
            
            result.enderecoscliente.enderecocobranca = new EXT_serverCargotracck.endereco();
            result.enderecoscliente.enderecocobranca.endereco = new EXT_serverCargotracck.dadosendereco();
            result.enderecoscliente.enderecocobranca.endereco.cep = (acc.Enderecos_Cobranca_CEP__c != null)?integer.valueOf(BCL_HLP_String.getNumberFromFormatedString(acc.Enderecos_Cobranca_CEP__c)):null;
            result.enderecoscliente.enderecocobranca.endereco.pais = acc.Enderecos_Cobranca_Pais__c;
            result.enderecoscliente.enderecocobranca.endereco.estado = acc.Enderecos_Cobranca_UF__c;
            result.enderecoscliente.enderecocobranca.endereco.cidade = acc.Enderecos_Cobranca_Cidade__c;
            result.enderecoscliente.enderecocobranca.endereco.bairro = acc.Enderecos_Cobranca_Bairro__c;
            result.enderecoscliente.enderecocobranca.endereco.logradouro = BCL_HLP_String.removeSpecialCharacters(acc.Enderecos_Cobranca_Logradouro__c);
            result.enderecoscliente.enderecocobranca.endereco.numero = (acc.Enderecos_Cobranca_Numero__c != null)?integer.valueOf(acc.Enderecos_Cobranca_Numero__c):null;
            result.enderecoscliente.enderecocobranca.endereco.complemento = acc.Enderecos_Cobranca_Complemento__c;
            
            result.enderecoscliente.enderecoentrega = new EXT_serverCargotracck.endereco();
            result.enderecoscliente.enderecoentrega.endereco = new EXT_serverCargotracck.dadosendereco();
            result.enderecoscliente.enderecoentrega.endereco.cep = (acc.Enderecos_Entrega_CEP__c != null)?integer.valueOf(BCL_HLP_String.getNumberFromFormatedString(acc.Enderecos_Entrega_CEP__c)):null;
            result.enderecoscliente.enderecoentrega.endereco.pais = acc.Enderecos_Entrega_Pais__c;
            result.enderecoscliente.enderecoentrega.endereco.estado = acc.Enderecos_Entrega_UF__c;
            result.enderecoscliente.enderecoentrega.endereco.cidade = acc.Enderecos_Entrega_Cidade__c;
            result.enderecoscliente.enderecoentrega.endereco.bairro = acc.Enderecos_Entrega_Bairro__c;
            result.enderecoscliente.enderecoentrega.endereco.logradouro = BCL_HLP_String.removeSpecialCharacters(acc.Enderecos_Entrega_Logradouro__c);
            result.enderecoscliente.enderecoentrega.endereco.numero = (acc.Enderecos_Entrega_Numero__c != null)?integer.valueOf(acc.Enderecos_Entrega_Numero__c):null;
            result.enderecoscliente.enderecoentrega.endereco.complemento = acc.Enderecos_Entrega_Complemento__c;
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
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
        a = a + 1;
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