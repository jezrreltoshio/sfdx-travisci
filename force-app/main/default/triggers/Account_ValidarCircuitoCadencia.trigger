trigger Account_ValidarCircuitoCadencia on Account (before insert, before update) {
    String userRoleId = UserInfo.getUserRoleId();
    
    system.debug('begin - trigger Account_ValidarCircuitoCadencia');
    system.debug('listAcc: '+Trigger.new);
    system.debug('getUserRoleId: '+userRoleId);
    
    AccountTriggers.validarCircuitoCadencia(Trigger.new, userRoleId);
    
    system.debug('end - trigger Account_ValidarCircuitoCadencia');    
}