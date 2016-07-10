 #!/usr/bin/perl -w
use strict;
use Tk;
use Win32;
use CGI qw/(:standard)/;

use Win32::sound;
my $mw = MainWindow->new();

Win32::Sound::Play('MailBeep');
 my $label1 = $mw->Label(-text => 'Bhavana')->pack();
 my $label2 = $mw->Label(-text => 'Year: 2002')->pack();
 my $label3 = $mw->Label(-text => 'Email: abc@xyz.com')->pack();
 my $label4 = $mw->Label(-text => '   	                                                       ')->pack();
 my $label5 = $mw->Label(-text => '7th   semester Computer Science')->pack();
 my $label6 = $mw->Label(-text => 'APSCE')->pack();

 MainLoop;

 print "<script Language = 'JavaScript'>";
 print "history.back();";
 print "</script>";





