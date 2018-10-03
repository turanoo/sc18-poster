#!/bin/bash
#SBATCH --job-name="atacama-dada2"
#SBATCH --mem=320000
#SBATCH --cpus-per-task=16
#SBATCH --time=72:00:00


module load qiime2/2018.6

qiime dada2 denoise-paired \
  --i-demultiplexed-seqs data-paired/demux.qza \
  --p-trunc-len-f 0 \
  --p-trunc-len-r 0 \
  --o-table data-paired/dada2-paired-table.qza \
  --o-representative-sequences data-paired/dada2-paired-rep-seqs.qza \
  --o-denoising-stats data-paired/dada2-paired-denoising-stats.qza

qiime feature-table summarize \
  --i-table data-paired/dada2-paired-table.qza \
  --o-visualization data-paired/visualizations/dada2-paired-table.qzv \
  --m-sample-metadata-file sample-metadata.tsv

qiime feature-table tabulate-seqs \
  --i-data data-paired/dada2-paired-rep-seqs.qza \
  --o-visualization data-paired/visualizations/dada2-paired-rep-seqs.qzv
