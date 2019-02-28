/*
    Classe de teste: Teste_Util_Organizacao
    Criado por: Mario Reis
    Data de criação: 31/08/2017
    Descrição: Classe com métodos uteis para a Organização
    ---------------------------------
    @author Renan Rocha
    @date 14/01/2019
    @description Método getAmbienteSF refatorado e ambiente Homolog corrigido
    @JIRA KCA-429
*/
public class Util_Organizacao {
    private static String CLASS_NAME = 'Util_Organizacao';
    
    public static Boolean test = false;
    
    public static String DESENVOLVIMENTO = 'desenvolvimento';
    public static String HOMOLOGACAO = 'homologacao';
    public static String PRODUCAO = 'producao';
    
    public static Organization org;
    
    // Método que verifica qual o ambiente atual do SF
    public static String getAmbienteSF(){
        String METHOD_NAME = 'getAmbienteSF';
        
        try {
            String user;
            String posfixoORG;
            
            org = DAO_Organizacao.getOrganizacao();
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - org: '+ org);
            
            user = UserInfo.getUserName();
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - user: '+ user);
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - posfixoORG: '+ posfixoORG);
            
            String ambienteRetorno = '';
            
            // Verifica os ambientes
            if(org.IsSandbox && user.contains('hml') && !test) ambienteRetorno = HOMOLOGACAO;
            else if(org.IsSandbox && !test) ambienteRetorno = DESENVOLVIMENTO;
            else if(!org.IsSandbox || test) ambienteRetorno = PRODUCAO;
            else ambienteRetorno = DESENVOLVIMENTO;

            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - ambienteRetorno: '+ ambienteRetorno);
            
            return ambienteRetorno;       
        } catch(Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

            throw new customException(Label.MSG_ERRO_0005);
        }   
    } // Fim getAmbienteSF
    
    // Método para formatar o telefone do Brasil
    public static String formatarTelefoneBrasil(String telefone){
        
        System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - formatarTelefoneBrasil()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - formatarTelefoneBrasil()] - telefone: '+telefone);
        
