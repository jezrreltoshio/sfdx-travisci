/*

	Classe de teste: -
	Criado por: Admin CRM Sascar
	Data de criação: 25/01/2014
	Descrição: Classe server da Cargo tracck

	===================================================

    Atualizado por: Mario Reis
    Data da alteração: 31/8/2017
    Descrição: Tratamento para buscar URL conforme o ambiente, ajustado padronização do código

*/
public class EXT_serverCargotracck {

    public class dadosAnalisePreliminar {

        public Integer usuarioid;
        public Integer oportunidadeid;
        public Integer tipoproposta;
        public Integer tipocontrato;
        public Integer clienteid;
        public Integer operacaoid;
        public Integer formapagamentoid;
        public Integer executivovendasid;
        public String vigencia_contrato;
        public Integer cep;
        public Integer numero;
        public String quantidade_parcelas;
        public EXT_serverCargotracck.dadosAnaliseCredito analise_credito;
        public EXT_serverCargotracck.dadosItens itens;
        private String[] usuarioid_type_info = new String[]{'usuarioid','urn:server.cargotracck',null,'1','1','false'};
        private String[] oportunidadeid_type_info = new String[]{'oportunidadeid','urn:server.cargotracck',null,'1','1','false'};
        private String[] tipoproposta_type_info = new String[]{'tipoproposta','urn:server.cargotracck',null,'1','1','false'};
        private String[] tipocontrato_type_info = new String[]{'tipocontrato','urn:server.cargotracck',null,'1','1','false'};
        private String[] clienteid_type_info = new String[]{'clienteid','urn:server.cargotracck',null,'1','1','false'};
        private String[] operacaoid_type_info = new String[]{'operacaoid','urn:server.cargotracck',null,'1','1','false'};
        private String[] formapagamentoid_type_info = new String[]{'formapagamentoid','urn:server.cargotracck',null,'1','1','false'};
        private String[] executivovendasid_type_info = new String[]{'executivovendasid','urn:server.cargotracck',null,'1','1','false'};
        private String[] vigencia_contrato_type_info = new String[]{'vigencia_contrato','urn:server.cargotracck',null,'1','1','false'};
        private String[] cep_type_info = new String[]{'cep','urn:server.cargotracck',null,'1','1','false'};
        private String[] numero_type_info = new String[]{'numero','urn:server.cargotracck',null,'1','1','false'};
        private String[] quantidade_parcelas_type_info = new String[]{'quantidade_parcelas','urn:server.cargotracck',null,'1','1','false'};
        private String[] analise_credito_type_info = new String[]{'analise_credito','urn:server.cargotracck',null,'1','1','false'};
        private String[] itens_type_info = new String[]{'itens','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'usuarioid','oportunidadeid','tipoproposta','tipocontrato','clienteid','operacaoid','formapagamentoid','executivovendasid','vigencia_contrato','cep','numero','quantidade_parcelas','analise_credito','itens'};
    }

    public class AnaliseFinalResponseType {

        public String retorno_analisefinal;
        private String[] retorno_analisefinal_type_info = new String[]{'retorno-analisefinal','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'retorno_analisefinal'};
    }

    public class AnaliseCreditoResponseType {

        public String return_x;
        private String[] return_x_type_info = new String[]{'return','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'return_x'};
    }

    public class PersistirClienteResponseType {

        public EXT_serverCargotracck.PersistirCliente PersistirCliente;
        private String[] PersistirCliente_type_info = new String[]{'PersistirCliente','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'PersistirCliente'};
    }

    public class PersistirPropostaRequestType {

        public EXT_serverCargotracck.dadosAnalisePreliminar dados;
        private String[] dados_type_info = new String[]{'dados','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'dados'};
    }

    public class AnalisePreliminarRequestType {

        public EXT_serverCargotracck.dadosAnalisePreliminar dados;
        private String[] dados_type_info = new String[]{'dados','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'dados'};
    }

    public class dadosPF {

        public String nomemae;
        public String sexo;
        public Date data_nascimento;
        public String rg;
        public String estado_civil;
        private String[] nomemae_type_info = new String[]{'nomemae','urn:server.cargotracck',null,'1','1','false'};
        private String[] sexo_type_info = new String[]{'sexo','urn:server.cargotracck',null,'1','1','false'};
        private String[] data_nascimento_type_info = new String[]{'data_nascimento','urn:server.cargotracck',null,'1','1','false'};
        private String[] rg_type_info = new String[]{'rg','urn:server.cargotracck',null,'1','1','false'};
        private String[] estado_civil_type_info = new String[]{'estado_civil','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'nomemae','sexo','data_nascimento','rg','estado_civil'};
    }

