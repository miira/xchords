package cz.versarius.xchords;

import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.StringReader;
import java.io.StringWriter;
import java.io.Writer;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Source;
import javax.xml.transform.Templates;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.URIResolver;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.sax.SAXTransformerFactory;
import javax.xml.transform.sax.TransformerHandler;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

public class XML2SVG {
	private static XMLChordSaver saver = new XMLChordSaver();
	
	public Writer transform(Chord chord) {

			DocumentBuilderFactory docFactory = DocumentBuilderFactory
					.newInstance();
			DocumentBuilder docBuilder = null;
			try {
				docBuilder = docFactory.newDocumentBuilder();
			} catch (ParserConfigurationException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

			// root elements
			Document doc = docBuilder.newDocument();
			Element rootElement = doc.createElement("chord");
			rootElement.setAttribute("id", chord.getId());
			doc.appendChild(rootElement);

			saver.processChord(doc, chord, rootElement);
			
			MyResolver uriResolver = new MyResolver();
			// write the content into xml file
			SAXTransformerFactory tFactory = (SAXTransformerFactory) TransformerFactory.newInstance();
			tFactory.setURIResolver(uriResolver);
			DOMSource source = new DOMSource(doc);

			// Output to console for testing
			//StreamResult result = new StreamResult(System.out);
			
			System.out.println("meine chords1: " + doc.toString());
			
	        String outputDir = "../out/" + "g" + "/";
	        String[] paramValues = {outputDir, ".xml", ".svg", "yes", "130"}; // width matches with svgpanel on chords page
	        String[] paramNames = {"directory", "inext", "outext", "showfingers", "width" }; //, "height"
	        
	        Transformer transformer = null;
	        Transformer transformer2 = null;
	        Transformer transformer3 = null;
	        //Source xchordsSchema = null;
	        //Source xchordsDrawSchema = null;
	        String xslDir = "/xsl/";
	        //String xsdDir = "/xsd/";
	        try {
	            //transformer = tFactory.newTransformer(new StreamSource("svg2.xsl"));   //svg3.xsl
	            //xchordsSchema = new StreamSource(XML2SVG.class.getResourceAsStream(xsdDir + "xchords.xsd"));
	            //xchordsDrawSchema = new StreamSource(XML2SVG.class.getResourceAsStream(xsdDir + "xchords-draw.xsd"));
	            
	            transformer = tFactory.newTransformer(new StreamSource(XML2SVG.class.getResourceAsStream(xslDir + "xchords2draw.xsl")));   
	            transformer2 = tFactory.newTransformer(new StreamSource(XML2SVG.class.getResourceAsStream(xslDir + "xchords2draw2.xsl")));  
	            // this style should be later optional from user perspective
	            transformer3 = tFactory.newTransformer(new StreamSource(XML2SVG.class.getResourceAsStream(xslDir + "draw2svg-default.xsl")));
	            assert transformer!=null : "xchords2draw.xsl not found!";
	            assert transformer2!=null : "xchords2draw2.xsl not found!";
	            assert transformer3!=null : "draw2svg-default.xsl not found!";
	            
	        } catch (TransformerConfigurationException e) {
	            e.printStackTrace();  //To change body of catch statement use Options | File Templates.
	        }
	        for (int i = 0; i < paramNames.length; i++) {
	            transformer.setParameter(paramNames[i], // parameter name
	                    paramValues[i] );	// parameter value
	            transformer2.setParameter(paramNames[i], // parameter name
	                    paramValues[i] );	// parameter value
	            transformer3.setParameter(paramNames[i], // parameter name
	                    paramValues[i] );	// parameter value
	        }
	        try {
	        
	            /*
	             * working solution for xchords->xchords draw->svg.
	             */
	            /*File temp1 = File.createTempFile("temp1_"+chord.getName(), "xml");
	            File temp2 = File.createTempFile("temp2_"+chord.getName(), "xml");
	            StringWriter sw = new StringWriter();
	            StreamResult tempResult = new StreamResult(temp1);
	            StreamResult finalResult = new StreamResult(sw);
	            transformer.transform(source, tempResult);
	            FileReader fr = new FileReader(temp1);
	            StreamResult tempResult2 = new StreamResult(temp2);
	            transformer2.transform(new StreamSource(fr), tempResult2);
	            FileReader fr2 = new FileReader(temp2);
	            transformer3.transform(new StreamSource(fr2), finalResult);
	            
	            temp1.delete();
	            temp2.delete();
				*/
	        	// without files on the disk
	        	StringWriter sw1 = new StringWriter();
	        	transformer.transform(source, new StreamResult(sw1));
	        	StringWriter sw2 = new StringWriter();
	        	transformer2.transform(new StreamSource(new StringReader(sw1.toString())), new StreamResult(sw2));
	        	StringWriter sw3 = new StringWriter();
	        	transformer3.transform(new StreamSource(new StringReader(sw2.toString())), new StreamResult(sw3));
	        	
	        	System.out.println("---------------------------------");
	        	printDocument(doc, System.out);
	        	System.out.println("source: " + chord.toJson());
	        	System.out.println("draw1:" + sw1.toString());
	        	System.out.println("draw:" + sw2.toString());
	        	System.out.println("svg: " + sw3.toString());
				return sw3;
	            
	        } catch (TransformerException e) {
	            e.printStackTrace();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
		        
		    return null;
	}
	
	public static void printDocument(Document doc, OutputStream out) throws IOException, TransformerException {
	    TransformerFactory tf = TransformerFactory.newInstance();
	    Transformer transformer = tf.newTransformer();
	    transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "no");
	    transformer.setOutputProperty(OutputKeys.METHOD, "xml");
	    transformer.setOutputProperty(OutputKeys.INDENT, "yes");
	    transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
	    transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "4");

	    transformer.transform(new DOMSource(doc), 
	         new StreamResult(new OutputStreamWriter(out, "UTF-8")));
	}
	
