
$snp_file = $ARGV[0];
$gff = $ARGV[1];
$outfile = $ARGV[2];

open SNP, $snp_file;
open GFF, $gff or die "Could not open $gff for writing";
open OUTFILE, ">$outfile" or die "Could not open $outfile for writing";
my @gff_array = ();
my @snp_array = ();
my $row = 0;
my @array = ();
my $j=0;
$count = `wc -l < $gff`;

while ($line=<GFF>) {
    #print STDERR "$count";
	chomp $line;
	my @gff_array = split('\,',$line);
	print STDERR "Loading GFF:$gff_array[0]:\n";
	for my $i(0..$#gff_array){
	    $array [$row][$i] = $gff_array [$i];
	}
	   $row ++;
            
}

while ($snp=<SNP>){
	chomp $snp;
	my @snp_array = split('\t',$snp);
	chomp @snp_array;
	print STDERR "Checking Chromosome $snp_array[1]\n";
	for ($j = 0; $j<$count + 2; $j=$j+1) {
	  
	  # print STDERR "$j \n";
	     if ($snp_array[0] eq $array[$j][0] and 
                $snp_array[1]>= $array[$j][1] and 
		 $snp_array[1]<= $array[$j][2]) {
		 print STDERR "match $snp\n";
		 print OUTFILE "$snp\t$array[$j][5]\n";
		 last;
	     }
	     elsif($j < $count + 1){
		 next;
	     }
	    # else{
	#	 print STDERR "intergene $snp\n";
	#	 print OUTFILE "$snp\tintergene\n";

	 #    }
	     
	}
}

$to = 'haroonkhazi@gmail.com';
$from = 'hxk443@case.edu';
$subject = 'Analysis ';
$message = "$ARGV[2]";
 
open(MAIL, "|/usr/sbin/sendmail -t");
 
 #Email Header
print MAIL "To: $to\n";
print MAIL "From: $from\n";
print MAIL "Subject: $subject\n\n";
 #Email Body
print MAIL $message;

close(MAIL);
print "Email Sent Successfully\n";
