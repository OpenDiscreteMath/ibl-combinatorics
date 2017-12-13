<?xml version="1.0" encoding="UTF-8"?>


<!-- This file is part of the book                 -->
<!--                                               -->
<!--   Combinatorics through Guided Discovery      -->
<!-- Adapted from the corresponding file for       -->
<!-- Discrete Mathematics: An Open Introduction    -->
<!-- Copyright (C) 2015-2016 Oscar Levin           -->
<!-- See the file COPYING for copying conditions.  -->

<!-- Parts of this file were adapted from the author guide at https://github.com/rbeezer/mathbook and the analagous file at https://github.com/twjudson/aata -->


<!-- DMOI customizations for HTML runs -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Assumes current file is in ibl-combinatorics/xsl and that the mathbook repository is adjacent -->
<xsl:import href="../../mathbook/xsl/mathbook-html.xsl" />
<!-- Assumes next file can be found in discrete-text/xsl -->
<xsl:import href="custom-common.xsl" />

<!-- List Chapters and Sections in sidebar Table of Contents -->
<xsl:param name="toc.level" select="''" />


<!-- Exercises -->
<!-- HTML: knowlize as available/appropriate -->


<!-- Now project-like elements, in main text.  -->
<!-- A task is a division of a project         -->
<xsl:param name="project.text.statement" select="'yes'" /> <!-- not implemented -->
<xsl:param name="project.text.hint" select="'yes'" />
<xsl:param name="project.text.answer" select="'no'" />
<xsl:param name="project.text.solution" select="'no'" />
<xsl:param name="task.text.statement" select="'yes'" /> <!-- not implemented -->
<xsl:param name="task.text.hint" select="'yes'" />
<xsl:param name="task.text.answer" select="'no'" />
<xsl:param name="task.text.solution" select="'no'" />
<!-- And project-like elements, in back matter (none implemented). -->
<xsl:param name="project.backmatter.statement" select="'no'" />
<xsl:param name="project.backmatter.hint" select="'yes'" />
<xsl:param name="project.backmatter.answer" select="'no'" />
<xsl:param name="project.backmatter.solution" select="'no'" />
<xsl:param name="task.backmatter.statement" select="'no'" />
<xsl:param name="task.backmatter.hint" select="'yes'" />
<xsl:param name="task.backmatter.answer" select="'no'" />
<xsl:param name="task.backmatter.solution" select="'no'" />

<!-- Changes to mimic in HTML via CSS/other changes? -->
<!-- LaTeX: Bold and italic for terminology macro -->
<!-- LaTeX: Proof to small caps -->
<!-- LaTeX: Historical Notes -->




<!-- Here are the options, taken from mathbook-html.xsl, changed as needed -->

<!-- Parameters -->
<!-- Parameters to pass via xsltproc "stringparam" on command-line            -->
<!-- Or make a thin customization layer and use 'select' to provide overrides -->
<!-- See more generally applicable parameters in mathbook-common.xsl file     -->

<!-- Content as Knowls -->
<!-- These parameters control if content is      -->
<!-- hidden in a knowl on first appearance       -->
<!-- The happens automatically sometimes,        -->
<!-- eg content of a footnote is always hidden   -->
<!-- Some things never are hidden,               -->
<!-- eg an entire section (too big),             -->
<!-- or a bibliographic item (pointless)         -->
<!-- These switches often control a whole group  -->
<!-- of similar items, for example the "theorem" -->
<!-- switch will similarly affect corrolaries,   -->
<!-- lemmas, etc - anything that can be proved   -->
<!-- NB: figures and tables inside of            -->
<!-- side-by-side panels are never born hidden,  -->
<!-- no matter how the switches below are set.   -->
<!-- You may elect to have entire side-by-side   -->
<!-- panels born as knowls, using the switch.    -->
<!-- PROJECT-LIKE gets own switch here           -->

<xsl:param name="html.knowl.theorem" select="'no'" />
<xsl:param name="html.knowl.proof" select="'no'" />
<xsl:param name="html.knowl.definition" select="'no'" />
<xsl:param name="html.knowl.example" select="'no'" />
<xsl:param name="html.knowl.project" select="'no'" />
<xsl:param name="html.knowl.list" select="'no'" />
<xsl:param name="html.knowl.remark" select="'no'" />
<xsl:param name="html.knowl.figure" select="'no'" />
<xsl:param name="html.knowl.table" select="'no'" />
<xsl:param name="html.knowl.listing" select="'no'" />
<xsl:param name="html.knowl.exercise.inline" select="'no'" />
<xsl:param name="html.knowl.exercise.sectional" select="'no'" />
<!-- html.knowl.example.solution: always "yes", could be implemented -->

<!-- CSS and Javascript Servers -->
<!-- We allow processing paramteers to specify new servers   -->
<!-- or to specify the particular CSS file, which may have   -->
<!-- different color schemes.  The defaults should work      -->
<!-- fine and will not need changes on initial or casual use -->
<!-- #0 to #5 on mathbook-modern for different color schemes -->
<!-- We just like #3 as the default                          -->
<!-- N.B.:  This scheme is transitional and may change             -->
<!-- N.B.:  without warning and without any deprecation indicators -->
<xsl:param name="html.js.server"  select="'https://aimath.org'" />
<xsl:param name="html.css.server" select="'https://aimath.org'" />
<xsl:param name="html.css.file"   select="'mathbook-4.css'" />
<!-- A space-separated list of CSS URLs (points to servers or local files) -->
<xsl:param name="html.css.extra"  select="'custom-styles.css'" />

