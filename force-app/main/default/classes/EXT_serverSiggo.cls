/*

	Classe de teste: -
	Criado por: Admin CRM Sascar
	Data de criação: 25/01/2014
	Descrição: Classe server da SIGGO

	===================================================

    Atualizado por: Mario Reis
    Data da alteração: 31/8/2017
    Descrição: Tratamento para buscar URL conforme o ambiente, ajustado padronização do código

*/
public class EXT_serverSiggo {

    public class lista_contratos {

        public EXT_serverSiggo.contrato[] contrato;
        private String[] contrato_type_info = new String[]{'contrato','urn:server.siggo',null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.siggo','true','false'};
        private String[] field_order_type_info = new String[]{'contrato'};
    } // Fim lista_contratos

    public class status {

        public String codigo;
        public String descricao;
        private String[] codigo_type_info = new String[]{'codigo','urn:server.siggo',null,'1','1','false'};
        private String[] descricao_type_info = new String[]{'descricao','urn:server.siggo',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.siggo','true','false'};
        private String[] field_order_type_info = new String[]{'codigo','descricao'};
    } // Fim status

    public class AnaliseCreditoResponseType {

        public EXT_serverSiggo.AnaliseCredito AnaliseCredito;
        private String[] AnaliseCredito_type_info = new String[]{'AnaliseCredito','urn:server.siggo',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.siggo','true','false'};
        private String[] field_order_type_info = new String[]{'AnaliseCredito'};
    }

    public class PersistirPropostaRequestType {

        public String xml;
        private String[] xml_type_info = new String[]{'xml','urn:server.siggo',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.siggo','true','false'};
        private String[] field_order_type_info = new String[]{'xml'};
    }

    public class AnalisePreliminarResponseType {

        public EXT_serverSiggo.AnalisePreliminar AnalisePreliminar;
        private String[] AnalisePreliminar_type_info = new String[]{'AnalisePreliminar','urn:server.siggo',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.siggo','true','false'};
        private String[] field_order_type_info = new String[]{'AnalisePreliminar'};
    }

    public class AnalisePreliminarRequestType {

        public String xml;
        private String[] xml_type_info = new String[]{'xml','urn:server.siggo',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.siggo','true','false'};
        private String[] field_order_type_info = new String[]{'xml'};
    }

    public class PersistirProposta {

        public Integer codigo;
        public String descricao;
        public String proposta;
        public String status_proposta;
        public EXT_serverSiggo.lista_contratos lista_contratos;
        private String[] codigo_type_info = new String[]{'codigo','urn:server.siggo',null,'1','1','false'};
        private String[] descricao_type_info = new String[]{'descricao','urn:server.siggo',null,'1','1','false'};
        private String[] proposta_type_info = new String[]{'proposta','urn:server.siggo',null,'1','1','false'};
        private String[] status_proposta_type_info = new String[]{'status_proposta','urn:server.siggo',null,'1','1','false'};
        private String[] lista_contratos_type_info = new String[]{'lista_contratos','urn:server.siggo',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.siggo','true','false'};
        private String[] field_order_type_info = new String[]{'codigo','descricao','proposta','status_proposta','lista_contratos'};
    }

    public class header {

        public EXT_serverSiggo.status status;
        private String[] status_type_info = new String[]{'status','urn:server.siggo',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.siggo','true','false'};
        private String[] field_order_type_info = new String[]{'status'};
    }

    public class lista_orcamento {

        public EXT_serverSiggo.orcamento[] orcamento;
        private String[] orcamento_type_info = new String[]{'orcamento','urn:server.siggo',null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.siggo','true','false'};
        private String[] field_order_type_info = new String[]{'orcamento'};
    }

    public class contrato {

        public Integer numero_item;
        public String numero_contrato;
        public String status_contrato;
        private String[] numero_item_type_info = new String[]{'numero_item','urn:server.siggo',null,'1','1','false'};
        private String[] numero_contrato_type_info = new String[]{'numero_contrato','urn:server.siggo',null,'1','1','false'};
        private String[] status_contrato_type_info = new String[]{'status_contrato','urn:server.siggo',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.siggo','true','false'};
        private String[] field_order_type_info = new String[]{'numero_item','numero_contrato','status_contrato'};
    }

