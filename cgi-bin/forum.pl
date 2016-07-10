#!/usr/bin/perl 

use strict; 
use CGI qw(:standard); 
use Win32::ODBC;


my $script = 'forum.pl'; 
require "cgi-lib.pl";

my %Cmds = ( 
	
    'main'		=>	\&do_main, 
      'post'		=>	\&do_post, 
    'reply'		=>	\&do_reply, 
	
     'save'		=>	\&do_save, 
'view'		=>	\&do_view, 
); 


my @lines; 
my $dbh; 



#1-----------------------------------------------------------------------------


eval { 

	
	
        $dbh=new Win32::ODBC("DSN=bha") || die "Connect Error :$!";
     
	print header; 
	print start_html(-bgcolor=>'pink'); 
       print h2('Online Forum') .print qq!<marquee style="font-family: Times New Roman; text-decoration: underline; font-size: 24pt; font-weight: bold; color: #000080" behavior="alternate">Unified
Modelling Language</marquee>! .qq!<HR SIZE="3" NOSHADE>!; 
	print qq!<A HREF="$script?action=post">Pose a question</A>!; 
	print qq!&nbsp;&nbsp;&nbsp;&nbsp;!; 
	print qq!<A HREF="$script">Back to main page of online forum</A><P>!; 
	

	
	
	my $action = param('action') || 'main'; 

	if( my $func = $Cmds{$action} ) { 
		push(@lines, &$func() ); 
	}
	else { 
		push(@lines, qq!The action "$action" is not valid!); 
	}

};


if($@) { 
	push(@lines, "An error has occured: $@"); 
}


print join("\n", @lines); 

#print @lines;	

print qq!<A HREF=\"http://127.0.0.1/cgi-bin/online.html\"><P ALIGN=\"right\"><IMG SRC = \"http://127.0.0.1/cgi-bin/images/01.gif\"></A>!; 

print end_html; 





#2-----------------------------------------------------------------------------
sub do_main { 

	
my @thread_ids = get_message_ids_whose_value_is_zero(); 	
	
push(@lines, qq!<TABLE BORDER=0>!); 

foreach my $id ( @thread_ids ) { 
		push(@lines, 
			qq!<TR><TD>!, 
  			 get_thread_messages($id, 0), 
			qq!</TD></TR>!, 
		); 
	} 

push(@lines, qq!</TABLE>!); 

return(); 

} 






#3-----------------------------------------------------------------------------
sub do_post { 

	
	
	param('action', 'save'); 
        
	push(@lines, 
		start_form, 
	hidden('parent_id', 0), 
	   qq!<TABLE BORDER=0><TR><TD><B><IMG SRC = \"http://127.0.0.1/cgi-bin/images/title.jpg\"></B></TD><TD>!, 
	textfield(-name=>'title', -maxlength=>50),
	    qq!</TD></TR><TR><TD><B><IMG SRC = \"http://127.0.0.1/cgi-bin/images/name.jpg\"></B></TD><TD>!, 
       	textfield(-name=>'name', -maxlength=>50), 
	qq!</TD></TR><TR><TD><IMG SRC = \"http://127.0.0.1/cgi-bin/images/email.jpg\"></TD><TD>!, 
		  textfield(-name=>'email', -maxlength=>50), 
qq!</TD></TR><TR><TR><TD><B><IMG SRC = \"http://127.0.0.1/cgi-bin/images/link.jpg\"></B></TD><TD>!,
		textfield(-name=>'link', -maxlength=>255), 
		qq!</TD></TR><TR><TD VALIGN="middle"><B><IMG SRC = \"http://127.0.0.1/cgi-bin/images/message.jpg\"></B></TD>!,
	qq!<TD>!, 
		textarea(-name=>'message',-rows=>8,-columns=>50), 
		qq!</TD></TR></TABLE>!, 
	hidden('action'), 
		submit('Post Message'), 
		 reset, 
		end_form, 
	); 

	 return(); 

} 






