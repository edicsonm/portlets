package au.com.billingbuddy.porlet.reports;

import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import au.com.billigbuddy.utils.BBUtils;
import au.com.billingbuddy.common.objects.ConfigurationApplication;
import au.com.billingbuddy.common.objects.ConfigurationSystem;
import au.com.billingbuddy.common.objects.Utilities;
import au.com.billingbuddy.exceptions.objects.ReporteAmountByDayException;
import au.com.billingbuddy.vo.objects.TransactionVO;

public class ReporteAmountByDay {
	
//	private static int dimensionXScreen = Integer.parseInt(ConfigurationSystem.getInstance().getKey("report.dimensionXScreen"));
//	private static int dimensionYScreen = Integer.parseInt(ConfigurationSystem.getInstance().getKey("report.dimensionYScreen"));
//	private static int adjustmentDimensionYScreen = Integer.parseInt(ConfigurationSystem.getInstance().getKey("report.adjustmentDimensionYScreen"));
	
	private int dimensionXScreen;
	private int dimensionYScreen;
	private int adjustmentDimensionYScreen;
	
//	private double initialXPositionGrahic = Integer.parseInt(ConfigurationSystem.getInstance().getKey("report.initialXPositionGrahic"));
//	private double initialYPositionGrahic = Integer.parseInt(ConfigurationSystem.getInstance().getKey("report.initialYPositionGrahic"));
	
	private double initialXPositionGrahic;
	private double initialYPositionGrahic;
	
//	private double longYGrahic = Integer.parseInt(ConfigurationSystem.getInstance().getKey("report.longYGrahic"));
	private double longYGrahic;
	
	private double escalaX;
	private double mayorY;
	private double minorY;
	private double mayorX;
	private double minorX;
	
	private static ReporteAmountByDay instance = null;
	
//	private double rightMargenReferenceLine = Integer.parseInt(ConfigurationSystem.getInstance().getKey("report.rightMargenReferenceLine"));
//	private double leftMargenReferenceLine = Integer.parseInt(ConfigurationSystem.getInstance().getKey("report.leftMargenReferenceLine"));
//	
//	private double rightMargenGrahic = Integer.parseInt(ConfigurationSystem.getInstance().getKey("report.rightMargenGrahic"));
//	private double leftMargenGrahic = Integer.parseInt(ConfigurationSystem.getInstance().getKey("report.leftMargenGrahic"));
	
	private double rightMargenReferenceLine;
	private double leftMargenReferenceLine;
	
	private double rightMargenGrahic;
	private double leftMargenGrahic;
	
//	private double scaleYFactor = initialYPositionGrahic + longYGrahic;
//	private double scaleXFactor = dimensionXScreen - (leftMargenGrahic + rightMargenGrahic);
//	
//	private double longXGrahic = dimensionXScreen-(leftMargenGrahic + rightMargenGrahic);
	
	
	private double scaleYFactor;
	private double scaleXFactor;
	private double longXGrahic;
	
	private Map<String, String> mapConfiguration;
	private StreamSource xslStream;
	
//	public static synchronized ReporteAmountByDay getInstance(Map<String, String> mapConfiguration) {
//		if (instance == null) {
//			instance = new ReporteAmountByDay(mapConfiguration);
//		}
//		return instance;
//	}
	
