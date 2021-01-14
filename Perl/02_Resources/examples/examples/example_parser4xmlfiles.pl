#!/usr/local/bin/perl

###################################################
#    parser one xml file to  txt file             #
#    write by jiaxl for corba 2.0 xmlfile 	  #
###################################################
use strict;
use warnings;
use FileHandle;
use XML::Parser;
use Data::Dumper;
use Getopt::Long;

my ( $xml_file , $dest_dir) ;
$xml_file = $ARGV[0];
$dest_dir = $ARGV[1];

my  $usage =<<"EOF";
Usage:
  $0  <xml_file> <dest_dir>  
EOF
if (!($xml_file && $dest_dir ))
{
    print $usage ;
    exit -1;
}

my $qetxt_ref ;  # use method : $data_ref->{$table}->[0] = 'column0' ;
my @element_stack ;
my @measTypes;
my @measResults ;
my $measTypes_hash;
my $measResults_hash;
my ($elementType, $localDn, $measObjLdn, $beginTime, $endTime, $duration, $cur_element, $cur_number) ;
my $name_theme;
my $line_char;

my $data_ref ;  # use method : $data_ref->{$attribute_name} = $attribute_value ;
my %hTableName = ( 'MscFunction'=>'MscFunction',
                   'Msc'=>'MscFunction',
                   'MSC'=>'MscFunction',
                   'VlrFunction' => 'VlrFunction' ,
                   'Vlr' => 'VlrFunction' ,
                   'VLR' => 'VlrFunction' ,
                   'HlrFunction' => 'HlrFunction' ,
                   'Hlr' => 'HlrFunction' ,
                   'HLR' => 'HlrFunction' ,
                   'AcFunction' => 'AcFunction' ,
                   'Ac' => 'AcFunction' ,
                   'EirFunction' => 'EirFunction' ,
                   'CircuitEndPointSubgroup' => 'CircuitEndPointSubgroup' ,
                   'CircuitEndPointSubGroup' => 'CircuitEndPointSubgroup' ,
                   'TKGP' => 'CircuitEndPointSubgroup' ,
                   'ObservedDestionation' => 'ObservedDestionation' ,
                   'ObservDest' => 'ObservedDestionation' ,
                   'SignallingLinkSetTP' => 'SignallingLinkSetTP' ,
                   'signallingLinkSetTP' => 'SignallingLinkSetTP' ,
                   'SignallingLinkTP' => 'signallingLinkTP' ,
                   'signallingLinkTP' => 'signallingLinkTP' ,
                   'BscFunction' => 'BscFunction' ,
                   'Bsc' => 'BscFunction' ,
                   'BtsFunction' => 'BtsFunction' ,
                   'Bts' => 'BtsFunction' ,
                   'Sector' => 'sector' ,
                   'PcfFunction' => 'PcfFunction' ,
                   'Pcf' => 'PcfFunction' ,
                   'PdsnFunction' => 'PdsnFunction' ,
                   'HaFunction' => 'HaFunction' ,
                   'AaaFunction' => 'AaaFunction' 
                  ) ;
my $FH_O ; # ;

######  main program  ####### 

#read QETXT.INI 
$dest_dir =~ s/(.*)\/$/$1/;
&read_qetxt( "$dest_dir/QETXT.INI" );

#parser xml
my $xml_hd = new XML::Parser(ErrorContext => 2);
$xml_hd->setHandlers(	Start   => \&_start_handler,
			Char    => \&_char_handler,
			End     => \&_end_handler);
$xml_hd->parsefile($xml_file);

######  end of main  ########

sub read_qetxt {
    my $file_name = shift ;
    my $FH = new FileHandle("$file_name") || die "can not open $file_name\n";
    
    my ($cur_tab ,$line ,$idx) ;
    while( $line = <$FH> ){
        
        if( $line =~ /^\s*\[(\S+)\]\s*$/ ){
            $cur_tab = $1; 
            $idx = 0 ;
            next ;       	
        }	
       	
       	if( $line =~ /^\s*FIELD\d+=(\w+),/ ){
       	    $qetxt_ref->{$cur_tab}->[$idx] = uc $1 ;
       	    $idx++;
       	    next;
       	}	
    }

    close($FH);
}