        try {
            
            String telefoneDigitos; 
            String naoDigitos = '[^0-9]'; 
            String telefoneRetorno;
            
            if (String.isEmpty(telefone)) 
                telefoneRetorno = telefone; 
            
            telefoneDigitos = telefone.replaceAll(naoDigitos,'');
            
            // Verifica validade do telefone
            if(telefoneDigitos.length() < 8 ||
               telefoneDigitos == '00000000' ||
               telefoneDigitos == '11111111' ||
               telefoneDigitos == '22222222' ||
               telefoneDigitos == '33333333' ||
               telefoneDigitos == '44444444' ||
               telefoneDigitos == '55555555' ||
               telefoneDigitos == '66666666' ||
               telefoneDigitos == '77777777' ||
               telefoneDigitos == '88888888' ||
               telefoneDigitos == '99999999' ||
               telefoneDigitos == '000000000' ||
               telefoneDigitos == '111111111' ||
               telefoneDigitos == '222222222' ||
               telefoneDigitos == '333333333' ||
               telefoneDigitos == '444444444' ||
               telefoneDigitos == '555555555' ||
               telefoneDigitos == '666666666' ||
               telefoneDigitos == '777777777' ||
               telefoneDigitos == '888888888' ||
               telefoneDigitos == '999999999' ||
               telefoneDigitos == '0000000000' ||
               telefoneDigitos == '1111111111' ||
               telefoneDigitos == '2222222222' ||
               telefoneDigitos == '3333333333' ||
               telefoneDigitos == '4444444444' ||
               telefoneDigitos == '5555555555' ||
               telefoneDigitos == '6666666666' ||
               telefoneDigitos == '7777777777' ||
               telefoneDigitos == '8888888888' ||
               telefoneDigitos == '9999999999' ||
               telefoneDigitos == '00000000000' ||
               telefoneDigitos == '11111111111' ||
               telefoneDigitos == '22222222222' ||
               telefoneDigitos == '33333333333' ||
               telefoneDigitos == '44444444444' ||
               telefoneDigitos == '55555555555' ||
               telefoneDigitos == '66666666666' ||
               telefoneDigitos == '77777777777' ||
               telefoneDigitos == '88888888888' ||
               telefoneDigitos == '99999999999' ||
               telefoneDigitos == '000000000000' ||
               telefoneDigitos == '111111111111' ||
               telefoneDigitos == '222222222222' ||
               telefoneDigitos == '333333333333' ||
               telefoneDigitos == '444444444444' ||
               telefoneDigitos == '555555555555' ||
               telefoneDigitos == '666666666666' ||
               telefoneDigitos == '777777777777' ||
               telefoneDigitos == '888888888888' ||
               telefoneDigitos == '999999999999' ||
               telefoneDigitos == '0000000000000' ||
               telefoneDigitos == '1111111111111' ||
               telefoneDigitos == '2222222222222' ||
               telefoneDigitos == '3333333333333' ||
               telefoneDigitos == '4444444444444' ||
               telefoneDigitos == '5555555555555' ||
               telefoneDigitos == '6666666666666' ||
               telefoneDigitos == '7777777777777' ||
               telefoneDigitos == '8888888888888' ||
               telefoneDigitos == '9999999999999'){
                   
                   throw new customException(Label.MSG_ERRO_0017);
                   return null;
               }
            
            // Telefone com 8 dgitos
            if (telefoneDigitos.length() == 8) 
                telefoneRetorno = telefoneDigitos.substring(0,4) + '-' + telefoneDigitos.substring(4,8); 
            
            // Telefone com 9 digitos
            if (telefoneDigitos.length() == 9) 
                telefoneRetorno = telefoneDigitos.substring(0,5) + '-' + telefoneDigitos.substring(5,9); 
            
            // Telefone com 8 digitos e código de area (DDD)
            if (telefoneDigitos.length() == 10) 
                telefoneRetorno = '(' + telefoneDigitos.substring(0,2) + ') ' + telefoneDigitos.substring(2,6) + '-' + telefoneDigitos.substring(6,10); 
            
            // Telefone com 9 digitos e código de area (DDD)
            if (telefoneDigitos.length() == 11) 
                telefoneRetorno = '(' + telefoneDigitos.substring(0,2) + ') ' + telefoneDigitos.substring(2,7) + '-' + telefoneDigitos.substring(7,11); 
            
            // Telefone com 8 digitos, DDD e código do pais
            if (telefoneDigitos.length() == 12) 
                telefoneRetorno = '+ ' + telefoneDigitos.subString(0,2) + ' (' + telefoneDigitos.substring(2,4) + ') ' + telefoneDigitos.substring(4,8) + '-' + telefoneDigitos.substring(8,12); 
            
            // Telefone com 9 digitos, DDD e código do pais
            if (telefoneDigitos.length() == 13) 
                telefoneRetorno = '+ ' + telefoneDigitos.subString(0,2) + ' (' + telefoneDigitos.substring(2,4) + ') ' + telefoneDigitos.substring(4,9) + '-' + telefoneDigitos.substring(9,13); 
            
            System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - formatarTelefoneBrasil()] - telefoneRetorno: '+telefoneRetorno);
            
