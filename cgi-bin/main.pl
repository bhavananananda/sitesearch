#!/usr/bin/perl -w
use strict;


use CGI qw/(:standard)/;
print "<HTML>";
print "<HEAD>";

print "<TITLE> Online Forum</TITLE>";
print "</HEAD>";
print "<BODY TEXT=DARKBLUE BGCOLOR=white>";

print "<BASEFONT FACE= \"ARIAL\" SIZE=4>";

print "<H1><STRONG><MARQUEE BEHAVIOR=ALTERNATE ><font face=\"Areal\"><center>UNIFIED MODELING LANGUAGE</center></FONT></MARQUEE></STRONG></H1>";
print "<IMG SRC = \"http://127.0.0.1/cgi-bin/images/handhelp.gif\"P ALIGN=\"left\">";

print "<IMG SRC = \"images/11.gif\"P ALIGN=\"left\"><BR>";
print "<INPUT SIZE = \"40\" STYLE = \"HEIGHT:20px; WIDTH: 115px\">";
print "<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<IMG SRC = \"images/UML1.JPG\">";

print "<font color=\"#DFB300\">";

print "<h2><P ALIGN=\"CENTER\"><B>TOPICS</B></h2>";

print "<font color=\"MAROON\">";
print "<h3><P ALIGN=\"CENTER\"><A href=main1.pl>What's UML?</A></h3>";


print "<h3><P ALIGN=\"center\"><A href=UMLprimer.PDF>The UML Notation</A></h3>";

print "<h3><P ALIGN=\"center\">Object-Oriented Approach</h3>";


print "<h3><P ALIGN=\"center\">An Example...</h3>";


print "<IMG SRC = \"images/tellus.gif\"<br>";
print "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A href=forum.pl><IMG SRC = \"images/20.gif\"</A>";
print "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<IMG SRC = \"images/002.gif\"<BR>";



print "</BODY>";
print "</HTML>";