	/** attempt through sax chained transformers. doesn't work */
	private Writer transform2(Chord chord) {
		DocumentBuilderFactory docFactory = DocumentBuilderFactory
				.newInstance();
		DocumentBuilder docBuilder = null;
		try {
			docBuilder = docFactory.newDocumentBuilder();
		} catch (ParserConfigurationException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		// root elements
		Document doc = docBuilder.newDocument();
		Element rootElement = doc.createElement("chord");
		doc.appendChild(rootElement);

		saver.processChord(doc, chord, rootElement);
		
		MyResolver uriResolver = new MyResolver();
		// write the content into xml file
		SAXTransformerFactory tFactory = (SAXTransformerFactory) TransformerFactory.newInstance();
		tFactory.setURIResolver(uriResolver);
		DOMSource source = new DOMSource(doc);

		// Output to console for testing
		//StreamResult result = new StreamResult(System.out);
		
		System.out.println("meine chords1: " + doc.toString());
		
        String outputDir = "../out/" + "g" + "/";
        String[] paramValues = {outputDir, ".xml", ".svg", "yes", "220", "230"};
        String[] paramNames = {"directory", "inext", "outext", "showfingers", "width", "height"};
        
        Transformer transformer = null;
        Transformer transformer2 = null;
        Transformer transformer3 = null;
        //Source xchordsSchema = null;
        //Source xchordsDrawSchema = null;
        String xslDir = "/xsl/";
        //String xsdDir = "/xsd/";
        try {
            //transformer = tFactory.newTransformer(new StreamSource("svg2.xsl"));   //svg3.xsl
            //xchordsSchema = new StreamSource(XML2SVG.class.getResourceAsStream(xsdDir + "xchords.xsd"));
            //xchordsDrawSchema = new StreamSource(XML2SVG.class.getResourceAsStream(xsdDir + "xchords-draw.xsd"));
            
            transformer = tFactory.newTransformer(new StreamSource(XML2SVG.class.getResourceAsStream(xslDir + "xchords2draw.xsl")));   
            transformer2 = tFactory.newTransformer(new StreamSource(XML2SVG.class.getResourceAsStream(xslDir + "xchords2draw2.xsl")));  
            // this style should be later optional from user perspective
            transformer3 = tFactory.newTransformer(new StreamSource(XML2SVG.class.getResourceAsStream(xslDir + "draw2svg-default.xsl")));
            assert transformer!=null : "xchords2draw.xsl not found!";
            assert transformer2!=null : "xchords2draw2.xsl not found!";
            assert transformer3!=null : "draw2svg-default.xsl not found!";
            
        } catch (TransformerConfigurationException e) {
            e.printStackTrace();  //To change body of catch statement use Options | File Templates.
        }
        for (int i = 0; i < paramNames.length; i++) {
            transformer.setParameter(paramNames[i], // parameter name
                    paramValues[i] );	// parameter value
            transformer2.setParameter(paramNames[i], // parameter name
                    paramValues[i] );	// parameter value
            transformer3.setParameter(paramNames[i], // parameter name
                    paramValues[i] );	// parameter value
        }
        try {
        
            /*
             * working solution for xchords->xchords draw->svg.
             */
            /*
            File temp1 = File.createTempFile("temp1_"+chord.getName(), "xml");
            File temp2 = File.createTempFile("temp2_"+chord.getName(), "xml");
            StringWriter sw = new StringWriter();
            StreamResult tempResult = new StreamResult(temp1);
            StreamResult finalResult = new StreamResult(sw);
            transformer.transform(source, tempResult);
            FileReader fr = new FileReader(temp1);
            StreamResult tempResult2 = new StreamResult(temp2);
            transformer2.transform(new StreamSource(fr), tempResult2);
            FileReader fr2 = new FileReader(temp2);
            transformer3.transform(new StreamSource(fr2), finalResult);
            
            temp1.delete();
            temp2.delete();
            */
        	// filter chaining
        	/*
        	XMLFilter filter1 = tFactory.newXMLFilter(new StreamSource(XML2SVG.class.getResourceAsStream(xslDir + "xchords2draw.xsl")));
        	XMLFilter filter2 = tFactory.newXMLFilter(new StreamSource(XML2SVG.class.getResourceAsStream(xslDir + "xchords2draw2.xsl")));
        	XMLFilter filter3 = tFactory.newXMLFilter(new StreamSource(XML2SVG.class.getResourceAsStream(xslDir + "draw2svg-default.xsl")));
            
        	SAXParserFactory spf = SAXParserFactory.newInstance();
        	spf.setNamespaceAware(true);
            SAXParser parser = spf.newSAXParser();
            XMLReader reader = parser.getXMLReader();
        	filter1.setParent(reader);
        	*/
        	SAXTransformerFactory stf = (SAXTransformerFactory)TransformerFactory.newInstance();
        	// These templates objects could be reused and obtained from elsewhere.
        	//Templates template = stf.newTemplates(
        		//	uriResolver.resolve("draw2svg.xsl", null));
        	stf.setURIResolver(uriResolver);
        	
        	Templates template1 = stf.newTemplates(
        			new StreamSource(XML2SVG.class.getResourceAsStream(xslDir + "xchords2draw.xsl")));
        	Templates template2 = stf.newTemplates(
        			new StreamSource(XML2SVG.class.getResourceAsStream(xslDir + "xchords2draw.xsl")));
        	Templates template3 = stf.newTemplates(
        			new StreamSource(XML2SVG.class.getResourceAsStream(xslDir + "draw2svg-default.xsl")));
        	
        	TransformerHandler th1 = stf.newTransformerHandler(template1);
        	TransformerHandler th2 = stf.newTransformerHandler(template2);
        	TransformerHandler th3 = stf.newTransformerHandler(template3);
        	th1.setResult(new SAXResult(th2));
        	th2.setResult(new SAXResult(th3));
        	StringWriter sw = new StringWriter();
        	th3.setResult(new StreamResult(sw));

        	DOMSource domSource = new DOMSource(doc);
        	TransformerFactory tf = TransformerFactory.newInstance();
        	tf.setURIResolver(uriResolver);
        	Transformer bt = tf.newTransformer();
        	bt.transform(domSource, new SAXResult(th1));
        	
        	//StringReader sr = new StringReader(doc.toString());
        	//Transformer t = stf.newTransformer();
        	//t.transform(new StreamSource(sr), new SAXResult(th1));

        	// th1 feeds th2, which in turn feeds System.out.
        	//
            // working solution for xchords draw->svg
            //
             
           // StreamResult finalResult = new StreamResult(response.getOutputStream());
           // transformer3.transform(new DOMSource(document), finalResult);
           
            System.out.println("meine chords: " + sw.toString());
			System.out.println("ende scheise");
			return sw;
            
        } catch (TransformerException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
	        
	    return null;
	}
	
	class MyResolver implements URIResolver {
		public Source resolve(String href, String base) {
			System.out.println("uri resolver: " + href);
			return new StreamSource(XML2SVG.class.getResourceAsStream("/xsl/"+ href));
		}
	}
}
