({
	doInit : function(cmp, event, helper) {
        var action = cmp.get("c.getOS");

        action.setParams({  idOS: cmp.get("v.recordId") });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                cmp.set("v.os", response.getReturnValue());
                console.log(response.getReturnValue());
            }
         });
         $A.enqueueAction(action);
    }     
})