<!-- Navigation -->
<!-- Navigation may follow two different logical models:                     -->
<!--   (a) Linear, Prev/Next - depth-first search, linear layout like a book -->
<!--       Previous and Next take you to the adjacent "page"                 -->
<!--   (b) Tree, Prev/Up/Next - explicitly traverse the document tree        -->
<!--       Prev and Next remain at same depth/level in tree                  -->
<!--       Must follow a summary link to descend to finer subdivisions       -->
<!--   'linear' is the default, 'tree' is an option                          -->
<xsl:param name="html.navigation.logic"  select="'linear'" />
<!-- The "up" button is optional given the contents sidebar, default is to have it -->
<!-- An up button is very desirable if you use the tree-like logic                 -->
<xsl:param name="html.navigation.upbutton"  select="'yes'" />
<!-- There are also "compact" versions of the navigation buttons in the top right -->
<xsl:param name="html.navigation.style"  select="'full'" />

<!-- WeBWorK -->
<!-- There is no default server provided         -->
<!-- Interactions are with an "anonymous" course -->
<xsl:param name="webwork.server" select="''"/>
<xsl:param name="webwork.course" select="'anonymous'" />
<xsl:param name="webwork.userID" select="'anonymous'" />
<xsl:param name="webwork.password" select="'anonymous'" />

<!-- Permalinks -->
<!-- Next to subdivision headings a "paragraph" symbol     -->
<!-- (a pilcrow) along with internationalized text         -->
<!-- ("permalink") indicates a link to that section.       -->
<!-- It is useful if you want to right-click on it to      -->
<!-- capture a link for use somewhere else.  (Similar      -->
<!-- behavior for theorems, examples, etc is planned.)     -->
<!--                                                       -->
<!-- "Permalink" is a bit of an exaggeration.  Site        -->
<!-- domain name is relative to wherever content is        -->
<!-- hosted.  We say a link is "stable" if there is        -->
<!-- an  xml:id  on the enclosing page AND an  xml:id      -->
<!-- on the subdivision (which could be the same).         -->
<!-- If you change the chunking level, then the enclosing  -->
<!-- page could change and these links will be affected.   -->
<!--                                                       -->
<!-- 'none' - no permalinks anywhere                       -->
<!-- 'stable' - only stable links (see paragraph above)    -->
<!-- 'all' - every section heading, even if links are poor -->
<xsl:param name="html.permalink"  select="'all'" />



<!-- Hack classes to allow for display of problem type markers -->
<xsl:template match="activity" mode="body-css-class">
  <xsl:choose>
    <xsl:when test="@category='essential'">
      <xsl:text>example-like essential</xsl:text>
    </xsl:when>
    <xsl:when test="@category='motivation'">
      <xsl:text>example-like motivation</xsl:text>
    </xsl:when>
    <xsl:when test="@category='summary'">
      <xsl:text>example-like summary</xsl:text>
    </xsl:when>
    <xsl:when test="@category='interesting'">
      <xsl:text>example-like interesting</xsl:text>
    </xsl:when>
    <xsl:when test="@category='difficult'">
      <xsl:text>example-like difficult</xsl:text>
    </xsl:when>
    <xsl:when test="@category='essential for this or the next section'">
      <xsl:text>example-like forward-essential</xsl:text>
    </xsl:when>
    <xsl:when test="@category='essential for this or the next section, and interesting'">
      <xsl:text>example-like interesting-forward-essential</xsl:text>
    </xsl:when>
    <xsl:when test="@category='important and interesting'">
      <xsl:text>example-like interesting-essential}</xsl:text>
    </xsl:when>
    <xsl:when test="@category='interesting and difficult'">
      <xsl:text>example-like interesting-difficult}</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>example-like</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="task|exercise" mode="body-css-class">
  <xsl:choose>
    <xsl:when test="@category='essential'">
      <xsl:text>exercise-like essential</xsl:text>
    </xsl:when>
    <xsl:when test="@category='motivation'">
      <xsl:text>exercise-like motivation</xsl:text>
    </xsl:when>
    <xsl:when test="@category='summary'">
      <xsl:text>exercise-like summary</xsl:text>
    </xsl:when>
    <xsl:when test="@category='interesting'">
      <xsl:text>exercise-like interesting</xsl:text>
    </xsl:when>
    <xsl:when test="@category='difficult'">
      <xsl:text>exercise-like difficult</xsl:text>
    </xsl:when>
    <xsl:when test="@category='essential for this or the next section'">
      <xsl:text>exercise-like forward-essential</xsl:text>
    </xsl:when>
    <xsl:when test="@category='essential for this or the next section, and interesting'">
      <xsl:text>exercise-like interesting-forward-essential</xsl:text>
    </xsl:when>
    <xsl:when test="@category='important and interesting'">
      <xsl:text>exercise-like interesting-essential}</xsl:text>
    </xsl:when>
    <xsl:when test="@category='interesting and difficult'">
      <xsl:text>exercise-like interesting-difficult}</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>exercise-like</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>



</xsl:stylesheet>
