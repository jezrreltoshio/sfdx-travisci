/*
    Classe de testes para a Classe "Util_Validacoes"

    Criado por: Mario Reis
    Data: 27/11/2017

*/
@isTest
public class Teste_Util_Validacoes {

    // Validação do CUIT para Argentina
    static testmethod void testeValidarCUIT() {

        // CUIT vazio
        Util_Validacoes.validarCUIT('');

        // CUIT zerado inválido
        Util_Validacoes.validarCUIT('00000000000');

        // CUIT correto
        Util_Validacoes.validarCUIT('30-66058049-9');

        // CUIT com final 0
        Util_Validacoes.validarCUIT('30-68563505-0');

        // Erro
        Util_Validacoes.validarCUIT('30-66058049-A');

    } // Fim testeValidarCUIT



    // Validação do CPF
    static testmethod void testeValidarCPF() {

        // CPF vazio
        Util_Validacoes.validarCPF('');

        // CPFs inválidos
        Util_Validacoes.validarCPF('00000000000');
        Util_Validacoes.validarCPF('11111111111');
        Util_Validacoes.validarCPF('22222222222');
        Util_Validacoes.validarCPF('33333333333');
        Util_Validacoes.validarCPF('44444444444');
        Util_Validacoes.validarCPF('55555555555');
        Util_Validacoes.validarCPF('66666666666');
        Util_Validacoes.validarCPF('77777777777');
        Util_Validacoes.validarCPF('88888888888');
        Util_Validacoes.validarCPF('99999999999');

        // CPF correto
        Util_Validacoes.validarCPF('675.637.136-38');

        // CPF incorreto
        Util_Validacoes.validarCPF('675.637.136-AA');

        // CPF para erro
        Util_Validacoes.validarCPF('AAAAAAAAAAA');

    } // Fim testeValidarCPF



    // Validação do CNPJ
    static testmethod void testeValidarCNPJ() {

        // CNPJ vazio
        Util_Validacoes.validarCNPJ('');

        // CNPJs inválidos
        Util_Validacoes.validarCNPJ('00000000000000');
        Util_Validacoes.validarCNPJ('11111111111111');
        Util_Validacoes.validarCNPJ('22222222222222');
        Util_Validacoes.validarCNPJ('33333333333333');
        Util_Validacoes.validarCNPJ('44444444444444');
        Util_Validacoes.validarCNPJ('55555555555555');
        Util_Validacoes.validarCNPJ('66666666666666');
        Util_Validacoes.validarCNPJ('77777777777777');
        Util_Validacoes.validarCNPJ('88888888888888');
        Util_Validacoes.validarCNPJ('99999999999999');

        // CNPJ correto
        Util_Validacoes.validarCNPJ('31.254.806/0001-30');
        Util_Validacoes.validarCNPJ('07.961.810/0001-53');
        Util_Validacoes.validarCNPJ('54.510.229/0001-03');

        // CNPJ incorreto
        Util_Validacoes.validarCNPJ('31.254.806/0001-AA');

        // CNPJ para erro
        Util_Validacoes.validarCNPJ('AAAAAAAAAAAAAA');

    } // Fim testeValidarCNPJ



}