/*
    Classe de testes para a Classe "Handler_Lead"

    Criado por: Mario Reis
    Data: 05/09/2017
*/
@isTest
public class Teste_Handler_Lead{

    /*
        @author Renan Rocha
        @date 16/11/2018
    */
    static testMethod void abasteceHistoricoDetalhes(){
        Id mercosulId = Schema.getGlobalDescribe().get('Lead').getDescribe().getRecordTypeInfosByName().get('Mercosul').getRecordTypeId();

        Lead lead = new Lead();
        lead.LastName = 'TesteClasse';
        lead.Company = 'TesteEmpresa';
        insert lead;
        
        Handler_Lead.abasteceHistoricoDetalhes(new List<Lead>{lead}, null);
        
        lead.Description = 'Descrição';
        update lead;

        Handler_Lead.abasteceHistoricoDetalhes(new List<Lead>{lead}, new List<Lead>{lead});
    }

    /*
        @author Renan Rocha
        @date 28/12/2018
    */
    static testMethod void vericaUsuarioCanalExclusivo(){
        Map<String, sObject> mapBaseConfig = Teste_Util.createMapBaseConfig();
        Group grupo = (Group) mapBaseConfig.get('Group');
        User usuario = (User) mapBaseConfig.get('User');

        DML_Mix_Operations_Future.Handler_Lead_vericaUsuarioCanalExclusivoHelper(usuario.Id);
    }
}