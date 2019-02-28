/*
    Classe de teste: Teste_Util_Historico_OS
    Criado por: Mario Reis <mario.pereira.ext@sascar.com.br>
    Data de criação: 23/06/2018
    Descrição: Classe Util para informações da OS
    ----------------------------------------------------------------------
*/
public class Util_Historico_OS {

    // Método para atualizar as informações da OS
    public static List<WorkOrder> atualizarInformacoesHistorico(List<WorkOrder> listaOS){

        System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarInformacoesHistorico()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarInformacoesHistorico()] - listaOS: '+listaOS);

        try {

            List<WorkOrder> listaAtualizar = new List<WorkOrder>();

            if(listaOS != null && listaOS.size() > 0){

                for(WorkOrder os : listaOS){

                    System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarInformacoesHistorico()] - os.Status_OS__c: '+os.Status_OS__c);
                    System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarInformacoesHistorico()] - os.Status_OS__r.Tipo__c: '+os.Status_OS__r.Tipo__c);

                    if(os.Status_OS__c != null && os.Status_OS__r.Tipo__c == 'Finalizado'){
                        for(Historico_OS__c h : os.Historicos_OS__r){

                            System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarInformacoesHistorico()] - os.Id: '+os.Id);

                            if(h.Status__c != null && h.Data__c != null){
                                
                                System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarInformacoesHistorico()] - h.Status__r.Name: '+h.Status__r.Name);
								System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarInformacoesHistorico()] - h.Data__c: '+h.Data__c);
                                System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarInformacoesHistorico()] - os.Status_OS__r.Name: '+os.Status_OS__r.Name);