            return telefoneRetorno;
            
        } catch(Exception e){
            
            System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - formatarTelefoneBrasil()] - ERRO: ' + e.getMessage());
            throw new customException(e.getMessage());
            return null;
        }
        
    } // Fim formatarTelefoneBrasil
    
    @Future(callout=true)
    public static void buscaCEP(String idRegistro, String cep, String tipoObjeto, String tipoEndereco) {
        
        System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - idRegistro: '+idRegistro);
        System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - cep: '+cep);
        System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - tipoObjeto: '+tipoObjeto);
        System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - tipoEndereco: '+tipoEndereco);
        
        try {
            
            String endereco = '';
            
            String endpoint = Util_Integracao.getEndpointBuscaCEP();
            
            System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - endpoint: '+endpoint);
            
            HttpRequest req = new HttpRequest();
            req.setEndpoint(endpoint+cep);
            req.setMethod('GET');
            Http http = new Http();
            
            if(!test){
                
                HTTPResponse res = http.send(req);
                
                try {
                    
                    endereco = res.getBody(); 
                } catch(Exception e) {
                    
                    System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - ERRO: '+e.getMessage());
                }
                
            } else {
                
                endereco = '{"status":200,"mensagem":"Endereco encontrado","dados":{"tipo":"RUA","logradouro":"JOAO MARCHESINI","complemento":"","bairro":"PRADO VELHO","municipio":"CURITIBA","uf":"PR","cep":"80215432","cod_ibge":"4106902","cod_tom":null}}';
            }
            
            System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - endereco: '+endereco);
            
            //HTTPResponse res = http.send(req);
            
            Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(endereco);
            String mensagem = (String) m.get('mensagem');
            Integer status  = (Integer) m.get('status');
            
            System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - mensagem: '+mensagem);
            System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - status: '+status);
            System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - m: '+m);
            
            Map<String, Object> dados = new Map<String, Object>();
            
            if(m.get('dados') != null){
                
                dados = (Map<String, Object>) m.get('dados');
            }
            
            String bairro = (String) dados.get('bairro');
            String cep1 = (String) dados.get('cep');
            String ibge = (String) dados.get('cod_ibge');
            String tom = (String) dados.get('cod_tom');
            String complemento = (String) dados.get('complemento');
            String logradouro = (String) dados.get('logradouro');
            String municipio = (String) dados.get('municipio');
            String tipo = (String) dados.get('tipo');
            String uf = (String) dados.get('uf');
            
            System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - tipo: '+tipo);
            System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - logradouro: '+logradouro);
            System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - complemento: '+complemento);
            System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - bairro: '+bairro);
            System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - cep1: '+cep1);
            System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - municipio: '+municipio);
            System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - uf: '+uf);
            System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - ibge: '+ibge);
            System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - tom: '+tom);
            
            Map<String, Object> dado = (Map<String, Object>) m.get('dados');
            
            System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - dado: '+dado);
            
            if(tipoObjeto == 'conta' && dado != null && tipoEndereco != null){
                
                Account conta = new Account(Id = idRegistro);
                
                if(tipoEndereco == 'principal') {
                    
                    //conta.Cep_preenchido_principal__c = false;
                    
                    if(tipo != null) conta.Enderecos_Principal_Logradouro__c = tipo != null && logradouro != null ? tipo + ' ' + logradouro : '';
                    if(bairro != null) conta.Enderecos_Principal_Bairro__c = bairro;
                    if(municipio != null) conta.Enderecos_Principal_Cidade__c = municipio;
                    if(tipo != null) conta.Enderecos_Principal_UF__c = uf;
                    if(ibge != null) conta.Codigo_municipio_principal__c= ibge;
                    conta.Enderecos_Principal_Pais__c = 'BRASIL';
                    if(cep != null) conta.Enderecos_Principal_CEP__c = cep;
                    
                } else if(tipoEndereco == 'entrega') {
                    
                    //conta.Cep_preenchido_entrega__c = false;
                    
                    if(tipo != null) conta.Enderecos_Entrega_Logradouro__c = tipo != null && logradouro != null ? tipo + ' ' + logradouro : '';
                    if(bairro != null) conta.Enderecos_Entrega_Bairro__c = bairro;
                    if(municipio != null) conta.Enderecos_Entrega_Cidade__c = municipio;
                    if(uf != null) conta.Enderecos_Entrega_UF__c = uf;
                    if(ibge != null) conta.Codigo_municipio_entrega__c= ibge;
                    conta.Enderecos_Entrega_Pais__c = 'BRASIL';
                    if(cep != null) conta.Enderecos_Entrega_CEP__c = cep;
                    
                } else if(tipoEndereco == 'cobranca') {
                    
                    //conta.Cep_preenchido_cobranca__c = false;
                    
                    if(tipo != null) conta.Enderecos_Cobranca_Logradouro__c = tipo != null && logradouro != null ? tipo + ' ' + logradouro : '';
                    if(bairro != null) conta.Enderecos_Cobranca_Bairro__c = bairro;
                    if(municipio != null) conta.Enderecos_Cobranca_Cidade__c = municipio;
                    if(uf != null) conta.Enderecos_Cobranca_UF__c = uf;
                    if(ibge != null) conta.Codigo_municipio_cobranca__c= ibge;
                    conta.Enderecos_Cobranca_Pais__c = 'BRASIL';
                    if(cep != null) conta.Enderecos_Cobranca_CEP__c = cep;
                    
                }
                
                System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - conta: '+conta);
                
                update conta;
                
                conta.Cep_preenchido_entrega__c = false;
                conta.Cep_preenchido_principal__c = false;
                conta.Cep_preenchido_cobranca__c = false;
                update conta; //rbsilva 26-11-2018: Não estava funcionando se atualizasse a flag antes, então precisamos atualizar somente após a atualização do endereço.
                
            } else if(tipoObjeto == 'lead' && dado != null){
                
                Lead lead = new Lead(Id = idRegistro);
                
                lead.Id = idRegistro;
                lead.Street = String.valueOf(dado.get('tipo')) + ' ' + String.valueOf(dado.get('logradouro'));
                lead.Bairro_endereco__c = String.valueOf(dado.get('bairro'));
                lead.City = String.valueOf(dado.get('municipio'));
                lead.State = String.valueOf(dado.get('uf'));
                lead.Codigo_municipio__c = String.valueOf(dado.get('cod_ibge'));
                lead.Country = 'BRASIL';
                lead.PostalCode = String.valueOf(dado.get('cep'));
                
                System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - lead: '+lead);
                
                update lead;
            } // Fim if(tipoObjeto == 'conta')
            
        } catch(Exception e){
            
            System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - ERRO: ' + e.getMessage());
        }
        
    } // Fim buscaCEP
    
    @Future(callout=true)
    public static void buscaCEPMapa(List<String> ids, Map<String, String> mapContaCEP, String tipoObjeto, String tipoEndereco) {
        
        System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - idRegistro: '+ids);
        System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - cep: '+mapContaCEP);
        System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - tipoObjeto: '+tipoObjeto);
        System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - tipoEndereco: '+tipoEndereco);
        
        try {
            
            for(String s : ids)
            {
                String endereco = '';
                
                String endpoint = Util_Integracao.getEndpointBuscaCEP();
                
                System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - endpoint: '+endpoint);
                
                HttpRequest req = new HttpRequest();
                req.setEndpoint(endpoint+mapContaCEP.get(s));
                req.setMethod('GET');
                Http http = new Http();
                
                if(!test){
                    
                    HTTPResponse res = http.send(req);
                    
                    try {
                        
                        endereco = res.getBody(); 
                    } catch(Exception e) {
                        
                        System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - ERRO: '+e.getMessage());
                    }
                    
                } else {
                    
                    endereco = '{"status":200,"mensagem":"Endereco encontrado","dados":{"tipo":"RUA","logradouro":"JOAO MARCHESINI","complemento":"","bairro":"PRADO VELHO","municipio":"CURITIBA","uf":"PR","cep":"80215432","cod_ibge":"4106902","cod_tom":null}}';
                }
                
                System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - endereco: '+endereco);
                
                //HTTPResponse res = http.send(req);
                
                Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(endereco);
                String mensagem = (String) m.get('mensagem');
                Integer status  = (Integer) m.get('status');
                
                System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - mensagem: '+mensagem);
                System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - status: '+status);
                System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - m: '+m);
                
                Map<String, Object> dados = new Map<String, Object>();
                
                if(m.get('dados') != null){
                    
                    dados = (Map<String, Object>) m.get('dados');
                }
                
                String bairro = (String) dados.get('bairro');
                String cep1 = (String) dados.get('cep');
                String ibge = (String) dados.get('cod_ibge');
                String tom = (String) dados.get('cod_tom');
                String complemento = (String) dados.get('complemento');
                String logradouro = (String) dados.get('logradouro');
                String municipio = (String) dados.get('municipio');
                String tipo = (String) dados.get('tipo');
                String uf = (String) dados.get('uf');
                
                System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - tipo: '+tipo);
                System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - logradouro: '+logradouro);
                System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - complemento: '+complemento);
                System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - bairro: '+bairro);
                System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - cep1: '+cep1);
                System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - municipio: '+municipio);
                System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - uf: '+uf);
                System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - ibge: '+ibge);
                System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - tom: '+tom);
                
                Map<String, Object> dado = (Map<String, Object>) m.get('dados');
                
                System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - dado: '+dado);
                
                if(tipoObjeto == 'conta' && dado != null && tipoEndereco != null){
                    
                    Account conta = new Account(Id = s);
                    
                    if(tipoEndereco == 'principal') {
                        
                        if(tipo != null) conta.Enderecos_Principal_Logradouro__c = tipo != null && logradouro != null ? tipo + ' ' + logradouro : '';
                        if(bairro != null) conta.Enderecos_Principal_Bairro__c = bairro;
                        if(municipio != null) conta.Enderecos_Principal_Cidade__c = municipio;
                        if(tipo != null) conta.Enderecos_Principal_UF__c = uf;
                        if(ibge != null) conta.Codigo_municipio_principal__c= ibge;
                        conta.Enderecos_Principal_Pais__c = 'BRASIL';
                        if(cep1 != null) conta.Enderecos_Principal_CEP__c = cep1;
                        
                    } else if(tipoEndereco == 'entrega') {
                        
                        if(tipo != null) conta.Enderecos_Entrega_Logradouro__c = tipo != null && logradouro != null ? tipo + ' ' + logradouro : '';
                        if(bairro != null) conta.Enderecos_Entrega_Bairro__c = bairro;
                        if(municipio != null) conta.Enderecos_Entrega_Cidade__c = municipio;
                        if(uf != null) conta.Enderecos_Entrega_UF__c = uf;
                        if(ibge != null) conta.Codigo_municipio_entrega__c= ibge;
                        conta.Enderecos_Entrega_Pais__c = 'BRASIL';
                        if(cep1 != null) conta.Enderecos_Entrega_CEP__c = cep1;
                        
                    } else if(tipoEndereco == 'cobranca') {
                        
                        if(tipo != null) conta.Enderecos_Cobranca_Logradouro__c = tipo != null && logradouro != null ? tipo + ' ' + logradouro : '';
                        if(bairro != null) conta.Enderecos_Cobranca_Bairro__c = bairro;
                        if(municipio != null) conta.Enderecos_Cobranca_Cidade__c = municipio;
                        if(uf != null) conta.Enderecos_Cobranca_UF__c = uf;
                        if(ibge != null) conta.Codigo_municipio_cobranca__c= ibge;
                        conta.Enderecos_Cobranca_Pais__c = 'BRASIL';
                        if(cep1 != null) conta.Enderecos_Cobranca_CEP__c = cep1;
                        
                    }
                    
                    System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - conta: '+conta);
                    
                    update conta;
                    
                } else if(tipoObjeto == 'lead' && dado != null){
                    
                    Lead lead = new Lead(Id = s);
                    
                    lead.Id = s;
                    lead.Street = String.valueOf(dado.get('tipo')) + ' ' + String.valueOf(dado.get('logradouro'));
                    lead.Bairro_endereco__c = String.valueOf(dado.get('bairro'));
                    lead.City = String.valueOf(dado.get('municipio'));
                    lead.State = String.valueOf(dado.get('uf'));
                    lead.Codigo_municipio__c = String.valueOf(dado.get('cod_ibge'));
                    lead.Country = 'BRASIL';
                    lead.PostalCode = String.valueOf(dado.get('cep'));
                    
                    System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - lead: '+lead);
                    
                    update lead;
                } // Fim if(tipoObjeto == 'conta')
            }
            
            
            
        } catch(Exception e){
            
            System.debug(LoggingLevel.ERROR, '__ [cls Util_Organizacao - buscaCEP()] - ERRO: ' + e.getMessage());
        }
        
    } // Fim buscaCEP
    
}