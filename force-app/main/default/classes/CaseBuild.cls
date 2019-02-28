@isTest
public class CaseBuild {
    
    public static Case newCase(Id recordTypeId){
        Case caso = new Case(
            Subject = 'Reclamação',
            Status = 'Não iniciado',
            Origin = 'E-mail',
            StatusResposta__c = 'Não iniciada',
            StatusSolucao__c = 'Não iniciada',
            TelefoneCliente__c = '1144445555',
            CNPJ_CPF__c = '83813009084',
            NivelEscalacao__c = 'N1'
        );   
        return caso;
    }

}