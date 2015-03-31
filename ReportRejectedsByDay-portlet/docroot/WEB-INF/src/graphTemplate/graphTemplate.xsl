<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes">
<xsl:template match="/">
<xsl:variable name="space" select="' '"/>
<xsl:variable name="valueX" select="grafica/dimensionX/value"/>
<xsl:variable name="valueY" select="grafica/dimensionY/value"/>
<xsl:variable name="scaleXReference" select="grafica/scaleXReference/value"/>
<svg id="graphic_" height="{$valueY}" width="{$valueX}" version="1.1" xmlns="http://www.w3.org/2000/svg" style="overflow: hidden; position: relative;">
	<xsl:variable name="value" select="grafica/pathLinearGradient"/>
	<path class="pathGraphic" fill="url(#grad01)" d="{$value}"/>
	<defs>
		<linearGradient id="grad01" x1="150" y1="350.0" x2="600" y2="350.0" gradientTransform="matrix(1,0,0,1,0,0)">
			<stop offset="5%" stop-color="#cadaef"/>
			<stop offset="90%" stop-color="#ffffff"/>
		</linearGradient>
	</defs>

<!-- <rect width="600" height="300" style="fill:none;stroke-width:3;stroke:rgb(0,0,0)"/>-->

	<xsl:variable name="punt">
		 <xsl:for-each select="grafica/point">
		        <xsl:value-of select="pointx"/>,<xsl:value-of select="pointy"/><xsl:value-of select="$space"/>
			<xsl:variable name="pointx" select="pointx"/>
			<xsl:variable name="pointy" select="pointy"/>
			<circle id="greencircle" cx="{$pointx}" cy="{$pointy}" r="5"/>
		 </xsl:for-each>
	</xsl:variable>

	<polyline points = "{$punt}" fill = "none" stroke = "#4cabe2" stroke-width="2" stroke-opacity="49.95" fill-opacity="1"/>			
	 
	<xsl:for-each select="grafica/point">
		<xsl:variable name="pointx" select="pointx"/>
		<xsl:variable name="pointxReference" select="pointxReference"/>
		<xsl:variable name="pointy" select="pointy"/>				
		<xsl:variable name="label" select="label"/>
		<circle title="{$label}" id="greencircle" cx="{$pointx}" cy="{$pointy}" r="4">
			<tspan title="{$label}" dx="-10" dy="0">InfoYY</tspan>
		</circle>

		<!--<circle title="{$label}" id="greencircle" cx="{$pointx}" cy="300" r="5">
			<tspan title="{$label}" dx="-10" dy="0">InfoYY</tspan>
		</circle>-->

		<text class="labelPoint" x="{$pointxReference}" y="{$scaleXReference}" text-anchor="end" stroke="none">
			<tspan><xsl:value-of select="date"/></tspan>
		</text>

	 </xsl:for-each>

	
	<xsl:variable name="firtPointHighestReference" select="grafica/highestReference"/>
	<xsl:variable name="secondPointHighestReference" select="grafica/highestReference"/>
	<xsl:variable name="XPositionLabelHighestReference" select="grafica/positionLabelHighestReference/X"/>
	<xsl:variable name="YPositionLabelHighestReference" select="grafica/positionLabelHighestReference/Y"/>

	<path class="pathReferences" d="{$firtPointHighestReference} {$secondPointHighestReference}" stroke-width="1" stroke-opacity="0.06"/>
	<text class="labelPoint" x="{$XPositionLabelHighestReference}" y="{$YPositionLabelHighestReference}" text-anchor="end" stroke="none">
		<tspan><xsl:value-of select="grafica/positionLabelHighestReference/value"/></tspan>
	</text>


	<xsl:variable name="firtPointMiddleReference" select="grafica/middleReference"/>
	<xsl:variable name="secondPointMiddleReference" select="grafica/middleReference"/>
	<xsl:variable name="XPositionLabelMiddleReference" select="grafica/positionLabelMiddleReference/X"/>
	<xsl:variable name="YPositionLabelMiddleReference" select="grafica/positionLabelMiddleReference/Y"/>


	<path class="pathReferences" d="{$firtPointMiddleReference} {$secondPointMiddleReference}" stroke-width="1" stroke-opacity="0.06"/>
	<text class="labelPoint" x="{$XPositionLabelMiddleReference}" y="{$YPositionLabelMiddleReference}" text-anchor="end" stroke="none">
		<tspan><xsl:value-of select="grafica/positionLabelMiddleReference/value"/></tspan>
	</text>

	<xsl:variable name="firtPointLessReference" select="grafica/lessReference"/>
	<xsl:variable name="secondPointLessReference" select="grafica/lessReference"/>
	<xsl:variable name="XPositionLabelLessReference" select="grafica/positionLabelLessReference/X"/>
	<xsl:variable name="YPositionLabelLessReference" select="grafica/positionLabelLessReference/Y"/>
	<path class="pathReferences" d="{$firtPointLessReference} {$secondPointLessReference}" stroke-width="1" stroke-opacity="0.06"/>
	<text class="labelPoint" x="{$XPositionLabelLessReference}" y="{$YPositionLabelLessReference}" text-anchor="end" stroke="none">
		<tspan><xsl:value-of select="grafica/positionLabelLessReference/value"/></tspan>
	</text>

	
	<xsl:variable name="XPositionLabelDate" select="grafica/positionLabelDate/X"/>
	<xsl:variable name="YPositionLabelDate" select="grafica/positionLabelDate/Y"/>
	<text class="labelPoint" x="{$XPositionLabelDate}" y="{$YPositionLabelDate}" text-anchor="end" stroke="none">
		<tspan><xsl:value-of select="grafica/positionLabelDate/value"/></tspan>
	</text>

</svg>


</xsl:template>
</xsl:stylesheet>
