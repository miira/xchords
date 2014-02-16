package cz.versarius.xchords;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

public class XMLSaver {
	
	protected Element buildContainer(Document doc, String name, Element parent) {
		Element child = doc.createElement(name);
		// more .. attributes...
		parent.appendChild(child);
		return child;
	}

	protected Element buildTextNode(Document doc, String name, String value, Element parent) {
		Element child = doc.createElement(name);
		child.appendChild(doc.createTextNode((value == null)?"":value));
		parent.appendChild(child);
		return child;
	}
}