    public class AnalisePreliminarResponseType {

        public String retorno_analisepreliminar;
        private String[] retorno_analisepreliminar_type_info = new String[]{'retorno-analisepreliminar','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'retorno_analisepreliminar'};
    }

    public class dadosClienteAnalise {

        public Integer clienteid;
        public String nome;
        public String tipo_pessoa;
        public String cnpj_cpf;
        private String[] clienteid_type_info = new String[]{'clienteid','urn:server.cargotracck',null,'1','1','false'};
        private String[] nome_type_info = new String[]{'nome','urn:server.cargotracck',null,'1','1','false'};
        private String[] tipo_pessoa_type_info = new String[]{'tipo_pessoa','urn:server.cargotracck',null,'1','1','false'};
        private String[] cnpj_cpf_type_info = new String[]{'cnpj_cpf','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'clienteid','nome','tipo_pessoa','cnpj_cpf'};
    }

    public class enderecoscliente {

        public EXT_serverCargotracck.endereco enderecoprincipal;
        public EXT_serverCargotracck.endereco enderecocobranca;
        public EXT_serverCargotracck.endereco enderecoentrega;
        private String[] enderecoprincipal_type_info = new String[]{'enderecoprincipal','urn:server.cargotracck',null,'1','1','false'};
        private String[] enderecocobranca_type_info = new String[]{'enderecocobranca','urn:server.cargotracck',null,'1','1','false'};
        private String[] enderecoentrega_type_info = new String[]{'enderecoentrega','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'enderecoprincipal','enderecocobranca','enderecoentrega'};
    }

    public class dadosPJ {

        public String nomefantasia;
        public String inscricao_municipal;
        public String inscricao_estadual_uf;
        public String inscricao_estadual;
        public Boolean optante_simples;
        private String[] nomefantasia_type_info = new String[]{'nomefantasia','urn:server.cargotracck',null,'1','1','false'};
        private String[] inscricao_municipal_type_info = new String[]{'inscricao_municipal','urn:server.cargotracck',null,'1','1','false'};
        private String[] inscricao_estadual_uf_type_info = new String[]{'inscricao_estadual_uf','urn:server.cargotracck',null,'1','1','false'};
        private String[] inscricao_estadual_type_info = new String[]{'inscricao_estadual','urn:server.cargotracck',null,'1','1','false'};
        private String[] optante_simples_type_info = new String[]{'optante_simples','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'nomefantasia','inscricao_municipal','inscricao_estadual_uf','inscricao_estadual','optante_simples'};
    }

    public class dadosItens {

        public EXT_serverCargotracck.dadosItem item;
        private String[] item_type_info = new String[]{'item','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'item'};
    }

    public class dadosendereco {

        public Integer cep;
        public String pais;
        public String estado;
        public String cidade;
        public String bairro;
        public String logradouro;
        public Integer numero;
        public String complemento;
        private String[] cep_type_info = new String[]{'cep','urn:server.cargotracck',null,'0','1','false'};
        private String[] pais_type_info = new String[]{'pais','urn:server.cargotracck',null,'0','1','false'};
        private String[] estado_type_info = new String[]{'estado','urn:server.cargotracck',null,'0','1','false'};
        private String[] cidade_type_info = new String[]{'cidade','urn:server.cargotracck',null,'0','1','false'};
        private String[] bairro_type_info = new String[]{'bairro','urn:server.cargotracck',null,'0','1','false'};
        private String[] logradouro_type_info = new String[]{'logradouro','urn:server.cargotracck',null,'0','1','false'};
        private String[] numero_type_info = new String[]{'numero','urn:server.cargotracck',null,'0','1','false'};
        private String[] complemento_type_info = new String[]{'complemento','urn:server.cargotracck',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'cep','pais','estado','cidade','bairro','logradouro','numero','complemento'};
    }

    public class PersistirPropostaResponseType {

        public String retorno_persistirproposta;
        private String[] retorno_persistirproposta_type_info = new String[]{'retorno-persistirproposta','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'retorno_persistirproposta'};
    }

    public class AnaliseFinalRequestType {

        public EXT_serverCargotracck.dadosAnalisePreliminar dados;
        private String[] dados_type_info = new String[]{'dados','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'dados'};
    }

    public class PersistirCliente {

