/*
    Classe de teste: Teste_Util_OS_Atualizar_Informacoes
    Criado por: Mario Reis <mario.pereira.ext@sascar.com.br>
    Data de criação: 23/06/2018
    Descrição: Classe Util para centralizações de atualização de informações da OS
    ---------------------------------
    @author Renan Rocha
    @date 03/12/2018
    @description Classe refatorada e novos debugs inseridos
    @JIRA KCA-86
*/
public class Util_OS_Atualizar_Informacoes {
    private static String CLASS_NAME = 'Util_OS_Atualizar_Informacoes';

    // Método para atualizar as informações da OS
    public static List<WorkOrder> atualizarInformacoesOS(List<WorkOrder> listaOS){
        String METHOD_NAME = 'atualizarInformacoesOS';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaOS: '+ listaOS);
        
        try {

            List<Parametrizacao_faixa_aging__c> listaFaixaAging = new List<Parametrizacao_faixa_aging__c>();
            Map<Id, Parametrizacao_faixa_aging__c> mapFaixaAging = new Map<Id, Parametrizacao_faixa_aging__c>();
            
            List<Parametrizacao_faixa_aging__c> listaFaixaAgingDAO = DAO_Parametrizacao_Faixa_Aging.getListParametrizacaoFaixaAging();
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaFaixaAgingDAO: '+ listaFaixaAgingDAO);
            
            for(Parametrizacao_faixa_aging__c pfa : listaFaixaAgingDAO){                                    
				listaFaixaAging.add(pfa);
				mapFaixaAging.put(pfa.Id, pfa);
            }            

            List<WorkOrder> listaAtualizar = new List<WorkOrder>();

            if(listaOS != null && listaOS.size() > 0){

                List<WorkOrder> listaAttHistorico = Util_Historico_OS.atualizarInformacoesHistorico(listaOS);
                System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaAttHistorico: '+ listaAttHistorico);

                List<WorkOrder> listaAttAging = new List<WorkOrder>();

                for(WorkOrder os : listaAttHistorico){

                    WorkOrder OSDAOAux = DAO_Ordem_Servico.getOrdemById(os.Id);
                    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - OSDAOAux: '+ OSDAOAux);

                    if(os.Status_OS__c != null){
                        if(OSDAOAux.Status_OS__r.Tipo__c == 'Pendente'){
                        // if(os.Status_OS__r.Tipo__c == 'Pendente'){
                            DateTime hojeDateTime = System.now();
                            Date hoje = date.newinstance(hojeDateTime.year(), hojeDateTime.month(), hojeDateTime.day());
                            Date dataInicial = date.newinstance(OS.StartDate.year(), OS.StartDate.month(), OS.StartDate.day());
                            os.Aging__c = dataInicial.daysBetween(hoje);
                            
                            if( (os.Agendado_para__c == null || os.Agendado_para__c < hoje) && os.Aging__c >= 85) os.OS_sem_agendamento_aging_85_dias__c = true;
                            else os.OS_sem_agendamento_aging_85_dias__c = false;

                        } else if(OSDAOAux.Status_OS__r.Tipo__c == 'Finalizado' && os.Data_atualizacao_status_OS__c != null){
                            Date dataStatusFinalizado = os.Data_atualizacao_status_OS__c;
                            Date dataInicial = date.newinstance(OS.StartDate.year(), OS.StartDate.month(), OS.StartDate.day());
                            os.Aging__c = dataInicial.daysBetween(dataStatusFinalizado);
                            os.OS_sem_agendamento_aging_85_dias__c = false;
                        } // if(os.Status__r.Tipo__c == 'Pendente')
                    } // Fim if(os.Status__c != null)

                    listaAttAging.add(os);

                } // Fim for(WorkOrder os : listaOS)

                System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaAttAging: '+ listaAttAging);

                List<WorkOrder> listaTipoMacroMicro = Util_Servicos_OS.verificarTipoMacroMicro(listaAttAging);
                System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaTipoMacroMicro: '+ listaTipoMacroMicro);

                List<WorkOrder> listaParametrizacaoFaixaAging = new List<WorkOrder>();

                for(WorkOrder os : listaTipoMacroMicro){

                    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - os: '+ os);

                    if(os.Tipo_macro_OS__c != null && os.Tipo_micro_OS__c != null){

	                    for(Parametrizacao_faixa_aging__c p : listaFaixaAging){
                            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - p: '+ p);

                            if(p.Tipo_Macro_OS__c != null && p.Tipo_Micro_OS__c != null){
                                if(os.Tipo_macro_OS__c == p.Tipo_Macro_OS__c && p.Tipo_Micro_OS__c == os.Tipo_micro_OS__c) {
                                    if(p.Aging_de__c != null && p.Aging_ate__c == null && os.Aging__c >= p.Aging_de__c) os.Faixa_aging__c = p.Id;            
                                    else if(p.Aging_de__c == null && p.Aging_ate__c != null && os.Aging__c <= p.Aging_de__c) os.Faixa_aging__c = p.Id;            
                                    else if(os.Aging__c >= p.Aging_de__c && os.Aging__c <= p.Aging_ate__c) os.Faixa_aging__c = p.Id;            
                                }
                            } // Fim if(p.Tipo_Macro_OS__c != null && p.Tipo_Micro_OS__c != null)
                        } // Fim for(Parametrizacao_faixa_aging__c p : listaFaixaAging)
					} // Fim if(os.Tipo_macro_OS__c != null && os.Tipo_micro_OS__c != null)
                    
                    listaParametrizacaoFaixaAging.add(os);
                } // Fim for(WorkOrder os : listaTipoMacroMicro)

                System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaParametrizacaoFaixaAging: '+ listaParametrizacaoFaixaAging);

                listaAtualizar = Util_Historico_OS.atualizarQuantidadeContatos(listaParametrizacaoFaixaAging, mapFaixaAging);
                System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaAtualizar: '+ listaAtualizar);
            } // Fim if(listaOS != null && listaOS.size() > 0)
            
            return listaAtualizar;

        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());

            return new List<WorkOrder>();
        } // Fim try/catch
    } // Fim atualizarInformacoesOS
}