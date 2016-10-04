<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="1.0">

    <xsl:template match="/">
        <html>
            <head><title>Super-héros DC et Marvel</title></head>
            <body>
                <h2>Les super-héros</h2>
                <xsl:apply-templates/>                
            </body>   
        </html>
    </xsl:template>
    
    <xsl:template match="DC">
        <fieldset>
            <legend>Les super-héros de DC</legend>
            <xsl:apply-templates select="character"/>
        </fieldset>
    </xsl:template>
    
    <xsl:template match="character">
        <fieldset>
            <legend>
                <xsl:value-of select="superHeroAlias"/>
            </legend>
            <table>
                <tbody>
                    <xsl:apply-templates select="realName"/>
                    <xsl:apply-templates select="otherAliases"/>
                    <xsl:apply-templates select="relatives"/>
                    <xsl:apply-templates select="affiliation"/>
                    <xsl:apply-templates select="baseOfOperation"/>
                    <xsl:apply-templates select="status"/>
                    <xsl:apply-templates select="characteristics"/>
                    <xsl:apply-templates select="origin/universe"/>
                    <xsl:apply-templates select="origin/placeOfBirth"/>
                    <xsl:apply-templates select="origin/creators"/>
                    <xsl:apply-templates select="firstAppearance"/>
                    <xsl:apply-templates select="lastAppearance"/>
                </tbody>
            </table>    
        </fieldset>
    </xsl:template>
    
    <!--<xsl:template match="realName">
        <tr>
            <td>
                Real Name:
            </td>
            <td>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>-->
    
    <xsl:template match="otherAliases">
        <td>
            <b>Other aliases</b>:
        </td>
        <td>
            <ul>
                <xsl:apply-templates select="alias"/>
            </ul>
        </td>
    </xsl:template>
    
    <xsl:template match="alias|group|location|creator">
        <li>
            <xsl:value-of select="."/>
        </li>
    </xsl:template>
    
    <xsl:template match="relatives">
        <tr>
            <td><b>Relatives</b>:</td>
            <td>
                <ul style="list-style-type:none">
                    <xsl:apply-templates select="relative"/>
                </ul>
            </td>
        </tr>
        
    </xsl:template>    
    
    <xsl:template match="relative">
        <li>
            <xsl:value-of select="."/><xsl:text>(</xsl:text><xsl:value-of select="@relation"/><xsl:text>)</xsl:text>
        </li>
    </xsl:template>

    <xsl:template match="affiliation">
        <tr>
        <td>
            <b>Affiliations</b>:
        </td>
        <td>
            <ul>
                <xsl:apply-templates select="group"/>
            </ul>
        </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="baseOfOperation">
        <tr>
        <td>
            <b>Base(s) of Operation</b>:
        </td>
        <td>
            <ul>
                <xsl:apply-templates select="location"/>
            </ul>
        </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="status">
        <xsl:apply-templates select="alignment"/>
        <xsl:apply-templates select="identity"/>
        <xsl:apply-templates select="citizenship"/>
        <xsl:apply-templates select="maritalStatus"/>
        <xsl:apply-templates select="occupation"/>
        <xsl:apply-templates select="education"/>
    </xsl:template>
    
    <xsl:template match="characteristics">
        <tr>
            <td>
                <b>Characteristics</b>
            </td>
            <td>
                <table>
                    <xsl:apply-templates select="gender"/>
                    <xsl:apply-templates select="height"/>
                    <xsl:apply-templates select="weight"/>
                    <xsl:apply-templates select="eyes"/>
                    <xsl:apply-templates select="hair"/>
                </table>    
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="realName|alignment|identity|citizenship|maritalStatus|
        occupation|education|gender|height|weight|eyes|hair">
        
<!-- Next section is to upperCase the first letter of a tag name. Inspired from http://stackoverflow.com/questions/9611569/xsl-how-do-you-capitalize-first-letter-->
        
        <xsl:variable name="vLower" select=
            "'abcdefghijklmnopqrstuvwxyz'"/>
        
        <xsl:variable name="vUpper" select=
            "'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
        
        <tr>
            <td>
                <b><xsl:value-of select=
                    "concat(translate(substring(name(.),1,1), $vLower, $vUpper),
                    substring(name(.), 2))"/></b>
                <xsl:text>: </xsl:text><xsl:value-of select="."/>    
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="origin/universe">
        <tr>
        <td>
            <b>Universe</b>:
        </td>
        <td>
            <ul>
                <xsl:apply-templates select="location"/>
            </ul>
        </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="origin/placeOfBirth">
        <tr>
        <td>
            <b>Place of Birth</b>:
        </td>
        <td>
            <ul>
                <xsl:apply-templates select="location"/>
            </ul>
        </td>
        </tr>
    </xsl:template>

    <xsl:template match="origin/creators">
        <tr>
            <td>
                <b>Creators</b>:
            </td>
            <td>
                <ul>
                    <xsl:apply-templates select="creator"/>
                </ul>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="firstAppearance">
        <tr>
            <td><b>First Appearance</b>:</td>
            <td>
                <i><xsl:value-of select="./title"/></i>
                <xsl:text> on </xsl:text>
                <xsl:value-of select="./date"/>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="firstAppearance|lastAppearance">
        <tr>
            <td>
                <xsl:choose>
                    <xsl:when test="name(.)='firstAppearance'">
                        <b>First Appearance</b>:            
                    </xsl:when>
                    <xsl:when test="name(.)='lastAppearance'">
                        <b>Last Appearance</b>:
                    </xsl:when>
                    <xsl:otherwise>
                        Oups
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td>
                <xsl:choose>
                    <xsl:when test="./title">
                        <i><xsl:value-of select="./title"/></i>
                        <xsl:if test="./date">
                            <xsl:text> on </xsl:text>
                            <xsl:value-of select="./date"/>
                        </xsl:if>    
                    </xsl:when>
                    <xsl:otherwise>
                        To be determined...
                    </xsl:otherwise>
                </xsl:choose>
            </td>
        </tr>
    </xsl:template>
</xsl:stylesheet>