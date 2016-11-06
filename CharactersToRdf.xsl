<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE RDF [
            <!ENTITY wc "http://www.iro.umontreal.ca/lapalme/WineCatalog#" >
            <!ENTITY cb "http://www.iro.umontreal.ca/lapalme/CellarBook" >
            <!ENTITY tp2 "http://www-etud.iro.umontreal.ca/~gauthif/ift6282/tp2#" >
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:gauthif="http://www-etud.iro.umontreal.ca/~gauthif#"
    xmlns:tp2="http://www-etud.iro.umontreal.ca/~gauthif/ift6282/tp2#"
    xmlns:dc="http://www-etud.iro.umontreal.ca/~gauthif/ift6282/tp2/dc#"
    xmlns:marvel="http://www-etud.iro.umontreal.ca/~gauthif/ift6282/marvel#"
    xml:base="http://www-etud.iro.umontreal.ca/~gauthif/ift6282/tp2"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="/">
        
        <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
            xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
            xmlns:gauthif="http://www-etud.iro.umontreal.ca/~gauthif#"
            xmlns:tp2="http://www-etud.iro.umontreal.ca/~gauthif/ift6282/tp2#"
            xmlns:dc="http://www-etud.iro.umontreal.ca/~gauthif/ift6282/tp2/dc#"
            xmlns:marvel="http://www-etud.iro.umontreal.ca/~gauthif/ift6282/marvel#"
            xml:base="http://www-etud.iro.umontreal.ca/~gauthif/ift6282/tp2">
            <xsl:apply-templates/>
        </rdf:RDF>
 
    </xsl:template>

    <xsl:template match="Characters">
        <xsl:apply-templates select="DC"/>
    </xsl:template>
    
    <xsl:template match="DC">
        <xsl:apply-templates select="character"/>
    </xsl:template>
    
    <xsl:template match="character">
        <xsl:variable name="alias">
            <xsl:value-of select="superHeroAlias"/>
        </xsl:variable>
        <rdf:Description rdf:about="&tp2;{$alias}">
            <tp2:characterOf>
                <xsl:text>DC Comics</xsl:text>
            </tp2:characterOf>
        </rdf:Description>
        <rdf:Description rdf:about="&tp2;{$alias}">
            <tp2:superHeroAlias>
                <xsl:value-of select="superHeroAlias"/>
            </tp2:superHeroAlias>
        </rdf:Description>
        
        <xsl:apply-templates select="realName"></xsl:apply-templates>
        <xsl:apply-templates select="otherAliases"></xsl:apply-templates>
        <xsl:apply-templates select="relatives"></xsl:apply-templates>
        <xsl:apply-templates select="affiliation"></xsl:apply-templates>
        <xsl:apply-templates select="baseOfOperation"></xsl:apply-templates>
        <xsl:apply-templates select="status"></xsl:apply-templates>
        <xsl:apply-templates select="characteristics"></xsl:apply-templates>
        <xsl:apply-templates select="origin"></xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="realName">
        <xsl:variable name="alias">
            <xsl:value-of select="../superHeroAlias"/>
        </xsl:variable>
        <rdf:Description rdf:about="&tp2;{$alias}">
            <tp2:realName>
                <xsl:value-of select="."/>
            </tp2:realName>
        </rdf:Description>
    </xsl:template>
    
    <xsl:template match="otherAliases">
        <xsl:variable name="alias">
            <xsl:value-of select="../superHeroAlias"/>
        </xsl:variable>
        <rdf:Description rdf:about="&tp2;{$alias}">
            <tp2:otherAliases>
                <rdf:Bag>
                    <xsl:apply-templates select="child::node()"></xsl:apply-templates>
                </rdf:Bag>
            </tp2:otherAliases>
        </rdf:Description>
    </xsl:template>
    
    <xsl:template match="relatives">
        <xsl:apply-templates select="child::node()"/>
    </xsl:template>
    
    <xsl:template match="relative">
        <xsl:variable name="alias">
            <xsl:value-of select="../../superHeroAlias"/>
        </xsl:variable>
        <xsl:variable name="relativ">
            <xsl:value-of select="."/>
        </xsl:variable>
        
        <rdf:Description rdf:about="&tp2;{$alias}">    
            <tp2:relative rdf:resource="&tp2;{$relativ}">
           </tp2:relative>
        </rdf:Description>
        <xsl:if test="@deceased='yes'">
            <xsl:variable name="deceased">
                <xsl:value-of select="@deceased"/>
            </xsl:variable>
            <rdf:Description rdf:about="&tp2;{$relativ}">
                <tp2:deceased rdf:resource="&tp2;{$deceased}">
                </tp2:deceased>
            </rdf:Description>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="alias|location">
        <xsl:variable name="info">
            <xsl:value-of select="."/>
        </xsl:variable>
        <rdf:li rdf:resource="&tp2;{$info}">
        </rdf:li>
    </xsl:template>
    
    <xsl:template match="affiliation">
        <xsl:variable name="alias">
            <xsl:value-of select="../superHeroAlias"/>
        </xsl:variable>
        <rdf:Description rdf:about="&tp2;{$alias}">    
            <xsl:apply-templates select="group"></xsl:apply-templates>           
        </rdf:Description>
    </xsl:template>
    
    <xsl:template match="group">
        <xsl:variable name="info">
            <xsl:value-of select="."/>
        </xsl:variable>
        <tp2:memberOf rdf:resource="&tp2;{$info}">
        </tp2:memberOf>
    </xsl:template>
    
    <xsl:template match="baseOfOperation">
        <xsl:variable name="alias">
            <xsl:value-of select="../superHeroAlias"/>
        </xsl:variable>
        <rdf:Description rdf:about="&tp2;{$alias}">
            <tp2:basesOfOperation>
                <rdf:Bag>
                    <xsl:apply-templates select="child::node()"></xsl:apply-templates>
                </rdf:Bag>
            </tp2:basesOfOperation>
        </rdf:Description>
    </xsl:template>
    
    <xsl:template match="status">
        <xsl:variable name="alias">
            <xsl:value-of select="../superHeroAlias"/>
        </xsl:variable>
        <xsl:apply-templates select="child::node()">
            <xsl:with-param name="alias">
                <xsl:value-of select="../superHeroAlias"/>
            </xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="alignment">
        <xsl:variable name="alias">
            <xsl:value-of select="../../superHeroAlias"/>
        </xsl:variable>
        <xsl:variable name="info">
            <xsl:value-of select="."/>
        </xsl:variable>
        <rdf:Description rdf:about="&tp2;{$alias}">
            <tp2:alignment rdf:resource="&tp2;{$info}"/>
        </rdf:Description>
    </xsl:template>
    
    <xsl:template match="identity">
        <xsl:variable name="alias">
            <xsl:value-of select="../../superHeroAlias"/>
        </xsl:variable>
        <xsl:variable name="info">
            <xsl:value-of select="."/>
        </xsl:variable>
        <rdf:Description rdf:about="&tp2;{$alias}">
            <tp2:identity rdf:resource="#{$info}"/>
        </rdf:Description>
    </xsl:template>
    
    <xsl:template match="citizenship">
        <xsl:variable name="alias">
            <xsl:value-of select="../../superHeroAlias"/>
        </xsl:variable>
        <xsl:variable name="info">
            <xsl:value-of select="."/>
        </xsl:variable>
        <rdf:Description rdf:about="&tp2;{$alias}">
            <tp2:citizenship rdf:resource="#{$info}"/>
        </rdf:Description>
    </xsl:template>
    
    <xsl:template match="maritalStatus">
        <xsl:variable name="alias">
            <xsl:value-of select="../../superHeroAlias"/>
        </xsl:variable>
        <xsl:variable name="info">
            <xsl:value-of select="."/>
        </xsl:variable>
        <rdf:Description rdf:about="&tp2;{$alias}">
            <tp2:maritalStatus rdf:resource="#{$info}"/>
        </rdf:Description>
    </xsl:template>
    
    <xsl:template match="occupation">
        <xsl:variable name="alias">
            <xsl:value-of select="../../superHeroAlias"/>
        </xsl:variable>
        <xsl:variable name="info">
            <xsl:value-of select="."/>
        </xsl:variable>
        <rdf:Description rdf:about="&tp2;{$alias}">
            <tp2:occupation rdf:resource="#{$info}"/>
        </rdf:Description>
    </xsl:template>
    
    <xsl:template match="education">
        <xsl:variable name="alias">
            <xsl:value-of select="../../superHeroAlias"/>
        </xsl:variable>
        <xsl:variable name="info">
            <xsl:value-of select="."/>
        </xsl:variable>
        <rdf:Description rdf:about="&tp2;{$alias}">
            <tp2:education rdf:resource="#{$info}"/>
        </rdf:Description>
    </xsl:template>
    
    <xsl:template match="characteristics|creators">
    <!--<xsl:variable name="alias">
        <xsl:value-of select="../superHeroAlias"/>
    </xsl:variable>-->
    <xsl:apply-templates select="child::node()"/>
    </xsl:template>
    
    <xsl:template match="gender">
        <xsl:variable name="alias">
            <xsl:value-of select="../../superHeroAlias"/>
        </xsl:variable>
        <xsl:variable name="info">
            <xsl:value-of select="."/>
        </xsl:variable>
        <rdf:Description rdf:about="&tp2;{$alias}">
            <tp2:gender rdf:resource="#{$info}"/>
        </rdf:Description>
    </xsl:template>
    
    <xsl:template match="height">
        <xsl:variable name="alias">
            <xsl:value-of select="../../superHeroAlias"/>
        </xsl:variable>
        <xsl:variable name="info">
            <xsl:value-of select="."/>
        </xsl:variable>
        <rdf:Description rdf:about="&tp2;{$alias}">
            <tp2:height rdf:resource="#{$info}"/>
        </rdf:Description>
    </xsl:template>
    
    <xsl:template match="weight">
        <xsl:variable name="alias">
            <xsl:value-of select="../../superHeroAlias"/>
        </xsl:variable>
        <xsl:variable name="info">
            <xsl:value-of select="."/>
        </xsl:variable>
        <rdf:Description rdf:about="&tp2;{$alias}">
            <tp2:weight rdf:resource="#{$info}"/>
        </rdf:Description>
    </xsl:template>
    
    <xsl:template match="eyes">
        <xsl:variable name="alias">
            <xsl:value-of select="../../superHeroAlias"/>
        </xsl:variable>
        <xsl:variable name="info">
            <xsl:value-of select="."/>
        </xsl:variable>
        <rdf:Description rdf:about="&tp2;{$alias}">
            <tp2:eyes rdf:resource="#{$info}"/>
        </rdf:Description>
    </xsl:template>
    
    <xsl:template match="hair">
        <xsl:variable name="alias">
            <xsl:value-of select="../../superHeroAlias"/>
        </xsl:variable>
        <xsl:variable name="info">
            <xsl:value-of select="."/>
        </xsl:variable>
        <rdf:Description rdf:about="&tp2;{$alias}">
            <tp2:hair rdf:resource="#{$info}"/>
        </rdf:Description>
    </xsl:template>
    
    <xsl:template match="origin">
        <xsl:apply-templates select="universe/location"/>
        <xsl:apply-templates select="placeOfBirth/location"/>
        <xsl:apply-templates select="creators"></xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="universe/location">
        <xsl:variable name="alias">
            <xsl:value-of select="../../../superHeroAlias"/>
        </xsl:variable>
        <xsl:variable name="info">
            <xsl:value-of select="."/>
        </xsl:variable>
        <rdf:Description rdf:about="&tp2;{$alias}">
            <tp2:inUniverse rdf:resource="#{$info}"/>
        </rdf:Description>
    </xsl:template>
    
    <xsl:template match="placeOfBirth/location">
        <xsl:variable name="alias">
            <xsl:value-of select="../../../superHeroAlias"/>
        </xsl:variable>
        <xsl:variable name="info">
            <xsl:value-of select="."/>
        </xsl:variable>
        <rdf:Description rdf:about="&tp2;{$alias}">
            <tp2:bornIn rdf:resource="#{$info}"/>
        </rdf:Description>
    </xsl:template>
    
    <xsl:template match="creator">
        <xsl:variable name="alias">
            <xsl:value-of select="../../../superHeroAlias"/>
        </xsl:variable>
        <xsl:variable name="info">
            <xsl:value-of select="."/>
        </xsl:variable>
        <rdf:Description rdf:about="&tp2;{$alias}">
            <tp2:createdBy rdf:resource="#{$info}"/>
        </rdf:Description>
    </xsl:template>
    
    
    
    
</xsl:stylesheet>