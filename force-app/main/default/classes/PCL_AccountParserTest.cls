@isTest
private class PCL_AccountParserTest {

    public static Account createAccount() {
        Account acc = new Account();
        acc.TelefoneCelular__c = '1198765432';
        acc.Phone = '1198765432';
        acc.Name = 'Teste';
        acc.TelefoneComercial__c = '1167854567';
        return acc;
    }
    
    public static Contact createContact() {
        Contact contato = new Contact();
        contato.LastName = 'Teste';
        contato.RG__c = '123456789';
        contato.CPF__c = '12345678909';
        contato.Phone = '1167854567';
        contato.HomePhone = '1167854567';
        contato.MobilePhone = '1198765432';
        contato.Email = 'teste@teste.com.br';
        return contato;
    }
    
    static testMethod void myUnitTest() {
        //Conta e Contato PF
        Account accPF = createAccount();
        accPF.Tipo_de_pessoa__c = 'F-Física';
        accPF.DadosPF_NomeMae__c = 'Mae Teste';
        accPF.DadosPF_Sexo__c = 'M-Masculino';
        accPF.DadosPF_DataNascimento__c = date.today().addYears(-20);
        accPF.DadosPF_EstadoCivil__c = 'S-Solteiro';
        accPF.DadosPF_RG__c = '432996781';
        insert accPF;
        
        Contact contatoPF = createContact();
        contatoPF.AccountId = accPF.Id;
        insert contatoPF;
        
        //Conta e Contato PJ
        Account accPJ = createAccount();
        accPJ.Tipo_de_pessoa__c = 'J-Jurídica';
        insert accPJ;
        
        Contact contatoPJ = createContact();
        contatoPJ.AccountId = accPJ.Id;
        insert contatoPJ;
        
        accPJ.ContatoPessoaAutorizada__c = contatoPJ.Id;
        accPJ.ContatoPadrao__c = contatoPJ.Id;
        accPJ.ContatoInstalacao__c = contatoPJ.Id;
        accPJ.ContatoEmergencia__c = contatoPJ.Id;
        update accPJ;
        /*SEFO Comentado para implantação das demandas da Siggo
        Operacao__c op = new Operacao__c();
        op.Name = 'Teste';
        op.ContaPai__c = accPJ.Id;
        op.Conta_Entrega__c = accPJ.Id;
        insert op;
        
        Endereco__c e = new Endereco__c();
        e.Operacao__c = op.Id;
        e.Endereco_Principal__c = true;
        e.CEP__c = '12345-999';
        e.UF__c = 'SP';
        e.Cidade__c = 'Teste';
        e.Bairro__c = 'Teste';
        e.Logradouro__c = 'Teste';
        e.Numero__c = 1000;
        e.Complemento__c = 'Apto A';
        insert e;
        */
        PCL_AccountParser pcl = new PCL_AccountParser();
        pcl.toExternalObject(accPF);
        pcl.toExternalObject(accPJ);
        
        accPJ.FormaCobranca__c = '3-Débito Automático HSBC';
        accPJ.DebAut_Agencia__c = 1234;
        accPJ.DebAut_ContaCorrente__c = 123456;
        accPJ.DebAut_NomeTitular__c = 'Teste';
        update accPJ;
        pcl.toExternalObject(accPJ);
        
        accPJ.FormaCobranca__c = '4-Débito Automático Itaú';
        update accPJ;
        pcl.toExternalObject(accPJ);
        
        accPJ.FormaCobranca__c = '12-Débito Automático Bradesco';
        update accPJ;
        pcl.toExternalObject(accPJ);
        
        accPJ.FormaCobranca__c = '13-Débito Automático Banco do Brasil';
        update accPJ;
        pcl.toExternalObject(accPJ);
        
        accPJ.FormaCobranca__c = '80-Débito Automático Santander';
        update accPJ;
        pcl.toExternalObject(accPJ);
        
        accPJ.FormaCobranca__c = '24-Cartão Visa';
        accPJ.Cobranca_Cartao_Numero_Cript__c = '1111222233334444';
        accPJ.Cobranca_Cartao_CodigoSeguranca_Cript__c = '123';
        accPJ.Cobranca_Cartao_Vcto__c = '0150';
        update accPJ;
        pcl.toExternalObject(accPJ);
        
        accPJ.FormaCobranca__c = '25-Cartão Mastercard';
        update accPJ;
        pcl.toExternalObject(accPJ);
        
        accPJ.FormaCobranca__c = '82-Cartão Hipercard';
        update accPJ;
        pcl.toExternalObject(accPJ);
        
        //PCL_AccountParser.neverCallThisMethod();
    }
}