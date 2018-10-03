#!/bin/bash
#SBATCH --job-name="atacama-demux"
#SBATCH --mem=80000
#SBATCH --cpus-per-task=1
#SBATCH --time=6:00:00

# import
qiime tools import \
  --type EMPPairedEndSequences \
  --input-path emp-paired-end-seqs \
  --output-path emp-paired-end-sequences.qza

# demux...
qiime demux emp-paired \
  --m-barcodes-file sample-metadata.tsv \
  --m-barcodes-column BarcodeSequence \
  --i-seqs emp-paired-end-sequences.qza \
  --o-per-sample-sequences demux \
  --p-rev-comp-mapping-barcodes

# ...and create a view
qiime demux summarize \
  --i-data demux.qza \
  --o-visualization demux.qzv
