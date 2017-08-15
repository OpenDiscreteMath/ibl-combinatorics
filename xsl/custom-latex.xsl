<?xml version="1.0" encoding="UTF-8"?>


<!-- This file is part of the book                 -->
<!--                                               -->
<!--   Discrete Mathematics: an Open Introduction  -->
<!--                                               -->
<!-- Copyright (C) 2015-2016 Oscar Levin           -->
<!-- See the file COPYING for copying conditions.  -->

<!-- Parts of this file were adapted from the author guide at https://github.com/rbeezer/mathbook and the analagous file at https://github.com/twjudson/aata -->


<!-- DMOI customizations for LaTeX runs -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Assumes current file is in discrete-text/xsl and that the mathbook repository is adjacent -->
<xsl:import href="../../mathbook/xsl/mathbook-latex.xsl" />
<!-- Assumes next file can be found in discrete-text/xsl -->
<xsl:import href="custom-common.xsl" />





<!-- Parameters to pass via xsltproc "stringparam" on command-line            -->
<!-- Or make a thin customization layer and use 'select' to provide overrides -->
<!--  -->
<!-- LaTeX executable, "engine"                       -->
<!-- pdflatex is default, xelatex or lualatex for Unicode support -->
<!-- N.B. This has no effect, and may never.  xelatex and lualatex support is automatic -->
<xsl:param name="latex.engine" select="'xelatex'" />
<!--  -->
<!-- Standard fontsizes: 10pt, 11pt, or 12pt       -->
<!-- extsizes package: 8pt, 9pt, 14pt, 17pt, 20pt  -->
<!-- memoir class offers more, but maybe other changes? -->
<xsl:param name="latex.font.size" select="'10pt'" />
<!--  -->
<!-- Geometry: page shape, margins, etc            -->
<!-- Pass a string with any of geometry's options  -->
<!-- Default is empty and thus ineffective         -->
<!-- Otherwise, happens early in preamble template -->

<!-- <xsl:param name="latex.geometry" select="'papersize={6in,9in}, hmargin={0.85in, 0.5in}, height=7.75in, top=0.75in, twoside, ignoreheadfoot'"/> -->

