#!/bin/bash
#SBATCH --job-name="atacama-dada2"
#SBATCH --mem=320000
#SBATCH --cpus-per-task=16
#SBATCH --time=72:00:00

module load qiime2/2018.6

qiime dada2 denoise-single \
  --i-demultiplexed-seqs data-single/demux.qza \
  --p-trunc-len 0 \
  --o-table data-single/dada2-single-table.qza \
  --o-representative-sequences data-single/dada2-single-rep-seqs.qza \
  --o-denoising-stats data-single/dada2-single-denoising-stats.qza

qiime feature-table summarize
  --i-table data-single/dada2-single-table.qza  \
  --o-visualization data-single/visualizations/dada2-single-table.qzv \
  --m-sample-metadata-file sample-metadata.tsv

qiime feature-table tabulate-seqs \
  --i-data data-single/dada2-single-rep-seqs.qza  \
  --o-visualization data-single/visualizations/dada2-single-rep-seqs.qzv
