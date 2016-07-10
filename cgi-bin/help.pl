#!/usr/bin/perl -w
use strict;
use Tk;
use Win32;
use CGI qw/(:standard)/;

use Win32::sound;
my $mw = MainWindow->new();

Win32::Sound::Play('MailBeep');
 my $label1 = $mw->Label(-text => 'Search:    Type in the text you want information for')->pack();
 my $label2 = $mw->Label(-text => '                                                    ')->pack();
 my $label3 = $mw->Label(-text => 'Topics:    You can click on any of the topics for information')->pack();
 my $label4 = $mw->Label(-text => '                                                             ')->pack();
 my $label5 = $mw->Label(-text => 'FAQs  :    You can click on this to move to the online forum!  ')->pack();
 my $label6 = $mw->Label(-text => '                                                               ')->pack();
 my $label7 = $mw->Label(-text => 'About us:  You can know about us on clicking this')->pack();
 my $label8 = $mw->Label(-text => '                                                 ')->pack();
 my $label9 = $mw->Label(-text => 'Tell us what you think: You can mail us what you think about our site!')->pack();
 my $label10 = $mw->Label(-text => '                                                                     ')->pack();

 MainLoop;

 print "<script Language = 'JavaScript'>";
 print "history.back();";
 print "</script>";