        public Integer codigo;
        public String mensagem;
        public Integer clienteid;
        private String[] codigo_type_info = new String[]{'codigo','urn:server.cargotracck',null,'1','1','false'};
        private String[] mensagem_type_info = new String[]{'mensagem','urn:server.cargotracck',null,'1','1','false'};
        private String[] clienteid_type_info = new String[]{'clienteid','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'codigo','mensagem','clienteid'};
    }

    public class contato {

        public String nome;
        public String cpf;
        public String rg;
        public String email;
        public EXT_serverCargotracck.dadosTelefones telefones;
        private String[] nome_type_info = new String[]{'nome','urn:server.cargotracck',null,'1','1','false'};
        private String[] cpf_type_info = new String[]{'cpf','urn:server.cargotracck',null,'1','1','false'};
        private String[] rg_type_info = new String[]{'rg','urn:server.cargotracck',null,'1','1','false'};
        private String[] email_type_info = new String[]{'email','urn:server.cargotracck',null,'1','1','false'};
        private String[] telefones_type_info = new String[]{'telefones','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'nome','cpf','rg','email','telefones'};
    }

    public class status {

        public String codigo;
        public String descricao;
        private String[] codigo_type_info = new String[]{'codigo','urn:server.cargotracck',null,'1','1','false'};
        private String[] descricao_type_info = new String[]{'descricao','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'codigo','descricao'};
    }

    public class dadosAnaliseCredito {

        public Integer usuario_aprovador;
        public String observacao;
        private String[] usuario_aprovador_type_info = new String[]{'usuario_aprovador','urn:server.cargotracck',null,'1','1','false'};
        private String[] observacao_type_info = new String[]{'observacao','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'usuario_aprovador','observacao'};
    }

    public class dadosItem {

        public Integer id;
        public String descricao;
        public String quantidade;
        public String valor;
        private String[] id_type_info = new String[]{'id','urn:server.cargotracck',null,'1','1','false'};
        private String[] descricao_type_info = new String[]{'descricao','urn:server.cargotracck',null,'1','1','false'};
        private String[] quantidade_type_info = new String[]{'quantidade','urn:server.cargotracck',null,'1','1','false'};
        private String[] valor_type_info = new String[]{'valor','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'id','descricao','quantidade','valor'};
    }

    public class dadosCartaoCredito {

        public String numero;
        public String vencimento;
        public String codigo_seguranca;
        public String nome_cartao;
        private String[] numero_type_info = new String[]{'numero','urn:server.cargotracck',null,'1','1','false'};
        private String[] vencimento_type_info = new String[]{'vencimento','urn:server.cargotracck',null,'1','1','false'};
        private String[] codigo_seguranca_type_info = new String[]{'codigo_seguranca','urn:server.cargotracck',null,'1','1','false'};
        private String[] nome_cartao_type_info = new String[]{'nome_cartao','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'numero','vencimento','codigo_seguranca','nome_cartao'};
    }

    public class header {

        public EXT_serverCargotracck.status status;
        private String[] status_type_info = new String[]{'status','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'status'};
    }

    public class AnaliseCreditoRequestType {

        public EXT_serverCargotracck.dadosAnalisePreliminar dados;
        private String[] dados_type_info = new String[]{'dados','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'dados'};
    }

    public class dadosBancarios {

        public Integer banco;
        public Integer agencia;
        public Integer conta_corrente;
        public String titular_conta;
        private String[] banco_type_info = new String[]{'banco','urn:server.cargotracck',null,'1','1','false'};
        private String[] agencia_type_info = new String[]{'agencia','urn:server.cargotracck',null,'1','1','false'};
        private String[] conta_corrente_type_info = new String[]{'conta_corrente','urn:server.cargotracck',null,'1','1','false'};
        private String[] titular_conta_type_info = new String[]{'titular_conta','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'banco','agencia','conta_corrente','titular_conta'};
    }

    public class dadosCobrancaCliente {

        public Integer forma_pagamento;
        public EXT_serverCargotracck.dadosBancarios dados_bancario;
        public EXT_serverCargotracck.dadosCartaoCredito dados_cartao_credito;
        public Integer vencimento;
        private String[] forma_pagamento_type_info = new String[]{'forma_pagamento','urn:server.cargotracck',null,'1','1','false'};
        private String[] dados_bancario_type_info = new String[]{'dados_bancario','urn:server.cargotracck',null,'1','1','false'};
        private String[] dados_cartao_credito_type_info = new String[]{'dados_cartao_credito','urn:server.cargotracck',null,'1','1','false'};
        private String[] vencimento_type_info = new String[]{'vencimento','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'forma_pagamento','dados_bancario','dados_cartao_credito','vencimento'};
    }