	public ReporteAmountByDay(StreamSource xslStream, Map<String, String> mapConfiguration) {
		this.xslStream = xslStream;
		this.mapConfiguration = mapConfiguration;
		
		dimensionXScreen = Integer.parseInt(mapConfiguration.get("report.dimensionXScreen"));
		dimensionYScreen = Integer.parseInt(mapConfiguration.get("report.dimensionYScreen"));
		adjustmentDimensionYScreen = Integer.parseInt(mapConfiguration.get("report.adjustmentDimensionYScreen"));
		
		initialXPositionGrahic = Integer.parseInt(mapConfiguration.get("report.initialXPositionGrahic"));
		initialYPositionGrahic = Integer.parseInt(mapConfiguration.get("report.initialYPositionGrahic"));
		
		longYGrahic = Integer.parseInt(mapConfiguration.get("report.longYGrahic"));
		
		rightMargenReferenceLine = Integer.parseInt(mapConfiguration.get("report.rightMargenReferenceLine"));
		leftMargenReferenceLine = Integer.parseInt(mapConfiguration.get("report.leftMargenReferenceLine"));
		
		rightMargenGrahic = Integer.parseInt(mapConfiguration.get("report.rightMargenGrahic"));
		leftMargenGrahic = Integer.parseInt(mapConfiguration.get("report.leftMargenGrahic"));
		
		scaleYFactor = initialYPositionGrahic + longYGrahic;
		scaleXFactor = dimensionXScreen - (leftMargenGrahic + rightMargenGrahic);
		
		longXGrahic = dimensionXScreen-(leftMargenGrahic + rightMargenGrahic);
		
	}
	