<!--  -->
<!-- PDF Watermarking                    -->
<!-- Non-empty string makes it happen    -->
<!-- Scale works well for "CONFIDENTIAL" -->
<!-- or  for "DRAFT YYYY/MM/DD"          -->
<xsl:param name="latex.watermark" select="''"/>
<xsl:param name="latex.watermark.scale" select="2.0"/>
<!--  -->
<!-- Author's Tools                                            -->
<!-- Set the author-tools parameter to 'yes'                   -->
<!-- (Documented in mathbook-common.xsl)                       -->
<!-- Installs some LaTeX-specific behavior                     -->
<!-- (1) Index entries in margin of the page                   -->
<!--      where defined, on single pass (no real index)        -->
<!-- (2) LaTeX labels near definition and use                  -->
<!--     N.B. Some are author-defined; others are internal,    -->
<!--     and CANNOT be used as xml:id's (will raise a warning) -->
<!--  -->
<!-- Draft Copies                                              -->
<!-- Various options for working copies for authors            -->
<!-- (1) LaTeX's draft mode                                    -->
<!-- (2) Crop marks on letter paper, centered                  -->
<!--     presuming geometry sets smaller page size             -->
<!--     with paperheight, paperwidth                          -->
<xsl:param name="latex.draft" select="'no'"/>
<!--  -->
<!-- Print Option                                         -->
<!-- For a non-electronic copy, inactive links in black   -->
<!-- Any color options go to black and white, as possible -->
<xsl:param name="latex.print" select="'no'"/>
<!--  -->
<!-- Preamble insertions                    -->
<!-- Insert packages, options into preamble -->
<!-- early or late                          -->
<xsl:param name="latex.preamble.early" select="''" />
<xsl:param name="latex.preamble.late">
    <xsl:text>% Set up the emoji for the three fruit we use&#xa;</xsl:text>
    <xsl:text>\newfontfamily{\emojifont}{Symbola}&#xa;</xsl:text>
    <xsl:text>\usepackage{newunicodechar}&#xa;</xsl:text>
    <xsl:text>\newunicodechar{🍎}{\emojifont{🍎}} % Red apple &#xa;</xsl:text>
    <xsl:text>\newunicodechar{🍐}{{\emojifont{🍐}}} % Pear &#xa;</xsl:text>
    <xsl:text>\newunicodechar{🍌}{{\emojifont{🍌}}} % Banana &#xa;</xsl:text>
    <xsl:text>% Redefine activity environment to get problem type labels&#xa;</xsl:text>
    <xsl:text>\usepackage{tabto, pdfcomment}</xsl:text>
    <xsl:text>\newcommand{\marginsymbol}[2][0]{\tabto*{#1}\makebox[1ex][r]{#2}\tabto*{\TabPrevPos}}</xsl:text>
    <!-- For fonts and headers: -->
    <xsl:text>\input{latex-preamble-styles}&#xa;</xsl:text>

</xsl:param>
<!--  -->
<!-- Console characters allow customization of how    -->
<!-- LaTeX macros are recognized in the fancyvrb      -->
<!-- package's Verbatim clone environment, "console"  -->
<!-- The defaults are traditional LaTeX, we let any   -->
<!-- other specification make a document-wide default -->
<xsl:param name="latex.console.macro-char" select="'\'" />
<xsl:param name="latex.console.begin-char" select="'{'" />
<xsl:param name="latex.console.end-char" select="'}'" />

<!-- We have to identify snippets of LaTeX from the server,   -->
<!-- which we have stored in a directory, because XSLT 1.0    -->
<!-- is unable/unwilling to figure out where the source file  -->
<!-- lives (paths are relative to the stylesheet).  When this -->
<!-- is needed a fatal message will warn if it is not set.    -->
<!-- Path ends with a slash, anticipating appended filename   -->
<!-- This could be overridden in a compatibility layer        -->
<xsl:param name="webwork.server.latex" select="''" />






<!-- List Chapters and Sections in Table of Contents -->
<xsl:param name="toc.level" select="'3'" />


<!-- Exercises have "solution"s which should be put in the back. -->
<!-- Not sure what to do for homework solutions -->
<xsl:param name="exercise.text.statement" select="'yes'" />
<xsl:param name="exercise.text.hint" select="'yes'" />
<xsl:param name="exercise.text.answer" select="'no'" />
<xsl:param name="exercise.text.solution" select="'yes'" />
<xsl:param name="exercise.backmatter.statement" select="'no'" />
<xsl:param name="exercise.backmatter.hint" select="'no'" />
<xsl:param name="exercise.backmatter.answer" select="'yes'" />
<xsl:param name="exercise.backmatter.solution" select="'yes'" />



<!-- Include a style file at the end of the preamble: -->

<!-- <xsl:param name="latex.preamble.late">
  <xsl:text>%This should load all the style information that mbx does not.&#xa;</xsl:text>
    <xsl:text>\input{latex-preamble-styles}&#xa;</xsl:text>
</xsl:param> -->



<!-- The following is an attempt at hacking in the category of the project/task.  Eventually this should be removed. -->

<xsl:template name="problem-type">
  <xsl:choose>
    <xsl:when test="@category='essential'">
      <xsl:text>\pdftooltip{$\bullet$}{essential}</xsl:text>
    </xsl:when>
    <xsl:when test="@category='motivation'">
      <xsl:text>\pdftooltip{$\circ$}{motivational material}</xsl:text>
    </xsl:when>
    <xsl:when test="@category='summary'">
      <xsl:text>\pdftooltip{\tiny$+$}{summary}</xsl:text>
    </xsl:when>
    <xsl:when test="@category='interesting'">
      <xsl:text>\pdftooltip{\importantarrow}{especially interesting}</xsl:text>
    </xsl:when>
    <xsl:when test="@category='difficult'">
      <xsl:text>\pdftooltip{$*$}{difficult}</xsl:text>
    </xsl:when>
    <xsl:when test="@category='essential for this or the next section'">
      <xsl:text>\pdftooltip{\Large$\cdot$}{essential for this section or the next}</xsl:text>
    </xsl:when>
    <xsl:when test="@category='essential for this or the next section, and interesting'">
      <xsl:text>\pdftooltip{\importantarrow\ {\Large$\cdot$}}{especially interesting and essential for this or the next section}</xsl:text>
    </xsl:when>
    <xsl:when test="@category='important and interesting'">
      <xsl:text>\pdftooltip{\importantarrow\ $\bullet$}{especially interesting and essential}</xsl:text>
    </xsl:when>
    <xsl:when test="@category='interesting and difficult'">
      <xsl:text>\pdftooltip{\importantarrow\ $*$}{especially interesting and difficult}</xsl:text>
    </xsl:when>
    <xsl:otherwise>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- Remark Like, Example Like, Project Like -->
<!-- Simpler than theorems, definitions, etc            -->
<!-- Information comes from self, so slightly different -->
<xsl:template match="activity">
    <xsl:if test="statement or ((self::project or self::activity or self::exploration or self::investigation) and task)">
        <xsl:apply-templates select="prelude" />
    </xsl:if>
    <xsl:text>\begin{</xsl:text>
        <xsl:value-of select="local-name(.)" />
    <xsl:text>}</xsl:text>
    <!-- optional argument to environment -->
    <!-- TODO: and/or credit              -->
    <xsl:text>[</xsl:text>
    <xsl:apply-templates select="." mode="title-full" />
    <xsl:text>]</xsl:text>
    <!-- Start added problem type code: -->
    <xsl:text>\marginsymbol[-1em]{</xsl:text>
    <xsl:call-template name="problem-type" />
    <xsl:text>} </xsl:text>
    <!-- End added problem type code  -->
    <xsl:apply-templates select="." mode="label"/>
    <xsl:text>&#xa;</xsl:text>
    <xsl:choose>
        <!-- structured versions first      -->
        <!-- prelude?, introduction?, task+,   -->
        <!-- conclusion?, postlude? -->
        <xsl:when test="(self::project or self::activity or self::exploration or self::investigation) and task">
            <xsl:apply-templates select="introduction"/>
            <!-- careful right after project heading -->
            <xsl:if test="not(introduction)">
                <xsl:call-template name="leave-vertical-mode" />
            </xsl:if>
            <xsl:apply-templates select="task"/>
            <xsl:apply-templates select="conclusion"/>
        </xsl:when>
        <!-- Now no project/task possibility -->
        <!-- prelude?, statement, hint*,   -->
        <!-- answer*, solution*, postlude? -->
        <xsl:when test="statement">
            <xsl:apply-templates select="statement"/>
            <xsl:apply-templates select="hint"/>
            <xsl:apply-templates select="answer"/>
            <xsl:apply-templates select="solution"/>
        </xsl:when>
        <!-- Potential common mistake, no content results-->
        <xsl:when test="prelude|hint|answer|solution|postlude">
            <xsl:message>MBX:WARNING: a &lt;prelude&gt;, &lt;hint&gt;, &lt;answer&gt;, &lt;solution&gt;, or &lt;postlude&gt; in a remark-like, example-like, or project-like block will need to also be structured with a &lt;statement&gt;.  Content will be missing from output.</xsl:message>
            <xsl:apply-templates select="." mode="location-report" />
        </xsl:when>
        <!-- unstructured, no need to avoid dangerous misunderstandings -->
        <xsl:otherwise>
            <xsl:apply-templates select="*"/>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:text>\end{</xsl:text>
        <xsl:value-of select="local-name(.)" />
    <xsl:text>}&#xa;</xsl:text>
    <xsl:if test="statement or ((self::project or self::activity or self::exploration or self::investigation) and task)">
        <xsl:apply-templates select="postlude" />
    </xsl:if>
</xsl:template>

<!-- Task (a part of a project) -->
<xsl:template match="task">
    <!-- if first at its level, start the list environment -->
    <xsl:if test="not(preceding-sibling::task)">
        <!-- set the label style of this list       -->
        <!-- using features of the enumitem package -->
        <xsl:text>\begin{enumerate}[font=\bfseries,label=</xsl:text>
        <xsl:choose>
            <!-- three deep -->
            <xsl:when test="parent::task/parent::task">
                <xsl:text>(\Alph*),ref=\theenumi.\theenumii.\Alph*</xsl:text>
            </xsl:when>
            <!-- two deep -->
            <xsl:when test="parent::task">
                <xsl:text>(\roman*),ref=\theenumi.\roman*</xsl:text>
            </xsl:when>
            <!-- one deep -->
            <xsl:otherwise>
                <xsl:text>(\alph*),ref=\alph*</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>]&#xa;</xsl:text>
    </xsl:if>
    <!-- always a list item, note space -->
    <xsl:text>\item</xsl:text>
    <xsl:apply-templates select="." mode="label" />
    <xsl:text> </xsl:text>
    <!-- Start added problem type code: -->
    <xsl:text>\marginsymbol[-2.5em]{</xsl:text>
    <xsl:call-template name="problem-type" />
    <xsl:text>} </xsl:text>
    <!-- End added problem type code  -->
    <!-- more structured versions first -->
    <xsl:choose>
        <!-- introduction?, task+, conclusion? -->
        <xsl:when test="task">
            <xsl:apply-templates select="introduction"/>
            <xsl:apply-templates select="task"/>
            <xsl:apply-templates select="conclusion"/>
        </xsl:when>
        <!-- statement, hint*, answer*, solution* -->
        <xsl:when test="statement">
            <xsl:apply-templates select="statement"/>
            <xsl:apply-templates select="hint"/>
            <xsl:apply-templates select="answer"/>
            <xsl:apply-templates select="solution"/>
        </xsl:when>
        <!-- unstructured -->
        <xsl:otherwise>
            <xsl:apply-templates />
        </xsl:otherwise>
    </xsl:choose>
    <!-- if last at its level, end the list environment -->
    <xsl:if test="not(following-sibling::task)">
        <xsl:text>\end{enumerate}&#xa;</xsl:text>
    </xsl:if>
</xsl:template>



<xsl:template match="exercises/exercise|exercisegroup/exercise">
    <!-- Start a list right before first exercise of subdivision, or of exercise group -->
    <xsl:choose>
        <xsl:when test="not(preceding-sibling::exercise) and parent::exercisegroup">
            <xsl:text>\begin{exercisegroup}(</xsl:text>
            <xsl:choose>
                <xsl:when test="not(../@cols)">
                    <xsl:text>1</xsl:text>
                </xsl:when>
                <xsl:when test="../@cols = 1 or ../@cols = 2 or ../@cols = 3 or ../@cols = 4 or ../@cols = 5 or ../@cols = 6">
                    <xsl:value-of select="../@cols"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:message terminate="yes">MBX:ERROR: invalid value <xsl:value-of select="../@cols" /> for cols attribute of exercisegroup</xsl:message>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>)&#xa;</xsl:text>
        </xsl:when>
        <xsl:when test="not(preceding-sibling::exercise) and parent::exercises">
            <xsl:text>\begin{exerciselist}&#xa;</xsl:text>
        </xsl:when>
    </xsl:choose>
    <xsl:choose>
        <xsl:when test="parent::exercises">
            <xsl:text>\item[</xsl:text>
        </xsl:when>
        <xsl:when test="parent::exercisegroup">
            <xsl:text>\exercise[</xsl:text>
        </xsl:when>
    </xsl:choose>
    <xsl:apply-templates select="." mode="serial-number" />
    <xsl:text>.]</xsl:text>
    <!-- Start added problem type code: -->
    <xsl:text>\marginsymbol[-1em]{</xsl:text>
    <xsl:call-template name="problem-type" />
    <xsl:text>} </xsl:text>
    <!-- End added problem type code  -->
    <xsl:apply-templates select="." mode="label"/>
    <xsl:if test="title">
        <xsl:text>(</xsl:text>
        <xsl:apply-templates select="." mode="title-full"/>
        <xsl:text>)\space\space{}</xsl:text>
    </xsl:if>
    <!-- condition on webwork wrapper or not -->
    <xsl:choose>
        <xsl:when test="webwork">
            <xsl:apply-templates select="introduction" />
            <xsl:apply-templates select="webwork" />
            <xsl:apply-templates select="conclusion" />
        </xsl:when>
        <xsl:otherwise>
        <!-- Order enforced: statement, hint, answer, solution -->
            <xsl:if test="$exercise.text.statement='yes'">
                <xsl:apply-templates select="statement" />
                <xsl:if test="not(parent::exercisegroup)">
                    <xsl:text>\par\smallskip&#xa;</xsl:text>
                </xsl:if>
            </xsl:if>
            <xsl:if test="hint and $exercise.text.hint='yes'">
                <xsl:apply-templates select="hint" />
            </xsl:if>
            <xsl:if test="answer and $exercise.text.answer='yes'">
                <xsl:apply-templates select="answer" />
            </xsl:if>
            <xsl:if test="solution and $exercise.text.solution='yes'">
                <xsl:apply-templates select="solution" />
            </xsl:if>
        </xsl:otherwise>
    </xsl:choose>
    <!-- close list if no more exercise in subdivision or in exercise group -->
    <xsl:choose>
        <xsl:when test="not(following-sibling::exercise) and parent::exercisegroup">
            <xsl:text>\end{exercisegroup}&#xa;</xsl:text>
        </xsl:when>
        <xsl:when test="not(following-sibling::exercise) and parent::exercises">
            <xsl:text>\end{exerciselist}&#xa;</xsl:text>
        </xsl:when>
    </xsl:choose>
</xsl:template>


</xsl:stylesheet>
