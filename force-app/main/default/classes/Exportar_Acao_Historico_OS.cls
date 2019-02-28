/*
    Classe de teste: Teste_Exportar_Acao_Historico_OS
    Criado por: Mario Reis
    Data de criação: 20/06/2018
    Descrição: Classe para exportação da Ação do historico da OS
*/
global class Exportar_Acao_Historico_OS {

    public List<Acao> acoesHistoricoOS {get;set;}

    public Exportar_Acao_Historico_OS() {

        try {

            acoesHistoricoOS = new List<Acao>();
    
            for(Acao_historico_OS__c acaoH : [SELECT Id, Name, Categoria_contato__c,
                                                    Data_cadastro__c,LastModifiedDate, 
                                                    LastModifiedBy.Name, Ativo__c, CreatedDate
                                                 FROM Acao_historico_OS__c ORDER BY Ativo__c DESC]){
                Acao acao = new Acao();
                acao.Nome = acaoH.Name;
                acao.Categoria = acaoH.Categoria_contato__c;
                acao.alteradoPor = acaoH.LastModifiedBy.Name;
                acao.ativo = acaoH.Ativo__c == false ? 'Não' : 'Sim';
                acao.dataCadastro = acaoH.Data_cadastro__c.format('dd/MM/yyy HH:mm:ss');
                acao.dataAlteracao = acaoH.LastModifiedDate.format('dd/MM/yyy HH:mm:ss');
                acoesHistoricoOS.add(acao);
    
            }

		} catch (Exception e){
            System.debug(LoggingLevel.ERROR, '__ [cls Exportar_Acao_Historico_OS - Exportar_Acao_Historico_OS()] - ERRO: '+e.getMessage());
        } // Fim try/catch

    }


    global class Acao {
        public String Nome {get; set;}
        public String Categoria {get; set;}
        public String dataCadastro {get; set;}
        public String alteradoPor {get; set;}
        public String dataAlteracao {get; set;}
        public String ativo {get; set;}
    }

}