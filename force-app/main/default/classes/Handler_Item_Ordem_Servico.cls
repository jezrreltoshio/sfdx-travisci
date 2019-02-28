/*
	Classe de teste: Teste_Handler_Item_Ordem_Servico
	Criado por: Mario Reis
	Data de criação: 25/06/2018
	Descrição: Classe responsável por realizar o tratamento da Trigger para o objeto 
				Item da ordem de serviço e direcionar para a funcionalidade correta

*/
public class Handler_Item_Ordem_Servico {

    public static Boolean rodouAtualizacaoInformacoes = false;

    // Método para verificação da Trigger
    public static Boolean verificacao(Boolean isBefore, Boolean isAfter, 
                                      Boolean isInsert, Boolean isUpdate, 
                                      Boolean isDelete, Boolean isUndelete, 
                                  	  List<Item_ordem_servico__c> oldList, Map<Id, Item_ordem_servico__c> oldMap,
                                  	  List<Item_ordem_servico__c> newList, Map<Id, Item_ordem_servico__c> newMap){

		System.debug(LoggingLevel.ERROR, '__ [cls Handler_Item_Ordem_Servico - verificacao()] - Inicio...');
		System.debug(LoggingLevel.ERROR, '__ [cls Handler_Item_Ordem_Servico - verificacao()] - isBefore: '+isBefore);
        System.debug(LoggingLevel.ERROR, '__ [cls Handler_Item_Ordem_Servico - verificacao()] - isAfter: '+isAfter);
        System.debug(LoggingLevel.ERROR, '__ [cls Handler_Item_Ordem_Servico - verificacao()] - isInsert: '+isInsert);
        System.debug(LoggingLevel.ERROR, '__ [cls Handler_Item_Ordem_Servico - verificacao()] - isUpdate: '+isUpdate);
		System.debug(LoggingLevel.ERROR, '__ [cls Handler_Item_Ordem_Servico - verificacao()] - isDelete: '+isDelete);
		System.debug(LoggingLevel.ERROR, '__ [cls Handler_Item_Ordem_Servico - verificacao()] - isUndelete: '+isUndelete);
		System.debug(LoggingLevel.ERROR, '__ [cls Handler_Item_Ordem_Servico - verificacao()] - oldList: '+oldList);
		System.debug(LoggingLevel.ERROR, '__ [cls Handler_Item_Ordem_Servico - verificacao()] - oldMap: '+oldMap);
		System.debug(LoggingLevel.ERROR, '__ [cls Handler_Item_Ordem_Servico - verificacao()] - newList: '+newList);
		System.debug(LoggingLevel.ERROR, '__ [cls Handler_Item_Ordem_Servico - verificacao()] - newMap: '+newMap);

		if(isBefore){

            if(isInsert){

                System.debug(LoggingLevel.ERROR, '__ [cls Handler_Item_Ordem_Servico - verificacao()] - Before insert');
                
                /*if(newList != null && newList.size() > 0){

        	        try {


                    } catch (Exception e) {
						throw e;
                    }

				}*/ // Fim if(newList != null && newList.size() > 0)

            } // Fim if(isInsert)

			if(isUpdate){

                System.debug(LoggingLevel.ERROR, '__ [cls Handler_Item_Ordem_Servico - verificacao()] - Before update');

				/*if(newList != null && newList.size() > 0){

        	        try {

                    } catch (Exception e) {
						throw e;
                    }

				}*/ // Fim if(newList != null && newList.size() > 0)

			} // Fim if(idUpdate)

		} // Fim if(isBefore)

		if(isAfter){

			if(isInsert){

                System.debug(LoggingLevel.ERROR, '__ [cls Handler_Item_Ordem_Servico - verificacao()] - After insert');

                if(newList != null && newList.size() > 0){

        	        try {

                        rodouAtualizacaoInformacoes = true;
                        Set<Id> setIdOS = new Set<Id>();
                        for(Item_ordem_servico__c item : newList){
                            setIdOS.add(item.Ordem_servico__c);
                        }
                        List<WorkOrder> listaWO = DAO_Ordem_Servico.getListaOrdemServico(setIdOS);
						List<WorkOrder> listaWOAtt = Util_Direcionamento_OS.atualizarInformacoesOS(listaWO);
                        update listaWOAtt;

                    } catch (Exception e) {
						throw e;
                    }

				} // Fim if(newList != null && newList.size() > 0)

			} // Fim if(isInsert)

            if(isUpdate){

                System.debug(LoggingLevel.ERROR, '__ [cls Handler_Item_Ordem_Servico - verificacao()] - After update');

                if(newList != null && newList.size() > 0){

        	        try {

                        rodouAtualizacaoInformacoes = true;
                        Set<Id> setIdOS = new Set<Id>();
                        for(Item_ordem_servico__c item : newList){
                            setIdOS.add(item.Ordem_servico__c);
                        }
                        List<WorkOrder> listaWO = DAO_Ordem_Servico.getListaOrdemServico(setIdOS);
						List<WorkOrder> listaWOAtt = Util_Direcionamento_OS.atualizarInformacoesOS(listaWO);
                        update listaWOAtt;

                    } catch (Exception e) {
						throw e;
                    }

				} // Fim if(newList != null && newList.size() > 0)

            } // Fim if(isUpdate)

		} // Fim if(isAfter)

		return true;

    } // Fim método verificacao
}