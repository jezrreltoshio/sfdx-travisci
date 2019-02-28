trigger SetAddressInEvent on Event (after insert, before update) {
	Event ev = Trigger.new[0];        
	EventTriggers.setAddress(ev);    
}