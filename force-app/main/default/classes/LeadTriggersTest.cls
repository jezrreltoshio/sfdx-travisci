/*
    @testClass LeadTriggers

    @author Admin CRM Sascar
    @date 14/02/2014
*/
@isTest
public class LeadTriggersTest{

    /*
        @author Renan Rocha
        @date 19/11/2018
    */
    static testMethod void markLeadOrigin(){
        Util_Lead.carregarTipoRegistro();
        Lead lead = Teste_Util_Lead.criaLeadMercosulCUIT(Util_Lead.mercosul, '20-39627937-2');

        Database.LeadConvert lc = new Database.LeadConvert();
        lc.setLeadId(lead.id);

        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        lc.setConvertedStatus(convertStatus.MasterLabel);

        Database.LeadConvertResult lcr = Database.convertLead(lc);
        System.assert(lcr.isSuccess());

        LeadTriggers.markLeadOrigin(new List<Lead>{lead});
    }

    /*
        @author Renan Rocha
        @date 19/11/2018
    */
    static testMethod void formatCNPJ(){
        Util_Lead.carregarTipoRegistro();
        Lead lead = Teste_Util_Lead.criaLeadCargoTracckJ(Util_Lead.cargoTracck, '99.063.286/0001-11');

        LeadTriggers.formatCNPJ(new List<Lead>{lead});
    }

    /*
        @author Renan Rocha
        @date 19/11/2018
    */
    static testMethod void formatCPF(){
        Util_Lead.carregarTipoRegistro();
        Lead lead = Teste_Util_Lead.criaLeadBluetecF(Util_Lead.bluetec, '843.163.290-90');
        LeadTriggers.formatCPF(new List<Lead>{lead});
        
        Lead lead2 = Teste_Util_Lead.criaLeadBluetecF(Util_Lead.bluetec, '111.111.111-11');
        LeadTriggers.formatCPF(new List<Lead>{lead2});
    }
    
    /*
        @author Renan Rocha
        @date 19/11/2018
    */
    static testMethod void AbasteceHistoricoDetalhes(){
        Util_Lead.carregarTipoRegistro();
        Lead lead = Teste_Util_Lead.criaLeadCargoTracckJ(Util_Lead.cargoTracck, '99.063.286/0001-11');
        lead.Description = 'Descrição';
        update lead;

        LeadTriggers.AbasteceHistoricoDetalhes(new List<Lead>{lead});
    }
}