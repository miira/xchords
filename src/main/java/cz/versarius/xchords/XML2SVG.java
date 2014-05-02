package cz.versarius.xchords;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.InputStream;
import java.io.StringWriter;
import java.io.Writer;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.URIResolver;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.sax.SAXTransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.xml.sax.XMLFilter;

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
			doc.appendChild(rootElement);

			saver.processChord(doc, chord, rootElement);
			
			// write the content into xml file
			SAXTransformerFactory tFactory = (SAXTransformerFactory) TransformerFactory.newInstance();
			tFactory.setURIResolver(new MyResolver());
			DOMSource source = new DOMSource(doc);
			StringWriter sw = new StringWriter();

			// Output to console for testing
			//StreamResult result = new StreamResult(System.out);

			System.out.println("meine chords1: " + source.toString());
			
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
	            
	            File temp1 = File.createTempFile("temp1_"+chord.getName(), "xml");
	            File temp2 = File.createTempFile("temp2_"+chord.getName(), "xml");
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
	            
	        	// filter chaining
	        	/*
	        	XMLFilter filter1 = tFactory.newXMLFilter(new StreamSource(XML2SVG.class.getResourceAsStream(xslDir + "xchords2draw.xsl")));
	        	XMLFilter filter2 = tFactory.newXMLFilter(new StreamSource(XML2SVG.class.getResourceAsStream(xslDir + "xchords2draw2.xsl")));
	        	XMLFilter filter3 = tFactory.newXMLFilter(new StreamSource(XML2SVG.class.getResourceAsStream(xslDir + "draw2svg-default.xsl")));
	            
	        	filter1.setParent(arg0);
	        	*/
	        	//
	            // working solution for xchords draw->svg
	            //
	             
	           // StreamResult finalResult = new StreamResult(response.getOutputStream());
	           // transformer3.transform(new DOMSource(document), finalResult);
	           
	            System.out.println("meine chords: " + sw.toString());
				System.out.println("ende scheise");
				return finalResult.getWriter();
	            
	        } catch (TransformerException e) {
	            e.printStackTrace();
	        } catch (FileNotFoundException e) {
	            e.printStackTrace();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
		        
		    return null;
	}
	
	class MyResolver implements URIResolver {
		public Source resolve(String href, String base) {
			return new StreamSource(XML2SVG.class.getResourceAsStream("/xsl/"+ href));
		}
	}
}
