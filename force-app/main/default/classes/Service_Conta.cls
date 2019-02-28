/*
 * 
 * Classe de teste: Teste_Service_Conta
 * Criado por: Mario Reis
 * Data de criação: 24/08/2017
 * Descrição: Classe com métodos para as funcionalidades da Trigger do Objeto Conta
 * 
 * Alteração: Rafael Silva
 * Data de Alteração: 05/07/2018
 * Descrição: Classe alterada e reescrita para a correção de erros, e unificação das triggers presentes em Conta.
*/

public class Service_Conta {
    
    private static Boolean verificarBluetec;
    private static Boolean verificarCORP;
    private static Boolean verificarGrupoEconomico;
    private static Boolean verificarMichelin;
    private static Boolean verificarSIGGO;
    
    // Método que carrega as configurações
    private static void carregarInformacoes(){
        
        verificarBluetec = Duplicidade_conta__c.getOrgDefaults().Bluetec__c;
        verificarCORP = Duplicidade_conta__c.getOrgDefaults().CORP__c;
        verificarGrupoEconomico = Duplicidade_conta__c.getOrgDefaults().Grupo_economico__c;
        verificarMichelin = Duplicidade_conta__c.getOrgDefaults().Michelin__c;
        verificarSIGGO = Duplicidade_conta__c.getOrgDefaults().SIGGO__c;
        
    } // Fim método carregarInformacoes
    
    
    public static void preencheCamposFaltantesConversao(List<Account> listaConta)
    {
        List<Account> listaPreencherEstadoEndPrincipal = new List<Account>();
        
        for(Account a: listaConta)
        {
            if(a.BillingState != null)
                listaPreencherEstadoEndPrincipal.add(a);
                
        }
		for(Account a : listaPreencherEstadoEndPrincipal)
        {
            if(a.BillingState == 'AC')
                a.Enderecos_Principal_UF__c = 'AC';
            if(a.BillingState == 'AL')
                a.Enderecos_Principal_UF__c = 'AL';
            if(a.BillingState == 'AP')
                a.Enderecos_Principal_UF__c = 'AP';
            if(a.BillingState == 'AM')
                a.Enderecos_Principal_UF__c = 'AM';
            if(a.BillingState == 'BA')
                a.Enderecos_Principal_UF__c = 'BA';
            if(a.BillingState == 'CE')
                a.Enderecos_Principal_UF__c = 'CE';
            if(a.BillingState == 'DF')
                a.Enderecos_Principal_UF__c = 'DF';
            if(a.BillingState == 'ES')
                a.Enderecos_Principal_UF__c = 'ES';
            if(a.BillingState == 'GO')
                a.Enderecos_Principal_UF__c = 'GO';
            if(a.BillingState == 'MA')
                a.Enderecos_Principal_UF__c = 'MA';
            if(a.BillingState == 'MT')
                a.Enderecos_Principal_UF__c = 'MT';
            if(a.BillingState == 'MS')
                a.Enderecos_Principal_UF__c = 'MS';
            if(a.BillingState == 'MG')
                a.Enderecos_Principal_UF__c = 'MG';
            if(a.BillingState == 'PA')
                a.Enderecos_Principal_UF__c = 'PA';
            if(a.BillingState == 'PB')
                a.Enderecos_Principal_UF__c = 'PB';
            if(a.BillingState == 'PR')
                a.Enderecos_Principal_UF__c = 'PR';
            if(a.BillingState == 'PE')
                a.Enderecos_Principal_UF__c = 'PE';
            if(a.BillingState == 'PI')
                a.Enderecos_Principal_UF__c = 'PI';
            if(a.BillingState == 'RJ')
                a.Enderecos_Principal_UF__c = 'RJ';
            if(a.BillingState == 'RN')
                a.Enderecos_Principal_UF__c = 'RN';
            if(a.BillingState == 'RS')
                a.Enderecos_Principal_UF__c = 'RS';
            if(a.BillingState == 'RO')
                a.Enderecos_Principal_UF__c = 'RO';
            if(a.BillingState == 'RR')
                a.Enderecos_Principal_UF__c = 'RR';
            if(a.BillingState == 'SC')
                a.Enderecos_Principal_UF__c = 'SC';
            if(a.BillingState == 'SP')
                a.Enderecos_Principal_UF__c = 'SP';
            if(a.BillingState == 'SE')
                a.Enderecos_Principal_UF__c = 'SE';
            if(a.BillingState == 'TO')
                a.Enderecos_Principal_UF__c = 'TO';

        }
    }
    
    
    
    // Método que preenche os campos da conta
    public static void preencheCamposConta(List<Account> listaConta) {
        
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - preencheCamposConta()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - preencheCamposConta()] - listaConta: '+listaConta);
        
