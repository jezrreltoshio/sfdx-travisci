@isTest
public class CaseBuildTest {
    
    public static Case casoBasic(Id recordTypeId){
        Case caso = new Case();
        caso.Subject = 'test';
        caso.Type = 'Problema';
        caso.Status = 'Em espera';
        caso.Origin = 'E-mail';
        caso.Reason = 'Novo problema';
    	caso.RecordTypeId = recordTypeId;    
        return caso;
    }

}