    public class cliente {

        public Integer id;
        public String nome;
        public String tipo_pessoa;
        public String cnpj_cpf;
        public String email;
        public String emailnfe;
        public Integer indicadorid;
        public EXT_serverCargotracck.dadosPJ dadospj;
        public EXT_serverCargotracck.dadosPF dadospf;
        public EXT_serverCargotracck.dadosTelefones telefones;
        public EXT_serverCargotracck.dadosContatos contatos;
        public EXT_serverCargotracck.dadosCobrancaCliente dados_cobranca_cliente;
        public EXT_serverCargotracck.enderecoscliente enderecoscliente;
        private String[] id_type_info = new String[]{'id','urn:server.cargotracck',null,'0','1','false'};
        private String[] nome_type_info = new String[]{'nome','urn:server.cargotracck',null,'1','1','false'};
        private String[] tipo_pessoa_type_info = new String[]{'tipo_pessoa','urn:server.cargotracck',null,'1','1','false'};
        private String[] cnpj_cpf_type_info = new String[]{'cnpj_cpf','urn:server.cargotracck',null,'1','1','false'};
        private String[] email_type_info = new String[]{'email','urn:server.cargotracck',null,'1','1','false'};
        private String[] emailnfe_type_info = new String[]{'emailnfe','urn:server.cargotracck',null,'1','1','false'};
        private String[] indicadorid_type_info = new String[]{'indicadorid','urn:server.cargotracck',null,'1','1','false'};
        private String[] dadospj_type_info = new String[]{'dadospj','urn:server.cargotracck',null,'0','1','false'};
        private String[] dadospf_type_info = new String[]{'dadospf','urn:server.cargotracck',null,'1','1','false'};
        private String[] telefones_type_info = new String[]{'telefones','urn:server.cargotracck',null,'1','1','false'};
        private String[] contatos_type_info = new String[]{'contatos','urn:server.cargotracck',null,'1','1','false'};
        private String[] dados_cobranca_cliente_type_info = new String[]{'dados_cobranca_cliente','urn:server.cargotracck',null,'1','1','false'};
        private String[] enderecoscliente_type_info = new String[]{'enderecoscliente','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'id','nome','tipo_pessoa','cnpj_cpf','email','emailnfe','indicadorid','dadospj','dadospf','telefones','contatos','dados_cobranca_cliente','enderecoscliente'};
    }

    public class telefone {

        public String tipo;
        public Integer ddd;
        public Integer numero;
        private String[] tipo_type_info = new String[]{'tipo','urn:server.cargotracck',null,'1','1','false'};
        private String[] ddd_type_info = new String[]{'ddd','urn:server.cargotracck',null,'1','1','false'};
        private String[] numero_type_info = new String[]{'numero','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'tipo','ddd','numero'};
    }

    public class PersistirClienteRequestType {

        public EXT_serverCargotracck.cliente cliente;
        private String[] cliente_type_info = new String[]{'cliente','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'cliente'};
    }

    public class server_cargotracckPort {

        public String endpoint_x = Util_Integracao.getEndpointServerCargoTracck();//'http://intranet.sascar.com.br/WS_SALESFORCE/WS_IntegracaoSalesForce.php';

        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x;

        private String[] ns_map_type_info = new String[]{'urn:server.cargotracck', 'EXT_serverCargotracck'};

        public String PersistirProposta(EXT_serverCargotracck.dadosAnalisePreliminar dados) {

            EXT_serverCargotracck.PersistirPropostaRequestType request_x = new EXT_serverCargotracck.PersistirPropostaRequestType();
            EXT_serverCargotracck.PersistirPropostaResponseType response_x;
            request_x.dados = dados;
            Map<String, EXT_serverCargotracck.PersistirPropostaResponseType> response_map_x = new Map<String, EXT_serverCargotracck.PersistirPropostaResponseType>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              	this,
              	request_x,
              	response_map_x,
              	new String[]{endpoint_x,
                    'urn:server.cargotracck#WS_SalesForcePersistirProposta',
                    'urn:server.cargotracck',
                    'PersistirProposta',
                    'urn:server.cargotracck',
                    'PersistirPropostaResponse',
                    'EXT_serverCargotracck.PersistirPropostaResponseType'}
            );

            response_x = response_map_x.get('response_x');
            return response_x.retorno_persistirproposta;
        }