#4-----------------------------------------------------------------------------
sub do_reply { 

	
	param('action', 'save'); 

	
	my $parent_id = param('parent_id'); 
	my $sql = "SELECT title, message FROM msg WHERE id=$parent_id"; 

         if($dbh->Sql($sql)){ 
		die "ERROR: Invalid SQL in do_reply(): $!"; 
                               }
       
	$dbh->FetchRow();
        my ($title, $message) = $dbh->Data(); 


	$title = 'Re: ' . $title; 

	$message =~ s/^/\>/mg; 

	push(@lines, 
		 start_form, 
		hidden('parent_id', $parent_id), 
   qq!<TABLE BORDER=0><TR><TD><B><IMG SRC = \"http://127.0.0.1/cgi-bin/images/title.jpg\"></B></TD><TD>!, 
		textfield(-name=>'title', -default=>"$title",
				  -maxlength=>50),
		qq!</TD></TR><TR><TD><B><IMG SRC = \"http://127.0.0.1/cgi-bin/images/name.jpg\"></B></TD><TD>!, 
	textfield(-name=>'name', -maxlength=>50), 
		qq!</TD></TR><TR><TD><B><IMG SRC = \"http://127.0.0.1/cgi-bin/images/email.jpg\"></B></TD><TD>!, 
        	   textfield(-name=>'email', -maxlength=>50), 
		qq!</TD></TR><TR><TR><TD><B><IMG SRC = \"http://127.0.0.1/cgi-bin/images/link.jpg\"></B></TD><TD>!,
textfield(-name=>'link', -maxlength=>255), 
		qq!</TD></TR><TR><TD VALIGN="middle"><B><IMG SRC = \"http://127.0.0.1/cgi-bin/images/message.jpg\"></B></TD>!,
		      qq!<TD>!, 
	textarea(-name=>'message',-default=>"$message",
				 -rows=>8,-columns=>50), 
		    qq!</TD></TR></TABLE>!, 
		hidden('action'), 
		submit('Save Reply'), 
		reset, 
		 end_form, 
	); 

	return(); 

} 





#5-----------------------------------------------------------------------------
sub do_save { 
	my %vars; 
	my @errors; 

	
	foreach my $key ( param() ) { 
		$vars{$key} = param($key); 
	}

	
	if( $vars{'title'} eq '' ) { 
		push(@errors, 'Title is a required field'); 
	}

	if( $vars{'name'} eq '' ) { 
		push(@errors, 'Name is a required field'); 
	}

	if( $vars{'message'} eq '' ) { 
		push(@errors, 'You did not input a message'); 
	} 

	if( $vars{'email'} eq '' ) { 
		push(@errors, 'Email is a required field');
        }

        if( $vars{'link'} eq '' ) { 
		push(@errors, 'You must try to give some link if you would answer the question!');
        }
	
	if(@errors) { 
		push(@lines, 
			qq!<B>Some errors occured:</B>!, 
			join('<BR>', @errors), 
		); 

		if( $vars{'action'} =~ /Post/ ) { 
			push(@lines, do_post()); 
		}
		else { 
			push(@lines, do_reply()); 
		}

		return(); 

	}

	$vars{message} =~ s/'/''/g; 
	$vars{message} =~ s/\\/\\\\/g; 
	$vars{message} =~ s/\</\&lt;/g; 
	$vars{message} =~ s/\>/\&gt;/g; 

	$vars{name} =~ s/'/''/g; 
	$vars{name} =~ s/\\/\\\\/g; 

	$vars{title} =~ s/'/''/g; 
	$vars{title} =~ s/\\/\\\\/g; 

	
         my $sqll = "INSERT INTO msg (parent_id, created,title,name, email, link, message) VALUES ($vars{parent_id},Now,'$vars{title}','$vars{name}' , '$vars{email}', '$vars{link}', '$vars{message}')";  
                                
         if($dbh->Sql($sqll))
         { die "ERROR in saving message: $!";
              }
	push(@lines, 
		qq!<CENTER><B>Thank you for your submission</B><BR>!, 
		qq!<A HREF="$script">Back to main page of online forum</A></CENTER>!, 
	); 

	return(); 

}








