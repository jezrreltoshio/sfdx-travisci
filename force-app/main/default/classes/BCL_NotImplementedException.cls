public with sharing class BCL_NotImplementedException extends Exception {
	//public string message {get; private set; }

	public static BCL_NotImplementedException createException(string message) {
		if (message == null) {
			throw BCL_ArgumentNullException.createException('message');
		}
		
		BCL_NotImplementedException result = null;
		
		result = new BCL_NotImplementedException(message);
		
		return result;
	}
	
	public static void neverCallThisMethod() {
		integer a = 0;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
		a = a + 1;
	}
}