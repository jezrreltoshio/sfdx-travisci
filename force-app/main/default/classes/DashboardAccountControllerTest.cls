/**************************************************************************************************************
* 
* @author           Ernani href=<ernani.junior.ext@sascar.com>
* Project:          SASCAR
* 
*
* Changes (Version)
* ------------------------------------- 
*           No.     Date            Author                  Desc       		  Sprint
*           -----   ----------      --------------------    ---------------   -------------
* @version   1.0    2018-06-02      Ernani Junior (EJ)      Class created      8     
*************************************************************************************************************/
@isTest
public class DashboardAccountControllerTest 
{
	@isTest
	static void testeClassCalcularData() {

        Account conta = new Account();
        conta.Name = 'teste 1';        
       	insert conta;

        Status_OS__c statusAtorizada = criarStatus('Autorizada','1', true);
        Status_OS__c statusCancelada = criarStatus('Cancelada' ,'2', true);

    	WorkOrder ordem = new WorkOrder();
    	ordem.Cliente__c = 'teste';
        ordem.Status_OS__c = statusAtorizada.id;
        ordem.Codigo_Externo__c = 1234569;
        ordem.StartDate = system.now() -1;
        // ordem.Tipo_macro_OS__c = 'Assistência';
        // ordem.Tipo_micro_OS__c = 'Assistência';
    	insert ordem;
        
        ordem.Status_OS__c = statusCancelada.id;
        update ordem; 
        
        ApexPages.StandardController sc = new ApexPages.StandardController(conta);
        DashboardAccountController controller = new DashboardAccountController(sc);
        
        PageReference pageRef = Page.FilterDashboard;
        pageRef.getParameters().put('id', String.valueOf(conta.Id));
        Test.setCurrentPage(pageRef);
                
    }    
    
    
    
    private static Status_OS__c criarStatus( String NomeStatus, String codigoExterno  , Boolean isInsert) {

        Status_OS__c os = new Status_OS__c();
        
        os.Name = NomeStatus;
        os.Codigo_Externo__c = codigoExterno;
        os.Pais_Referencia__c = 'BR';
        
        if(isInsert){
            insert os;
        }
        
        return os;
    }
}