#6-----------------------------------------------------------------------------
sub do_view { 
	my $id = param('id'); 

	
        if( $dbh->Sql("SELECT * FROM msg WHERE id=$id"))
        {
		die "ERROR: Invalid SQL in do_view(): $!"; 
        }
      
         $dbh->FetchRow();
	my ($cid, $pid,$created,$title, $name, $email, 
                  $link, $message ) = $dbh->Data(); 

	
	push(@lines, 
		qq!<TABLE BORDER="15">!,
		qq!<TR><TD><B>Title:</B></TD><TD>$title</TD></TR>!, 
	); 

	
	if($email ne '' ) { 
		push(@lines, 
			qq!<TR><TD><B>Name:</B></TD><TD>!, 
			qq!<A HREF="mailto:$email">$name</A></TD></TR>!, 
		); 
	}
	else { 
		push(@lines, qq!<TR><TD><B>Name:</TD><TD>$name</TD></TR>!); 
	}
	
	
	if($link ne '' ) { 
		push(@lines, 
			qq!<TR><TD><B>Link:</B></TD><TD><A HREF="$link">$link!,
			qq!</A></TD></TR>!,
		); 
	}

	
	$message =~ s/\n/<BR>/g; 

	push(@lines, 
		qq!<TR><TD VALIGN="TOP"><B>Message:</B></TD><TD>$message!,
		qq!</TD></TR></TABLE><P>!,
		qq!<A HREF="$script?action=reply\&parent_id=$id">!, 
		qq!Reply to this message</A>!, 
	); 

	push(@lines, 
		qq!<P><B>Replies:</B><HR SIZE="1">!, 
		get_thread_messages($id, 0, 'replies'), 
	); 
	 
	return(); 

} 









#7-----------------------------------------------------------------------------
sub  get_message_ids_whose_value_is_zero { 
         my @ids; 

       my $sqll = "SELECT id FROM msg WHERE parent_id=0 ".
                                         "ORDER BY created";
         
                                
        if($dbh->Sql($sqll))
        {
        die "ERROR: invalid SQL in  get_message_ids_whose_value_is_zero(): $!";
        }
               
  
       while($dbh->FetchRow())
     {  my $id=$dbh->Data("id");
        push(@ids, $id); 
     }
       return(@ids);
   
      

} 







#8-----------------------------------------------------------------------------
sub get_thread_messages { 
	my ($parent_id, $depth, $replies) = @_; 
	my $output;
         
	
	if( !$replies ) {  
		$output .= generate_link($parent_id, $depth); 
	}
        
	
	my $sql = 	"SELECT id FROM msg WHERE parent_id=$parent_id ".
				"ORDER BY created";
	
        if( $dbh->Sql($sql)) 
            {
               die "ERROR: invalid SQL in get_thread_messages(): $!";
             }
       
          $dbh->fetchrow;
        while( my $id = $dbh->Data() ) { 

		
		if( has_children($id) ) { 
			$output .= get_thread_messages($id, $depth+2 ); 
		}
		else { 
		        $output .= generate_link($id, $depth+2); 
		}
	}

      
	return($output); 

} 






#9-----------------------------------------------------------------------------
sub has_children { 
	my $id = shift; 

	my $sql = "SELECT count(*) FROM msg WHERE parent_id=$id"; 

        if($dbh->Sql($sql))
        {


                die "ERROR: Invalid SQL in has_children(): $!";
        }
       

	
        my $count = $dbh->fetchrow; 

       

	if( $count > 0 ) { 
		return(1); 
	}
	else { 
		return(0); 
	}

}







#10-----------------------------------------------------------------------------
sub generate_link { 
	my ($id, $depth) = @_; 
	my $output; 

	my $sqll = "SELECT title, name FROM msg WHERE id=$id"; 
	
	
        if($dbh->Sql($sqll))
        {

		die "ERROR: Invalid SQL in generate_link(): $!"; 
        }

        $dbh->FetchRow();
        my ($title,$name,$created) = $dbh->Data(); 
	
	$output = 	'&nbsp;&nbsp;' x $depth . 
				 qq!<A HREF="$script?action=view\&id=$id">$title</A>!.
				qq! $name <BR>\n!;

	return($output); 

}