	public StringWriter CreateXml(ArrayList<TransactionVO> listaReport) throws ReporteAmountByDayException {
		DOMSource domSource = null;
		try {
			
			if(listaReport.size() > 0){
				TransactionVO transactionVOMAX = Collections.max(listaReport,new SortListByAmountDesc());
				TransactionVO transactionVOMIN = Collections.max(listaReport,new SortListByAmountAsc());
				mayorY = Integer.parseInt(transactionVOMAX.getAmountDateReport());
				minorY = Integer.parseInt(transactionVOMIN.getAmountDateReport());
				
				if (mayorY == minorY) minorY = 0;
				mayorX = listaReport.size() + 1;
				escalaX = longXGrahic / (listaReport.size() + 1);
				
//				System.out.println("mayorY: " +  mayorY);
//				System.out.println("minorY: " +  minorY);
//				System.out.println("mayorX: " +  mayorX);
//				System.out.println("escalaX: " +  escalaX);
//				System.out.println("scaleYFactor: " +  scaleYFactor);
//				System.out.println("scaleXFactor: " +  scaleXFactor);
//				System.out.println("longXGrahic: " + longXGrahic);
				
				DocumentBuilderFactory documentFactory = DocumentBuilderFactory.newInstance();
				DocumentBuilder documentBuilder = documentFactory.newDocumentBuilder();
	
				Document document = documentBuilder.newDocument();
				Element rootElement = document.createElement("grafica");
				document.appendChild(rootElement);
				
				double positionX = leftMargenGrahic + escalaX;
//				System.out.println("positionX: " + positionX);
				double positionY = 0;
				String path = "";
				Collections.sort(listaReport,new SortListByDate());
				for (TransactionVO transactionVO : listaReport) {
					positionY = scaleYFactor - scaleValue(longYGrahic, Double.parseDouble(transactionVO.getAmountDateReport()));
//					System.out.println("("+transactionVO.getDateReport()+" , "+transactionVO.getAmountDateReport()+") - ("+positionX+" , "+ positionY +")");
					path += "L"+positionX +","+ positionY + " ";
					
					Element point = document.createElement("point");
					rootElement.appendChild(point);
									
					Element pointx = document.createElement("pointx");
					pointx.appendChild(document.createTextNode(String.valueOf(positionX)));
					point.appendChild(pointx);
					
					Element pointxReference = document.createElement("pointxReference");
					pointxReference.appendChild(document.createTextNode(String.valueOf(positionX+10)));
					point.appendChild(pointxReference);
					
					
					Element pointy = document.createElement("pointy");
					pointy.appendChild(document.createTextNode(String.valueOf(positionY)));
					point.appendChild(pointy);
					
					Element label = document.createElement("label");
//					label.appendChild(document.createTextNode("("+transactionVO.getDateReport()+" ,"+transactionVO.getAmountDateReport()+")"));
					label.appendChild(document.createTextNode("("+transactionVO.getDateReport()+" ,"+String.valueOf(BBUtils.stripeToCurrency(String.valueOf(transactionVO.getAmountDateReport()),"AUD")) + " AUD"+")"));
					point.appendChild(label);
					
					
					
					Element date = document.createElement("date");
					date.appendChild(document.createTextNode(Utilities.formatDate(transactionVO.getDateReport(), 2, 4)));
//					date.appendChild(document.createTextNode(transactionVO.getDateReport()));
					point.appendChild(date);
					
					positionX += escalaX;
					
				}
				
				positionX -= escalaX;
				
				Element dimensionX = document.createElement("dimensionX");
				rootElement.appendChild(dimensionX);
				
				Element value = document.createElement("value");
				value.appendChild(document.createTextNode(String.valueOf(dimensionXScreen)));
				dimensionX.appendChild(value);
				
				Element dimensionY = document.createElement("dimensionY");
				rootElement.appendChild(dimensionY);
				
				value = document.createElement("value");
				value.appendChild(document.createTextNode(String.valueOf(dimensionYScreen)));
				dimensionY.appendChild(value);
				
				path = "M" + (leftMargenGrahic + escalaX)+","+scaleYFactor + " "+path + "L"+positionX+","+scaleYFactor;
				
				Element pathLinearGradient = document.createElement("pathLinearGradient");
				rootElement.appendChild(pathLinearGradient);
				value = document.createElement("value");
				value.appendChild(document.createTextNode(path));
				pathLinearGradient.appendChild(value);
				
				/* Init HighestReference */
				positionY = scaleYFactor - scaleValue(longYGrahic, mayorY);
				Element highestReference = document.createElement("highestReference");
				rootElement.appendChild(highestReference);
				
				Element firstPoint = document.createElement("firtPointHighestReference");
				firstPoint.appendChild(document.createTextNode("M" + leftMargenReferenceLine +","+ (positionY)));
				highestReference.appendChild(firstPoint);
				
				Element secondPoint = document.createElement("secondPointHighestReference");
				secondPoint.appendChild(document.createTextNode("L"+(dimensionXScreen - rightMargenReferenceLine) +","+ (positionY)));
				highestReference.appendChild(secondPoint);
	
				Element positionLabelHighestReference = document.createElement("positionLabelHighestReference");
				rootElement.appendChild(positionLabelHighestReference);
				
				value = document.createElement("X");
//				value.appendChild(document.createTextNode(String.valueOf(dimensionXScreen - rightMargenReferenceLine - 10)));
				value.appendChild(document.createTextNode(String.valueOf(dimensionXScreen - rightMargenReferenceLine)));
				positionLabelHighestReference.appendChild(value);
				
				value = document.createElement("Y");
				value.appendChild(document.createTextNode(String.valueOf(positionY - 10)));
				positionLabelHighestReference.appendChild(value);
				
				value = document.createElement("value");
				value.appendChild(document.createTextNode(String.valueOf(BBUtils.stripeToCurrency(String.valueOf(mayorY),"AUD")) + " AUD"));
				positionLabelHighestReference.appendChild(value);
				
				/* Finish HighestReference */
				
				/* Init MiddleReference */
				positionY = ((scaleYFactor - scaleValue(longYGrahic, minorY)) + (scaleYFactor - scaleValue(longYGrahic, mayorY)))/2;
				Element middleReference = document.createElement("middleReference");
				rootElement.appendChild(middleReference);
				
				firstPoint = document.createElement("firtPointMiddleReference");
				firstPoint.appendChild(document.createTextNode("M" + leftMargenReferenceLine +","+ (positionY)));
				middleReference.appendChild(firstPoint);
				
				secondPoint = document.createElement("secondPointMiddleReference");
				secondPoint.appendChild(document.createTextNode("L"+(dimensionXScreen - rightMargenReferenceLine) +","+ (positionY)));
				middleReference.appendChild(secondPoint);
				
				Element positionLabelMiddleReference = document.createElement("positionLabelMiddleReference");
				rootElement.appendChild(positionLabelMiddleReference);
				
				value = document.createElement("X");
//				value.appendChild(document.createTextNode(String.valueOf(dimensionXScreen - rightMargenReferenceLine - 10)));
				value.appendChild(document.createTextNode(String.valueOf(dimensionXScreen - rightMargenReferenceLine)));
				positionLabelMiddleReference.appendChild(value);
				
				value = document.createElement("Y");
				value.appendChild(document.createTextNode(String.valueOf(positionY - 10)));
				positionLabelMiddleReference.appendChild(value);
				
				value = document.createElement("value");
//				value.appendChild(document.createTextNode(String.valueOf((mayorY - minorY)/2)));
				value.appendChild(document.createTextNode(String.valueOf(BBUtils.stripeToCurrency(String.valueOf((mayorY - minorY)/2),"AUD")) + " AUD"));
				positionLabelMiddleReference.appendChild(value);
				
				/* Finish MiddleReference */
				
				
				/* Init LessReference */
				positionY = scaleYFactor - scaleValue(longYGrahic, minorY);
				Element lessReference = document.createElement("lessReference");
				rootElement.appendChild(lessReference);
				
				firstPoint = document.createElement("firtPointLessReference");
				firstPoint.appendChild(document.createTextNode("M" + (leftMargenReferenceLine)+","+ (positionY)));
				lessReference.appendChild(firstPoint);
				
				secondPoint = document.createElement("secondPointLessReference");
				secondPoint.appendChild(document.createTextNode("L"+(dimensionXScreen - rightMargenReferenceLine) +","+ (positionY)));
				lessReference.appendChild(secondPoint);
				
				Element positionLabelLessReference = document.createElement("positionLabelLessReference");
				rootElement.appendChild(positionLabelLessReference);
				
				value = document.createElement("X");
//				value.appendChild(document.createTextNode(String.valueOf(dimensionXScreen - rightMargenReferenceLine - 10)));
				value.appendChild(document.createTextNode(String.valueOf(dimensionXScreen - rightMargenReferenceLine)));
				positionLabelLessReference.appendChild(value);
				
				value = document.createElement("Y");
				value.appendChild(document.createTextNode(String.valueOf(positionY - 10)));
				positionLabelLessReference.appendChild(value);
				
				value = document.createElement("value");
//				value.appendChild(document.createTextNode(String.valueOf(minorY)));
				value.appendChild(document.createTextNode(String.valueOf(BBUtils.stripeToCurrency(String.valueOf(minorY),"AUD")) + " AUD"));
				positionLabelLessReference.appendChild(value);
				
				/* Finish LessReference */
				
				
				/*Init Label Creation*/
				
				Element positionLabelDate = document.createElement("positionLabelDate");
				rootElement.appendChild(positionLabelDate);
				
				value = document.createElement("X");
				value.appendChild(document.createTextNode(String.valueOf(dimensionXScreen/2)));
				positionLabelDate.appendChild(value);
				
				value = document.createElement("Y");
				value.appendChild(document.createTextNode(String.valueOf(scaleYFactor)));
				positionLabelDate.appendChild(value);
				
				value = document.createElement("value");
				value.appendChild(document.createTextNode(""));
				positionLabelDate.appendChild(value);
				
				/*Finish Label Creation*/
				
				
//				positionY = scaleYFactor - scaleValue(longYGrahic, minorY) + 20;
				positionY = scaleYFactor + 10;
				
				Element scaleXReference = document.createElement("scaleXReference");
				rootElement.appendChild(scaleXReference);
				
				value = document.createElement("value");
				value.appendChild(document.createTextNode(String.valueOf(positionY)));
				scaleXReference.appendChild(value);
				
	//			// creating and writing to xml file
				TransformerFactory transformerFactory = TransformerFactory.newInstance();
				Transformer transformer = transformerFactory.newTransformer();
	//			transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
				transformer.setOutputProperty(OutputKeys.INDENT, "yes");
				domSource = new DOMSource(document);
				
	//			printContent(domSource);
//				printDocument(domSource);
				return printDocument(domSource);
			}else{
				return new StringWriter().append("There are not information to show");
			}
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
			ReporteAmountByDayException reporteAmountByDayException = new ReporteAmountByDayException(e);
			throw reporteAmountByDayException;
		} catch (TransformerException e) {
			e.printStackTrace();
			ReporteAmountByDayException reporteAmountByDayException = new ReporteAmountByDayException(e);
			throw reporteAmountByDayException;
		}
	}
	
