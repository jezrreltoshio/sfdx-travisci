public with sharing class termoPDFController extends PageControllerBase{
    //Campos de Oportunidade - Dados Cadastrais
    public Opportunity opp {get; set;}
    public String idOpportunity {get;set;}
    public String pdfName {get;set;}
    
    public String Opportunity_Name {get; set;} 
    public String Opportunity_ExecutivoDeVendas {get; set;} 
    public String Opportunity_Televendas {get;set;}
    public String Opportunity_DMV {get;set;}
    public String Opportunity_Indicador {get;set;}
    public String Opportunity_GR {get;set;}
    public String Opportunity_TipoNegociacao {get;set;}    
    public String Opportunity_TipoContrato {get;set;}
    
    //Campos de Conta - Dados do Cliente
    public String Account_RazaoSocial {get;set;} 
    public String Account_Cidade_UF {get;set;} 
    public String Account_CEP {get;set;} 
    public String Account_Endereco_Bairro {get;set;}
    public String Account_Complemento {get;set;}
    public String Contact_Email {get;set;} 
    public String Contact_EmailNFE {get;set;} 
    public String Account_CNPJ_CPF {get;set;}
    public String Account_InscricaoEstadual {get;set;} 
    public String Account_Telefone {get;set;} 
    public String Account_NomeDoPai {get;set;} 
    public String Account_NomeDaMae {get;set;} 
    public String Account_RG {get;set;} 
    public String Account_DtNascimento {get;set;}
    
    //Campos para exibir informações de Contato - Pessoas Autorizadas
    public String Contact1_NomeCompleto {get;set;}
    public String Contact1_RG {get;set;}
    public String Contact1_CPF {get;set;}
    public String Contact1_Tel1 {get;set;}
    public String Contact1_Tel2 {get;set;}
    public String Contact1_Tel3 {get;set;}
    public String Contact1_Tel4 {get;set;}
    public String Contact2_NomeCompleto {get;set;}
    public String Contact2_RG {get;set;}
    public String Contact2_CPF {get;set;}
    public String Contact2_Tel1 {get;set;}
    public String Contact2_Tel2 {get;set;}
    public String Contact2_Tel3 {get;set;}
    public String Contact2_Tel4 {get;set;}
    
    //Campos para exibir informações de Contato - Casos de Emergência  
    public String SOS_Contact1_NomeCompleto {get;set;}
    public String SOS_Contact1_RG {get;set;}
    public String SOS_Contact1_CPF {get;set;}
    public String SOS_Contact1_Tel1 {get;set;}
    public String SOS_Contact1_Tel2 {get;set;}
    public String SOS_Contact1_Tel3 {get;set;}
    public String SOS_Contact1_Tel4 {get;set;}
    public String SOS_Contact2_NomeCompleto {get;set;}
    public String SOS_Contact2_RG {get;set;}
    public String SOS_Contact2_CPF {get;set;}
    public String SOS_Contact2_Tel1 {get;set;}
    public String SOS_Contact2_Tel2 {get;set;}
    public String SOS_Contact2_Tel3 {get;set;}
    public String SOS_Contact2_Tel4 {get;set;}
    
    //Campos para exibir informações de Contato - Pessoa Contato no Cliente
    public String PessoaContatoCliente_NomeCompleto {get;set;}
    public String PessoaContatoCliente_Email {get;set;}
    public String PessoaContatoCliente_Tel1 {get;set;}
    public String PessoaContatoCliente_Tel2 {get;set;}
    public String PessoaContatoCliente_Tel3 {get;set;}
    
    //Campos de Conta SIGGO - Forma de Pagamento
    public String FormaDeCobranca {get;set;}
    public String Boleto_DiaDeVencimento {get;set;}
    public String Debito_Banco {get;set;}
    public String Debito_Agencia {get;set;}
    public String Debito_Conta {get;set;}
    public String Debito_DiaDeVencimento {get;set;}
    public String Credito_Cartao {get;set;}
    public String Credito_NomeCartao {get;set;}    
    public String Credito_NumeroCartao {get;set;}
    public String Credito_VencimentoCartao {get;set;}
    
    //Campos exibidos apenas no PDF
    public String DataDeCriacao {get;set;} //Campo para armazenar data da geração do termo (Data Atual)
    List<SelectOption> optionTermo = new List<SelectOption>(); // Opções de uso ou não de Adesivo
    public String tipoTermo {get;set;} // Valor selecionado em página exibida antes do PDF
    List<SelectOption> options = new List<SelectOption>(); // Opções de uso ou não de Adesivo
    public String adesivo {get;set;} // Valor selecionado em página exibida antes do PDF
    public String MultaRescisoria {get;set;} //Valor armazenado em Rótulo Personalizado (Armazenado em Rótulo Personalizado)
    
    //Campos de Cotação
    public String Quote_Numero {get;set;}
    public String Quote_Proposta {get;set;}
    public String Quote_Validade {get;set;}
    public String Quote_DataDeCriacao {get;set;}
    public String Quote_TaxaDeAdesao {get;set;}
    public String Quote_QtdeEquipamentosVendidos {get;set;}
    public String Quote_TotalTaxaDeAdesao {get;set;}
    public String Quote_ValorMensal {get;set;}
    public String Quote_ValorUntMensal {get;set;}
    
    //Campos de Item de Linha da Cotação
    public List<QuoteLineItem> lstQli {get;set;}
    //public String ILQ_Produto {get;set;}
    //public String ILQ_Familia {get;set;}
    //public String ILQ_Prazo {get;set;}
    //public String ILQ_Qtde {get;set;}
    //public String ILQ_ValorMensal {get;set;}
    //public String ILQ_ValorUntMensal {get;set;}
    
    //Campos de Veículo
    public List<ItemPropostaSiggo__c> lstIPS {get;set;}
    public String Veiculo_Marca {get;set;}
    public String Veiculo_Modelo {get;set;}
    public String Veiculo_Placa {get;set;}
    public String Veiculo_Chassi {get;set;}
    public String Veiculo_Ano {get;set;}
    public String Veiculo_Cor {get;set;}
    public String Veiculo_Renavam {get;set;}
    public String Veiculo_Produto {get;set;}
    
    //Campos de Taxa de Serviço
    public List<Taxas_de_Servicos__c> lstTaxa_Acessorios {get;set;}
    public List<Taxas_de_Servicos__c> lstTaxa_Produtos {get;set;}
    public List<Taxas_de_Servicos__c> lstTaxa_Servicos {get;set;}
    
    public termoPDFController()
    {
        idOpportunity = ApexPages.currentPage().getParameters().get('id');
        if(idOpportunity != null) this.setValuesPDF();
    }
    
    public termoPDFController(ApexPages.StandardController controller) {
        idOpportunity = ApexPages.currentPage().getParameters().get('id');
        if(idOpportunity != null) this.setValuesPDF();
    }
    
    public termoPDFController(attachmentController controller) {
        idOpportunity = ApexPages.currentPage().getParameters().get('id');
        if(idOpportunity != null) this.setValuesPDF();
    }
    
    public List<SelectOption> getItems() {
        if(options.isEmpty()){
            options.add(new SelectOption('Sim', 'Sim'));
            options.add(new SelectOption('Não', 'Não'));
        }
        return options;
    }
    
    public String getAdesivo() {
        return adesivo;
    }
    
    public void setAdesivo(String adesivo) {
        this.adesivo = adesivo;
    }
    
    public List<SelectOption> getTermo() {
        if(optionTermo.isEmpty()){
            optionTermo.add(new SelectOption('Base', 'Termo de Aquisição - Base'));
            optionTermo.add(new SelectOption('Novo', 'Termo de Aquisição - Novo'));
        }
        return optionTermo;
    }
    
    public String gettipoTermo() {
        return tipoTermo;
    }
    
    public void settipoTermo(String tipoTermo) {
        this.tipoTermo = tipoTermo;
    }
    
    private void setValuesPDF(){
        this.DataDeCriacao = String.valueOf(Date.today()).substring(8,10) + '/' + String.valueOf(Date.today()).substring(5,7)  + '/' + String.valueOf(Date.today()).substring(0,4) ;
        this.tipoTermo = tipoTermo;
        this.adesivo = adesivo;
        
        //Consulta informações do objeto Opportunity
        Map<Id,Opportunity> mapOpp = new Map<Id,Opportunity>([SELECT Id, AccountId, OwnerId, Owner.Name, DMV__c, GR__c, Papel_do_propriet_rio__c, Enviado_por__c, Executivo_de_vendas_new__r.Name, Name FROM Opportunity WHERE Id = :idOpportunity]);
        this.Opportunity_Name = mapOpp.get(idOpportunity).Name;
        this.Opportunity_ExecutivoDeVendas = mapOpp.get(idOpportunity).Executivo_de_vendas_new__r.Name;
        this.Opportunity_GR = mapOpp.get(idOpportunity).GR__c;
        
        //if(mapOpp.get(idOpportunity).Papel_do_propriet_rio__c.contains('Televendas')){
        // this.Opportunity_Televendas = mapOpp.get(idOpportunity).Owner.Name; 
        //}
        //if(mapOpp.get(idOpportunity).Executivo_de_vendas_new__c != null && mapOpp.get(idOpportunity).Enviado_por__c == 'Televendas'){
        this.Opportunity_Televendas = mapOpp.get(idOpportunity).Executivo_de_vendas_new__r.Name; 
        //}
        
        this.Opportunity_DMV = string.valueOf(mapOpp.get(idOpportunity).DMV__c);
        
        this.Opportunity_TipoNegociacao = '   -   '; 
        
        //Consulta informações do objeto Account
        Map<Id,Account> mapAcc = new map<Id,Account>();
        for(Account acc :[SELECT Id, Name, Owner.Name, Enderecos_Principal_Cidade__c, Phone, Enderecos_Principal_UF__c, Enderecos_Principal_CEP__c,
                          Enderecos_Principal_Logradouro__c, Enderecos_Principal_Bairro__c, Enderecos_Principal_Numero__c, Enderecos_Principal_Complemento__c, 
                          EMail__c, EMailNFE__c, Indicador__r.Name,
                          CNPJ__c, CPF__c, Inscri_o_estadual__c, TelefoneComercial__c, DadosPF_NomeMae__c, DadosPF_NomePai__c,
                          DadosPF_RG__c, DadosPF_DataNascimento__c, Tipo_de_contrato__c, FormaCobranca__c, 
                          /* Melhorias Siggo */ Cobranca_DiaVcto__c, Dia_de_vencimento__c,
                          DebAut_Agencia__c, DebAut_ContaCorrente__c, Cobranca_Cartao_Numero_Cript__c, Cobranca_Cartao_Vcto__c, Nome_como_no_cartao__c,
                          ContatoPessoaAutorizada__r.Name, ContatoPessoaAutorizada__r.RG__c, ContatoPessoaAutorizada__r.CPF__c, ContatoPessoaAutorizada__r.Phone,
                          ContatoPessoaAutorizada__r.Telefone_2__c, ContatoPessoaAutorizada__r.Telefone_3__c, ContatoPessoaAutorizada__r.Telefone_4__c,
                          ContatoPessoaAutorizada2__r.Name, ContatoPessoaAutorizada2__r.RG__c, ContatoPessoaAutorizada2__r.CPF__c, ContatoPessoaAutorizada2__r.Phone,
                          ContatoPessoaAutorizada2__r.Telefone_2__c, ContatoPessoaAutorizada2__r.Telefone_3__c, ContatoPessoaAutorizada2__r.Telefone_4__c,
                          ContatoEmergencia__r.Name, ContatoEmergencia__r.RG__c, ContatoEmergencia__r.CPF__c, ContatoEmergencia__r.Phone,
                          ContatoEmergencia__r.Telefone_2__c, ContatoEmergencia__r.Telefone_3__c, ContatoEmergencia__r.Telefone_4__c, 
                          ContatoEmergencia2__r.Name, ContatoEmergencia2__r.RG__c, ContatoEmergencia2__r.CPF__c, ContatoEmergencia2__r.Phone,
                          ContatoEmergencia2__r.Telefone_2__c, ContatoEmergencia2__r.Telefone_3__c, ContatoEmergencia2__r.Telefone_4__c,
                          Pessoa_contato_cliente__r.Name, Pessoa_contato_cliente__r.Email, Pessoa_contato_cliente__r.Phone, Pessoa_contato_cliente__r.Telefone_2__c, Pessoa_contato_cliente__r.Telefone_3__c 
                          FROM Account WHERE Id = : mapOpp.get(idOpportunity).AccountId]){
                              mapAcc.put(idOpportunity,acc);                                               
                          }
        this.Opportunity_ExecutivoDeVendas = mapAcc.get(idOpportunity).Owner.Name;
        this.Opportunity_Indicador = mapAcc.get(idOpportunity).Indicador__r.Name; 
        this.Account_RazaoSocial = mapAcc.get(idOpportunity).Name; 
        this.Account_Cidade_UF = mapAcc.get(idOpportunity).Enderecos_Principal_Cidade__c +'/'+ mapAcc.get(idOpportunity).Enderecos_Principal_UF__c; 
        this.Account_CEP = mapAcc.get(idOpportunity).Enderecos_Principal_CEP__c; 
        this.Account_Endereco_Bairro = mapAcc.get(idOpportunity).Enderecos_Principal_Logradouro__c + ', ' + mapAcc.get(idOpportunity).Enderecos_Principal_Numero__c + ' - ' + mapAcc.get(idOpportunity).Enderecos_Principal_Bairro__c;
        this.Account_Complemento = mapAcc.get(idOpportunity).Enderecos_Principal_Complemento__c;
        this.Contact_Email = mapAcc.get(idOpportunity).EMail__c; 
        this.Contact_EmailNFE = mapAcc.get(idOpportunity).EMailNFE__c; 
        this.Account_CNPJ_CPF = (mapAcc.get(idOpportunity).CPF__c != null) ? mapAcc.get(idOpportunity).CPF__c : mapAcc.get(idOpportunity).CNPJ__c;
        this.Account_InscricaoEstadual = mapAcc.get(idOpportunity).Inscri_o_estadual__c; 
        this.Account_Telefone = mapAcc.get(idOpportunity).Phone; 
        this.Account_NomeDoPai = mapAcc.get(idOpportunity).DadosPF_NomePai__c; 
        this.Account_NomeDaMae = mapAcc.get(idOpportunity).DadosPF_NomeMae__c; 
        this.Account_RG = mapAcc.get(idOpportunity).DadosPF_RG__c; 
        //if (this.Account_DtNascimento != NULL) {}
        if (String.valueOf(mapAcc.get(idOpportunity).DadosPF_DataNascimento__c) != NULL) {
            this.Account_DtNascimento = 
                String.valueOf(mapAcc.get(idOpportunity).DadosPF_DataNascimento__c).substring(8,10) + '/' + 
                String.valueOf(mapAcc.get(idOpportunity).DadosPF_DataNascimento__c).substring(5,7)  + '/' + 
                String.valueOf(mapAcc.get(idOpportunity).DadosPF_DataNascimento__c).substring(0,4);
        }
        
        this.Opportunity_TipoContrato = (mapAcc.get(idOpportunity).Tipo_de_contrato__c) != null ? mapAcc.get(idOpportunity).Tipo_de_contrato__c : 'Cliente';
        
        // - - - - - Consulta informações do objeto Contato - - - - -
        this.Contact1_NomeCompleto = mapAcc.get(idOpportunity).ContatoPessoaAutorizada__r.Name;
        this.Contact1_RG = mapAcc.get(idOpportunity).ContatoPessoaAutorizada__r.RG__c;
        this.Contact1_CPF = mapAcc.get(idOpportunity).ContatoPessoaAutorizada__r.CPF__c;
        this.Contact1_Tel1 = mapAcc.get(idOpportunity).ContatoPessoaAutorizada__r.Phone;
        this.Contact1_Tel2 = mapAcc.get(idOpportunity).ContatoPessoaAutorizada__r.Telefone_2__c;
        this.Contact1_Tel3 = mapAcc.get(idOpportunity).ContatoPessoaAutorizada__r.Telefone_3__c;
        this.Contact1_Tel4 = mapAcc.get(idOpportunity).ContatoPessoaAutorizada__r.Telefone_4__c;
        this.Contact2_NomeCompleto = mapAcc.get(idOpportunity).ContatoPessoaAutorizada2__r.Name;
        this.Contact2_RG = mapAcc.get(idOpportunity).ContatoPessoaAutorizada2__r.RG__c;
        this.Contact2_CPF = mapAcc.get(idOpportunity).ContatoPessoaAutorizada2__r.CPF__c;
        this.Contact2_Tel1 = mapAcc.get(idOpportunity).ContatoPessoaAutorizada2__r.Phone;
        this.Contact2_Tel2 = mapAcc.get(idOpportunity).ContatoPessoaAutorizada2__r.Telefone_2__c;
        this.Contact2_Tel3 = mapAcc.get(idOpportunity).ContatoPessoaAutorizada2__r.Telefone_3__c;
        this.Contact2_Tel4 = mapAcc.get(idOpportunity).ContatoPessoaAutorizada2__r.Telefone_4__c;
        
        //Campos para exibir informações de Contato - Casos de Emergência  
        this.SOS_Contact1_NomeCompleto = mapAcc.get(idOpportunity).ContatoEmergencia__r.Name;
        this.SOS_Contact1_RG = mapAcc.get(idOpportunity).ContatoEmergencia__r.RG__c;
        this.SOS_Contact1_CPF = mapAcc.get(idOpportunity).ContatoEmergencia__r.CPF__c;
        this.SOS_Contact1_Tel1 = mapAcc.get(idOpportunity).ContatoEmergencia__r.Phone;
        this.SOS_Contact1_Tel2 = mapAcc.get(idOpportunity).ContatoEmergencia__r.Telefone_2__c;
        this.SOS_Contact1_Tel3 = mapAcc.get(idOpportunity).ContatoEmergencia__r.Telefone_3__c;
        this.SOS_Contact1_Tel4 = mapAcc.get(idOpportunity).ContatoEmergencia__r.Telefone_4__c;
        this.SOS_Contact2_NomeCompleto = mapAcc.get(idOpportunity).ContatoEmergencia2__r.Name;
        this.SOS_Contact2_RG = mapAcc.get(idOpportunity).ContatoEmergencia2__r.RG__c;
        this.SOS_Contact2_CPF = mapAcc.get(idOpportunity).ContatoEmergencia2__r.CPF__c;
        this.SOS_Contact2_Tel1 = mapAcc.get(idOpportunity).ContatoEmergencia2__r.Phone;
        this.SOS_Contact2_Tel2 = mapAcc.get(idOpportunity).ContatoEmergencia2__r.Telefone_2__c;
        this.SOS_Contact2_Tel3 = mapAcc.get(idOpportunity).ContatoEmergencia2__r.Telefone_3__c;
        this.SOS_Contact2_Tel4 = mapAcc.get(idOpportunity).ContatoEmergencia2__r.Telefone_4__c;
        
        this.PessoaContatoCliente_NomeCompleto = mapAcc.get(idOpportunity).Pessoa_contato_cliente__r.Name;
        this.PessoaContatoCliente_Email = mapAcc.get(idOpportunity).Pessoa_contato_cliente__r.Email;
        this.PessoaContatoCliente_Tel1 = mapAcc.get(idOpportunity).Pessoa_contato_cliente__r.Phone;
        this.PessoaContatoCliente_Tel2 = mapAcc.get(idOpportunity).Pessoa_contato_cliente__r.Telefone_2__c;
        this.PessoaContatoCliente_Tel3 = mapAcc.get(idOpportunity).Pessoa_contato_cliente__r.Telefone_3__c;
        // - - - - - Consulta informações do objeto Contato - - - - -
        
        //Consulta campos de Conta SIGGO - informações de Forma de Pagamento
        this.FormaDeCobranca = mapAcc.get(idOpportunity).FormaCobranca__c;
        if(mapAcc.get(idOpportunity).FormaCobranca__c != null){
            if (mapAcc.get(idOpportunity).FormaCobranca__c.contains('Boleto')) {
                // Melhorias Siggo
                if(String.isEmpty(mapAcc.get(idOpportunity).Dia_de_vencimento__c)){
                    this.Boleto_DiaDeVencimento = String.valueOf(mapAcc.get(idOpportunity).Cobranca_DiaVcto__c);
                } else {
                    this.Boleto_DiaDeVencimento = mapAcc.get(idOpportunity).Dia_de_vencimento__c;
                }
            }
            
            if (mapAcc.get(idOpportunity).FormaCobranca__c.contains('Débito')) {
                String s = (String.valueOf(mapAcc.get(idOpportunity).FormaCobranca__c) != null ? String.valueOf(mapAcc.get(idOpportunity).FormaCobranca__c) : '');
                try{
                    String[] banco = s.split(' ', 3);
                    this.Debito_Banco = (banco.size() > 2 ? banco[2] : '');
                }catch(Exception e){}
                
                this.Debito_Agencia = String.valueOf(mapAcc.get(idOpportunity).DebAut_Agencia__c);
                this.Debito_Conta = String.valueOf(mapAcc.get(idOpportunity).DebAut_ContaCorrente__c);
                // Melhorias Siggo
                if(String.isEmpty(mapAcc.get(idOpportunity).Dia_de_vencimento__c)){
                    this.Debito_DiaDeVencimento = String.valueOf(mapAcc.get(idOpportunity).Cobranca_DiaVcto__c);
                }else{
                    this.Debito_DiaDeVencimento = String.valueOf(mapAcc.get(idOpportunity).Dia_de_vencimento__c);
                }
            }
            
            if (mapAcc.get(idOpportunity).FormaCobranca__c.contains('Cartão')) {
                String s = (String.valueOf(mapAcc.get(idOpportunity).FormaCobranca__c) != null ? String.valueOf(mapAcc.get(idOpportunity).FormaCobranca__c) : '');
                try{
                    String[] cartao = s.split(' ', 2);
                    this.Credito_Cartao = (cartao.size() > 1 ? cartao[1] : '');
                }catch(Exception e){}
                
                this.Credito_NomeCartao = mapAcc.get(idOpportunity).Nome_como_no_cartao__c;    
                this.Credito_NumeroCartao = String.valueOf(mapAcc.get(idOpportunity).Cobranca_Cartao_Numero_Cript__c);
                this.Credito_VencimentoCartao = String.valueOf(mapAcc.get(idOpportunity).Cobranca_Cartao_Vcto__c);  
            }
        }
        
        //Consulta informações do objeto Cotação
        Map<Id,Quote> mapQuote = new map<Id,Quote>();
        for(Quote q :[SELECT Id, QuoteNumber, Name, ExpirationDate, /*data de criação */Taxa_de_ades_o__c, Quantidade_de_equipamentos_vendidos__c,
                      Total_taxa_de_ades_o__c, Valor_mensal__c, Valor_unit_rio_mensal__c
                      FROM Quote WHERE OpportunityId = :idOpportunity ORDER BY CreatedDate DESC LIMIT 1]){
                          mapQuote.put(idOpportunity,q);                                               
                      }
        if(mapQuote.containsKey(idOpportunity)){
            this.Quote_Numero = mapQuote.get(idOpportunity).QuoteNumber;
            this.Quote_Proposta = mapQuote.get(idOpportunity).Name;
            this.Quote_Validade = String.valueOf(mapQuote.get(idOpportunity).ExpirationDate);
            this.Quote_DataDeCriacao = '   -   ';
            this.Quote_TaxaDeAdesao = String.valueOf(mapQuote.get(idOpportunity).Taxa_de_ades_o__c);
            this.Quote_QtdeEquipamentosVendidos = String.valueOf(mapQuote.get(idOpportunity).Quantidade_de_equipamentos_vendidos__c);
            this.Quote_TotalTaxaDeAdesao = String.valueOf(mapQuote.get(idOpportunity).Total_taxa_de_ades_o__c);
            this.Quote_ValorMensal = String.valueOf(mapQuote.get(idOpportunity).Valor_mensal__c);
            this.Quote_ValorUntMensal = String.valueOf(mapQuote.get(idOpportunity).Valor_unit_rio_mensal__c);
            
            //Consulta informações do objeto Item de linha da Cotação
            lstQli = [SELECT Id, Product2.Name, Fam_lia_de_produtos__c, Prazo_do_contrato__c, Quantity, 
                      Valor_mensal__c, Valor_unit_rio_mensal__c 
                      FROM QuoteLineItem WHERE QuoteId = :mapQuote.get(idOpportunity).Id ];
        }
        
        //Consulta informações do objeto Veículo
        Map<Id,ItemPropostaSiggo__c> mapVeiculo = new Map<Id,ItemPropostaSiggo__c>();
        for(ItemPropostaSiggo__c i :[SELECT Id, Marca_Veiculo__r.Name, Modelo_do_Veiculo__r.Name, Veiculo_Placa__c,
                                     Veiculo_Chassi__c, Veiculo_AnoModelo__c, Veiculo_Cor__c, 
                                     Veiculo_Renavam__c, Observacoes__c
                                     FROM ItemPropostaSiggo__c WHERE Oportunidade__c = :idOpportunity]){
                                         mapVeiculo.put(idOpportunity, i);
                                     }
        lstIPS = [SELECT Id, Marca_Veiculo__r.Name, Modelo_do_Veiculo__r.Name, Veiculo_Placa__c,
                  Veiculo_Chassi__c, Veiculo_AnoModelo__c, Veiculo_Cor__c,
                  Veiculo_Renavam__c, Observacoes__c
                  FROM ItemPropostaSiggo__c WHERE Oportunidade__c = :idOpportunity];
        
        if(mapVeiculo.containsKey(idOpportunity)){
            this.Veiculo_Marca = mapVeiculo.get(idOpportunity).Marca_Veiculo__r.Name;
            this.Veiculo_Modelo = mapVeiculo.get(idOpportunity).Modelo_do_Veiculo__r.Name;
            this.Veiculo_Placa = mapVeiculo.get(idOpportunity).Veiculo_Placa__c;
            this.Veiculo_Chassi = mapVeiculo.get(idOpportunity).Veiculo_Chassi__c;
            this.Veiculo_Ano = String.valueOf(mapVeiculo.get(idOpportunity).Veiculo_AnoModelo__c);
            this.Veiculo_Cor = mapVeiculo.get(idOpportunity).Veiculo_Cor__c;
            this.Veiculo_Renavam = mapVeiculo.get(idOpportunity).Veiculo_Renavam__c;
            this.Veiculo_Produto = '   -   ';
        }
        
        lstTaxa_Acessorios = [SELECT Id, Name, Descricao__c, Desinstalacao__c, Taxas__c, Tipo__c, Valor_Desinstalacao_e_Reinstalacao__c
                              FROM Taxas_de_Servicos__c WHERE Tipo__c = 'Acessórios' ORDER BY Name];
        lstTaxa_Produtos = [SELECT Id, Name, Descricao__c, Desinstalacao__c, Taxas__c, Tipo__c, Valor_Desinstalacao_e_Reinstalacao__c
                            FROM Taxas_de_Servicos__c WHERE Tipo__c = 'Produto' ORDER BY Name];
        lstTaxa_Servicos = [SELECT Id, Name, Descricao__c, Desinstalacao__c, Taxas__c, Tipo__c, Valor_Desinstalacao_e_Reinstalacao__c
                            FROM Taxas_de_Servicos__c WHERE Tipo__c = 'Tabela de Preços de Serviços' ORDER BY Name];
        
    }
    
    public PageReference previewPDF(){
        PageReference pdf = (tipoTermo == 'Base') ? Page.PDF_Termo_Novo : Page.PDF_Termo_Novo;
        // Add parent id to the parameters for standardcontroller
        pdf.getParameters().put('id',idOpportunity);
        pdf.setRedirect(false);
        return pdf;  
    }
    
    public PageReference savePdf() {
        PageReference pdf = (tipoTermo == 'Base') ? Page.PDF_Termo_Novo : Page.PDF_Termo_Novo;
        
        // Add parent id to the parameters for standardcontroller
        pdf.getParameters().put('id',idOpportunity);
        
        // Create the new attachment
        Attachment attach = new Attachment();
        
        // The contents of the attachment from the pdf
        Blob body;
        try{
            // returns the output of the page as a PDF
            body = pdf.getContent();
            // need to pass unit test -- current bug    
        }catch (VisualforceException e) {
            body = Blob.valueOf('Some Text');
        }
        
        attach.Body = body;
        // add the user entered name
        attach.Name = 'Termo ' + this.tipoTermo + ' ' + Opportunity_Name + '.pdf';
        attach.IsPrivate = false;
        // attach the pdf to the account
        attach.ParentId = idOpportunity;
        insert attach;
        
        Opportunity oppty = [SELECT Id, StageName FROM Opportunity WHERE Id = :idOpportunity];
        oppty.StageName = 'Aguardando documentação';
        update oppty;
        
        return new PageReference('/' + ApexPages.currentPage().getParameters().get('id')) ;
    }
    
    public PageReference saveSendPdf() {
        /*PageReference pdf = null;
if(tipoTermo == 'Base'){
pdf = Page.PDF_Termo_Base;
}else{
pdf = Page.PDF_Termo_Novo;
}

// Add parent id to the parameters for standardcontroller
pdf.getParameters().put('id',idOpportunity);

// Create the new attachment
Attachment attach = new Attachment();

// The contents of the attachment from the pdf
Blob body;
try{
// returns the output of the page as a PDF
body = pdf.getContent();
// need to pass unit test -- current bug    
}catch (VisualforceException e) {
body = Blob.valueOf('Some Text');
}

attach.Body = body;
// add the user entered name
attach.Name = 'Termo ' + this.tipoTermo + ' ' + Opportunity_Name + '.pdf';
attach.IsPrivate = false;
// attach the pdf to the account
attach.ParentId = idOpportunity;
insert attach;*/
        
        //PageReference pageRef = new PageReference('/apex/attachmentSendEmail?id='+idOpportunity);
        PageReference pageRef = Page.attachmentSendEmail;
        pageRef.getParameters().put('id',idOpportunity);
        pageRef.getParameters().put('tipoTermo',tipoTermo);
        pageRef.setRedirect(false);
        // send the user to the account to view results
        return pageRef;
    }
    
    public PageReference cancel() {
        PageReference pageRef = new PageReference('/' + this.idOpportunity);
        pageRef.setRedirect(false);
        return pageRef;
    }
    
}