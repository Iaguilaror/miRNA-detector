##Declaring paths to original input files
##SRR ids table
##SRR_FILE="/castle/iaguilar/FABERE/miRNAs-detector/mks/input_data/SRR-test.txt"
##SRR_FILE="/labs/crve-fabian/mirna_vaca/miRNAs-detector/mks/input_data/batch2_SRR.txt"
SRR_FILE="/labs/crve-fabian/mirna_vaca/miRNAs-detector/mks/input_data/SRR-Final-746_samples.txt"

##Fasta Sequences to look for
SEQUENCES_FILE="/castle/iaguilar/FABERE/miRNAs-detector/mks/input_data/noAnotadosUnicosVacas_correctedControl.fa"

##Variables for filtering
##Number of cores for Trimmomatic
T_CORES="3"

###Number of lines for quick survey of adapter presence via cutadapt (lines /4 = number of reads)
SURVEY_LINES="40000"	##MUST BE MULTIPLE OF 4

###CUTADAPT VARIABLES
ADAPTER_CUTTOF="50" ###fastqc files with a lower percentage of reads with adapter than this value, will not be adapter trimmed with cutadapt and pass complete to the next step of analysis. The reasoning is, reads come without adapter aleready.

##SEQUENCING READS VARIABLES
MIN_LENGTH="19"
MAX_LENGTH="999" ##needs fix
MIN_QUAL="30"

##PATHS to software
##TRIMdir="/run/media/winter/Winter_HDrive_2/Programs/Trimmomatic-0.32/trimmomatic-0.32.jar"
FASTQ_DUMP="/castle/iaguilar/dwn/bin/sratoolkit.2.8.2-1-ubuntu64/bin/fastq-dump"
TRIMdir="/castle/iaguilar/bin/trimmomatic.jar"
ASCP="/castle/iaguilar/.aspera/connect/bin/ascp"
ASPERA_KEY="/castle/iaguilar/.aspera/connect/etc/asperaweb_id_dsa.openssh"
