/*
    Classe de teste: Teste_DAO_Direcionamento_OS
    Criado por: Mario Reis
    Data de criação: 16/04/2018
    Descrição: Classe DAO para o objeto: Direcionamento_os__c
    ---------------------------------
    @author Renan Rocha
    @date 07/01/2019
    @description:
        - Classe refatorada
        - Novos debugs inseridos
        - Criado método getQueryBatch
        - Método getUsuariosSelecionados direcionado para classe DAO_Atendente_Direcionamento_OS e referências corrigidas
        - Métodos getListaUserDisponivel e getListaUser direcionados para classe DAO_Usuario e referências corrigidas
        - Método getListaTipoOS direcionado para classe DAO_Tipo_OS e referências corrigidas
        - Método getListaTipoContrato direcionado para classe DAO_TipoContrato e referências corrigidas
        - Método getListaStatusOS direcionado para classe DAO_Status_OS e referências corrigidas
        - Método getListaTipoItemOS direcionado para classe DAO_Tipo_Item_OS e referências corrigidas
        - Métodos getListaOS, filtrarConsultaPorQuantidadeOS, getListaOsByUser, getMapClienteAtd e getAtdQtd direcionado para classe DAO_Ordem_Servico e referências corrigidas
    @JIRA KCA-59
*/
public class DAO_Direcionamento_OS {

    private static String CLASS_NAME = 'DAO_Direcionamento_OS';

    // Método que retorna o direcionamento de OS pelo Id
    public static Direcionamento_os__c getDirecionamentoOsById(String idRegistro){
        String METHOD_NAME = 'getDirecionamentoOsById';

        System.debug(LoggingLevel.ERROR, '___ [cls '+ CLASS_NAME +' - '+ METHOD_NAME +'()] - idRegistro: '+ idRegistro);

        return
            [SELECT Id
                  , Agendamento_proximo_contato__c
                  , Aging_final__c
                  , Aging_inicial__c
                  , Classe__c
                  , Cliente__c
                  , Cliente_KA__c
                  , Contato_fora_faixa__c
                  , CreatedDate 
                  , Data_agendamento_final__c
                  , Data_agendamento_inicial__c
                  , Item__c
                  , Motivo__c
                  , Motivo_noshow__c
                  , Name
                  , Numero_OS__c
                  , OS_com_agendamento__c
                  , OS_sem_agendamento__c
                  , OS_sem_agendamento_aging_85_dias__c
                  , OS_sem_direcionamento__c
                  , OS_sem_servico__c
                  , Owner.Id
                  , Owner.Name
                  , Quantidade_OS__c
                  , Regiao_comercial__c
                  , Status_OS__c
                  , Tipo_contrato__c
                  , Tipo_OS__c
                  , Tipo_OS_macro__c
                  , Tipo_OS_micro__c
                  , Ultima_acao_OS__c
                  , (SELECT Id
                          , Usuario__c 
                    FROM Atendentes_Direcionamento_OS__r)
            FROM Direcionamento_os__c 
            WHERE Id =: idRegistro];
    } // Fim método getDirecionamentoOsById

    // Método que retorna todos os Direcionamentos de OS por usuário
    public static List<Direcionamento_os__c> getListaDirecionamentoOS(){
        String METHOD_NAME = 'getListaDirecionamentoOS';

        return
            [SELECT Id
                  , Agendamento_proximo_contato__c
                  , Aging_final__c
                  , Aging_inicial__c
                  , Classe__c
                  , Cliente__c
                  , Cliente_KA__c
                  , Contato_fora_faixa__c
                  , CreatedDate 
                  , Data_agendamento_final__c
                  , Data_agendamento_inicial__c
                  , Item__c
                  , Motivo__c
                  , Motivo_noshow__c
                  , Name
                  , Numero_OS__c
                  , OS_com_agendamento__c
                  , OS_sem_agendamento__c
                  , OS_sem_agendamento_aging_85_dias__c
                  , OS_sem_direcionamento__c
                  , OS_sem_servico__c
                  , Owner.Id
                  , Owner.Name
                  , Quantidade_OS__c
                  , Regiao_comercial__c
                  , Status_OS__c
                  , Tipo_contrato__c
                  , Tipo_OS__c
                  , Tipo_OS_macro__c
                  , Tipo_OS_micro__c
                  , Ultima_acao_OS__c
            FROM Direcionamento_os__c 
            WHERE Quantidade_OS__c > 0
            OR Quantidade_OS__c = 0 
            OR Quantidade_OS__c = NULL
            ORDER BY CreatedDate ASC];
    } // Fim método getListaDirecionamentoOS

    /*
        @description Retorna uma string com a query que será utilizada na Batch: Direcionamento_OS_Batch
        @param 
        @return String
        
        @author Renan Rocha
        @date 07/01/2019
        @JIRA KCA-59
    */
    public static String getQueryBatch(){
        String METHOD_NAME = 'getQueryBatch';
        
        return
            'SELECT Id'+
                  ', Agendamento_proximo_contato__c'+
                  ', Aging_final__c'+
                  ', Aging_inicial__c'+
                  ', Classe__c'+
                  ', Cliente__c'+
                  ', Cliente_KA__c'+
                  ', Contato_fora_faixa__c'+
                  ', CreatedDate'+
                  ', Data_agendamento_final__c'+
                  ', Data_agendamento_inicial__c'+
                  ', Item__c'+
                  ', Motivo__c'+
                  ', Motivo_noshow__c'+
                  ', Name'+
                  ', Numero_OS__c'+
                  ', OS_com_agendamento__c'+
                  ', OS_sem_agendamento__c'+
                  ', OS_sem_agendamento_aging_85_dias__c'+
                  ', OS_sem_direcionamento__c'+
                  ', OS_sem_servico__c'+
                  ', Owner.Id'+
                  ', Owner.Name'+
                  ', Quantidade_OS__c'+
                  ', Regiao_comercial__c'+
                  ', Status_OS__c'+
                  ', Tipo_contrato__c'+
                  ', Tipo_OS__c'+
                  ', Tipo_OS_macro__c'+
                  ', Tipo_OS_micro__c'+
                  ', Ultima_acao_OS__c'+
            ' FROM Direcionamento_os__c'+
            ' ORDER BY CreatedDate ASC';
    }
}