	public StringWriter printDocument(DOMSource source) throws TransformerConfigurationException, TransformerException {
//		String inputXSL = "file:///run/media/Edicson/SVG%20Example/ejemploGrafica/grafica.xsl";
//		StreamSource xslStream = new StreamSource(inputXSL);
		
		TransformerFactory factory = TransformerFactory.newInstance();
//		StreamSource xslStream = new StreamSource(ConfigurationSystem.getKey("urlConfigurationGraphics"));
		Transformer transformer = factory.newTransformer(xslStream);
		transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
		transformer.setOutputProperty(OutputKeys.INDENT, "yes");
		
		StringWriter sw = new StringWriter();
		StreamResult out = new StreamResult(sw);
		transformer.transform(source, out);
//		System.out.println("************************ Inicio Documento Generado ************************ ");
//		System.out.println(sw.toString());
//		System.out.println("************************ Fin Documento Generado ************************ ");
		return sw;
	}
	
	public void printContent(DOMSource source){
		try {
			System.out.println("Imprimiendo...");
			TransformerFactory transfac = TransformerFactory.newInstance();
			Transformer trans = transfac.newTransformer();
//			trans.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
			trans.setOutputProperty(OutputKeys.INDENT, "yes");
			// Print the DOM node

			StringWriter sw = new StringWriter();
			StreamResult result = new StreamResult(sw);
			
			trans.transform(source, result);
			String xmlString = sw.toString();

			System.out.println("xmlString: \n" + xmlString);
		} catch (TransformerException e) {
			e.printStackTrace();
		}
	}
	
