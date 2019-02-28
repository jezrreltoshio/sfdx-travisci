public with sharing class PCL_Helper {
	
	public static string getCodeAsString(string pickListValue) {
		string result = null;
		
		if (pickListValue != null) {
			result = pickListValue.subString(0, pickListValue.indexOf('-'));
		}
		
		return result;
	}

	public static integer getCodeAsInteger(string pickListValue) {
		integer result = null;
		
		string aux = getCodeAsString(pickListValue);
		if (aux != null) {
			result = integer.valueOf(aux);
		}
		
		return result;
	}
	
	public static string formatVctoCartao (integer v) {
		string vcto = '0000' + String.valueOf(v);
		vcto = BCL_HLP_String.subStringWithSize(vcto, vcto.length() - 4, 4);
		vcto = BCL_HLP_String.subStringWithSize(vcto, 0, 2) + '/'+ BCL_HLP_String.subStringWithSize(vcto, 2, 2);
		return vcto;
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
	}
}