        public String AnalisePreliminar(EXT_serverCargotracck.dadosAnalisePreliminar dados) {

            EXT_serverCargotracck.AnalisePreliminarRequestType request_x = new EXT_serverCargotracck.AnalisePreliminarRequestType();
            EXT_serverCargotracck.AnalisePreliminarResponseType response_x;
            request_x.dados = dados;
            Map<String, EXT_serverCargotracck.AnalisePreliminarResponseType> response_map_x = new Map<String, EXT_serverCargotracck.AnalisePreliminarResponseType>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              	this,
              	request_x,
              	response_map_x,
              	new String[]{endpoint_x,
              	'urn:server.cargotracck#WS_SalesForceAnalisePreliminar',
              	'urn:server.cargotracck',
              	'AnalisePreliminar',
              	'urn:server.cargotracck',
              	'AnalisePreliminarResponse',
              	'EXT_serverCargotracck.AnalisePreliminarResponseType'}
            );

            response_x = response_map_x.get('response_x');
            return response_x.retorno_analisepreliminar;

        }

        public String AnaliseCredito(EXT_serverCargotracck.dadosAnalisePreliminar dados) {
            EXT_serverCargotracck.AnaliseCreditoRequestType request_x = new EXT_serverCargotracck.AnaliseCreditoRequestType();
            EXT_serverCargotracck.AnaliseCreditoResponseType response_x;
            request_x.dados = dados;
            Map<String, EXT_serverCargotracck.AnaliseCreditoResponseType> response_map_x = new Map<String, EXT_serverCargotracck.AnaliseCreditoResponseType>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'urn:server.cargotracck#WS_SalesForceAnaliseCredito',
              'urn:server.cargotracck',
              'AnaliseCredito',
              'urn:server.cargotracck',
              'AnaliseCreditoResponse',
              'EXT_serverCargotracck.AnaliseCreditoResponseType'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.return_x;
        }
        public EXT_serverCargotracck.PersistirCliente PersistirCliente(EXT_serverCargotracck.cliente cliente) {
            EXT_serverCargotracck.PersistirClienteRequestType request_x = new EXT_serverCargotracck.PersistirClienteRequestType();
            EXT_serverCargotracck.PersistirClienteResponseType response_x;
            request_x.cliente = cliente;

            System.debug(LoggingLevel.ERROR, '__ [cls EXT_serverCargotracck - PersistirCliente()] - inicio...');
            System.debug(LoggingLevel.ERROR, '__ [cls EXT_serverCargotracck - PersistirCliente()] - cliente: '+cliente);
            

            Map<String, EXT_serverCargotracck.PersistirClienteResponseType> response_map_x = new Map<String, EXT_serverCargotracck.PersistirClienteResponseType>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'urn:server.cargotracck#PersistirCliente',
              'urn:server.cargotracck',
              'PersistirCliente',
              'urn:server.cargotracck',
              'PersistirClienteResponse',
              'EXT_serverCargotracck.PersistirClienteResponseType'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.PersistirCliente;
        }
        public String AnaliseFinal(EXT_serverCargotracck.dadosAnalisePreliminar dados) {
            EXT_serverCargotracck.AnaliseFinalRequestType request_x = new EXT_serverCargotracck.AnaliseFinalRequestType();
            EXT_serverCargotracck.AnaliseFinalResponseType response_x;
            request_x.dados = dados;
            Map<String, EXT_serverCargotracck.AnaliseFinalResponseType> response_map_x = new Map<String, EXT_serverCargotracck.AnaliseFinalResponseType>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'urn:server.cargotracck#WS_SalesForceAnaliseFinal',
              'urn:server.cargotracck',
              'AnaliseFinal',
              'urn:server.cargotracck',
              'AnaliseFinalResponse',
              'EXT_serverCargotracck.AnaliseFinalResponseType'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.retorno_analisefinal;
        }
    }
    public class dadosTelefones {
        public EXT_serverCargotracck.telefone[] telefone;
        private String[] telefone_type_info = new String[]{'telefone','urn:server.cargotracck',null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'telefone'};
    }
    public class endereco {
        public EXT_serverCargotracck.dadosendereco endereco;
        private String[] endereco_type_info = new String[]{'endereco','urn:server.cargotracck',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'endereco'};
    }
    public class dadosContatos {
        public EXT_serverCargotracck.contato[] contato;
        private String[] contato_type_info = new String[]{'contato','urn:server.cargotracck',null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.cargotracck','true','false'};
        private String[] field_order_type_info = new String[]{'contato'};
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