@isTest
private class PageControllerBaseTest {

    static testMethod void myUnitTest() {
        
        ComponentControllerBase componente = new ComponentControllerBase();
        
        PageControllerBase base = new PageControllerBase();
        PageControllerBase base2 = new PageControllerBase();
        PageControllerBase base3 = new PageControllerBase();
        
        componente = base.getComponentController();
        base2 = base.getThis();
        base.setComponentController(componente);
    }
}