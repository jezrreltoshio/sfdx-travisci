/**
 * [MANTIS 7650] - ERRO AO SINCRONIZAR CONTA
 * Remove os espaços em brancos dos campos, pois ao enviar com o espaço em branco, o WS_Salesforce
 * retorna o seguinte erro: [-1400] String is not in UTF-8. Trigger executada before insert, before update.
 * @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
 * @sinze 05/10/2015
 */
trigger Account_CleanBlankSpaceFields on Account (before insert, before update){
    AccountCleanBlankSpaceFields.cleanBlankSpaceFields(Trigger.new[0]);
}