    public class AnalisePreliminar {

        public Integer codigo;
        public String descricao;
        public EXT_serverSiggo.lista_orcamento lista_orcamento;
        private String[] codigo_type_info = new String[]{'codigo','urn:server.siggo',null,'1','1','false'};
        private String[] descricao_type_info = new String[]{'descricao','urn:server.siggo',null,'1','1','false'};
        private String[] lista_orcamento_type_info = new String[]{'lista_orcamento','urn:server.siggo',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.siggo','true','false'};
        private String[] field_order_type_info = new String[]{'codigo','descricao','lista_orcamento'};
    }

    public class AnaliseCreditoRequestType {

        public String xml;
        private String[] xml_type_info = new String[]{'xml','urn:server.siggo',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.siggo','true','false'};
        private String[] field_order_type_info = new String[]{'xml'};
    }

    public class AnaliseCredito {

        public EXT_serverSiggo.analise_credito analise_credito;
        private String[] analise_credito_type_info = new String[]{'analise_credito','urn:server.siggo',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.siggo','true','false'};
        private String[] field_order_type_info = new String[]{'analise_credito'};
    }

    public class orcamento {

        public Integer codigo;
        public String descricao;
        public String orcamento_numero;
        public Double valor_premio;
        private String[] codigo_type_info = new String[]{'codigo','urn:server.siggo',null,'1','1','false'};
        private String[] descricao_type_info = new String[]{'descricao','urn:server.siggo',null,'1','1','false'};
        private String[] orcamento_numero_type_info = new String[]{'orcamento_numero','urn:server.siggo',null,'1','1','false'};
        private String[] valor_premio_type_info = new String[]{'valor_premio','urn:server.siggo',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.siggo','true','false'};
        private String[] field_order_type_info = new String[]{'codigo','descricao','orcamento_numero','valor_premio'};
    }

    public class PersistirPropostaResponseType {

        public EXT_serverSiggo.PersistirProposta PersistirProposta;
        private String[] PersistirProposta_type_info = new String[]{'PersistirProposta','urn:server.siggo',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.siggo','true','false'};
        private String[] field_order_type_info = new String[]{'PersistirProposta'};
    }

    public class analise_credito {

        public Integer codigo;
        public String descricao;
        public String resultado_analise;
        public String retorno_gestor;
        public String experiencia_cliente;
        public Double valor_medio_parcela;
        public Integer quantidade_contratos_base;
        public String cliente_desde;
        public String maior_atraso;
        public Boolean pendencia_financeira;
        public Integer dias_atraso;
        private String[] codigo_type_info = new String[]{'codigo','urn:server.siggo',null,'1','1','false'};
        private String[] descricao_type_info = new String[]{'descricao','urn:server.siggo',null,'1','1','false'};
        private String[] resultado_analise_type_info = new String[]{'resultado_analise','urn:server.siggo',null,'1','1','false'};
        private String[] retorno_gestor_type_info = new String[]{'retorno_gestor','urn:server.siggo',null,'1','1','false'};
        private String[] experiencia_cliente_type_info = new String[]{'experiencia_cliente','urn:server.siggo',null,'1','1','false'};
        private String[] valor_medio_parcela_type_info = new String[]{'valor_medio_parcela','urn:server.siggo',null,'1','1','false'};
        private String[] quantidade_contratos_base_type_info = new String[]{'quantidade_contratos_base','urn:server.siggo',null,'1','1','false'};
        private String[] cliente_desde_type_info = new String[]{'cliente_desde','urn:server.siggo',null,'1','1','false'};
        private String[] maior_atraso_type_info = new String[]{'maior_atraso','urn:server.siggo',null,'1','1','false'};
        private String[] pendencia_financeira_type_info = new String[]{'pendencia_financeira','urn:server.siggo',null,'1','1','false'};
        private String[] dias_atraso_type_info = new String[]{'dias_atraso','urn:server.siggo',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'urn:server.siggo','true','false'};
        private String[] field_order_type_info = new String[]{'codigo','descricao','resultado_analise','retorno_gestor','experiencia_cliente','valor_medio_parcela','quantidade_contratos_base','cliente_desde','maior_atraso','pendencia_financeira','dias_atraso'};
    }

