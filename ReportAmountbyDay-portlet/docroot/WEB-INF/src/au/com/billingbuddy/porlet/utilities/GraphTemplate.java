package au.com.billingbuddy.porlet.utilities;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;

public class GraphTemplate {
	
	private static ResourceBundle resourceBundle = ResourceBundle.getBundle("graphTemplate.GraphTemplate");
	private static Map<String, String> map = convertResourceBundleToMap(resourceBundle);
	private static GraphTemplate instance = null;
	
	public static GraphTemplate getInstance() {
		if (instance == null) {
			instance = new GraphTemplate();
		}
		return instance;
	}
	
	public static String getKey(String key){
		return resourceBundle.getString(key);
	}
	
	
	public static Map<String, String> getMap(){
		return map;
	}
		
	private GraphTemplate(){
		
	} 
	
	static Map<String, String> convertResourceBundleToMap(ResourceBundle resource) {
		Map<String, String> map = new HashMap<String, String>();

		Enumeration<String> keys = resource.getKeys();
		while (keys.hasMoreElements()) {
			String key = keys.nextElement();
			map.put(key, resource.getString(key));
		}
		return map;
	}
	
	
}
