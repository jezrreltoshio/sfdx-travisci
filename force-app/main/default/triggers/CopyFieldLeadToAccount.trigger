/**
 * [STI 85892] - Novos campos objeto LEADs e CONTA.
 * @author Bruno B. Affonso <bruno.bonfim@sascar.com.br>
 * @sinze 20/08/2015
 */
trigger CopyFieldLeadToAccount on Lead (after update){
    CopyFieldLeadToAccount.copyFieldLeadToAccount(Trigger.old[0], Trigger.new[0]);
}