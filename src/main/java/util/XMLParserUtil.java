package util;

import java.util.HashMap;
import java.util.Map;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;
import com.thoughtworks.xstream.io.xml.StaxDriver;


/**
 *
 * @author serge
 */
public class XMLParserUtil {
	//private	static XStream xstream = new XStream(new StaxDriver());
	private	static XStream xstream = new XStream(new DomDriver("UTF-8"));
	
	@SuppressWarnings("rawtypes")
	public static String write(Object o, HashMap<String, Class> aliases) { //, HashMap<String, Class> collections) {
    	xstream = new XStream(new StaxDriver());
    	for (Map.Entry<String,Class> alias : aliases.entrySet()) { 	
    		xstream.alias(alias.getKey(), alias.getValue());
    	}
    	return xstream.toXML(o);
   }

	@SuppressWarnings("rawtypes")
	public static Object read(String xml, HashMap<String, Class> aliases) { //, HashMap<String, Class> collections) {
    	
    	for (Map.Entry<String,Class> alias : aliases.entrySet()) { 	
    		xstream.alias(alias.getKey(), alias.getValue());
    	}
    	return xstream.fromXML(xml);
   }

}