<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE RDF [
            <!ENTITY tp2 "http://www-etud.iro.umontreal.ca/~gauthif/ift6282/tp2#" >
            <!ENTITY tp3 "http://www-etud.iro.umontreal.ca/~gauthif/ift6282/tp3#" >
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:owl="http://www.w3.org/2002/07/owl#"
    xmlns:gauthif="http://www-etud.iro.umontreal.ca/~gauthif#"
    xmlns:tp2="http://www-etud.iro.umontreal.ca/~gauthif/ift6282/tp2#"
    xmlns:tp3="http://www-etud.iro.umontreal.ca/~gauthif/ift6282/tp3#"
    xmlns:dc="http://www-etud.iro.umontreal.ca/~gauthif/ift6282/tp3/dc#"
    xmlns:marvel="http://www-etud.iro.umontreal.ca/~gauthif/ift6282/tp3/marvel#"
    xml:base="http://www-etud.iro.umontreal.ca/~gauthif/ift6282/tp3"
    exclude-result-prefixes="xs"
    version="1.0">
   
    
    <xsl:template match="/">
        
        <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
            xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
            xmlns:owl="http://www.w3.org/2002/07/owl#"
            xmlns:gauthif="http://www-etud.iro.umontreal.ca/~gauthif#"
            xmlns:tp2="http://www-etud.iro.umontreal.ca/~gauthif/ift6282/tp2#"
            xmlns:dc="http://www-etud.iro.umontreal.ca/~gauthif/ift6282/tp3/dc#"
            xmlns:marvel="http://www-etud.iro.umontreal.ca/~gauthif/ift6282/tp3/marvel#"
            xml:base="http://www-etud.iro.umontreal.ca/~gauthif/ift6282/tp3">
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
        <xsl:text>&#xa;</xsl:text>
        <xsl:text>&#xa;</xsl:text>
        <owl:NamedIndividual rdf:about="&tp3;{$alias}">
            <rdf:type rdf:resource="&tp3;Character"/>
            <xsl:apply-templates select="realName"></xsl:apply-templates>
            <xsl:apply-templates select="otherAliases"></xsl:apply-templates>
            <xsl:apply-templates select="relatives"></xsl:apply-templates>
            <xsl:apply-templates select="affiliation"></xsl:apply-templates>
            <xsl:apply-templates select="baseOfOperation"></xsl:apply-templates>
            <xsl:apply-templates select="status"></xsl:apply-templates>
            <xsl:apply-templates select="characteristics"></xsl:apply-templates>
            <xsl:apply-templates select="origin"></xsl:apply-templates>
        </owl:NamedIndividual>
    </xsl:template>
    
    <xsl:template match="realName">
        <xsl:variable name="rName">
            <xsl:value-of select="."/>
        </xsl:variable>
        <hasRealName rdf:resource="&tp3;{$rName}"/>
    </xsl:template>
    
    <xsl:template match="otherAliases|affiliation|baseOfOperation|status|origin|characteristics|relative">
        <xsl:apply-templates select="child::node()"></xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="alias">
        <xsl:variable name="oalias">
            <xsl:value-of select="."/>
        </xsl:variable>
        <hasAlias rdf:resource="&tp3;{$oalias}"/>
    </xsl:template>
    
    <xsl:template match="group">
        <xsl:variable name="gro">
            <xsl:value-of select="."/>
        </xsl:variable>
        <affiliatedTo rdf:resource="&tp3;{$gro}"/>
    </xsl:template>
    
    <xsl:template match="baseOfOperation/location">
        <xsl:variable name="base">
            <xsl:value-of select="."/>
        </xsl:variable>
        <hasBaseOfOperation rdf:resource="&tp3;{$base}"/>
    </xsl:template>
    
    <xsl:template match="alignment">
        <xsl:variable name="alig">
            <xsl:value-of select="."/>
        </xsl:variable>
        <isAligned rdf:resource="&tp3;{$alig}"/>
    </xsl:template>
    
    <xsl:template match="identity">
        <xsl:variable name="alig">
            <xsl:value-of select="."/>
        </xsl:variable>
        <identityIs rdf:resource="&tp3;{$alig}"/>
    </xsl:template>
    
    <xsl:template match="citizenship">
        <xsl:variable name="alig">
            <xsl:value-of select="."/>
        </xsl:variable>
        <citizenshipIs rdf:resource="&tp3;{$alig}"/>
    </xsl:template>
    
    <xsl:template match="maritalStatus">
        <xsl:variable name="alig">
            <xsl:value-of select="."/>
        </xsl:variable>
        <maritalStatusIs rdf:resource="&tp3;{$alig}"/>
    </xsl:template>
    
    <xsl:template match="occupation">
        <xsl:variable name="alig">
            <xsl:value-of select="."/>
        </xsl:variable>
        <occupationIs rdf:resource="&tp3;{$alig}"/>
    </xsl:template>
    
    <xsl:template match="education">
        <xsl:variable name="alig">
            <xsl:value-of select="."/>
        </xsl:variable>
        <educationIs rdf:resource="&tp3;{$alig}"/>
    </xsl:template>
    
    <xsl:template match="gender">
        <xsl:variable name="alig">
            <xsl:value-of select="."/>
        </xsl:variable>
        <hasGender rdf:resource="&tp3;{$alig}"/>
    </xsl:template>
    
    <xsl:template match="height">
        <xsl:variable name="alig">
            <xsl:value-of select="."/>
        </xsl:variable>
        <measures rdf:resource="&tp3;{$alig}"/>
    </xsl:template>
    
    <xsl:template match="weight">
        <xsl:variable name="alig">
            <xsl:value-of select="."/>
        </xsl:variable>
        <weights rdf:resource="&tp3;{$alig}"/>
    </xsl:template>
    
    <xsl:template match="eyes">
        <xsl:variable name="alig">
            <xsl:value-of select="."/>
        </xsl:variable>
        <hasEyes rdf:resource="&tp3;{$alig}"/>
    </xsl:template>
    
    <xsl:template match="hair">
        <xsl:variable name="alig">
            <xsl:value-of select="."/>
        </xsl:variable>
        <hasHair rdf:resource="&tp3;{$alig}"/>
    </xsl:template>
    
    <xsl:template match="universe/location">
        <xsl:variable name="alig">
            <xsl:value-of select="."/>
        </xsl:variable>
        <originated rdf:resource="&tp3;{$alig}"/>
    </xsl:template>
    
    <xsl:template match="placeOfBirth/location">
        <xsl:variable name="alig">
            <xsl:value-of select="."/>
        </xsl:variable>
        <bornIn rdf:resource="&tp3;{$alig}"/>
    </xsl:template>
    
    <xsl:template match="creators/creator">
        <xsl:variable name="alig">
            <xsl:value-of select="."/>
        </xsl:variable>
        <createdBy rdf:resource="&tp3;{$alig}"/>
    </xsl:template>
    
    <xsl:template match="relative">
        <xsl:variable name="alig">
            <xsl:value-of select="."/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="@link='father' or @link='mother'">
                <childrenOf rdf:resource="&tp3;{$alig}"></childrenOf>
            </xsl:when>
            <xsl:when test="@link='son' or @link='daugther'">
                <parentOf rdf:resource="&tp3;{$alig}"></parentOf>
            </xsl:when>
            <xsl:when test="@link='grandmother' or @link='grandfather'">
                <grandChildrenOf rdf:resource="&tp3;{$alig}"></grandChildrenOf>
            </xsl:when>
            <xsl:when test="@link='wife' or @link='husband'">
                <spouseOf rdf:resource="&tp3;{$alig}"></spouseOf>
            </xsl:when>
            <xsl:when test="@link='sibling'">
                <siblingOf rdf:resource="&tp3;{$alig}"></siblingOf>
            </xsl:when>
            <xsl:when test="@link='ancestor'">
                <descendantOf rdf:resource="&tp3;{$alig}"></descendantOf>
            </xsl:when>
            <xsl:when test="@link='descendant'">
                <ancestorOf rdf:resource="&tp3;{$alig}"></ancestorOf>
            </xsl:when>
            <xsl:otherwise>
                <knownRelativeOf rdf:resource="&tp3;{$alig}"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>