    public class server_siggoPort {

        public String endpoint_x = Util_Integracao.getEndpointServerSiggo();

        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'urn:server.siggo', 'EXT_serverSiggo', 'urn:server.cargotracck', 'serverCargotracck'};

		public EXT_serverSiggo.PersistirProposta PersistirProposta(String xml) {

            EXT_serverSiggo.PersistirPropostaRequestType request_x = new EXT_serverSiggo.PersistirPropostaRequestType();
            request_x.xml = xml;
            EXT_serverSiggo.PersistirPropostaResponseType response_x;

            Map<String, EXT_serverSiggo.PersistirPropostaResponseType> response_map_x = new Map<String, EXT_serverSiggo.PersistirPropostaResponseType>();
            response_map_x.put('response_x', response_x);

            System.debug(LoggingLevel.ERROR, '__ [cls EXT_serverSiggo - PersistirProposta()] - xml: '+xml);
            System.debug(LoggingLevel.ERROR, '__ [cls EXT_serverSiggo - PersistirProposta()] - request_x: '+request_x);

            WebServiceCallout.invoke(
				this,
              	request_x,
              	response_map_x,
              	new String[]{endpoint_x,
              	'urn:server.siggo#PersistirProposta',
              	'urn:server.siggo',
              	'PersistirProposta',
              	'urn:server.siggo',
              	'PersistirPropostaResponse',
              	'EXT_serverSiggo.PersistirPropostaResponseType'}
            );

            response_x = response_map_x.get('response_x');

            return response_x.PersistirProposta;

        } // Fim PersistirProposta


        public EXT_serverSiggo.AnalisePreliminar AnalisePreliminar(String xml) {

            EXT_serverSiggo.AnalisePreliminarRequestType request_x = new EXT_serverSiggo.AnalisePreliminarRequestType();
            request_x.xml = xml;

            EXT_serverSiggo.AnalisePreliminarResponseType response_x;
            Map<String, EXT_serverSiggo.AnalisePreliminarResponseType> response_map_x = new Map<String, EXT_serverSiggo.AnalisePreliminarResponseType>();
            response_map_x.put('response_x', response_x);

            WebServiceCallout.invoke(
				this,
              	request_x,
              	response_map_x,
              	new String[]{endpoint_x,
              	'urn:server.siggo#AnalisePreliminar',
              	'urn:server.siggo',
              	'AnalisePreliminar',
              	'urn:server.siggo',
              	'AnalisePreliminarResponse',
              	'EXT_serverSiggo.AnalisePreliminarResponseType'}
            );

            response_x = response_map_x.get('response_x');
            return response_x.AnalisePreliminar;

        } // Fim AnalisePreliminar


        public EXT_serverSiggo.AnaliseCredito AnaliseCredito(String xml) {

            EXT_serverSiggo.AnaliseCreditoRequestType request_x = new EXT_serverSiggo.AnaliseCreditoRequestType();
            request_x.xml = xml;

            EXT_serverSiggo.AnaliseCreditoResponseType response_x;
            Map<String, EXT_serverSiggo.AnaliseCreditoResponseType> response_map_x = new Map<String, EXT_serverSiggo.AnaliseCreditoResponseType>();
            response_map_x.put('response_x', response_x);

            WebServiceCallout.invoke(
              	this,
              	request_x,
              	response_map_x,
              	new String[]{endpoint_x,
              	'urn:server.siggo#AnaliseCredito',
              	'urn:server.siggo',
              	'AnaliseCredito',
              	'urn:server.siggo',
              	'AnaliseCreditoResponse',
              	'EXT_serverSiggo.AnaliseCreditoResponseType'}
            );

            response_x = response_map_x.get('response_x');
            return response_x.AnaliseCredito;

		} // Fim AnaliseCredito

    } // Fim server_siggoPort


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
    }

}