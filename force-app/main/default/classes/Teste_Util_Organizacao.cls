/*
    Classe de testes para a Classe "Util_Organizacao"

    Criado por: Mario Reis
    Data: 04/09/2017

*/
@isTest
public class Teste_Util_Organizacao {

    // Método para testar o retorno da conf do server Siggo
    static testmethod void testeGetAmbienteSF() {

        Test.startTest();

        Profile perfil = Teste_Util_Usuario.getPerfilPorNome('Administrador do sistema');
        User usuario = Teste_Util_Usuario.criaNovoUsuarioBR(perfil.Id, 'dev@sascar.com.br.dev', 1.998);

        System.debug('usuario: '+usuario);

        System.RunAs(usuario) {
        	Util_Organizacao.getAmbienteSF();
        }

        User usuario2 = Teste_Util_Usuario.criaNovoUsuarioBR(perfil.Id, 'dev@sascar.com.br.homolog', 2.998);

        System.RunAs(usuario2) {
        	Util_Organizacao.getAmbienteSF();
        }

		User usuario3 = Teste_Util_Usuario.criaNovoUsuarioBR(perfil.Id, 'dev@sascar.com.br', 3.998);

        System.RunAs(usuario3) {
            Util_Organizacao.test = true;
            Util_Organizacao.getAmbienteSF();
            Util_Organizacao.test = false;
            Util_Organizacao.getAmbienteSF();
        }

        User usuario4 = Teste_Util_Usuario.criaNovoUsuarioBR(perfil.Id, 'testenulo@teste.com.br', 4.998);

        System.RunAs(usuario4) {
            try {
            	Util_Organizacao.getAmbienteSF();    
            } catch (Exception e){
                System.Assert(e.getMessage().contains(Label.MSG_ERRO_0005));
            }
            
        }

        Test.stopTest();

    } // Fim testeGetAmbienteSF



    // Método para formatar o telefone no Brasil
    static testmethod void testeFormatarTelefoneBrasil() {

        // Telefone vazio
        try {
            Util_Organizacao.formatarTelefoneBrasil('');
        } catch (Exception e){
            System.Assert(e.getMessage().contains(Label.MSG_ERRO_0017));
        }

        // Telefone invalido
        try {
            Util_Organizacao.formatarTelefoneBrasil('9999999999999');
        } catch (Exception e){
            System.Assert(e.getMessage().contains(Label.MSG_ERRO_0017));
        }

        // Telefones em formatos diferentes e verificação da formatação
        String telefone01 = Util_Organizacao.formatarTelefoneBrasil('99887898');
        System.Assert(telefone01.equalsIgnoreCase('9988-7898'));

        String telefone02 = Util_Organizacao.formatarTelefoneBrasil('999887898');
        System.Assert(telefone02.equalsIgnoreCase('99988-7898'));

        String telefone03 = Util_Organizacao.formatarTelefoneBrasil('4199887898');
        System.Assert(telefone03.equalsIgnoreCase('(41) 9988-7898'));

        String telefone04 = Util_Organizacao.formatarTelefoneBrasil('41999887898');
        System.Assert(telefone04.equalsIgnoreCase('(41) 99988-7898'));

        String telefone05 = Util_Organizacao.formatarTelefoneBrasil('554199887898');
        System.Assert(telefone05.equalsIgnoreCase('+ 55 (41) 9988-7898'));

        String telefone06 = Util_Organizacao.formatarTelefoneBrasil('5541999887898');
        System.Assert(telefone06.equalsIgnoreCase('+ 55 (41) 99988-7898'));

    } // Fim testeFormatarTelefoneBrasil



    // Método para buscar o CEP
    static testmethod void testeBuscaCEP() {

        Util_Conta.carregarTipoRegistro();

        Account conta = Teste_Util_Conta.criaContaArgentinaCUIT(Util_Conta.mercosul, '30-70095623-3');

        Util_Organizacao.test = false;

        Util_Organizacao.buscaCEP(conta.Id, '80215-432', 'conta', 'principal');

    }

    
    // Método para buscar o CEP
    static testmethod void testeBuscaCEP2() {

        Util_Conta.carregarTipoRegistro();

        Account conta = Teste_Util_Conta.criaContaArgentinaCUIT(Util_Conta.mercosul, '30-70095623-3');

        Util_Organizacao.test = true;

        Util_Organizacao.buscaCEP(conta.Id, '80215-432', 'conta', 'principal');
        Util_Organizacao.buscaCEP(conta.Id, '80215-432', 'conta', 'entrega');
        Util_Organizacao.buscaCEP(conta.Id, '80215-432', 'conta', 'cobranca');

        Util_Lead.carregarTipoRegistro();

        Lead lead = Teste_Util_Lead.criaLeadMercosulCUIT(Util_Lead.mercosul, '30-69465190-5');

        Util_Organizacao.buscaCEP(lead.Id, '80215-432', 'lead', '');

    }

}