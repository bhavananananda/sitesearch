
use CGI qw/:standard/;

my $search = param(T1);
my $counter = 0;

print header;
print "<BASEFONT FACE = \"ARIAL,SANS-SERIF\" SIZE = 3>";

open(FILE, "urls.txt") || 
   die "The URL database could not be opened";

while(<FILE>)
{
   my @data = split(/\n/);
   
   foreach $entry (@data)
   {
      my ($data, $url) = split(/;/, $entry);
      
      if ($data =~ /$search/i)
      {
         if ($counter == 0)
         {
            print "<STRONG>Search Results:<BR><BR></STRONG>";
         }
        
         print "<A HREF=\"http://$url/\">";
         print "http://$url/";
         print "</A>";
         print "<BR>$data<BR><BR>";
         $counter++;
      }
   }
}
close FILE;

if ($counter == 0)
{
   print "<B>Sorry, no results were found matching </B>";
   print "<FONT COLOR = BLUE>$search</FONT>. ";
}
else
{
   print "<STRONG>$counter matches found for </STRONG>";
   print "<FONT COLOR = BLUE>$search</FONT>";
}
