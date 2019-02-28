/*
    Classe de teste: Util_Servicos_OS
    Criado por: Mario Reis <mario.pereira.ext@sascar.com.br>
    Data de criação: 23/06/2018
    Descrição: Classe Util para informações da OS
    ----------------------------------------------------------------------
*/
public class Util_Servicos_OS {

    public static List<WorkOrder> verificarTipoMacroMicro(List<WorkOrder> listaOS){

        System.debug(LoggingLevel.ERROR, '__ [cls Util_Servicos_OS - verificarTipoMacroMicro()] - Inicio...');
        System.debug(LoggingLevel.ERROR,  '__ [cls Util_Servicos_OS - verificarTipoMacroMicro()] - listaOS: '+listaOS);

        try {

            List<WorkOrder> listaAtualizar = new List<WorkOrder>();

            if(listaOS != null && listaOS.size() > 0){

                for(WorkOrder os : listaOS){

                    System.debug(LoggingLevel.ERROR, '__ [cls Util_Servicos_OS - verificarTipoMacroMicro()] - os.Status_OS__c: '+os.Status_OS__c);
                    System.debug(LoggingLevel.ERROR, '__ [cls Util_Servicos_OS - verificarTipoMacroMicro()] - os.Status_OS__r.Tipo__c: '+os.Status_OS__r.Tipo__c);

                    if(os.Itens_ordem_servico__r.size() == 0){
                        os.Tipo_macro_OS__c = 'Sem motivo cadastrado';
						os.Tipo_micro_OS__c = 'Sem item cadastrado';
                    }

                    Decimal menorPrioridade = 0;

                    for(Item_ordem_servico__c item : os.Itens_ordem_servico__r){
                        
                        System.debug(LoggingLevel.ERROR, '__ [cls Util_Servicos_OS - atualizarInformacoesHistorico()] - os.Id: '+os.Id);
                        System.debug(LoggingLevel.ERROR, '__ [cls Util_Servicos_OS - atualizarInformacoesHistorico()] - item.Tipo_Item_OS__r.Codigo_externo__c: '+item.Tipo_Item_OS__r.Codigo_externo__c);

						if(item.Tipo_Item_OS__r.Codigo_externo__c == '3'){

                            //motivo_macro = 'INSTALAÇÃO';
                            os.Tipo_macro_OS__c = 'Instalação';
                            //motivo_micro = 'INSTALAÇÃO DE EQUIPAMENTO';
                            os.Tipo_micro_OS__c = 'Instalação de Equipamento';
                            break;

						} else if(item.Tipo_Item_OS__r.Codigo_externo__c == '77' || 
                                  item.Tipo_Item_OS__r.Codigo_externo__c == '932'){

							//motivo_macro = 'INSTALAÇÃO';
							os.Tipo_macro_OS__c = 'Instalação';
                            //motivo_micro = 'INSTALAÇÃO - UPGRADE';
                            os.Tipo_micro_OS__c = 'Instalação – Upgrade';
							break;

						} else if(item.Tipo_Item_OS__r.Codigo_externo__c == '1128' || 
                                  item.Tipo_Item_OS__r.Codigo_externo__c == '1287'){

							//motivo_macro = 'INSTALAÇÃO';
							os.Tipo_macro_OS__c = 'Instalação';
                            //motivo_micro = 'INSTALAÇÃO - DOWNGRADE';
                            os.Tipo_micro_OS__c = 'Instalação – Downgrade';
                            break;

                        } else if(item.Tipo_Item_OS__r.Codigo_externo__c == '1229' || 
                                  item.Tipo_Item_OS__r.Codigo_externo__c == '98' || 
                                  item.Tipo_Item_OS__r.Codigo_externo__c == '891' || 
                                  item.Tipo_Item_OS__r.Codigo_externo__c == '892'){

							//motivo_macro = 'Reinstalação';
                            os.Tipo_macro_OS__c = 'Reinstalação';
							//motivo_micro = 'REINSTALAÇÃO - TRC';
                            os.Tipo_micro_OS__c = 'Reinstalação – TRC';
                            break;

                        } else if (item.Tipo_Item_OS__r.Codigo_externo__c == '11' || 
                                   item.Tipo_Item_OS__r.Codigo_externo__c == '870'){

							//motivo_macro = 'RETIRADA';
                            os.Tipo_macro_OS__c = 'Retirada';
							//motivo_micro = 'RETIRADA - TRC';
                            os.Tipo_micro_OS__c = 'Retirada - TRC';
                            break;

                        } else {

                            menorPrioridade = menorPrioridade == 0 || menorPrioridade >  Integer.valueOf(item.Tipo_OS__r.Codigo_externo__c) ? 
                                				Integer.valueOf(item.Tipo_OS__r.Codigo_externo__c) : menorPrioridade;

                            if(menorPrioridade == Integer.valueOf(item.Tipo_OS__r.Codigo_externo__c)){

                                if(menorPrioridade == 1){
                                    os.Tipo_macro_OS__c = 'Instalação';
									os.Tipo_micro_OS__c = 'Instalação';
                                } else if(menorPrioridade == 2){
                                    os.Tipo_macro_OS__c = 'Reinstalação';
									os.Tipo_micro_OS__c = 'Reinstalação';
                                } else if(menorPrioridade == 3){
                                    os.Tipo_macro_OS__c = 'Retirada';
									os.Tipo_micro_OS__c = 'Retirada';
                                } else if(menorPrioridade == 4){
                                    os.Tipo_macro_OS__c = 'Assistência';
									os.Tipo_micro_OS__c = 'Assistência';
                                } else if(menorPrioridade == 9){
                                    os.Tipo_macro_OS__c = 'Reinstalação não cobrar';
									os.Tipo_micro_OS__c = 'Reinstalação não cobrar';
                                }  else {
                                    os.Tipo_macro_OS__c = 'Sem motivo cadastrado';
									os.Tipo_micro_OS__c = 'Sem item cadastrado';
                                }

                            } // Fim if(menorPrioridade == item.Tipo_OS__r.Codigo_externo__c)

                            System.debug(LoggingLevel.ERROR, '__ [cls Util_Servicos_OS - atualizarInformacoesHistorico()] - menorPrioridade: '+menorPrioridade);

                        } // Fim if(item.Tipo_Item_OS__r.Codigo_externo__c == 3)

                    } // Fim for(Item_ordem_servico__c item : os.Itens_ordem_servico__r)

					listaAtualizar.add(os);

                } // Fim for(WorkOrder os : listaOS)
				//listaAtualizar = retornaTipoMacroMicroOSLista(listaAtualizar);
            } // Fim if(listaOS != null && listaOS.size() > 0)

            return listaAtualizar;

        } catch (Exception e){
            System.debug(LoggingLevel.ERROR, '__ [cls Util_Servicos_OS - atualizarInformacoesOS()] - ERRO: '+e.getMessage());
            return new List<WorkOrder>();
        } // Fim try/catch

    } // Fim verificarTipoMacroMicro

}