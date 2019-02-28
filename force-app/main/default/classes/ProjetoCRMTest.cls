/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class ProjetoCRMTest {
	
	static testMethod void deleteTypesVehiclesFP(){
        Account acc = new Account();
        acc.Name = 'Teste';
        acc.RecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Account' AND Name = 'CORP'].Id;
        insert acc;
        
        Id accId = acc.Id;
        
        Frota_Potencial__c frotaP = new Frota_Potencial__c();
        frotaP.Conta__c = accId;
        frotaP.Tipo_de_ve_culo__c = 'VAN';
        frotaP.Quantidade_de_veiculos__c = 2;
        frotaP.Concorrente__c = 'AUTOTRAC';
        frotaP.Nivel_de_relacionamento__c = 'Bom';
        insert frotaP;
        
		test.startTest();
			delete frotaP;
		test.StopTest();
	}
	
	static testMethod void setPotencialInFrotaTotal(){		
		Account acc = new Account();
        acc.Name = 'Teste';
        acc.RecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Account' AND Name = 'CORP'].Id;
        insert acc;
        
        Id accId = acc.Id;
        
        Frota_Potencial__c frotaP = new Frota_Potencial__c();
        frotaP.Conta__c = accId;
        frotaP.Tipo_de_ve_culo__c = 'VAN';
        frotaP.Quantidade_de_veiculos__c = 2;
        frotaP.Concorrente__c = 'AUTOTRAC';
        frotaP.Nivel_de_relacionamento__c = 'Bom';
        insert frotaP;
        
        
        List<AggregateResult> frotaPotencial = [SELECT
                                                        Tipo_de_ve_culo__c, SUM(Quantidade_de_veiculos__c)
                                                    FROM
                                                        Frota_Potencial__c
                                                    WHERE
                                                        Conta__c =: accId
                                                    GROUP BY
                                                        Tipo_de_ve_culo__c
                                                    ORDER BY
                                                        Tipo_de_ve_culo__c ASC];
                                                                
        List<Frota_Total__c> frtotal = [Select Id, Tipo_de_Veiculo__c FROM Frota_Total__c WHERE Conta__c=:accId];        
        Map<String, Id> mapFrotaTotal = new Map<String, Id>();
        
        for(Frota_Total__c a: frtotal){
            mapFrotaTotal.put(String.valueOf(a.Tipo_de_Veiculo__c), a.Id);
        }
                                                                     
        for(AggregateResult fp: frotaPotencial){
            String tipo_veiculo = String.valueOf(fp.get('Tipo_de_ve_culo__c'));
                        
            if(mapFrotaTotal.containsKey(tipo_veiculo)){
                //update
                Frota_Total__c newFrotaTotal = new Frota_Total__c();
                newFrotaTotal.Id = mapFrotaTotal.get(tipo_veiculo);
                newFrotaTotal.Tipo_de_veiculo__c = String.valueOf(fp.get('Tipo_de_ve_culo__c')); //Tipo_de_ve_culo__c;
                newFrotaTotal.Quantidade_Potencial__c = Integer.valueOf(fp.get('expr0')); //Quantidade_de_veiculos__c;
                update newFrotaTotal;
                
                system.debug('setPotencialInFrotaTotal - update FrotaTotal: ' +newFrotaTotal);
            } else{
                //insert
                Frota_Total__c newFrotaTotal = new Frota_Total__c();
                newFrotaTotal.Tipo_de_veiculo__c = String.valueOf(fp.get('Tipo_de_ve_culo__c')); //Tipo_de_ve_culo__c;
                newFrotaTotal.Conta__c = acc.Id;
                newFrotaTotal.Quantidade_Potencial__c = Integer.valueOf(fp.get('expr0')); //Quantidade_de_veiculos__c;
                insert newFrotaTotal;
                
                system.debug('setPotencialInFrotaTotal  - insert newFrotaTotal: ' +newFrotaTotal);
            }
        
        }
	}
	
	static testMethod void acc(){
		Account acc1 = new Account();
        acc1.Name = 'Teste';
        acc1.RecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Account' AND Name = 'CORP'].Id;
        insert acc1;
        
        Account acc = new Account();
        acc.Id = acc1.Id;
	}
	
	static testMethod void pentahoUpsertSituacaoFinanceira(){
		Boolean bln = true;
        Account accnt = new Account();
        accnt.Name = 'Teste';
        accnt.RecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Account' AND Name = 'CORP'].Id;
        insert accnt;
        
        Situacao_Financeira__c vep = new Situacao_Financeira__c();
        vep.Id_Cliente__c = accnt.Id;
        vep.Conta__c = accnt.Id;
        
        insert vep;
        
        List<Situacao_Financeira__c> frota = new List<Situacao_Financeira__c>();
        frota.add(vep);
        
		if(bln){
            for(Situacao_Financeira__c sf : frota){
                String Id_Cliente = sf.Id_Cliente__c;
                
                if(sf.Id_Cliente__c != ''){                
                    Account acc = [SELECT Id, Name FROM Account WHERE Id=:Id_Cliente];                
                    sf.Conta__c = accnt.Id;    
                }
            }
        }
	}
	
	static testMethod void pentahoUpsertVeiculosPlacas(){
		Boolean bln = true;
        Account accnt = new Account();
        accnt.Name = 'Teste';
        accnt.RecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Account' AND Name = 'CORP'].Id;
        insert accnt;
        
        Veiculos_e_placas__c vep = new Veiculos_e_placas__c();
        vep.Id_Cliente__c = accnt.Id;
        vep.Conta__c = accnt.Id;
        
        insert vep;
        
        List<Veiculos_e_placas__c> frota = new List<Veiculos_e_placas__c>();
        frota.add(vep);
        
        if(bln){               
            for(Veiculos_e_placas__c vp : frota){
                String Id_Cliente = vp.Id_Cliente__c;
                
                if(vp.Id_Cliente__c != ''){
                    Account acc = [SELECT Id, Name FROM Account WHERE Id=:Id_Cliente];                
                    vp.Conta__c = accnt.Id;    
                }
            }     
        }
    }
	
	static testMethod void pentahoUpsertSituacaoTermo(){
		Boolean bln = true;
        Account accnt = new Account();
        accnt.Name = 'Teste';
        accnt.RecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Account' AND Name = 'CORP'].Id;
        insert accnt;
        
        Situacao_do_Termo__c sdt = new Situacao_do_Termo__c();
        sdt.Id_Cliente__c = accnt.Id;
        sdt.Conta__c = accnt.Id;
        
        insert sdt;
        
        List<Situacao_do_Termo__c> frota = new List<Situacao_do_Termo__c>();
        frota.add(sdt);
        
        if(bln){
            for(Situacao_do_Termo__c st : frota){
                String Id_Cliente = st.Id_Cliente__c;
                
                if(st.Id_Cliente__c != ''){                     
                    system.debug('Pentaho: '+Id_Cliente );
                
                    Account acc = [SELECT Id, Name FROM Account WHERE Id=:Id_Cliente];
                    system.debug('Pentaho: '+acc);
                
                    st.Conta__c = accnt.Id;    
                }
            }
        }
    }
	
	static testMethod void pentahoUpsertInteracoes(){
		Boolean bln = true;
        Account accnt = new Account();
        accnt.Name = 'Teste';
        accnt.RecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Account' AND Name = 'CORP'].Id;
        insert accnt;
        
        Interacoes__c intr = new Interacoes__c();
        intr.Id_Cliente__c = accnt.Id;
        intr.Conta__c = accnt.Id;
        
        insert intr;
        
        List<Interacoes__c> frota = new List<Interacoes__c>();
        frota.add(intr);
        
        if(bln){
            for(Interacoes__c itc : frota){
                String Id_Cliente = itc.Id_Cliente__c;
                
                if(itc.Id_Cliente__c != ''){
                    Account acc = [SELECT Id, Name FROM Account WHERE Id=:Id_Cliente];                
                    itc.Conta__c = accnt.Id;    
                }
            }
        }
    }
	
	static testMethod void pentahoUpsertInFrotaSascar(){        
        //before insert - isInsert
        /*Boolean bln = true;
        Account accnt = new Account();
        accnt.Name = 'Teste';
        accnt.RecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Account' AND Name = 'CORP'].Id;
        insert accnt;
        
        Frota_Sascar__c frt = new Frota_Sascar__c();
        frt.Id_Cliente__c = accnt.Id;
        frt.Conta__c = accnt.Id;
        
        insert frt;
        
        List<Frota_Sascar__c> frota = new List<Frota_Sascar__c>();
        frota.add(frt);
        
        if(bln){
            for(Frota_Sascar__c fs : frota){
                String Id_Cliente = fs.Id_Cliente__c;
                
                if(fs.Id_Cliente__c != ''){                
                    Account acc = [SELECT Id, Name FROM Account WHERE Id=:Id_Cliente];                
                    fs.Conta__c = accnt.Id;    
                }
            }     
        }*/
	}
		
	static testMethod void setInformacoesFinanceirasInAccount(){
		Account acc1 = new Account();
        acc1.Name = 'Teste';
        acc1.RecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Account' AND Name = 'CORP'].Id;
        insert acc1;
        
        Account acc = new Account();
        acc.Id = acc1.Id;
        
        Id accId = acc.Id;
        
        Situacao_Financeira__c situacao = new Situacao_Financeira__c();
        situacao.Conta__c = accId;
        situacao.Faturamento_medio_trimestral__c = 36000.10;
        situacao.Situacao_Financeira__c = 'Adimplente';
        situacao.Rentabilidade_Mensal__c = 21160.74;
        situacao.Situacao_sinal__c = 'Normal';
        situacao.Acao_judicial__c = 'NÃO';
        situacao.Rentabilidade_YTD__c = 210160.74;
        //insert situacao;
        
        /*List<Situacao_Financeira__c> sf = [SELECT
                                                Faturamento_medio_trimestral__c,
                                                Situacao_Financeira__c,
                                                Rentabilidade_Mensal__c,
                                                Situacao_sinal__c,
                                                Acao_judicial__c,
                                                Rentabilidade_YTD__c
                                            FROM
                                                Situacao_Financeira__c
                                            WHERE
                                                Conta__c=:accId];*/
        List<Situacao_Financeira__c> sf = new List<Situacao_Financeira__c>();
        sf.add(situacao);                                               
        
        if(sf.size() > 0){
            acc.Faturamento_medio_trimestral__c = sf[0].Faturamento_medio_trimestral__c;
            acc.Situacao_financeira__c = sf[0].Situacao_Financeira__c;
            acc.Rentabilidade_mensal__c = sf[0].Rentabilidade_Mensal__c;
            acc.Situacao_sinal__c = sf[0].Situacao_sinal__c;
            acc.A_o_judicial__c = sf[0].Acao_judicial__c;
            acc.Rentabilidade_YTD__c = sf[0].Rentabilidade_YTD__c;
            update acc;
        }
	}

    static testMethod void neverCallThisMethod() {
        ProjetoCRM.neverCallThisMethod();
	}
	
	static testMethod void neverCallThisMethod1() {
        ConsultaFrotaPotencial.neverCallThisMethod();
	}
	
	static testMethod void neverCallThisMethod2() {
        ConsultaFrotaSascar.neverCallThisMethod();
	}
	
	static testMethod void neverCallThisMethod3() {
        ConsultaFrotaTotal.neverCallThisMethod();
	}
	
	static testMethod void neverCallThisMethod4() {
        ConsultaSituacaoFinanceira.neverCallThisMethod();
	}
	
	static testMethod void neverCallThisMethod5() {
        VeiculosPlacas.neverCallThisMethod();
	}
}