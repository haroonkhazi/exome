$vcffile = $ARGV[0];
$outfile = $ARGV[1];
open VCF, $vcffile;
open OUTFILE, ">$outfile" or die "Could not open $outfile for writing";

use Data::Dumper qw(Dumper);

my @vcf_array = ();
my @info_array = ();
my @format_array = ();
my %data;


while ($line=<VCF>){
    my $dp_value = 0;
    chomp $line;
    my @vcf_array = split('\t',$line);
    my @info_array = split('\:',$vcf_array[9]);
    my $id = "".$vcf_array[10];
    my $gene = $info_array[1];
    #print STDERR "$info_array[0]\n";
   
    $data{$id}{$gene}{count}++;
     #print STDERR "$id\t$gene\t$data{$id}{$gene}{count}\n";
}
print Dumper \%data;

foreach my $id (sort keys %data) {
    local $/="\r\n";
    chomp;
    print OUTFILE "$id\t";
    my @format_array = ($id);
    foreach my $gene (keys %{$data{$id} }) {
	chomp;
	#print "$data{$id}{$gene}{count}\n";
	##print STDERR "$data{$id}{$gene}\n";
        print OUTFILE "$data{$id}{$gene}{count}\t";
    }
    print OUTFILE "\n";
}
	
