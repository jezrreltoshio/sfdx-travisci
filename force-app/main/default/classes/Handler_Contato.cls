/*
 * Classe de teste: Teste_Handler_Contato
 * Criado por: Mario Reis
 * Data de criação: 16/11/2017
 * Descrição: Classe responsável por realizar o tratamento da Trigger para o objeto Contato e
 * 			direcionar para a funcionalidade correta
 * 
 * Alteração: Rafael Silva
 * Data de alteração: 05/07/2018
 * Descrição: Correção de erros e unificação das triggers.
*/

public class Handler_Contato {

    // Método para verificação da Trigger
    public static Boolean verificacao(Boolean isBefore, Boolean isAfter, Boolean isInsert,
                                  	Boolean isUpdate, Boolean isDelete, Boolean isUndelete, 
                                  	List<Contact> oldList, Map<Id, Contact> oldMap,
                                  	List<Contact> newList, Map<Id, Contact> newMap){

		System.debug(LoggingLevel.ERROR, '__ [cls Handler_Contato - verificacao()] - Inicio...');
		System.debug(LoggingLevel.ERROR, '__ [cls Handler_Contato - verificacao()] - isBefore: '+isBefore);
        System.debug(LoggingLevel.ERROR, '__ [cls Handler_Contato - verificacao()] - isAfter: '+isAfter);
        System.debug(LoggingLevel.ERROR, '__ [cls Handler_Contato - verificacao()] - isInsert: '+isInsert);
        System.debug(LoggingLevel.ERROR, '__ [cls Handler_Contato - verificacao()] - isUpdate: '+isUpdate);
		System.debug(LoggingLevel.ERROR, '__ [cls Handler_Contato - verificacao()] - isDelete: '+isDelete);
		System.debug(LoggingLevel.ERROR, '__ [cls Handler_Contato - verificacao()] - isUndelete: '+isUndelete);
		System.debug(LoggingLevel.ERROR, '__ [cls Handler_Contato - verificacao()] - oldList: '+oldList);
		System.debug(LoggingLevel.ERROR, '__ [cls Handler_Contato - verificacao()] - oldMap: '+oldMap);
		System.debug(LoggingLevel.ERROR, '__ [cls Handler_Contato - verificacao()] - newList: '+newList);
		System.debug(LoggingLevel.ERROR, '__ [cls Handler_Contato - verificacao()] - newMap: '+newMap);

		if(isBefore){

            if(isInsert){

                System.debug(LoggingLevel.ERROR, '__ [cls Handler_Contato - verificacao()] - Before insert');
                
                if(newList != null && newList.size() > 0){
                    
                    Service_Contato.copiarDadosConta(newList);
                    Service_Contato.formataCPF(newList);
        	        /*try {


                    } catch (Exception e) {
						throw e;
                    }*/

				} // Fim if(newList != null && newList.size() > 0)

            } // Fim if(isInsert)

			if(isUpdate){

                System.debug(LoggingLevel.ERROR, '__ [cls Handler_Contato - verificacao()] - Before update');

				if(newList != null && newList.size() > 0){
                    
                    Service_Contato.formataCPF(newList);
                    
        	        /*try {

                    } catch (Exception e) {
						throw e;
                    }*/

				} // Fim if(newList != null && newList.size() > 0)

			} // Fim if(idUpdate)

		} // Fim if(isBefore)

		if(isAfter){
            
            List<Id> contactIds = new List<Id>();

			if(isInsert){
                
                System.debug(LoggingLevel.ERROR, '__ [cls Handler_Contato - verificacao()] - After insert');
                
                if (!ProcessorControl.inFutureContext){
                    for(Contact c : newList)
                    {
                        if(c.MailingPostalCode!=null)
                        	contactIds.add(c.Id);
                    }
                }
                
                if(contactIds.size() > 0)
                    Service_Contato.buscaCEP(contactIds);

				Service_Contato.carregarEnderecoConta(newList);

			} // Fim if(isInsert)

            if(isUpdate){
                
                System.debug(LoggingLevel.ERROR, '__ [cls Handler_Contato - verificacao()] - After update');
                
                if (!ProcessorControl.inFutureContext){
                    for(Contact c : newList)
                    {
                        if(c.MailingPostalCode != null && oldMap.get(c.Id).MailingPostalCode != c.MailingPostalCode)
                        	contactIds.add(c.Id);
                    }
                        
                }
                
                if(contactIds.size() > 0)
                    Service_Contato.buscaCEP(contactIds);

            } // Fim if(isUpdate)

		} // Fim if(isAfter)

		return true;

    } // Fim método verificacao

}