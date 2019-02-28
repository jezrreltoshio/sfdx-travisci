/*
  Classe de teste: Teste_DAO_Conta
  Criado por: Mario Reis
  Data de criação: 24/08/2017
  Descrição: Classe DAO para o objeto Conta

  Alteração 21/06/2018 - Rafael Silva
  ***Inclusão de um método para buscar contas por lista de Id e retornar lista de contas.
    ---------------------------------
    @author Renan Rocha
    @date 19/11/2018
    @description:
        - Classe refatorada e novos debugs inseridos
        - Inserido método getContasBySetId
    @JIRA KCA-10
    ---------------------------------
    @author Renan Rocha
    @date 11/01/2019
    @description Inserido método getContasByCNPJERecordTypeId
    @JIRA KCA-410 
*/
public class DAO_Conta{

    private static String CLASS_NAME = 'DAO_Conta';

    // Método que retorna a conta pelo ID
    public static Account getContaPorId(String idConta){
        String METHOD_NAME = 'getContaPorId';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - idConta: '+ idConta);

    try {
      return 
            [SELECT Id 
                  , Celular_contato_autorizado__c
                  , Celular_contato_emergencia__c
                  , Celular_contato_instalacao__c
                  , CNPJ__c 
                  , CNPJ_CPF__c 
                  , Cobranca_Cartao_Numero_Cript__c
                  , Cobranca_Cartao_Vcto__c
                  , ContatoEmergencia__c
                  , ContatoInstalacao__c
                  , ContatoPessoaAutorizada__c
                  , CPF_contato_autorizado__c
                  , CPF_contato_emergencia__c
                  , CPF_contato_instalacao__c
                  , DadosPF_DataNascimento__c
                  , DadosPF_NomeMae__c
                  , DadosPF_RG__c
                  , DebAut_Agencia__c
                  , DebAut_ContaCorrente__c
                  , DebAut_NomeTitular__c
                  , Dia_de_vencimento__c
                  , EMail__c
                  , Email_contato_autorizado__c
                  , Email_contato_emergencia__c
                  , Email_contato_instalacao__c
                  , EMailNFE__c
                  , Enderecos_Cobranca_Bairro__c
                  , Enderecos_Cobranca_CEP__c
                  , Enderecos_Cobranca_Cidade__c
                  , Enderecos_Cobranca_Complemento__c
                  , Enderecos_Cobranca_Logradouro__c                                 
                  , Enderecos_Cobranca_Numero__c
                  , Enderecos_Cobranca_Pais__c 
                  , Enderecos_Cobranca_UF__c 
                  , Enderecos_Principal_Bairro__c
                  , Enderecos_Principal_CEP__c
                  , Enderecos_Principal_Cidade__c
                  , Enderecos_Principal_Complemento__c
                  , Enderecos_Principal_Logradouro__c                                 
                  , Enderecos_Principal_Numero__c
                  , Enderecos_Principal_Pais__c
                  , Enderecos_Principal_UF__c   
                  , Estado_Inscricao_Estadual__c
                  , Forma_cobranca_ID__c
                  , Inscri_o_estadual__c
                  , Name
                  , Nome_contato_autorizado__c
                  , Nome_contato_emergencia__c
                  , Nome_contato_instalacao__c
                  , Owner.IdUsuarioPreCadastro__c
                  , Phone 
                  , RecordType.Name
                  , RecordTypeId
                  , RG_contato_autorizado__c
                  , RG_contato_emergencia__c
                  , RG_contato_instalacao__c
                  , Telefone_2__c 
                  , Telefone_3__c
                  , Telefone_4__c 
                  , TelefoneCelular__c 
                  , Tipo_cliente_ID__c
                  , Tipo_pessoa_ID__c
            FROM Account
            WHERE Id =: idConta];

        } catch (Exception e){
                System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

        throw new customException(Label.MSG_ERRO_0002);
        } // Fim try/catch
    } // Fim método getContaPorId