	public double scaleValue(double dimensionScreen, double value){
		return (value * dimensionScreen)/mayorY;
	}
	
	public String transformScale(int dimensionYScreen, double valueToTransfor){
		return String.valueOf(dimensionYScreen - valueToTransfor + adjustmentDimensionYScreen);
	}
	
//	public static void main(String[] args) {
//		new ReporteAmountByDay();
//	}

	class SortListByAmountDesc implements Comparator<TransactionVO>{
		public int compare(TransactionVO transactionVOA, TransactionVO transactionVOB) {
			return Integer.parseInt(transactionVOA.getAmountDateReport()) < Integer.parseInt(transactionVOB.getAmountDateReport()) ? -1 : Integer.parseInt(transactionVOA.getAmountDateReport()) == Integer.parseInt(transactionVOB.getAmountDateReport()) ? 0 : 1;
		}
	}
	
	class SortListByAmountAsc implements Comparator<TransactionVO>{
		public int compare(TransactionVO transactionVOA, TransactionVO transactionVOB) {
			return Integer.parseInt(transactionVOA.getAmountDateReport()) > Integer.parseInt(transactionVOB.getAmountDateReport()) ? -1 : Integer.parseInt(transactionVOA.getAmountDateReport()) == Integer.parseInt(transactionVOB.getAmountDateReport()) ? 0 : 1;
		}
	}
	
	class SortListByDate implements Comparator<TransactionVO>{
		public int compare(TransactionVO transactionVOA, TransactionVO transactionVOB) {
			if(Utilities.stringToDate(transactionVOA.getDateReport(),2).compareTo(Utilities.stringToDate(transactionVOB.getDateReport(),2)) > 0){
        		return 1;
			}else if(Utilities.stringToDate(transactionVOA.getDateReport(),2).compareTo(Utilities.stringToDate(transactionVOB.getDateReport(),2)) < 0){
        		return -1; 
			
			}else if(Utilities.stringToDate(transactionVOA.getDateReport(),2).compareTo(Utilities.stringToDate(transactionVOB.getDateReport(),2)) == 0){
        		return 0;
        	}
			return 1;
		}
		
	}
	
}