sub _start_handler
{
	my $pc = shift;
	my $ELEMENT = shift;
	my %ATTR = @_;

	undef($line_char);
         
        $cur_element = $ELEMENT;
        push @element_stack , $ELEMENT ;
        
        #NE type => fileName	
	if( $ELEMENT eq 'fileSender' && $element_stack[@element_stack -2 ] eq 'fileHeader'){
	    $elementType = $ATTR{'elementType'};	
	    $localDn = $ATTR{'localDn'};	

	    #open file 
	    my $file_name = "$dest_dir/$hTableName{$elementType}.txt";
            $FH_O = new FileHandle(">>$file_name") || die "can not open $file_name\n";
        
        #beginTime of file     		
	}elsif( $ELEMENT eq 'measCollec' && $element_stack[@element_stack -2 ] eq 'fileHeader' ){
	    $beginTime = $ATTR{'beginTime'} ;	

        #endTime of file
	}elsif( $ELEMENT eq 'measCollec' && $element_stack[@element_stack -2 ] eq 'fileFooter' ){
	    $endTime = $ATTR{'$endTime'} ;	


        #managedElement localDn
	}elsif( $ELEMENT eq 'managedElement' ){
	    $localDn = $ATTR{'localDn'};	

        #duration , endTime
	}elsif( $ELEMENT eq 'granPeriod' ){			
	    $duration = $ATTR{'duration'};	
	    $endTime = $ATTR{'endTime'};	
       
        #measObjLdn
	}elsif( $ELEMENT eq 'measValue' ){
	    $measObjLdn = $ATTR{'measObjLdn'};	
	     $name_theme=$measObjLdn;
		my $name_dn = $hTableName{$elementType} ;
		if (($name_dn=~ /MscFunction/) or ($name_dn=~ /VlrFunction/)){
#print "=======$name_dn=========\n";
			$name_theme=~ /^(\S+),\w*Function=\w+$/;
			$name_theme=$1;
#print "$name_theme\n";
		}


        #measType
	}elsif( $ELEMENT eq 'measType' ){
	    $cur_number = $ATTR{'p'};
            
        #measResults
	}elsif( $ELEMENT eq 'r' ){
	    $cur_number = $ATTR{'p'};
        }
}


sub _end_handler
{
	my $pc = shift;
	my $ELEMENT = shift;
	my $model = shift;

	undef($line_char);

        #print "end: $ELEMENT\n";
        pop @element_stack ;
        $cur_element = $element_stack[@element_stack -1] ;
        
	# output the data 
	if( $ELEMENT eq 'measValue' ){
	   
	    #print Dumper($measResults_hash),Dumper($measTypes_hash);
	    foreach my $key (sort{$a<=>$b} keys %$measTypes_hash) {
		$measTypes[$key-1] = $measTypes_hash->{$key};
		$measResults[$key-1] = $measResults_hash->{$key};
	    }
	    #print Dumper(\@measResults),Dumper(\@measTypes);
	    #exit;
            for( my $i = 0 ; $i<@measTypes ; $i++){
                 my $col_name =uc $measTypes[$i];
                 $col_name =~ s/^\w+\.//;
            	 $data_ref->{$col_name} = uc $measResults[$i];            	 
            }	

            $beginTime =~ s/T/ /g;
            $beginTime =~ s/\+\S+$//;
            $beginTime =~ s/\-\S+$//;
            $endTime =~ s/T/ /g;
            $endTime =~ s/\+\S+$//;
            $endTime =~ s/\-\S+$//;
            if( $duration =~ /(\d+)/ ){
            	$duration = $1 ;
            }	 
	    $beginTime =~ s/(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}).*/$1/;
	    $endTime =~ s/(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}).*/$1/;
            $data_ref->{uc 'beginTime'} = $beginTime ;
            $data_ref->{uc 'endTime'}   = $endTime ;
            $data_ref->{uc 'duration'}  = $duration ;
	    $data_ref->{uc 'theme'}  = $name_theme ;

            if( $localDn =~ /,\s*$/ ){
                $data_ref->{uc 'dn'}  = $localDn.$measObjLdn ;
            }else{    
                $data_ref->{uc 'dn'}  = $measObjLdn ;
            }         
            	
            my $line ;
            my $tab_name = $hTableName{$elementType} ;
            my $arr_tab = $qetxt_ref->{$tab_name} ;
            for( my $i =0 ; $i < @$arr_tab ; $i++){ 
            	my $column = $qetxt_ref->{$tab_name}->[$i] ;
            	if( defined($line) ){
            	    $line .= "\t".$data_ref->{$column};
            	}else{
                    $line = $data_ref->{$column};
            	}
            }	
	    print $FH_O "$line\n" ;	

	}	

	#close file after all element has ended .
	if( @element_stack == 0 ){
	    	close( $FH_O );
	}	

}


sub _char_handler
{
	my $pc = shift;
	my $CHAR = shift;

	$line_char .=$CHAR;
	$CHAR = $line_char;

        #print "CHAR:$CHAR\n";
	if ($CHAR =~ /^NIL$/ || $CHAR =~ /^IL$/ || $CHAR =~ /^L$/) {
		$CHAR ='';
	}
        if( $cur_element eq 'measType' ){
    
            $measTypes_hash->{$cur_number} =  $CHAR;  
	    $measTypes_hash->{$cur_number} =~ s/\s*//g;
	    $measTypes_hash->{$cur_number} =~ s/\n//g;

	}elsif( $cur_element eq 'r' ){
        
            $measResults_hash->{$cur_number} = $CHAR ; 
	    $measResults_hash->{$cur_number} =~ s/\s*//g;
	    $measResults_hash->{$cur_number} =~ s/\n//g;
        }    		
}

sub trim {
    my $str = shift;
    $str =~ s/^[\s\t\n]+//;
    $str =~ s/[\s\t\n]+$//;
    return $str;
}
