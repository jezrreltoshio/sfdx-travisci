@isTest
private class PCL_AccountProcessTest {

    public static Account createAccount() {
        Account acc = new Account();
        acc.TelefoneCelular__c = '(11) 9876-5432';
        acc.Phone = '(11) 9876-5432';
        acc.Name = 'Teste';
        acc.TelefoneComercial__c = '(11) 6785-4567';
        return acc;
    }
    
    public static Contact createContact() {
        Contact contato = new Contact();
        contato.LastName = 'Teste';
        contato.RG__c = '123456789';
        //contato.CPF__c = '12345678909';
        contato.Phone = '(11) 9876-5432';
        contato.HomePhone = '(11) 9876-5432';
        contato.MobilePhone = '(11) 9876-5432';
        contato.Email = 'teste@teste.com.br';
        return contato;
    }
    
    static testMethod void myUnitTest() {
        //Conta e Contato PF
        Account accPF = createAccount();
        accPF.Tipo_de_pessoa__c = 'F-Física';
        //accPF.CPF__c = '66236667373';
        accPF.DadosPF_NomeMae__c = 'Mamãe';
        accPF.DadosPF_Sexo__c = 'M-Masculino';
        accPF.DadosPF_DataNascimento__c = date.today().addYears(-20);
        accPF.DadosPF_EstadoCivil__c = 'S-Solteiro';
        accPF.FormaCobranca__c = '4-Débito Automático Itaú';
        accPF.DebAut_Agencia__c = 1234;
        accPF.DebAut_ContaCorrente__c = 123451;
        accPF.DebAut_NomeTitular__c = 'New Account';
        //accPF.Enderecos_Principal_CEP__c = '12345999';
        accPF.Enderecos_Principal_Numero__c = 1000;
        //accPF.Enderecos_Cobranca_CEP__c = '12345999';
        accPF.Enderecos_Cobranca_Numero__c = 1000;
        //accPF.Enderecos_Entrega_CEP__c = '12345999';
        accPF.Enderecos_Entrega_Numero__c = 1000;
        insert accPF;
        
        Contact contatoPF = createContact();
        contatoPF.AccountId = accPF.Id;
        insert contatoPF;
        
        //Conta e Contato PJ
        Account accPJ = createAccount();
        accPJ.Tipo_de_pessoa__c = 'J-Jurídica';
        //accPJ.CNPJ__c = '80116451000128';
        accPJ.Nome_fantasia__c = 'New Account';
        accPJ.DadosPJ_InscricaoMunicipal__c = 'Isento';
        accPJ.DadosPJ_InscricaoEstadualUF__c = 'Isento';
        accPJ.DadosPJ_InscricaoEstadual__c = 'Isento';
        accPJ.FormaCobranca__c = '4-Débito Automático Itaú';
        accPJ.DebAut_Agencia__c = 1234;
        accPJ.DebAut_ContaCorrente__c = 123451;
        accPJ.DebAut_NomeTitular__c = 'New Account';
        //accPJ.Enderecos_Principal_CEP__c = '12345999';
        accPJ.Enderecos_Principal_Numero__c = 1000;
        //accPJ.Enderecos_Cobranca_CEP__c = '12345999';
        accPJ.Enderecos_Cobranca_Numero__c = 1000;
        //accPJ.Enderecos_Entrega_CEP__c = '12345999';
        accPJ.Enderecos_Entrega_Numero__c = 1000;
        insert accPJ;
        
        Contact contatoPJ = createContact();
        contatoPJ.AccountId = accPJ.Id;
        insert contatoPJ;
        
        accPJ.ContatoPessoaAutorizada__c = contatoPJ.Id;
        accPJ.ContatoPadrao__c = contatoPJ.Id;
        accPJ.ContatoInstalacao__c = contatoPJ.Id;
        accPJ.ContatoEmergencia__c = contatoPJ.Id;
        update accPJ;
        
        PCL_AccountProcess pcl = new PCL_AccountProcess();
        pcl.validationAccountToCore(accPF.Id);
        pcl.validationAccountToCore(accPJ.Id);
        
        accPJ.Tipo_de_pessoa__c = 'J-Jurídica';
        update accPJ;
        /* SEFO comentado para implantação das demandas da Siggo
        Operacao__c op1 = new Operacao__c();
        op1.Name = 'Teste';
        op1.ContaPai__c = accPJ.Id;
        op1.Conta_Entrega__c = accPJ.Id;
        op1.ID_Operacao_CT__c = 299;
        insert op1;
        
        Endereco__c e1 = new Endereco__c();
        e1.Operacao__c = op1.Id;
        e1.Endereco_Principal__c = true;
        e1.CEP__c = '12345-999';
        e1.UF__c = 'SP';
        e1.Cidade__c = 'Teste';
        e1.Bairro__c = 'Teste';
        e1.Logradouro__c = 'Teste';
        e1.Numero__c = 1000;
        e1.Complemento__c = 'Apto A';
        insert e1;
        
        Operacao__c op2 = new Operacao__c();
        op2.Name = 'Teste';
        op2.ContaPai__c = accPF.Id;
        op2.Conta_Entrega__c = accPF.Id;
        op2.ID_Operacao_CT__c = 299;
        insert op2;
        
        Endereco__c e2 = new Endereco__c();
        e2.Operacao__c = op2.Id;
        e2.Endereco_Principal__c = true;
        e2.CEP__c = '12345-999';
        e2.UF__c = 'SP';
        e2.Cidade__c = 'Teste';
        e2.Bairro__c = 'Teste';
        e2.Logradouro__c = 'Teste';
        e2.Numero__c = 1000;
        e2.Complemento__c = 'Apto A';
        insert e2;
        */
        pcl.validationAccountToCore(accPF.Id);
        pcl.validationAccountToCore(accPJ.Id);
        
        accPF.DadosPF_NomeMae__c = 'Mae Teste';
        accPF.DadosPF_Sexo__c = 'M-Masculino';
        accPF.DadosPF_DataNascimento__c = date.today().addYears(-20);
        accPF.DadosPF_EstadoCivil__c = 'S-Solteiro';
        accPF.DadosPF_RG__c = '432996781';
        update accPF;
        
        pcl.sendAccountToCore(accPF.Id);
        pcl.sendAccountToCore(accPJ.Id);
        
        
         PCL_AccountProcess.neverCallThisMethod();
        
    }
}