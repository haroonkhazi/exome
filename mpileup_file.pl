
$mpilefile = $ARGV[0];
$outfile = $ARGV[1];
open MPI, $mpilefile;
open OUTFILE, ">$outfile" or die "Could not open $outfile for writing";

my @mpi_array = ();
my @info_array = ();
my %data;


while ($line=<MPI>){
    my $dp_value = 0;
    chomp $line;
    my @mpi_array = split('\t',$line);
    my $id = $mpi_array[10];
    
    my @info_array = split('\;',$mpi_array[7]);
    #print STDERR "$info_array[0]\n";
    my @value_array = split('\=', $info_array[0]);
    #print STDERR "$value_array[1]\n";
    $dp_value = $value_array[1];
    #print STDERR "$dp_value\n";
    $data{$id}{sum} += $dp_value;
    $data{$id}{count}++;
    #print STDERR "$vcf_array[0]\t$dp_value\n";
}
print OUTFILE "ID\tsum\tavg\tn\n";


for my $id (sort keys %data) {
    my $avg = $data{$id}{sum}/$data{$id}{count};
    print STDERR "$id\t$data{$id}{sum}\t$avg\t$data{$id}{count}\n";

    print OUTFILE "$id\t$data{$id}{sum}\t$avg\t$data{$id}{count}\n";
    #print OUTFILE "$id\t$data{$id}{sum}\t$avg\t$data{$id}{count}\n";
}


	