        carregarInformacoes();
        
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - preencheCamposConta()] - Carregou informações');
        
        if(listaConta != null && listaConta.size() > 0) {
            
            Util_Conta.carregarTipoRegistro();
            
            System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - preencheCamposConta()] - Carregou tipos de regitro');
            
            for(Account conta : listaConta){
                
                System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - preencheCamposConta()] - conta: '+conta);
                
                if(conta.RecordTypeId != null){
                    
                    String recordTypeName = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosById().get(conta.RecordTypeId).getName();
                    System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - preencheCamposConta()] - recordTypeName: ' + recordTypeName);
                    System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - preencheCamposConta()] - conta.Id_registro__c: ' + conta.Id_registro__c);
                    System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - preencheCamposConta()] - PreencheCampoConta: ' + conta);
                    
                    //rbsilva 07-06-18: controle para padronizar o preenchimento dos campos nos registros de conta.
                    if((conta.CNPJ__c != null && conta.Tipo_de_pessoa__c == 'J-Jurídica')||(conta.CNPJ__c != null && conta.CPF__c == null))
                    {
                        conta.CPF__c = null;
                        conta.CNPJ_CPF__c = conta.CNPJ__c;
                    }
                    if((conta.CPF__c != null && conta.Tipo_de_pessoa__c == 'F-Física')||(conta.CPF__c != null && conta.CNPJ__c == null))
                    {
                        conta.CNPJ__c = null;
                        conta.CNPJ_CPF__c = conta.CPF__c;
                    }                    
                    if(conta.CUIT__c != null)
                    {
                        conta.CNPJ_CPF__c = conta.CUIT__c; //Estudar a possibilidade de passar a chamar esse campo de "Documento", visto que já existem, e existirão ainda mais tipos de documento
                        									// devido a demanda de multipaíses.
                    }
                    if(conta.RFC__c != null)
                    {
                        conta.CNPJ_CPF__c = conta.RFC__c;
                    }
                    ////////////////////////////// fim da condição de padronização //////////////////////////////////
                    //
                    ///// Pensar no impacto de alterar o VerificaDuplicidade_3__c para um nome mais condizente para ser a chave externa dos registros de conta.
                    
                    if(conta.CNPJ__c != null && 
                       String.valueOf(conta.RecordTypeId).subString(0,15) == Util_Conta.CORP){
                           conta.VerificaDuplicidade__c = conta.CNPJ_CPF__c + 'CORP';
                           conta.VerificaDuplicidade_2__c = conta.CNPJ_CPF__c + 'CORP';
                           conta.VerificaDuplicidade_3__c = conta.CNPJ_CPF__c + 'CORP';
                       }
                    
                    else if(conta.RecordTypeId != null &&
                            String.valueOf(conta.RecordTypeId).subString(0,15) == Util_Conta.bluetec){
                                
                                conta.VerificaDuplicidade__c = conta.CNPJ_CPF__c + 'Blue tec';
                           		conta.VerificaDuplicidade_2__c = conta.CNPJ_CPF__c + 'Blue tec';
                           		conta.VerificaDuplicidade_3__c = conta.CNPJ_CPF__c + 'Blue tec';
                            }
                    
                    else if(conta.CNPJ_CPF__c != null && conta.RecordTypeId != null &&
                            String.valueOf(conta.RecordTypeId).subString(0,15) == Util_Conta.SIGGO){
                                
                                conta.VerificaDuplicidade__c = conta.CNPJ_CPF__c + 'SIGGO';
                           		conta.VerificaDuplicidade_2__c = conta.CNPJ_CPF__c + 'SIGGO';
                           		conta.VerificaDuplicidade_3__c = conta.CNPJ_CPF__c + 'SIGGO';
                                
                            }
                    
                    else if(conta.CNPJ_CPF__c != null && conta.RecordTypeId != null &&
                            String.valueOf(conta.RecordTypeId).subString(0,15) == Util_Conta.FRETEIRO){
                                conta.VerificaDuplicidade__c = conta.CNPJ_CPF__c + 'FRETEIRO';
                                conta.VerificaDuplicidade_2__c = conta.CNPJ_CPF__c + 'FRETEIRO';
                                conta.VerificaDuplicidade_3__c = conta.CNPJ_CPF__c + 'FRETEIRO';
                            }
                    
                    else if(conta.CNPJ_CPF__c != null && conta.RecordTypeId != null &&
                            String.valueOf(conta.RecordTypeId).subString(0,15) == Util_Conta.michelin){
                                conta.VerificaDuplicidade__c = conta.CNPJ_CPF__c + 'Michelin';
                                conta.VerificaDuplicidade_2__c = conta.CNPJ_CPF__c + 'Michelin';
                                conta.VerificaDuplicidade_3__c = conta.CNPJ_CPF__c + 'Michelin';
                            }
                    
                    else if(conta.RecordTypeId != null && // o que essa verificação pretende?
                            String.valueOf(conta.RecordTypeId).subString(0,15) == Util_Conta.cargoTracck){
                                
                                conta.VerificaDuplicidade__c = conta.CNPJ_CPF__c + 'Cargo Tracck';
                                conta.VerificaDuplicidade_2__c = conta.CNPJ_CPF__c + 'Cargo Tracck';
                                conta.VerificaDuplicidade_3__c = conta.CNPJ_CPF__c + 'Cargo Tracck';
                                
                            }
                    
                    //rbsilva 08-06-2018: criadas as verificações para os tipos de registros faltantes.
                    
                    else if(conta.CNPJ_CPF__c != null && 
                            String.valueOf(conta.RecordTypeId).subString(0,15) == Util_Conta.argentina){
                                conta.VerificaDuplicidade__c = conta.CNPJ_CPF__c + 'Argentina';
                                conta.VerificaDuplicidade_2__c = conta.CNPJ_CPF__c + 'Argentina';
                                conta.VerificaDuplicidade_3__c = conta.CNPJ_CPF__c + 'Argentina';
                            }
                    
                    else if(conta.CNPJ_CPF__c != null && 
                            String.valueOf(conta.RecordTypeId).subString(0,15) == Util_Conta.mercosul){
                                conta.VerificaDuplicidade__c = conta.CNPJ_CPF__c + 'Mercosul';
                                conta.VerificaDuplicidade_2__c = conta.CNPJ_CPF__c + 'Mercosul';
                                conta.VerificaDuplicidade_3__c = conta.CNPJ_CPF__c + 'Mercosul';
                            }
                    
                    else if(conta.CNPJ_CPF__c != null && 
                            String.valueOf(conta.RecordTypeId).subString(0,15) == Util_Conta.corp_exec){
                                conta.VerificaDuplicidade__c = conta.CNPJ_CPF__c + 'CORP_EXEC';
                                conta.VerificaDuplicidade_2__c = conta.CNPJ_CPF__c + 'CORP_EXEC';
                                conta.VerificaDuplicidade_3__c = conta.CNPJ_CPF__c + 'CORP_EXEC';
                            }
                    
                    else if(conta.CNPJ_CPF__c != null && 
                            String.valueOf(conta.RecordTypeId).subString(0,15) == Util_Conta.corp_tele){
                                conta.VerificaDuplicidade__c = conta.CNPJ_CPF__c + 'CORP_TELE';
                                conta.VerificaDuplicidade_2__c = conta.CNPJ_CPF__c + 'CORP_TELE';
                                conta.VerificaDuplicidade_3__c = conta.CNPJ_CPF__c + 'CORP_TELE';
                            } // Fim ifs
                    
                } // Fim if(a.RecordTypeId != null)
                
            } // Fim for(Account conta : listaConta)
            
            System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - preencheCamposConta()] - listaConta: ' + listaConta);
            
        } // FIm if(listaConta != null && listaConta.size() > 0)
        
    } // Fim método preencheCamposConta
    
    
    // Método que verifica a duplicidade da conta pelo tipo de registro
    // rbasilva 08-06-2018 : pretendo inutilizar esse método, verificar o impacto.
    // 						Pelo que eu observei, quando a query retorna ao menos um valor, a mensagem de erro aparece, e a verificação é feita por um método de DAO_Conta.
    // 						A verificação por campo exclusivo será mais simples e eficiente.
    // 						
    
    /* rbasilva 08-06-2018: Comentei para manter histórico, mas não pretendo utilizar esse método. Atualização: retirei o comentário por que gera falhas em muitas classes que chamam esse método,
							deverá ser feito um trabalho de remoção dessa funcionalidade. 
	*/
    public static void verificaDuplicidadeConta(List<Account> listaConta) {
        
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - verificaDuplicidadeConta()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - verificaDuplicidadeConta()] - listaConta: '+listaConta);
        
        if(!Triggers__c.getOrgDefaults().Duplicidade_conta__c) return;
        
        carregarInformacoes();
        
        if(listaConta != null && listaConta.size() > 0) {
            
            // Carrega as informações do tipo de registro da conta
            Util_Conta.carregarTipoRegistro();
            
            Set<Id> setIdConta = new Set<Id>();
            Set<String> setIdVerificaDuplicidade = new Set<String>();
            
            for(Account conta : listaConta){
                
                if(verificarBluetec) {
                    if(Util_Conta.bluetec == conta.RecordTypeId) {
                        setIdConta.add(conta.Id);
                        if(conta.VerificaDuplicidade__c != null && conta.VerificaDuplicidade__c != '') 
                            setIdVerificaDuplicidade.add(conta.VerificaDuplicidade__c);
                    }
                } // if(verificarBluetec)
                
                if(verificarCORP) {
                    if(Util_Conta.CORP == conta.RecordTypeId) {
                        setIdConta.add(conta.Id);
                        if(conta.VerificaDuplicidade__c != null && conta.VerificaDuplicidade__c != '') 
                            setIdVerificaDuplicidade.add(conta.VerificaDuplicidade__c);
                    }
                } // Fim if(verificarCORP)
                
                if(verificarGrupoEconomico) {
                    if(Util_Conta.grupoEconomico == conta.RecordTypeId) {
                        setIdConta.add(conta.Id);
                        
                        // Tipo de registro não verifica a duplicidade
                        //if(conta.VerificaDuplicidade__c != null && conta.VerificaDuplicidade__c != '') 
                        //		setIdVerificaDuplicidade.add(conta.VerificaDuplicidade__c);
                    }
                } // Fim if(verificarGrupoEconomico)
                
                if(verificarMichelin) {
                    if(Util_Conta.michelin == conta.RecordTypeId) {
                        setIdConta.add(conta.Id);
                        if(conta.VerificaDuplicidade__c != null && conta.VerificaDuplicidade__c != '') 
                            setIdVerificaDuplicidade.add(conta.VerificaDuplicidade__c);
                    }
                } // Fim if(verificarMichelin) 
                
                if(verificarSIGGO) {
                    if(Util_Conta.SIGGO == conta.RecordTypeId) {
                        setIdConta.add(conta.Id);
                        if(conta.VerificaDuplicidade__c != null && conta.VerificaDuplicidade__c != '') 
                            setIdVerificaDuplicidade.add(conta.VerificaDuplicidade__c);
                    }								
                } // Fim if(verificarSIGGO)
                
            } // Fim for(Account conta : listaConta)
            
            System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - verificaDuplicidadeConta()] - setIdConta: '+setIdConta);
            System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - verificaDuplicidadeConta()] - setIdVerificaDuplicidade: '+setIdVerificaDuplicidade);
            
            if(setIdConta != null && setIdConta.size() > 0 ){
                
                for(Account conta : DAO_Conta.getContaVerificaoDuplicidadePorId(setIdConta, setIdVerificaDuplicidade)){
                    
                    String urlBase = String.valueof(URL.getSalesforceBaseUrl().toExternalForm());
                    
                    String cpfCNPJ = '';
                    if(conta.CNPJ__c != null && conta.CNPJ__c != '') cpfCNPJ = conta.CNPJ__c;
                    if(conta.CNPJ_CPF__c != null && conta.CNPJ_CPF__c != '') cpfCNPJ = conta.CNPJ_CPF__c;
                    if(conta.CPF__c != null && conta.CPF__c != '') cpfCNPJ = conta.CPF__c;
                    //throw new customException(Label.MSG_ERRO_0004 + ' Nome da Conta: <a target=\'_blank\' href=\''+urlBase+'/'+conta.Id+'\'>'+conta.Name+'</a>'); - rbasilva 28-05-18: alterei apenas a mensagem de erro, que estava aparecendo fora de formato, sem o link pretendido e com o código "href...".
                    throw new customException(Label.MSG_ERRO_0004 + ' Nome da Conta: '+conta.Name);
                }
                
            } // Fim if(setIdConta != null && setIdConta.size() > 0 )
            
        } else {
            
            throw new customException(Label.MSG_ERRO_0001);
            
        } // if(listaConta != null && listaConta.size() > 0)
        
    } // Fim verificaDuplicidadeConta

	 //Fim da classe que verificava duplicidade de contas.
    
    
    // Método que faz a busca do CEP
	public static void buscaCEP(List<Account> listaConta) {

		System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - buscaCEP()] - Inicio...');
		System.debug(LoggingLevel.ERROR, '__ [cls Service_Lead - buscaCEP()] - listaConta: '+listaConta);

        if(!Servicos__c.getOrgDefaults().Busca_CEP_conta__c) return;

		if(listaConta != null && listaConta.size() > 0) {

			for(Account conta : listaConta){

				if(System.IsBatch() == false && System.isFuture() == false) {
 					if(conta.Enderecos_Principal_CEP__c != null ){
    					Util_Organizacao.buscaCEP(conta.Id, conta.Enderecos_Principal_CEP__c, 'conta', 'principal');
                        conta.BotaoAtualizaCEPEndPrincipal__c = false;
                        //conta.Cep_preenchido_principal__c = false; rbsilva 26-11-2018: Temos duas flags, então vamos utilizar uma para realizar a verificação de rodar ou não a atualização no botão,
                        //																enquanto que a outra será utilizada para dar bypass na verificação de Circuito e Cadência que já estavam no código,
                        //																por que por ser um método futuro, a mesma flag não funciona.
    				}
                    if(conta.Enderecos_Entrega_CEP__c != null ){
    					Util_Organizacao.buscaCEP(conta.Id, conta.Enderecos_Entrega_CEP__c, 'conta', 'entrega');
                        conta.BotaoAtualizaCEPEndEntrega__c = false;
                        //conta.Cep_preenchido_entrega__c = false;
    				}
                    if(conta.Enderecos_Cobranca_CEP__c != null ){
    					Util_Organizacao.buscaCEP(conta.Id, conta.Enderecos_Cobranca_CEP__c, 'conta', 'cobranca');
                        conta.BotaoAtualizaCEPEndCobranca__c = false;
                        //conta.Cep_preenchido_cobranca__c = false;
    				}
				}

			} // Fim for(Lead lead : listaLead)

        } // Fim if(listaLead != null && listaLead.size() > 0) 

	} // Fim verificaDuplicidadeLead
    
    
    
    // Método que verifica a validação da CUIT
    public static void validacaoCUIT(List<Account> listaAccount) {
        
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Account - validacaoCUIT()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Account - validacaoCUIT()] - listaAccount: '+listaAccount);
        
        if(listaAccount != null && listaAccount.size() > 0) {
            
            for(Account conta : listaAccount){
                
                System.debug(LoggingLevel.ERROR, '__ [cls Service_Account - validacaoCUIT()] - conta.CUIT__c: '+conta.CUIT__c);
                
                if(conta.CUIT__c != null && conta.CUIT__c != '' && 
                   !Util_Validacoes.validarCUIT(conta.CUIT__c)){
                       
                       if(Triggers__c.getOrgDefaults().Estudo_base__c)
                       		conta.Verificar_registro__c = true;
                       else
                       		throw new customException(Label.MSG_ERRO_0008); //Os lançamentos de exceção deverão ser comentados para rodar a trigger em tod
                   }
            } // Fim for(Account conta : listaAccount)
            
        } else {
            throw new customException(Label.MSG_ERRO_0009); // verificar que erro é esse... se não tem conta nenhuma, não deveria nem entrar na trigger
        } // if(listaAccount != null && listaconta.size() > 0)
        
    } // Fim validacaoCUIT
    
    
    // Método que verifica a validação do CPF
    public static void validacaoCPF(List<Account> listaAccount) {
        
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Account - validacaoCPF()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Account - validacaoCPF()] - listaAccount: '+listaAccount);
        
        if(listaAccount != null && listaAccount.size() > 0) {
            
            for(Account conta : listaAccount){
                
                System.debug(LoggingLevel.ERROR, '__ [cls Service_Account - validacaoCPF()] - conta.CPF__c: '+conta.CPF__c);
                
                if(conta.CPF__c != null && conta.CPF__c != ''){
                    
                    String cpfRetorno = Util_Validacoes.validarCPF(conta.CPF__c);
                    
                    if(cpfRetorno != null) 
                        conta.CPF__c = cpfRetorno;
                    else{ 
                        	if(Triggers__c.getOrgDefaults().Estudo_base__c)
                        		conta.Verificar_registro__c = true;
                            else
                        		throw new customException(Label.MSG_ERRO_0011);
                    }
                } // Fim if(conta.CPF__c != null && conta.CPF__c != '')
                
            } // Fim for(Account conta : listaAccount)
            
        } else {
            
            throw new customException(Label.MSG_ERRO_0012); //idem ao anterior, entender por que lançamos exceção aqui.
        } // if(listaAccount != null && listaconta.size() > 0)
        
    } // Fim validacaoCPF
    
    
    // Método que verifica a validação do CPF
    public static void validacaoCNPJ(List<Account> listaAccount) {
        
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - validacaoCNPJ()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - validacaoCNPJ()] - listaAccount: '+listaAccount);
        Boolean retorno = true;
        
        if(listaAccount != null && listaAccount.size() > 0) {
            
            for(Account conta : listaAccount){
                
                System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - validacaoCNPJ()] - conta.CNPJ__c: '+conta.CNPJ__c);
                
                if(conta.CNPJ__c != null && conta.CNPJ__c != ''){
                    
                    String cnpjRetorno = Util_Validacoes.validarCNPJ(conta.CNPJ__c);
                    
                    System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - validacaoCNPJ()] - cnpjRetorno: '+cnpjRetorno);
                    
                    if(cnpjRetorno != null) 
                        conta.CNPJ__c = cnpjRetorno;
                    else{
                        //retorno = true;
                        if(Triggers__c.getOrgDefaults().Estudo_base__c)
                            conta.Verificar_registro__c = true;
                        else
                            conta.addError('Insira um CNPJ válido para salvar o registro.');
                            //throw new customException(Label.MSG_ERRO_0013); // deverão ser comentadas os lançamentos de exceção quando for rodar a trigger em todos os registros.
                    }
                        
                }
            } // Fim for(Account conta : listaAccount)
            
        } else {
            
            throw new customException(Label.MSG_ERRO_0014);
        } // if(listaAccount != null && listaconta.size() > 0)
        
    } // Fim validacaoCNPJ
    
    
    // Método que formata Telefone
    public static void formataTelefone(List<Account> listaConta) {
        
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - formataTelefone()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - formataTelefone()] - listaConta: '+listaConta);
        
        try {
            
            if(listaConta != null && listaConta.size() > 0) {
                
                Util_conta.carregarTipoRegistro();
                
                for(Account conta : listaConta){
                    
                    System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - formataTelefone()] - conta.CNPJ__c: '+conta.CNPJ__c);
                    System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - formataTelefone()] - conta.RecordType.Name: '+conta.RecordType.Name);
                    
                    // Só faz a formatação se o Account não for do mercosul
                    if(conta.RecordTypeId != Util_conta.mercosul){
                        
                        if(conta.Phone != null && conta.Phone != ''){
                            
                            conta.Phone = Util_Organizacao.formatarTelefoneBrasil(conta.Phone);
                        }
                        
                        if(conta.TelefoneCelular__c != null && conta.TelefoneCelular__c != ''){
                            
                            conta.TelefoneCelular__c = Util_Organizacao.formatarTelefoneBrasil(conta.TelefoneCelular__c);
                        }
                        
                        if(conta.Telefone_2__c != null && conta.Telefone_2__c != ''){
                            
                            conta.Telefone_2__c = Util_Organizacao.formatarTelefoneBrasil(conta.Telefone_2__c);
                        }
                        
                        if(conta.Telefone_3__c != null && conta.Telefone_3__c != ''){
                            
                            conta.Telefone_3__c = Util_Organizacao.formatarTelefoneBrasil(conta.Telefone_3__c);
                        }						
                        
                    } // Fim if(conta.RecordTypeId != Util_conta.mercosul)
                    
                } // Fim for(Account conta : listaConta)
                
            } else {
                
                throw new customException(Label.MSG_ERRO_0015);
            } // if(listaConta != null && listaConta.size() > 0)
            
        } catch(Exception e){
            
            System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - formataTelefone()] - ERRO: '+e.getMessage());
            throw new customException(e.getMessage());
        } // Fim try/catch
        
    } // Fim formataTelefone
    
    
    // Método que copia os campos do Lead para a Conta
    public static void copiarCamposLeadConta(List<Account> newList) {
        
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - copiarCamposLeadConta()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - copiarCamposLeadConta()] - newList: '+newList);
        
        if(newList != null && newList.size() > 0) {
            
            for(Account conta : newList){
                
                Util_Conta.copiarCamposLeadConta(conta.Id);
                
            } // Fim for(Lead lead : newList)
            
        } // Fim if(newList != null && newList.size() > 0)
        
    } // Fim copiarCamposLeadConta
    
	//rbsilva 08-06-2018:
    //Classe que deverá marcar as contas que possuem oportunidades. Por padrão as triggers estão trazendo listas de registros do próprio objeto, analisar
    //o impacto de enviar uma lista de IDs do registro.
    public static void possuiOportunidade(List<Account> listAccounts)
    {
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - possuiOportunidade()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - possuiOportunidade()] - listAccounts: '+listAccounts);
        
        List<Id> accIds = new List<Id>(); // Lista de Ids das contas que entraram como argumento do método.
        List<Id> accIdsToChange = new List<Id>(); // Lista de Ids das contas que possuem oportunidades.
        List<Account> modifiedAccounts = new List<Account>(); // Lista de contas que serão marcadas na flag "Possui_oportunidade__c"

        for(Account a : listAccounts)
        {
            accIds.add(a.Id);
        }
        
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - possuiOportunidade()] - accIds: '+accIds);
        
        List<Opportunity> opportunities = new List<Opportunity>();
        
        opportunities = [SELECT Id, AccountId FROM Opportunity WHERE AccountId IN : accIds]; // As queries deverão ser incluídas no método "DAO_Conta" (Nesse caso, DAO_Oportunidade), mas não foram por enquanto por que estou aguardando validar as alterações.
        																			// Por enquanto vou evitar alterar outras classes desnecessariamete.
		
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - possuiOportunidade()] - opportunities: '+opportunities);
        
		for(Opportunity o : opportunities)
        {
            accIdsToChange.add(o.AccountId);
        }
        
        modifiedAccounts = [SELECT Id, Possui_oportunidade__c FROM Account WHERE Id IN : accIdsToChange]; // Análogo ao comentário em "opportunities".
        
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - possuiOportunidade()] - modifiedAccounts: '+modifiedAccounts);
        
        for(Account a : listAccounts)
        {
            if(accIdsToChange.contains(a.Id))
                a.Possui_oportunidade__c = true;
        }
        
    }
    
    /* rbsilva 08-06-2018:
     * 
     * Classe que deverá marcar as contas que estão duplicadas no campo "Registro_duplicado__c". Por padrão as triggers estão trazendo listas de registros do próprio objeto, analisar
     * o impacto de enviar uma lista de IDs do registro.
     * Este método deverá ficar comentado, e rodar apenas em ambiente controlado, visto que somente servirá sem a verificação de duplicidade ativa, e somente após todos os registros terem
     * preenchido a chave externa, para que tenhamos base de comparação.
     * Verificar a possibilidade de criar um novo campo fórmula para não precisar de uma rotina de preenchimento do "VerificaDuplicidade"
    */
    public static void marcarDuplicidades(List<Account> listAccounts)
    {
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - marcarDuplicidades()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - marcarDuplicidades()] - listAccounts: '+listAccounts);
        
        List<String> listaChaveExterna = new List<String>(); // Lista dos valores de chave externa que estarão na query de contas a serem modificadas.
        List<String> extKeysToModify = new List<String>();
        List<Account> accountsToModify = new List<Account>();
        
        for(Account a : listAccounts)
        {
            System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - marcarDuplicidades()] - a.VerificaDuplicidade_3__c: '+a.VerificaDuplicidade_3__c);
            
            if(!listaChaveExterna.contains(a.VerificaDuplicidade_3__c)) // Verifica se a lista já possui o valor de chave externa. Se não existir, adiciona à lista, se existir, marca a conta como duplicidade.
            {
                listaChaveExterna.add(a.VerificaDuplicidade_3__c);
            }
            else
            {
                a.Registro_duplicado__c = true;
                extKeysToModify.add(a.VerificaDuplicidade_3__c);
                System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - marcarDuplicidades()] - Id Registro Alterado: '+a.Id);
            }
            
            System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - marcarDuplicidades()] - listaChaveExterna: '+listaChaveExterna);
        }
        
        for(Account a : listAccounts) //for para alterar os registros que faltaram (primeira ocorrência na lista do primeiro for)
        {
            if(extKeysToModify.contains(a.VerificaDuplicidade_3__c) && a.Registro_duplicado__c == false)
            {
                a.Registro_duplicado__c = true;
            }
        }
    }
    
    //rbsilva 11-06-18:
    //		Agregando a trigger "Account_CleanBlankSpaceFields".
    //		Entender um pouco melhor a necessidade de existir esse método.
    //
    public static void cleanBlankSpaceFields(List<Account> listAccounts){ //rbsilva 11-06-18: alteração na trigger original, passando a aceitar lista no método, em lugar de item único.
		try{
			//Aplicando .trim() para remover espaços em branco
			//no início e final do texto
			
            for(Account acc : listAccounts)
            {
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
            }
										
		} catch(System.NullPointerException e){
			System.debug('Account - NullPointerException: '+ e);
		}
    }
    
    
    //rbsilva 11-06-18:
    //	Agregando "AccountTriggers.apxt"
    //	Verificar o impacto de remover esse método, visto que não é necessário criar uma flag customizada para marcar contas convertidas de um lead.
    //	
    public static void markLeadOrigin(List<Account> accountList) {
        Map<Id,Id> mapLead = new Map<Id,Id>();
        Set<Id> accIds = new Set<Id>();
        for(Account acc :accountList){
            accIds.add(acc.Id);
        }
        for (Lead l : [SELECT Id, ConvertedAccountId FROM Lead WHERE ConvertedAccountId IN :accIds LIMIT 99999]){
            if(l.ConvertedAccountId != null){
                mapLead.put(l.ConvertedAccountId, l.Id);
            }
        }
        for (Account acc: accountList) {
            if (mapLead.containsKey(acc.Id)) {
                acc.Criado_via_lead__c = true;
            }else{
                acc.Criado_via_Lead__c = false;
            }
        }
    }
    
    
    //rbsilva 11-06-18:
    //	Agregando "Account_updateShippingAddress.apxt".
    public static void updateShippingAddress(List<Account> accList) {
        for(Account acc: accList) {
            
            if (acc.Enderecos_Entrega_UsarPrincipal__c)
            {
                
                acc.Enderecos_Entrega_Bairro__c = acc.Enderecos_Principal_Bairro__c;
                acc.Enderecos_Entrega_CEP__c = acc.Enderecos_Principal_CEP__c;
                acc.Enderecos_Entrega_Cidade__c = acc.Enderecos_Principal_Cidade__c;
                acc.Enderecos_Entrega_Complemento__c = acc.Enderecos_Principal_Complemento__c;
                acc.Enderecos_Entrega_Logradouro__c = acc.Enderecos_Principal_Logradouro__c;
                acc.Enderecos_Entrega_Numero__c = acc.Enderecos_Principal_Numero__c;
                acc.Enderecos_Entrega_Pais__c = acc.Enderecos_Principal_Pais__c;
                acc.Enderecos_Entrega_UF__c = acc.Enderecos_Principal_UF__c;
            }
        }
    }
    
    //rbsilva 11-06-18:
    //	Agregando "Account_updateBillingAddress.apxt"
    public static void updateBillingAddress(List<Account> accList) {
        system.debug('to no método');
        for(Account acc: accList) {
            system.debug('to no for');
            if (acc.Enderecos_Cobranca_UsarPrincial__c)
            {
                system.debug('entrega');
                acc.Enderecos_Cobranca_Bairro__c = acc.Enderecos_Principal_Bairro__c;
                acc.Enderecos_Cobranca_CEP__c = acc.Enderecos_Principal_CEP__c;
                acc.Enderecos_Cobranca_Cidade__c = acc.Enderecos_Principal_Cidade__c;
                acc.Enderecos_Cobranca_Complemento__c = acc.Enderecos_Principal_Complemento__c;
                acc.Enderecos_Cobranca_Logradouro__c = acc.Enderecos_Principal_Logradouro__c;
                acc.Enderecos_Cobranca_Numero__c = acc.Enderecos_Principal_Numero__c;
                acc.Enderecos_Cobranca_Pais__c = acc.Enderecos_Principal_Pais__c;
                acc.Enderecos_Cobranca_UF__c = acc.Enderecos_Principal_UF__c;
                acc.Codigo_municipio_cobranca__c = acc.Codigo_municipio_cobranca__c;
            }
        }
    }//
    
    //rbsilva 11-06-18:
    //	Agregando "Account_VerificaBandeiraCartao.apxt"
    public static void setBandeiraCartao(List<Account> listAccounts){ // Alterado para receber lista como parâmetro.
		//Visa
		Pattern pVisa = Pattern.compile('(4[0-9]{12}(?:[0-9]{3}))');
		//Mastercard
		Pattern pMastercard = Pattern.compile('(5[1-5][0-9]{14})');
		//Hipercard
		Pattern pHipercard = Pattern.compile('(606282[0-9]{7,13}|3841[0-9]{9,15})');
		
        for(Account acc : listAccounts) // rbsilva 11-06-2018: alteração para receber listas como parâmetro.
        {
            if(acc.Cobranca_Cartao_Numero_Cript__c != null){
                //Numero do cartao
                String card = (String) acc.Cobranca_Cartao_Numero_Cript__c;
                
                //Valida no pattern
                Matcher mVisa = pVisa.matcher(card);		
                Matcher mMastercard = pMastercard.matcher(card);		
                Matcher mHipercard = pHipercard.matcher(card);
                
                if(mVisa.matches()){
                    acc.Tipo_cartao__c = 'Visa';
                    acc.FormaCobranca__c = '24-Cartão Visa';
                    acc.Dia_de_vencimento__c = '16';
                } else if(mMastercard.matches()){
                    acc.Tipo_cartao__c = 'Mastercard';
                    acc.FormaCobranca__c = '25-Cartão Mastercard';
                    acc.Dia_de_vencimento__c = '16';
                } else if(mHipercard.matches()){
                    acc.Tipo_cartao__c = 'Hipercard';
                    acc.FormaCobranca__c = '82-Cartão Hipercard';
                    acc.Dia_de_vencimento__c = '16';
                }
			}
            
        }
		
	}//
    
    //rbsilva 11-06-18:
    //	Agregando "Account_ValidarCircuitoCadencia.apxt"
    public static void validarCircuitoCadencia(List<Account> listAcc, String userRoleId){
    	if(userRoleId != null){
			UserRole userRole = [SELECT Name FROM UserRole WHERE Id =:userRoleId];
			system.debug('UserRole: '+userRole);
			
			if(userRole.Name.contains('Executivo') || userRole.Name.contains('Administrador')){
				for(Account acc : listAcc){
					if(acc.RecordTypeId != null){
						//Recuperando o record type name do objeto Conta
						String recordTypeName = Account.SObjectType.getDescribe().getRecordTypeInfosById().get(acc.RecordTypeId).getName();
						system.debug('recordTypeName: '+recordTypeName);
						
						if(recordTypeName == 'CORP'){
							system.debug('Circuito__c: '+acc.Circuito__c);
							system.debug('Cadencia__c: '+acc.Cadencia__c);
							if((acc.Circuito__c == null)&&(acc.Cep_preenchido_principal__c == false)&&(acc.Cep_preenchido_entrega__c == false)&&(acc.Cep_preenchido_cobranca__c == false)){
								acc.Circuito__c.addError('Informe o Circuito.');
                            } else if((acc.Cadencia__c == null)&&(acc.Cep_preenchido_principal__c == false)&&(acc.Cep_preenchido_entrega__c == false)&&(acc.Cep_preenchido_cobranca__c == false)){
								acc.Cadencia__c.addError('Informe a Cadência.');
							}
						}
					}
				}
			}
		}
    } //
    
    //rbsilva 11-06-18:
    //	Agregando "Account_updateRelatedContacts.apxt"
    public static void updateRelatedContacts(List<Account> accList) {
        
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - updateRelatedContacts()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - updateRelatedContacts()] - accList: '+accList);
        
        Map<Id,Account> mapAcc = new Map<Id,Account>();
        Account oldAcc = new Account();
        Boolean condicao;
        if(!Test.isRunningTest()){
            for(Account acc :accList){
                oldAcc = (Account) Trigger.oldMap.get(acc.Id);
                System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - updateRelatedContacts()] - oldAcc: '+oldAcc);
                
                condicao = (acc.DadosPF_RG__c != null && acc.DadosPF_RG__c != '' && acc.CPF__c != null && acc.CPF__c != '')&&(acc.DadosPF_RG__c != oldAcc.DadosPF_RG__c || acc.CPF__c != oldAcc.CPF__c);
                
                if(condicao){
                    mapAcc.put(acc.Id,acc);
                }
            }
        }
        if(mapAcc.size() > 0){ 
            List<Contact> lstContact = [SELECT Id, RG__c, CPF__c, AccountId FROM Contact WHERE AccountId IN :mapAcc.keySet()];
            if(lstContact.size() > 0){
                for(Contact c :lstContact){
                    if(c.RG__c == null || c.RG__c == ''){
                        System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - updateRelatedContacts()] - mapAcc.get(c.AccountId).DadosPF_RG__c: '+mapAcc.get(c.AccountId).DadosPF_RG__c);
                        c.RG__c = mapAcc.get(c.AccountId).DadosPF_RG__c;
                    }
                    if(c.CPF__c == null || c.CPF__c == ''){
                        System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - updateRelatedContacts()] - mapAcc.get(c.AccountId).CPF__c: '+mapAcc.get(c.AccountId).CPF__c);
                        c.CPF__c = mapAcc.get(c.AccountId).CPF__c;
                    }
                }
                update lstContact;
                
                System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - updateRelatedContacts()] - lstContact: '+lstContact);
            }
        }
    }//
    
    //rbsilva 11-06-18:
    //	Agregando "ValidarNomePortador.apxt"
    //	A classe precisou ser reescrita, e ainda contém algumas alterações a serem realizadas que podem ser contempladas durante o teste.
    //	A ressaltar, as principais alterações realizadas trataram de adequar os parâmetros de entrada e o tratamento de listas dentro do método.
    public static void validarNomePortador(List<Account> listAccounts, Boolean isInsert, Boolean isUpdate){
        
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - validarNomePortador()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - validarNomePortador()] - listAccounts: '+listAccounts);
        
        Map<Id, String> mapRecTypeIdName = new Map<Id, String>();
        Map<Id, Account> mapIdOldAcc = new Map<Id, Account>();
        List<RecordType> recTypeList = new List<RecordType>();
        Account oldAcc = new Account();
        recTypeList = [SELECT Id, Name, DeveloperName, SObjectType FROM RecordType WHERE SObjectType = 'Account'];
        
        for(RecordType rt : recTypeList)
        {
            mapRecTypeIdName.put(rt.Id, rt.Name);
        }
        
        for(Account acc : listAccounts)
        {
            
            if(mapRecTypeIdName.get(acc.RecordTypeId).toUpperCase() == 'SIGGO'){
                if(isInsert){ //rbsilva 13-06-2018: essa verificação não precisa de trigger para acontecer, entender o impacto de substituir por uma regra de validação.
                    if(acc.FormaCobranca__c != null){
                        if(acc.FormaCobranca__c == '24-Cartão Visa' || acc.FormaCobranca__c == '25-Cartão Mastercard' || acc.FormaCobranca__c == '82-Cartão Hipercard'){
                            if(acc.Nome_do_portador__c == null || acc.Nome_do_portador__c == ''){
                                acc.Nome_do_portador__c.addError('Informe o nome do portador conforme impresso no cartão.');
                            }
                        }
                    }
                } else if(isUpdate){ //rbsilva 13-06-2018: essa verificação não precisa de trigger para acontecer, entender o impacto de substituir por uma regra de validação.
                    if(acc.FormaCobranca__c != null){
                        oldAcc = (Account) Trigger.oldMap.get(acc.Id);
                        System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - validarNomePortador()] - oldAcc: '+oldAcc);
                        System.debug(LoggingLevel.ERROR, '__ [cls Service_Conta - validarNomePortador()] - acc.FormaCobranca__c: '+acc.FormaCobranca__c);
                        if(acc.FormaCobranca__c == '24-Cartão Visa' || acc.FormaCobranca__c == '25-Cartão Mastercard' || acc.FormaCobranca__c == '82-Cartão Hipercard'){
                            if(acc.Cobranca_Cartao_Numero_Cript__c == ''){
                                acc.Cobranca_Cartao_Numero_Cript__c = null;
                            }
                            
                            if(acc.FormaCobranca__c != oldAcc.FormaCobranca__c){
                                if(acc.Nome_do_portador__c == null || acc.Nome_do_portador__c == ''){
                                    acc.Nome_do_portador__c.addError('Informe o nome do portador conforme impresso no cartão.');
                                }
                            } else if(acc.Cobranca_Cartao_Numero_Cript__c != oldAcc.Cobranca_Cartao_Numero_Cript__c){
                                system.debug('Cobranca_Cartao_Numero_Cript__c acc: '+acc.Cobranca_Cartao_Numero_Cript__c);
                                system.debug('Cobranca_Cartao_Numero_Cript__c oldAcc: '+oldAcc.Cobranca_Cartao_Numero_Cript__c);
                                if(acc.Nome_do_portador__c == null || acc.Nome_do_portador__c == ''){
                                    acc.Nome_do_portador__c.addError('Informe o nome do portador conforme impresso no cartão.');
                                }
                            } else if(acc.Nome_do_portador__c != oldAcc.Nome_do_portador__c){
                                if(acc.Nome_do_portador__c == null || acc.Nome_do_portador__c == ''){
                                    acc.Nome_do_portador__c.addError('Informe o nome do portador conforme impresso no cartão.');
                                }
                            }
                        }
                    }
                }
            }//
        }
    }
}