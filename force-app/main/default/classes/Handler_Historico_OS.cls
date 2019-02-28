/*
	Classe de teste: Teste_Handler_Historico_OS
	Criado por: Mario Reis
	Data de criação: 25/06/2018
	Descrição: Classe responsável por realizar o tratamento da Trigger para o objeto Historico da OS e
				direcionar para a funcionalidade correta

*/
public class Handler_Historico_OS {

 	public static Boolean rodouAtualizacaoInformacoes = false;

    // Método para verificação da Trigger
    public static Boolean verificacao(Boolean isBefore, Boolean isAfter, 
                                      Boolean isInsert, Boolean isUpdate, 
                                      Boolean isDelete, Boolean isUndelete, 
                                  	  List<Historico_OS__c> oldList, Map<Id, Historico_OS__c> oldMap,
                                  	  List<Historico_OS__c> newList, Map<Id, Historico_OS__c> newMap){

		System.debug(LoggingLevel.ERROR, '__ [cls Handler_Historico_OS - verificacao()] - Inicio...');
		System.debug(LoggingLevel.ERROR, '__ [cls Handler_Historico_OS - verificacao()] - isBefore: '+isBefore);
        System.debug(LoggingLevel.ERROR, '__ [cls Handler_Historico_OS - verificacao()] - isAfter: '+isAfter);
        System.debug(LoggingLevel.ERROR, '__ [cls Handler_Historico_OS - verificacao()] - isInsert: '+isInsert);
        System.debug(LoggingLevel.ERROR, '__ [cls Handler_Historico_OS - verificacao()] - isUpdate: '+isUpdate);
		System.debug(LoggingLevel.ERROR, '__ [cls Handler_Historico_OS - verificacao()] - isDelete: '+isDelete);
		System.debug(LoggingLevel.ERROR, '__ [cls Handler_Historico_OS - verificacao()] - isUndelete: '+isUndelete);
		System.debug(LoggingLevel.ERROR, '__ [cls Handler_Historico_OS - verificacao()] - oldList: '+oldList);
		System.debug(LoggingLevel.ERROR, '__ [cls Handler_Historico_OS - verificacao()] - oldMap: '+oldMap);
		System.debug(LoggingLevel.ERROR, '__ [cls Handler_Historico_OS - verificacao()] - newList: '+newList);
		System.debug(LoggingLevel.ERROR, '__ [cls Handler_Historico_OS - verificacao()] - newMap: '+newMap);

		if(isBefore){

            if(isInsert){

                System.debug(LoggingLevel.ERROR, '__ [cls Handler_Historico_OS - verificacao()] - Before insert');
                
                if(newList != null && newList.size() > 0){

        	        try {

                    } catch (Exception e) {
						throw e;
                    }

				} // Fim if(newList != null && newList.size() > 0)

            } // Fim if(isInsert)

			if(isUpdate){

                System.debug(LoggingLevel.ERROR, '__ [cls Handler_Historico_OS - verificacao()] - Before update');

				if(newList != null && newList.size() > 0){

        	        try {

						rodouAtualizacaoInformacoes = true;
                        Set<Id> setIdOS = new Set<Id>();
                        for(Historico_OS__c h : newList){
                            setIdOS.add(h.Ordem_servico__c);
                        }
                        List<WorkOrder> listaWO = DAO_Ordem_Servico.getListaOrdemServico(setIdOS);
						List<WorkOrder> listaWOAtt = Util_Direcionamento_OS.atualizarInformacoesOS(listaWO);
                        update listaWOAtt;

                    } catch (Exception e) {
						throw e;
                    }

				} // Fim if(newList != null && newList.size() > 0)

			} // Fim if(idUpdate)

		} // Fim if(isBefore)

		if(isAfter){

			if(isInsert){

                System.debug(LoggingLevel.ERROR, '__ [cls Handler_Historico_OS - verificacao()] - After insert');

                if(newList != null && newList.size() > 0){

        	        try {

						rodouAtualizacaoInformacoes = true;
                        Set<Id> setIdOS = new Set<Id>();
                        for(Historico_OS__c h : newList){
                            setIdOS.add(h.Ordem_servico__c);
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

            } // Fim if(isUpdate)

		} // Fim if(isAfter)

		return true;

    } // Fim método verificacao

}