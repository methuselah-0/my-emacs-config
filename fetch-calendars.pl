#!/usr/bin/env perl
use warnings;
use strict;

my $debug = 0;

my $wget = "~/.guix-profile/bin/wget";
my $ical2org = "$ENV{HOME}/src/my-emacs-config/ical2org.pl";
my $perlscript = "$ENV{HOME}/src/my-emacs-config/org-schedule.pl";

my $base_dir = "$ENV{HOME}/org";
my $org_dir  = "$ENV{HOME}/org/";
my $timezone = "X-WR-TIMEZONE:Europe/Stockholm";

my @addfiles;

my $calendarsfile = $ARGV[0];
my $todokeywordsfile = $ARGV[1];

open(FILE1, $calendarsfile);
my @lines = <FILE1>;
close (FILE1);
my @cals;
my %calendars;
foreach my $line(@lines){
    #print STDOUT $line;
    if ( $line =~ /(\S+)\ (\S+calendar\.ics$)/) {
	#my $string = "MATCH1: " . $1 . "\n" . "MATCH2: " . $2 . "\n";
	#print STDOUT $string;
	push @cals, "$1";
	$calendars{"$1"} = "$2";
    }
    elsif ( $line =~ /(\S+$)/) {
	#my $string = "MATCH1: " . $1 . "\n" . "MATCH2: " . $2 . "\n";
	#print STDOUT $string;
	push @addfiles, "$1";
	#$calendars{"$1"} = "$2";
    }    
}

chdir $base_dir;

foreach my $cal (@cals) {
    next unless $calendars{$cal};

    my $cmd = "$wget -q -O $cal.ics.new $calendars{$cal} && mv $cal.ics.new $cal.ics && sed -i '/X-WR-CALNAME/aX-WR-TIMEZONE:Europe/Stockholm' $cal.ics";
    print STDERR "$cmd\n" if $debug;
    system $cmd;

    next unless -r "$cal.ics";

    $cmd = "perl $ical2org -c $cal < $base_dir/$cal.ics > $org_dir/$cal.org.new";
    print STDERR "$cmd\n" if $debug;
    system $cmd;

    if ( -s "$org_dir/$cal.org.new" ) {
	my $cmd2 = "perl $perlscript $org_dir/$cal.org $org_dir/$cal.org.new $todokeywordsfile && if ! diff -s &>/dev/null $org_dir/$cal.org.new $org_dir/$cal.org ; then mv $org_dir/$cal.org $org_dir/$cal.org.old && mv $org_dir/$cal.org.new $org_dir/$cal.org ; fi";
	print STDERR "$cmd2\n" if $debug;
	system $cmd2;
    }
}
#my @files qw(notes);
foreach my $file (@addfiles) {
    my $cmd = "perl $perlscript $file $file.new $todokeywordsfile && if ! diff -s &>/dev/null $file.new $file ; then mv $file $file.old && mv $file.new $file; fi";
    system $cmd;
}