    // Método que retorna a conta pelo ID da conta no Lead
  public static Account getContaPorLeadContaId(String leadContaId){
        String METHOD_NAME = 'leadContaId';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - leadContaId: '+ leadContaId);

    try {
      return 
        [SELECT Id
              , Cadencia__c
              , Circuito__c
              , CNPJ__c
              , Consultor_indicacao__c
              , CPF__c
              , CUIT__c
              , Description
              , DNI__c
              , EMail__c
              , Enderecos_Cobranca_CEP__c
              , Enderecos_Cobranca_Cidade__c
              , Enderecos_Cobranca_Logradouro__c
              , Enderecos_Cobranca_Pais__c
              , Enderecos_Cobranca_UF__c
              , GR__c
              , Indicador__c
              , Ja_utilizou_rastreador__c
              , Marca_do_concorrente__c
              , Name
              , Nome_fantasia__c
              , Origem_Lead_Agrupado__c
              , Outro_GR__c
              , Outro_Segmento__c
              , Phone
              , Possui_Escolta_Armada__c
              , Qual_a_outra_marca__c
              , Quantidade_de_ve_culos__c
              , Quantidade_Ve_culos_Leves__c
              , Quantidade_Ve_culos_Pesados__c
              , Segmento__c
              , Telefone_2__c
              , Telefone_3__c
              , Telefone_4__c
              , TelefoneCelular__c
              , Tem_veiculos_leves__c
              , Tem_veiculos_pesados__c
              , Tipo_de_cliente__c
              , Tipo_de_pessoa__c
              , Utiliza_rastreador_do_concorrente__c
              , Website
        FROM Account
        WHERE Id =: leadContaId];

    } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

      throw new customException(Label.MSG_ERRO_0022);
    } // Fim try/catch
  } // Fim método getContaPorLeadContaId

  // Método que retorna a lista de Contas para verificação da duplicidade
  public static List<Account> getContaVerificaoDuplicidadePorId(Set<Id> setIdConta, Set<String> setIdVerificaDuplicidade){
        String METHOD_NAME = 'getContaVerificaoDuplicidadePorId';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - setIdConta: '+ setIdConta);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - setIdVerificaDuplicidade: '+ setIdVerificaDuplicidade);

    try {
      return 
                [SELECT Id
                      , CNPJ__c
                      , CNPJ_CPF__c 
                      , CPF__c
                      , Name
                      , VerificaDuplicidade__c
                FROM Account 
                WHERE VerificaDuplicidade__c != ''
              AND VerificaDuplicidade__c IN: setIdVerificaDuplicidade
              AND Id NOT IN: setIdConta];
    } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

      throw new customException(Label.MSG_ERRO_0002);
    } // Fim try/catch
  } // Fim método getContaVerificaoDuplicidadePorId

  // Método que retorna a lista de tipos de registro da Conta
  public static Map<String, String> getMapTipoRegistro(){
        String METHOD_NAME = 'getMapTipoRegistro';

    Map<String, String> mapRetorno = new Map<String, String>();

    try {
      for(RecordType rt : [SELECT Id
                                      , DeveloperName 
                                      , Name
                  FROM RecordType 
                WHERE sObjectType = 'Account'])
            {
        mapRetorno.put(rt.DeveloperName, String.valueOf(rt.Id).substring(0,15) );
      }
            
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - mapRetorno: '+ mapRetorno);

      return mapRetorno;
    } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

      throw new customException(Label.MSG_ERRO_0002);
    } // Fim try/catch
  } // Fim método getMapTipoRegistro
    
    // Método que retorna a conta pelo ID
  public static List<Account> getContaPorListaId(List<Id> idsToQuery){
        String METHOD_NAME = 'getContaPorListaId';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - idsToQuery: '+ idsToQuery);

    try {
      return 
                [SELECT Id 
                      , CPF__c
                      , Enderecos_Cobranca_Pais__c 
                      , Enderecos_Principal_Pais__c
                      , RecordTypeId
                      , Tipo_de_pessoa__c
                      , Celular_contato_autorizado__c
                      , Celular_contato_emergencia__c
                      , Celular_contato_instalacao__c
                      , CNPJ__c 
                      , CNPJ_CPF__c 
                      , Cobranca_Cartao_Numero_Cript__c
                      , Cobranca_Cartao_Vcto__c
                      , ContatoEmergencia__c
                      , ContatoInstalacao__c
                      , ContatoPessoaAutorizada__c
                      , CPF_contato_autorizado__c
                      , CPF_contato_emergencia__c
                      , CPF_contato_instalacao__c
                      , DadosPF_DataNascimento__c
                      , DadosPF_NomeMae__c
                      , DadosPF_RG__c
                      , DebAut_Agencia__c
                      , DebAut_ContaCorrente__c
                      , DebAut_NomeTitular__c
                      , Dia_de_vencimento__c
                      , EMail__c
                      , Email_contato_autorizado__c
                      , Email_contato_emergencia__c
                      , Email_contato_instalacao__c
                      , EMailNFE__c
                      , Enderecos_Cobranca_Bairro__c
                      , Enderecos_Cobranca_CEP__c
                      , Enderecos_Cobranca_Cidade__c
                      , Enderecos_Cobranca_Complemento__c
                      , Enderecos_Cobranca_Logradouro__c                                 
                      , Enderecos_Cobranca_Numero__c
                      , Enderecos_Cobranca_UF__c 
                      , Enderecos_Principal_Bairro__c
                      , Enderecos_Principal_CEP__c
                      , Enderecos_Principal_Cidade__c
                      , Enderecos_Principal_Complemento__c
                      , Enderecos_Principal_Logradouro__c                                 
                      , Enderecos_Principal_Numero__c
                      , Enderecos_Principal_UF__c   
                      , Estado_Inscricao_Estadual__c
                      , Forma_cobranca_ID__c
                      , Inscri_o_estadual__c
                      , Name
                      , Nome_contato_autorizado__c
                      , Nome_contato_emergencia__c
                      , Nome_contato_instalacao__c
                      , Owner.IdUsuarioPreCadastro__c
                      , Phone 
                      , RecordType.Name
                      , RG_contato_autorizado__c
                      , RG_contato_emergencia__c
                      , RG_contato_instalacao__c
                      , Telefone_2__c 
                      , Telefone_3__c
                      , Telefone_4__c 
                      , TelefoneCelular__c 
                      , Tipo_cliente_ID__c
                      , Tipo_pessoa_ID__c
                FROM Account
                 WHERE Id IN: idsToQuery];
    } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

      throw new customException(Label.MSG_ERRO_0002);
    } // Fim try/catch
  } // Fim método getContaPorId

    /*
        @description Retorna uma lista de contas conforme o set informado
        @param Set<Id> pSetContas
        @return List<Account>
        
        @author Renan Rocha
    */
    public static List<Account> getContasBySetId(Set<Id> pSetContas){
        String METHOD_NAME = 'getContasBySetId';
    
        return
            [SELECT Id
                  , Criado_via_lead__c
            FROM Account
            WHERE Id IN: pSetContas];
    }

    /*
      @description Retorna uma lista de contas conforme o CNPJ e o RecordTypeId informado
      @param String pCNPJ, String pRecordTypeId
      @return List<Account>
      
      @author Renan Rocha
      @date 11/01/2019
      @JIRA KCA-410
    */
    public static List<Account> getContasByCNPJERecordTypeId(String pCNPJ, String pRecordTypeId){
      String METHOD_NAME = 'getContasByCNPJERecordTypeId';
      
      return
        [SELECT Id
              , CNPJ__c
              , RecordTypeId 
        FROM Account 
        WHERE CNPJ__c <> null 
        AND CNPJ__c =: pCNPJ 
        AND RecordTypeId =: pRecordTypeId];  
    }
}