/*
    Classe de testes: Teste_Util_Direcionamento_OS
    Criado por: Mario Reis
    Data de criação: 28/05/2018
    Descrição: Classe Util para direcionamento automatico de OS
    ----------------------------------------------------------------------
    ---------------------------------
    @author Renan Rocha
    @date 09/01/2019
    @description:
        - Classe refatorada
        - Novos debugs inseridos
        - Alterado classe de busca no método direcionarOS da classe DAO_Direcionamento_OS para a classe DAO_Ordem_Servico
    @JIRA KCA-59
*/
public class Util_Direcionamento_OS {

    private static String CLASS_NAME = 'Util_Direcionamento_OS';

    // Método para fazer o direcionamento das OSs para os atendentes
    public static Boolean direcionarOS(Direcionamento_os__c direcionamentoOS){
        String METHOD_NAME = 'direcionarOS';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - direcionamentoOS: '+ direcionamentoOS);

        Set<Id> setIdUsuario = new Set<Id>();
        List<WorkOrder> listaOS = new List<WorkOrder>();
        List<String> listaClientes = new List<String>();
        Set<Id> setIdOS = new Set<Id>();
        Map<String, String> mapClienteAtd = new Map<String, String>();
        List<WorkOrder> listaAtualizar = new List<WorkOrder>();
        List<String> listaUsuarioConsulta = new List<String>();
        List<String> listaUsuario = new List<String>();
        Set<Id> OSRemovidaRegra = new Set<Id>();

        try {
            if(direcionamentoOS != null){
                direcionamentoOS = DAO_Direcionamento_OS.getDirecionamentoOsById(direcionamentoOS.Id);
                System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - direcionamentoOS: '+ direcionamentoOS);

                for(Atendente_Direcionamento_OS__c atd : direcionamentoOS.Atendentes_Direcionamento_OS__r) setIdUsuario.add(atd.Usuario__c);
                System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - setIdUsuario: '+ setIdUsuario);

                if(setIdUsuario != null && setIdUsuario.size() > 0){

                    if(direcionamentoOS.Quantidade_OS__c != null && direcionamentoOS.Quantidade_OS__c > 0){
                        listaClientes = DAO_Ordem_Servico.filtrarConsultaPorQuantidadeOS(direcionamentoOS);
                        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaClientes: '+ listaClientes);
                        
                        if(listaClientes.size() > 0) listaOS = DAO_Ordem_Servico.getListaOS(direcionamentoOS, listaClientes);
                    } else {
                        listaOS = DAO_Ordem_Servico.getListaOS(direcionamentoOS, listaClientes);
                    } // Fim if(direcionamentoOS.Quantidade_OS__c != null && direcionamentoOS.Quantidade_OS__c > 0)
                    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaOS: '+ listaOS);

                    for(WorkOrder wo : listaOS) setIdOS.add(wo.Id);
                    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - setIdOS: '+ setIdOS);

                    mapClienteAtd = DAO_Ordem_Servico.getMapClienteAtd(setIdusuario);
                    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - mapClienteAtd: '+ mapClienteAtd);

                    // listaUsuarioConsulta = DAO_Direcionamento_OS.getAtdQtd(setIdUsuario);
                    listaUsuarioConsulta = DAO_Ordem_Servico.getAtdQtd(setIdUsuario);
                    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaUsuarioConsulta: '+ listaUsuarioConsulta);

                    if(listaUsuarioConsulta.size() == setIdUsuario.size()) listaUsuario = listaUsuarioConsulta;
                    else {
                        for(String idUsuario : setIdUsuario){
                            Boolean possuiAtd = false;
                            
                            for(String idListaUsuario : listaUsuarioConsulta){
                                if(idUsuario == idListaUsuario) possuiAtd = true;
                            }
                            
                            if(possuiAtd == false) listaUsuario.add(idUsuario);
                        }

                        for(String idUsuario : setIdUsuario){
                            for(String idListaUsuario : listaUsuarioConsulta){
                                if(idUsuario == idListaUsuario) listaUsuario.add(idListaUsuario);
                            }
                        }
                    } // Fim if(listaUsuarioConsulta.size() == setIdUsuario.size())
                    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaUsuario: '+ listaUsuario);

                    Integer linha = 0;

                    for(WorkOrder wo : listaOS){

                        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - wo.Regra_direcionamento_OS__c: '+ wo.Regra_direcionamento_OS__c);
                        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - wo.Regra_direcionamento_OS__r.CreatedDate: '+ wo.Regra_direcionamento_OS__r.CreatedDate);
                        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - direcionamentoOS.CreatedDate: '+ direcionamentoOS.CreatedDate);

                        OSRemovidaRegra.add(wo.Id);
                        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - OSRemovidaRegra: '+ OSRemovidaRegra);

                        if(wo.Regra_direcionamento_OS__c == null 
                            || direcionamentoOS.Quantidade_OS__c > 0 
                            || (direcionamentoOS.CreatedDate < wo.Regra_direcionamento_OS__r.CreatedDate 
                                && direcionamentoOS.Quantidade_OS__c == 0)
                        ){
                            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - mapClienteAtd: '+ mapClienteAtd);
                            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - linha: '+ linha);

                            if(mapClienteAtd.get(wo.Cliente__c) != null){
                                if(wo.OwnerId != mapClienteAtd.get(wo.Cliente__c)){
                                    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - mapClienteAtd.get(wo.Cliente__c): '+ mapClienteAtd.get(wo.Cliente__c));
                                    
                                    wo.OwnerId = mapClienteAtd.get(wo.Cliente__c);
                                    wo.Data_direcionamento__c = date.today().addDays(1);
                                    wo.Regra_direcionamento_OS__c = direcionamentoOS.Id;
                                    listaAtualizar.add(wo);
                                }
                            } else {
                                if(!setIdUsuario.contains(wo.OwnerId)){
                                    mapClienteAtd.put(wo.Cliente__c, listaUsuario.get(linha));
                                    wo.OwnerId = mapClienteAtd.get(wo.Cliente__c);
                                    
                                    linha ++;
                                    if(linha == listaUsuario.size()) linha = 0;
                                    
                                    wo.Data_direcionamento__c = date.today().addDays(1);
                                    wo.Regra_direcionamento_OS__c = direcionamentoOS.Id;
                                    listaAtualizar.add(wo);
                                }
                            }
                        } // Fim if(diferencaMinutos < 30)

                    } // Fim for(WorkOrder wo : listaOS)

                    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaAtualizar: '+ listaAtualizar);

                    if(listaAtualizar != null && listaAtualizar.size() > 0) update listaAtualizar;
                    
                    Boolean removeu = removerOSRegra(OSRemovidaRegra, direcionamentoOS.Id);
                    System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - removeu: '+ removeu);
                } // Fim if(setIdUsuario != null && setIdUsuario.size() > 0)
            } // Fim if(direcionamento != null)

            return true;
        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());
            
            return false;
        } // Fim try/catch
    } // Fim direcionarOS

    // Método para remover OSs que sairam da regra
    public static Boolean removerOSRegra(Set<Id> setIdOS, String idRegra){
        String METHOD_NAME = 'removerOSRegra';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - setIdOS: '+ setIdOS);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - idRegra: '+ idRegra);

        try {

            if(setIdOS != null && setIdOS.size() > 0){

                // Carrega todas as OSs que não estão na regra do direcionamento
                List<WorkOrder> listaConsulta = [SELECT Id FROM WorkOrder WHERE Id NOT IN:setIdOS AND Regra_direcionamento_OS__c =: idRegra LIMIT 10000];
                System.debug(LoggingLevel.ERROR, '__ [cls Util_Direcionamento_OS - removerOSRegra()] - listaConsulta: '+listaConsulta);

                List<WorkOrder> listaRemover = new List<WorkOrder>();

                // Faz o laço removendo as regras, data do direcionamento e alterando o proprietario para a fila
                if(listaConsulta != null && listaConsulta.size() > 0){
                    for(WorkOrder wo : listaConsulta){
                        wo.Regra_direcionamento_OS__c = null;
                        wo.Data_direcionamento__c = null;
                        wo.OwnerId = Parametros_ORG__c.getOrgDefaults().ID_fila_ordem_servico__c;
                        listaRemover.add(wo);
                    }
                }

                if(listaRemover != null && listaRemover.size() > 0){
                    update listaRemover;
                }

            } // Fim if(direcionamento != null)
            else {
                
                // Carrega todas as OSs que não estão na regra do direcionamento
                List<WorkOrder> listaConsulta = [SELECT Id FROM WorkOrder WHERE Regra_direcionamento_OS__c =: idRegra LIMIT 10000];
                System.debug(LoggingLevel.ERROR, '__ [cls Util_Direcionamento_OS - removerOSRegra()] - listaConsulta: '+listaConsulta);

                List<WorkOrder> listaRemover = new List<WorkOrder>();

                // Faz o laço removendo as regras, data do direcionamento e alterando o proprietario para a fila
                if(listaConsulta != null && listaConsulta.size() > 0){
                    for(WorkOrder wo : listaConsulta){
                        wo.Regra_direcionamento_OS__c = null;
                        wo.Data_direcionamento__c = null;
                        wo.OwnerId = Parametros_ORG__c.getOrgDefaults().ID_fila_ordem_servico__c;
                        listaRemover.add(wo);
                    }
                }

                if(listaRemover != null && listaRemover.size() > 0){
                    update listaRemover;
                }

            }

            return true;

        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '__ [cls Util_Direcionamento_OS - removerOSRegra()] - ERRO: '+e.getMessage());
            return false;
        } // Fim try/catch

    } // Fim removerOSRegra


	// Método para atualizar as informações da OS
    public static List<WorkOrder> atualizarInformacoesOS(List<WorkOrder> listaOS){
        String METHOD_NAME = 'atualizarInformacoesOS';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaOS: '+ listaOS);

        try {
            //Refatorado para chamada ser realizada de Classe: Util_Tipo_OS by Diego Medeiros
            List<WorkOrder> listaAtualizar = Util_OS_Atualizar_Informacoes.atualizarInformacoesOS(listaOS);
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaAtualizar: '+ listaAtualizar);            

            return listaAtualizar;
        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - #ERROR: '+ e.getLineNumber() +':'+ e.getMessage());
            
            return new List<WorkOrder>();
        } // Fim try/catch
    } // Fim atualizarInformacoesOS
}