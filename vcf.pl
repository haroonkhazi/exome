$vcffile = $ARGV[0];
$outfile = $ARGV[1];
open VCF, $vcffile;
open OUTFILE, ">$outfile" or die "Could not open $outfile for writing";

use Data::Dumper qw(Dumper);

my @vcf_array = ();
my @info_array = ();
my @format_array = ();
my @value_array = ();

while ($line=<VCF>){
    my $dp_value = 0;
    chomp $line;
    my @vcf_array = split('\t',$line);
    chomp $vcf_array[9];
    my @info_array = split('\:',$vcf_array[9]);
    chomp $vcf_array[7];
    my @dp_array =  split('\;',$vcf_array[7]);
    
    if ($dp_array[0] eq "INDEL"){
	
	chomp $dp_array[1];
	#print "$dp_array[1]\n";
	my @value_array = split('\=',$dp_array[1]);
	print "$value_array[1]\n";
	$dp_value = $value_array[1];
    }
    else{
	chomp $dp_array[0];
	#print "$dp_array[0]\n";
	my @value_array = split('\=',$dp_array[0]);
	$dp_value = $value_array[1];
	print "$value_array[1]\n";
    }
    #print "$value_array[1]\n";
    my $id = $vcf_array[10];
    my $gene = $info_array[1];
    #print STDERR "$info_array[0]\n";
    print OUTFILE "$vcf_array[10]\t$vcf_array[0]\t$vcf_array[1]\t$gene\t$dp_value\n";
}

$to = 'haroonkhazi@gmail.com';
$from = 'hxk443@case.edu';
$subject = 'Analysis ';
$message = "$ARGV[1]";
 
open(MAIL, "|/usr/sbin/sendmail -t");
 
 #Email Header
print MAIL "To: $to\n";
print MAIL "From: $from\n";
print MAIL "Subject: $subject\n\n";
 #Email Body
print MAIL $message;

close(MAIL);
print "Email Sent Successfully\n";
