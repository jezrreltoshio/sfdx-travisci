/*
	Classe de teste: Teste_Handler_Lead
	Criado por: Mario Reis
	Data de criação: 02/10/2017
	Descrição: Classe responsável por realizar o tratamento da Trigger para o objeto Lead e
				direcionar para a funcionalidade correta
    ---------------------------------
    @author Renan Rocha
    @date 16/11/2018
    @description Inserido método abasteceHistoricoDetalhes que estava na trigger: Lead_AbasteceHistoricoDetalhes, para unificar todos os métodos em uma única trigger
    @JIRA KCA-10
    ---------------------------------
    @author Renan Rocha
    @date 28/12/2018
    @description Inserido método vericaUsuarioCanalExclusivo
    @JIRA KCA-384
    ---------------------------------
    @author Renan Rocha
    @date 02/01/2019
    @description Inserido label no método verificaUsuarioCanalExclusivo
    @JIRA KCA-384
    ---------------------------------
    @author Renan Rocha
    @date 10/01/2019
    @description Retirado verificação de "Canal Exclusivo - Indicação Executivo" conforme solicitação na história
    @JIRA KCA-384
    ---------------------------------
    @author Renan Rocha
    @date 23/01/2019
    @description Alterado método verificaUsuarioCanalExclusivo para receber o parâmetro oldMap e verificar se o campo origem foi alterado
    @JIRA KCA-384
*/
public class Handler_Lead{

    private static String CLASS_NAME = 'Handler_Lead';

    /*
        @description Verifica a possibilidade de preenchimento de detalhes na descrição quando não informado
        @param List<Lead> pListaNew
        @param List<Lead> pListaOld
        @return void
        
        @author Renan Rocha
    */
    public static void abasteceHistoricoDetalhes(List<Lead> pListaNew, List<Lead> pListaOld){
        String METHOD_NAME = 'abasteceHistoricoDetalhes';

        Map<String, String> mapaNew = new Map<String, String>();
        List<Lead> listaLead = new List<Lead>();

        for(Lead forLead : pListaNew){
            if(forLead.Description != null) mapaNew.put(forLead.Id, forLead.Description);
        }

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - mapaNew: '+ mapaNew);
     
        if(pListaOld != null){
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - pListaOld: '+ pListaOld);
            
            for(Lead forLead : pListaOld){
                if(mapaNew.containsKey(forLead.Id)){
                    if(mapaNew.get(forLead.Id) != forLead.Description && forLead.Description != null) listaLead.add(forLead);
                }
            }
            
            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaLead: '+ listaLead);
             
            if(listaLead.size() > 0) LeadTriggers.AbasteceHistoricoDetalhes(listaLead);
        }
    }

    /*
        @description Verifica se o usuário atual editando ou criando o Lead faz parte do grupo: "Origem Lead: Canal exclusivo"
        @param List<Lead> pListaNew, Map<Id, Lead> pOldMap, Boolean pIsInsert
        @return void
        
        @author Renan Rocha
        @date 28/12/2018
        @JIRA KCA-384
    */
    public static void vericaUsuarioCanalExclusivo(List<Lead> pListaNew, Map<Id, Lead> pOldMap, Boolean pIsInsert){
        String METHOD_NAME = 'vericaUsuarioCanalExclusivo';
        
        List<GroupMember> listaMembrosGrupoDAO = DAO_GroupMember.getMembroGrupoByGrupoId(Parametros_ORG__c.getOrgDefaults().Id_grupo_origem_lead_canal_exclusivo__c);
        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - listaMembrosGrupoDAO: '+ listaMembrosGrupoDAO);

        Set<Id> setMembrosFilter = new Set<Id>();

        for(GroupMember forMembroGrupo : listaMembrosGrupoDAO){
            if(!setMembrosFilter.contains(forMembroGrupo.UserOrGroupId)) setMembrosFilter.add(forMembroGrupo.UserOrGroupId);
        }

        for(Lead forLead : pListaNew){

            System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - forLead.LeadSource: '+ forLead.LeadSource);

            if(pIsInsert){
                if(forLead.LeadSource == 'Canal Exclusivo de Indicações' && !setMembrosFilter.contains(UserInfo.getUserId())) forLead.addError(' ' + System.Label.LBL_001); //LBL_001: Não é possível utilizar os valores: "Canal Exclusivo de Indicações" ou "Canal Exclusivo - Indicação Executivo" no campo "Origem do lead" para seu usuário, entre em contato com o Administrador.  
            } else if ((pOldMap.get(forLead.Id).LeadSource == 'Canal Exclusivo de Indicações' && forLead.LeadSource != pOldMap.get(forLead.Id).LeadSource)
               || (!pIsInsert && forLead.LeadSource == 'Canal Exclusivo de Indicações' && forLead.LeadSource != pOldMap.get(forLead.Id).LeadSource)){
                   if(!setMembrosFilter.contains(UserInfo.getUserId())) forLead.addError(' ' + System.Label.LBL_001);
            }
        }
    }
}