                                if(h.Status__r.Name.contains(os.Status_OS__r.Name)){
                                    os.Data_atualizacao_status_OS__c = date.newInstance(h.Data__c.year(), h.Data__c.month(),h.Data__c.day());
                                    System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarInformacoesHistorico()] - os.Data_atualizacao_status_OS__c: '+os.Data_atualizacao_status_OS__c);
                                    break;
                                }
                            } else if(h.Data__c != null){
                                if(h.Observacao__c.contains('Ordem de serviço cancelada') || 
                                   h.Observacao__c.contains('O.S. Aguardando Conclusão Técnico')){
                                    os.Data_atualizacao_status_OS__c = date.newInstance(h.Data__c.year(), h.Data__c.month(),h.Data__c.day());
                                    System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarInformacoesHistorico()] - os.Data_atualizacao_status_OS__c: '+os.Data_atualizacao_status_OS__c);
                                    break;
                                }
                            }
                        } // Fim for(Historico_OS__c h : os.Historicos_OS__r)
                    } // Fim if(os.Status_OS__c != null && os.Status_OS__r.Tipo__c == 'Finalizado')

					listaAtualizar.add(os);
                    
                } // Fim for(WorkOrder os : listaOS)

            } // Fim if(listaOS != null && listaOS.size() > 0)

            return listaAtualizar;

        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '__ [cls Util_Tipo_OS - atualizarInformacoesOS()] - ERRO: '+e.getMessage());
            return new List<WorkOrder>();
        } // Fim try/catch

    } // Fim atualizarInformacoesOS


    // Método para atualizar as informações da OS
    public static List<WorkOrder> atualizarQuantidadeContatos(List<WorkOrder> listaOS, Map<Id, Parametrizacao_faixa_aging__c> mapFaixaAging ){

        System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - Inicio...');
        System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - listaOS: '+listaOS);

        try {

            List<WorkOrder> listaAtualizar = new List<WorkOrder>();

            if(listaOS != null && listaOS.size() > 0){

				Set<Date> setFeriado = new Set<Date>();
                for(Holiday h : [SELECT Name, ActivityDate FROM Holiday]){
					setFeriado.add(h.ActivityDate);
                }

                System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - setFeriado: '+setFeriado);

                for(WorkOrder os : listaOS){

                    System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - os.Faixa_aging__c: '+os.Faixa_aging__c);
                    System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - os.Agendado_para__c: '+os.Agendado_para__c);

    				if(os.Faixa_aging__c != null) {

                        Parametrizacao_faixa_aging__c faixaAging = mapFaixaAging.get(os.Faixa_aging__c);
                        List<Historico_OS__c> listaHistorico = new List<Historico_OS__c>();

						System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - os.Faixa_aging__c: '+os.Faixa_aging__c);
						System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - faixaAging.Contatos_faixa__c: '+faixaAging.Contatos_faixa__c);
						System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - faixaAging.Contatos_dias_distintos__c: '+faixaAging.Contatos_dias_distintos__c);
						System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - os.StartDate: '+os.StartDate);
						System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - faixaAging.Aging_de__c: '+faixaAging.Aging_de__c);
                        System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - faixaAging.Aging_ate__c: '+faixaAging.Aging_ate__c);

                        Boolean contatoTodoDia = faixaAging.Contatos_faixa__c;
                        Boolean contatoDiasDistintos = faixaAging.Contatos_dias_distintos__c;
                        Datetime dtmInicio = faixaAging.Aging_de__c != null ? 
                            					os.StartDate.addDays(Integer.valueOf(faixaAging.Aging_de__c)) :
                            					os.StartDate;
                        System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - dtmInicio: '+dtmInicio);
                        Date dataInicioVerificacao = date.newInstance(dtmInicio.year(), dtmInicio.month(), dtmInicio.day());
                        Date dataFinalVerificacao = date.newInstance(os.StartDate.year(), os.StartDate.month(), os.StartDate.day())
                            							.addDays(Integer.valueOf(os.Aging__c));
                        Decimal quantidadeDeContatosFaixa = faixaAging.Quantidade_contatos__c;
                        Integer qtddDiasFaixa = 0;
                        if(quantidadeDeContatosFaixa != null && quantidadeDeContatosFaixa > 0){
                            qtddDiasFaixa = dataInicioVerificacao.daysBetween(dataFinalVerificacao);
                        }

                        Integer qtddDiasTotalFaixa = 0;
                        if(faixaAging.Aging_ate__c != null){
                            qtddDiasTotalFaixa = Integer.valueOf(faixaAging.Aging_ate__c);
                        } else {
                            qtddDiasTotalFaixa = dataInicioVerificacao.daysBetween(dataFinalVerificacao);
                        }

                        Integer qtddContatos = 0;
                        Integer qtddContatosTotal = 0;

                        System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - qtddDiasFaixa: '+qtddDiasFaixa);
                        
                        System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - contatoTodoDia: '+contatoTodoDia);
                        System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - contatoDiasDistintos: '+contatoDiasDistintos);
                        System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - dataInicioVerificacao: '+dataInicioVerificacao);
                        System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - quantidadeDeContatosFaixa: '+quantidadeDeContatosFaixa);
                        System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - qtddDiasTotalFaixa: '+qtddDiasTotalFaixa);


                        Set<String> setDateDiasDistintos = new Set<String>();
                        
                        System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - Vai fazer for do historico ');
                        for(Historico_OS__c ho : os.Historicos_OS__r){
                            
                            System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - ho: '+ho);
                            System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - ho.Categoria_contato__c: '+ho.Categoria_contato__c);
                            
                            if(ho.Categoria_contato__c != null && 
                               ho.Categoria_contato__c == 'Efetivo' || ho.Categoria_contato__c == 'Não efetivo'){
                                   
                                   Date dataHistorico = date.newInstance(ho.Data__c.year(), ho.Data__c.month(), ho.Data__c.day());
                                   String dia = dataHistorico.day() < 10 ? '0'+dataHistorico.day() : String.valueOf(dataHistorico.day());
                                   String mes = dataHistorico.month() < 10 ? '0'+dataHistorico.month() : String.valueOf(dataHistorico.month());
                                   String diaMesHistorico = dia+'-'+mes;
                                   String diaStringHistorico = dia+'-'+mes+'-'+String.valueOf(dataHistorico.year());
                                   System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - dataInicioVerificacao: '+dataInicioVerificacao);
                                   System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - dataHistorico: '+dataHistorico);
                                   System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - diaMesHistorico: '+diaMesHistorico);
                                   System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - setFeriado.contains(dataHistorico): '+setFeriado.contains(dataHistorico));
                                   
                                   if(dataHistorico >= dataInicioVerificacao){
                                       
                                       Datetime dt = (DateTime)dataHistorico;
                                       String dayOfWeek = dt.addDays(1).format('EEEE');
                                       System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - dayOfWeek: '+dayOfWeek);
                                       
                                       qtddContatosTotal += 1;
                                       
                                       if(diaMesHistorico != '01-01' && diaMesHistorico != '21-04' &&
                                          diaMesHistorico != '01-05' && diaMesHistorico != '07-09' &&
                                          diaMesHistorico != '12-10' && diaMesHistorico != '02-11' &&
                                          diaMesHistorico != '15-11' && diaMesHistorico != '25-11' &&
                                          dayOfWeek != 'Sunday' && !setFeriado.contains(dataHistorico)){
                                              if(!setDateDiasDistintos.contains(diaStringHistorico)){
                                                  setDateDiasDistintos.add(diaStringHistorico);
                                                  qtddContatos += 1;
                                              }
                                          }
                                   } // Fim if(data-Historico >= dataInicioVerificacao)

                                   System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - setDateDiasDistintos: '+setDateDiasDistintos);

                               }
                            
                        } // for(Historico_OS__c ho : os.Historicos_OS__r)
                        
                        System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - qtddContatos: '+qtddContatos);
                        

                        Date dataVerificacaoDiasUteis = dataInicioVerificacao;
                        Integer qtdDiasUteis = 0;

                        Set<String> setDateDias = new Set<String>();

                        for(Integer i = 0; i < qtddDiasFaixa && dataVerificacaoDiasUteis <= System.today();){
							
                            String dia = dataVerificacaoDiasUteis.day() < 10 ? '0'+dataVerificacaoDiasUteis.day() : String.valueOf(dataVerificacaoDiasUteis.day());
                            String mes = dataVerificacaoDiasUteis.month() < 10 ? '0'+dataVerificacaoDiasUteis.month() : String.valueOf(dataVerificacaoDiasUteis.month());
                            String diaMesVerificacao = dia+'-'+mes;
                            String diaStringHistorico = dia+'-'+mes+'-'+String.valueOf(dataVerificacaoDiasUteis.year());
                            System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - dataInicioVerificacao: '+dataInicioVerificacao);
                            System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - dataVerificacaoDiasUteis: '+dataVerificacaoDiasUteis);
                            System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - diaMesVerificacao: '+diaMesVerificacao);
                            System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - setFeriado.contains(dataVerificacaoDiasUteis): '+setFeriado.contains(dataVerificacaoDiasUteis));

                            Datetime dt = (DateTime)dataVerificacaoDiasUteis;
                            String dayOfWeek = dt.addDays(1).format('EEEE');
                            System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - dayOfWeek: '+dayOfWeek);

                            if(diaMesVerificacao != '01-01' && diaMesVerificacao != '21-04' &&
                               diaMesVerificacao != '01-05' && diaMesVerificacao != '07-09' &&
                               diaMesVerificacao != '12-10' && diaMesVerificacao != '02-11' &&
                               diaMesVerificacao != '15-11' && diaMesVerificacao != '25-11' &&
                               dayOfWeek != 'Sunday' &&  !setDateDias.contains(diaStringHistorico) &&
                               !setFeriado.contains(dataVerificacaoDiasUteis)){
                                   
                                   setDateDias.add(diaStringHistorico);
                                   qtdDiasUteis += 1;

                                   i++;
                               }

                            dataVerificacaoDiasUteis = dataVerificacaoDiasUteis.addDays(1);
                        }

						System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - contatoTodoDia: '+contatoTodoDia);
                        System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - contatoDiasDistintos: '+contatoDiasDistintos);
                        System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - qtddContatos: '+qtddContatos);
                        System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - qtddContatosTotal: '+qtddContatosTotal);
                        System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - qtdDiasUteis: '+qtdDiasUteis);

                        System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - (qtddDiasTotalFaixa - os.Aging__c): '+(qtddDiasTotalFaixa - os.Aging__c));
                        System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - (quantidadeDeContatosFaixa - qtddContatos): '+(quantidadeDeContatosFaixa - qtddContatos));

                        if(qtddContatosTotal != null) { os.Quantidade_contato__c = qtddContatosTotal; }
                        if(qtddContatos != null) { os.Quantidade_contatos_faixa__c = qtddContatos; }

                        if((os.Agendado_para__c == null || os.Agendado_para__c < System.now())){

                            if(contatoTodoDia == true && (qtddContatos < qtdDiasUteis || 
                                                         	(qtddContatos == 0 && qtdDiasUteis == 0)
                                                         )
                              ){

                                os.Contato_fora_faixa__c = true;

                            } else if( (contatoDiasDistintos == true) && 
                                        faixaAging.Aging_ate__c == null &&
                                        qtddContatos < quantidadeDeContatosFaixa
                                     ){
                                os.Contato_fora_faixa__c = true;
                            } else if( (contatoDiasDistintos == true) && 
                                       ((qtddDiasTotalFaixa - os.Aging__c) < (quantidadeDeContatosFaixa - qtddContatos))
                                     ){
                                os.Contato_fora_faixa__c = true;
                            } else {
                                os.Contato_fora_faixa__c = false;
                            }

                        } else {
                            os.Contato_fora_faixa__c = false;
                        }
                        
                        System.debug(LoggingLevel.ERROR, '__ [cls Util_Historico_OS - atualizarQuantidadeContatos()] - os.Contato_fora_faixa__c: '+os.Contato_fora_faixa__c);

                    } // Fim if(os.Faixa_aging__c != null)

					listaAtualizar.add(os);

                } // Fim for(WorkOrder os : listaOS)

            } // Fim if(listaOS != null && listaOS.size() > 0)

            return listaAtualizar;

        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '__ [cls Util_Tipo_OS - atualizarQuantidadeContatos()] - ERRO: '+e.getMessage());
            return new List<WorkOrder>();
        } // Fim try/catch

    } // Fim atualizarQuantidadeContatos

}