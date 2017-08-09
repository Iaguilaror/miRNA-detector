#==Declaring paths to original input files==#
##SRR ids table
##SRR_FILE="/castle/iaguilar/FABERE/miRNAs-detector/mks/input_data/SRR-test.txt"
##SRR_FILE="/labs/crve-fabian/mirna_vaca/miRNAs-detector/mks/input_data/batch2_SRR.txt"
##SRR_FILE="/labs/crve-fabian/mirna_vaca/miRNAs-detector/mks/input_data/SRA_list/SRR-Final-746_samples.txt"
SRR_FILE="/labs/crve-fabian/mirna_vaca/miRNAs-detector/mks/input_data/SRA_list/Hsa-cell-GEO_july2017.txt"
##SRR_FILE="/labs/crve-fabian/mirna_vaca/miRNAs-detector/mks/input_data/SRA_list/Hsa-tissue-GEO_july2017.txt"

#==Fasta Sequences to look for==#
##SEQUENCES_FILE="/labs/crve-fabian/mirna_vaca/miRNAs-detector/mks/input_data/fasta_sequences/noAnotadosUnicosVacas_correctedControl.fa"
##SEQUENCES_FILE="/labs/crve-fabian/mirna_vaca/miRNAs-detector/mks/input_data/secuencias_unicas.mir_most_abundant.fa"
SEQUENCES_FILE="/labs/crve-fabian/mirna_vaca/miRNAs-detector/mks/input_data/fasta_sequences/bta-miRNAs-mirbase_mariana_corrected.fa"

#==CONTROL Sequences to look for==#
NEGATIVE_SEQS="/labs/crve-fabian/mirna_vaca/miRNAs-detector/mks/input_data/fasta_sequences/controles_negativos.fa"
##POSITIVE_SEQS=

#==Variables for filtering==#
##Number of cores for Trimmomatic
T_CORES="4"

#==Number of lines for quick survey of adapter presence via cutadapt (lines /4 = number of reads)==#
SURVEY_LINES="40000"	#MUST BE MULTIPLE OF 4

#==CUTADAPT VARIABLES==#
ADAPTER_CUTTOF="50" #fastqc files with a lower percentage of reads with adapter than this value, will not be adapter trimmed with cutadapt and pass complete to the next step of analysis. The reasoning is, reads come without adapter aleready.

#==SEQUENCING READS VARIABLES==#
MIN_LENGTH="19"
MAX_LENGTH="999" #needs fix to make infinite
MIN_QUAL="30"

#==PATHS to software==#
FASTQ_DUMP="/castle/iaguilar/dwn/bin/sratoolkit.2.8.2-1-ubuntu64/bin/fastq-dump"
TRIMdir="/castle/iaguilar/bin/trimmomatic.jar"
ASCP="/castle/iaguilar/.aspera/connect/bin/ascp"
ASPERA_KEY="/castle/iaguilar/.aspera/connect/etc/asperaweb_id_dsa.openssh"
