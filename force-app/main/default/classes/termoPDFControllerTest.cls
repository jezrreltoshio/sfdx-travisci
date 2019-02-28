/*
    @testClass 
    
    @author Renan Rocha
    @date 12/12/2018
*/

@isTest
public class termoPDFControllerTest{
    
    static testMethod void myUnitTest() {
        Map<String, sObject> mapBase = Teste_Util.createMapBase();
        Opportunity opp = (Opportunity) mapBase.get('Opportunity');
        opp.StageName = 'Negociação/Proposta';
        update opp;

        //Instancia pagina
        PageReference pageRef;
        pageRef = Page.PDF_Termo_Novo;
        pageRef.getParameters().put('Id', opp.Id);
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id', opp.Id);
        PageControllerBase pageControllerBase = new PageControllerBase();
        termoPDFController pdf = new termoPDFController();
        pdf.idOpportunity = opp.Id;
        pdf.previewPDF();
        pdf.savePdf();
        pdf.saveSendPdf();
        pdf.cancel();        
    }
}