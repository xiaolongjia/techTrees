#!C:\user\local\Perl\bin

use URI;
use LWP::UserAgent;

my $code_file = './sh.code';
my $output_dir = './sh';

open (READ, $code_file) or die "cannot open file $code_file";
while(<READ>) {
    my $ric = $_;
    chomp($ric);
	
	my ($filename, $filesize) = download_price($ric);
	if ($filesize < 4000) {
		sleep(5);
		my ($filename, $filesize) = download_price($ric);
		print $ric,"\t",$filesize,"\n";
	}
	else {
		print $ric,"\t",$filesize,"\n";
	}
};
close(READ);

sub download_price {
	my $ric = shift;

	my $uri = URI->new( "http://table.finance.yahoo.com/table.csv?s=$ric.ss" ); #sh->ss; sz->sz
    $uri->query_form();
    my $ua = LWP::UserAgent->new;
    $ua->timeout(20);
    my $response = $ua->get( $uri->as_string );
    my $data = $response->content;
	my $datafile = $output_dir."/$ric.csv";
    open (WRITE, ">$datafile") or die "cannot open file $datafile";
    print WRITE "$data\n";
	close(WRITE);
	my @fileinfo = stat($datafile);
	my $filesize = $fileinfo[7];

	return ($datafile, $filesize);
}

