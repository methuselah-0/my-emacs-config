#!/usr/bin/env perl
use warnings;
use strict;
use Data::ICal;
use Data::Dumper;
use DateTime::Format::ICal;
use Getopt::Long;
use DateTime::Duration;    

# perl perlscript.pl infile-wth-timestamps.org outfile-with-sheduled-timestamps.org ~/.emacs.d/todokeywords.txt
my $infile = $ARGV[0];
my $outfile = $ARGV[1];
my $keywordsfile = $ARGV[2];

open(FILE1, "$infile");
my @lines = <FILE1>;
close (FILE1);

open(FILE2, "$keywordsfile");
my @keywords = <FILE2>;
close (FILE2);

open (OUTFILE, ">$outfile");
my $index = 0;
my $currentOrgHeader;
my %currentOrgHeaderIndex;
my @newlines;


foreach my $line(@lines)
{
    sub org_date_range {
	use DateTime::Duration;    
	my $start = shift;
	my $end = shift;
	my $now = DateTime->now;
	$now->add(hours => 1); # for timezone UTC+1
	my $startstr = sprintf('<%04d-%02d-%02d %s %02d:%02d>',
			       $start->year,
			       $start->month,
			       $start->day,
			       $start->day_abbr,
			       $start->hour,
			       $start->minute
	    );
	# TODO here, change all 00:00 to 23:59 and minus 1 day.
	my $endstr = sprintf('<%04d-%02d-%02d %s %02d:%02d>',
			     $end->year,
			     $end->month,
			     $end->day,
			     $end->day_abbr,
			     $end->hour,
			     $end->minute
	    );
	# https://github.com/houseabsolute/DateTime.pm/wiki/Sample-Calculations
	my $interval = DateTime::Duration->new( days => 0, hours => 0, minutes => 30 );
	
	my $str = '';
	if ( $start > $now && $start - $interval < $now ) {
	    $str .= sprintf('SCHEDULED: ');
	    #print STDOUT "$start\n$end\n$now\n";	
	}
	# Assume it's an appointment, not an event with duration
	if ($startstr eq $endstr){
	    $str .= $startstr;
	}
	else {
	    $str .= $startstr;
	    $str .= '--';
	    $str .= $endstr;
	}
	return $str;
    }
    #print STDOUT $index
    #if ($index

    my $mystring = ("index: " . $index . "line: " . $line) ;
    if ( $line =~ /(^\*+\ .+)/ ) {
	$currentOrgHeaderIndex{$1} = $index ;
	$currentOrgHeader = $1 ;
    };

    # is a long-form duration timestamp
    if ($line =~ /<(.*)>--<(.*)>/)
    {
	my $date1 = $1;
	my $date2 = $2;
	$line =~ /<([0-9]{4})\-([0-9]{2})\-([0-9]{2})\ (\S*)\ ([0-9]{2}):([0-9]{2})>--<([0-9]{4})\-([0-9]{2})\-([0-9]{2})\ (\S*)\ ([0-9]{2}):([0-9]{2})/;
#	#print STDOUT "found\n$date1 $date2 $3 $4 $5 $6 $7 $8 $9 $10 $11 $12 lala\n";
	my $dt1 = DateTime->new( year => $1, month => $2, day => $3 , hour => $5, minute => $6);
	my $dt2 = DateTime->new( year => $7, month => $8, day => $9 , hour => $11, minute => $12);
	
	my $result = org_date_range($dt1, $dt2);
	my $i = $currentOrgHeaderIndex{$currentOrgHeader};
	
	if ($result =~ /(^SCHEDULED: .+)/) {
	    if ($newlines[$i] =~ /(^\*+ )(.+)/) {
		# possibly has a keyword
		#print STDOUT "newlines i is: $newlines[$i]";		
		if ($newlines[$i] =~ /(^\*+ )(\S+) (.+)/) {
		    #print STDOUT "$newlines[$i] may have a keyword";
		    my $keyword = "";
		    foreach my $kw(@keywords){
			chomp $kw;
			if ( $2 eq "$kw" ){
			    $keyword = "$kw";
			}
		    }
		    if ($keyword eq ""){
			#print STDOUT "keyword is: " . $keyword . "\n";
			my $new_newlines = $1 . "NEXT " . "$2 $3\n";
			$newlines[$i] = $new_newlines;			
		    }
		    elsif (($keyword eq "CANCELLED") or ($keyword eq "NEXT" )) {
			#print STDOUT "keyword is: " . $keyword . "\n";
			my $new_newlines = $1 . "$2 " . $3 . "\n";
			$newlines[$i] = $new_newlines;			
		    }
		    else {
			#print STDOUT "keyword is: " . $keyword . "\n";			
			my $new_newlines = $1 . "NEXT " . $3 . "\n";
			$newlines[$i] = $new_newlines;
		    }
		}
		# no keyword
		else {
		    #print STDOUT "$newlines[$i] has no keyword";		    
		    my $new_newlines = $1 . "NEXT " . $2 . "\n";
		    $newlines[$i] = $new_newlines;
		}		    
	    }
	}
    }
    
    # a short-form duration timestamp with repeater interval    
    elsif ($line =~ /<([0-9]{4})\-([0-9]{2})\-([0-9]{2})\ (\S*)\ ([0-9]{2}):([0-9]{2})\-([0-9]{2}):([0-9]{2}) (\+\d+(d|w|m|y))>/) {

	my $dt1 = DateTime->new( year => $1, month => $2, day => $3 , hour => $5, minute => $6);
	my $dt2 = DateTime->new( year => $1, month => $2, day => $3 , hour => $7, minute => $8);

	my $now = DateTime->now;
	$now->add(hours => 1); # for timezone UTC+1

	my $i = $currentOrgHeaderIndex{$currentOrgHeader};

	my $repeat_num;
	my $repeater;
	
	if ($9 =~ /(\+)(\d+)((d|w|m|y))/){
	    $repeat_num = $2;
	    $repeater = $3;
	    if ($repeater eq "w"){
		$repeat_num = $repeat_num * 7;
		$repeater = "d";
	    }
	}
	
	until ( $dt1 > $now ) {
	    # if timestamp is not within range it should be increased by repeater interval
	    if ($repeater eq "d"){
		$dt1->add(days => $repeat_num);
	    } elsif ($repeater eq "m"){
		$dt1->add(months => $repeat_num);
	    } elsif ($repeater eq "y"){
		$dt1->add(years => $repeat_num);
	    }
	}
	    
	my $result = org_date_range($dt1, $dt2);
	if ($result =~ /(^SCHEDULED: .+)/) {
	    if ($newlines[$i] =~ /(^\*+ )(.+)/) {		
		
		# possibly has a keyword
		#print STDOUT "newlines i is: $newlines[$i]";
		if ($newlines[$i] =~ /(^\*+ )(\S+) (.+)/) {
		    #print STDOUT "$newlines[$i] may have a keyword";
		    my $keyword = "";
		    foreach my $kw(@keywords){
			chomp $kw;
			if ( $2 eq $kw ){
			    $keyword = $kw;
			}
		    }
		    if ($keyword eq ""){
			#print STDOUT "keyword is: " . $keyword . "\n";
			my $new_newlines = $1 . "NEXT " . "$2 $3 \n";
			$newlines[$i] = $new_newlines;			
		    }
		    elsif (($keyword eq "CANCELLED") or ($keyword eq "NEXT" )) {
			#print STDOUT "keyword is: " . $keyword . "\n";
			my $new_newlines = $1 . "$2 " . $3 . "\n";
			$newlines[$i] = $new_newlines;			
			}
		    else {
			#print STDOUT "keyword is: " . $keyword . "\n";			
			my $new_newlines = $1 . "NEXT " . $3 . "\n";
			$newlines[$i] = $new_newlines;
			}
		}
		# no keyword
		else {
			#print STDOUT "$newlines[$i] has no keyword";
			my $new_newlines = $1 . "NEXT " . $2 . "\n";
			$newlines[$i] = $new_newlines;
		}	   
	    }	
	}	    
    }
    
    # a short-form duration timestamp
    elsif ($line =~ /<([0-9]{4})\-([0-9]{2})\-([0-9]{2})\ (\S*)\ ([0-9]{2}):([0-9]{2})-([0-9]{2}):([0-9]{2})>/)
    {
	my $dt1 = DateTime->new( year => $1, month => $2, day => $3 , hour => $5, minute => $6);
	my $dt2 = DateTime->new( year => $1, month => $2, day => $3 , hour => $7, minute => $8);
	
	my $result = org_date_range($dt1, $dt2);
	my $i = $currentOrgHeaderIndex{$currentOrgHeader};	
	if ($result =~ /(^SCHEDULED: .+)/) {
	    if ($newlines[$i] =~ /(^\*+ )(.+)/) {
		# possibly has a keyword
		#print STDOUT "newlines i is: $newlines[$i]";
		if ($newlines[$i] =~ /(^\*+ )(\S+) (.+)/) {
		    #print STDOUT "$newlines[$i] may have a keyword";
		    my $keyword = "";
		    foreach my $kw(@keywords){
			chomp $kw;
			if ( $2 eq $kw ){
			    $keyword = $kw;
			}
		    }
		    if ($keyword eq ""){
			#print STDOUT "keyword is: " . $keyword . "\n";
			my $new_newlines = $1 . "NEXT " . "$2 $3 \n";
			$newlines[$i] = $new_newlines;			
		    }
		    elsif (($keyword eq "CANCELLED") or ($keyword eq "NEXT" )) {
			#print STDOUT "keyword is: " . $keyword . "\n";
			my $new_newlines = $1 . "$2 " . $3 . "\n";
			$newlines[$i] = $new_newlines;			
		    }
		    else {
			#print STDOUT "keyword is: " . $keyword . "\n";			
			my $new_newlines = $1 . "NEXT " . $3 . "\n";
			$newlines[$i] = $new_newlines;
		    }
		}
		# no keyword

		else {
		    #print STDOUT "$newlines[$i] has no keyword";
		    my $new_newlines = $1 . "NEXT " . $2 . "\n";
		    $newlines[$i] = $new_newlines;
		}	   
	    }
	}
    }

    # appointment timestamp with repeater interval
    # TODO:
    elsif ($line =~ /<([0-9]{4})\-([0-9]{2})\-([0-9]{2})\ (\S*)\ ([0-9]{2}):([0-9]{2})\ (\+\d(d|w|m|y))>/)
    {

	my $dt1 = DateTime->new( year => $1, month => $2, day => $3 , hour => $5, minute => $6);
	my $dt2 = DateTime->new( year => $1, month => $2, day => $3 , hour => $5, minute => $6);

	my $now = DateTime->now;
	$now->add(hours => 1); # for timezone UTC+1

	my $i = $currentOrgHeaderIndex{$currentOrgHeader};

	my $repeat_num;
	my $repeater;
	
	if ($7 =~ /(\+)(\d+)((d|w|m|y))/){
	    $repeat_num = $2;
	    $repeater = $3;
	    if ($repeater eq "w"){
		$repeat_num = $repeat_num * 7;
		$repeater = "d";
	    }
	}
	
	until ( $dt1 > $now ) {
	    # if timestamp is not within range it should be increased by repeater interval
	    if ($repeater eq "d"){
		$dt1->add(days => $repeat_num);
	    } elsif ($repeater eq "m"){
		$dt1->add(months => $repeat_num);
	    } elsif ($repeater eq "y"){
		$dt1->add(years => $repeat_num);
	    }
	}
	    
	my $result = org_date_range($dt1, $dt2);
	if ($result =~ /(^SCHEDULED: .+)/) {
	    if ($newlines[$i] =~ /(^\*+ )(.+)/) {		
		
		# possibly has a keyword
		#print STDOUT "newlines i is: $newlines[$i]";
		if ($newlines[$i] =~ /(^\*+ )(\S+) (.+)/) {
		    #print STDOUT "$newlines[$i] may have a keyword";
		    my $keyword = "";
		    foreach my $kw(@keywords){
			chomp $kw;
			if ( $2 eq $kw ){
			    $keyword = $kw;
			}
		    }
		    if ($keyword eq ""){
			#print STDOUT "keyword is: " . $keyword . "\n";
			my $new_newlines = $1 . "NEXT " . "$2 $3 \n";
			$newlines[$i] = $new_newlines;			
		    }
		    elsif (($keyword eq "CANCELLED") or ($keyword eq "NEXT" )) {
			#print STDOUT "keyword is: " . $keyword . "\n";
			my $new_newlines = $1 . "$2 " . $3 . "\n";
			$newlines[$i] = $new_newlines;			
			}
		    else {
			#print STDOUT "keyword is: " . $keyword . "\n";			
			my $new_newlines = $1 . "NEXT " . $3 . "\n";
			$newlines[$i] = $new_newlines;
			}
		}
		# no keyword
		else {
			#print STDOUT "$newlines[$i] has no keyword";
			my $new_newlines = $1 . "NEXT " . $2 . "\n";
			$newlines[$i] = $new_newlines;
		}	   
		# else error
	    }	
	}	    
    }

    # TODO: match on appointment: change in sub org_date_range so that if start and end are the same value it is an appointment and return string should be in appointment format instead.
    elsif ($line =~ /<([0-9]{4})\-([0-9]{2})\-([0-9]{2})\ (\S*)\ ([0-9]{2}):([0-9]{2})>/)
    {

	my $dt1 = DateTime->new( year => $1, month => $2, day => $3 , hour => $5, minute => $6);
	my $dt2 = DateTime->new( year => $1, month => $2, day => $3 , hour => $5, minute => $6);

	my $result = org_date_range($dt1, $dt2);
	my $i = $currentOrgHeaderIndex{$currentOrgHeader};	

	# If within timerange, we need to modify the current org
	# header
	if ($result =~ /(^SCHEDULED: .+)/) {
	    if ($newlines[$i] =~ /(^\*+ )(.+)/) {		
		
		# possibly has a keyword
		#print STDOUT "newlines i is: $newlines[$i]";
		if ($newlines[$i] =~ /(^\*+ )(\S+) (.+)/) {
		    #print STDOUT "$newlines[$i] may have a keyword";
		    my $keyword = "";
		    foreach my $kw(@keywords){
			chomp $kw;
			if ( $2 eq $kw ){
			    $keyword = $kw;
			}
		    }
		    if ($keyword eq ""){
			#print STDOUT "keyword is: " . $keyword . "\n";
			my $new_newlines = $1 . "NEXT " . "$2 $3 \n";
			$newlines[$i] = $new_newlines;			
		    }
		    elsif (($keyword eq "CANCELLED") or ($keyword eq "NEXT" )) {
			#print STDOUT "keyword is: " . $keyword . "\n";
			my $new_newlines = $1 . "$2 " . $3 . "\n";
			$newlines[$i] = $new_newlines;			
			}
		    else {
			#print STDOUT "keyword is: " . $keyword . "\n";			
			my $new_newlines = $1 . "NEXT " . $3 . "\n";
			$newlines[$i] = $new_newlines;
			}
		}
		# no keyword
		else {
			#print STDOUT "$newlines[$i] has no keyword";
			my $new_newlines = $1 . "NEXT " . $2 . "\n";
			$newlines[$i] = $new_newlines;

		}
	    }	
	}
    }    
    # always add the current line as it is
    $newlines[$index] = "$line";
    $index = $index + 1;
}
# my $dump = Dumper %currentOrgHeaderIndex;
# print STDOUT $dump;
#my $dump = Dumper @newlines;
#print STDOUT $dump;
print OUTFILE @newlines;
#print STDOUT @newlines;
close (OUTFILE);
