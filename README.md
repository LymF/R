# R — Bioinformatics Visualization and Statistics Scripts

A collection of R scripts for biological data visualization and statistical analysis, organized into visualization (`plots/`) and statistical analysis (`stats/`) categories. Developed primarily for transcriptomics, viral ecology, and diversity analyses in the context of invertebrate biology and virology research.

## Repository structure

```
R/
├── plots/    # Publication-quality visualization scripts
└── stats/    # Statistical analysis and differential expression
```

---

## plots/

Scripts for generating publication-quality figures from biological datasets.

| Script | Input | Description |
|---|---|---|
| `heatmap.R` | Count/expression matrix (TSV/CSV) | Clustered heatmap with hierarchical clustering of rows and columns; suitable for expression matrices and similarity scores |
| `heatmap_virus_eves.R` | Presence/absence or count matrix | Heatmap tailored for visualizing virus and EVE detection across samples |
| `heatmap_red.R` | Expression matrix | Alternative heatmap with a red color palette for fold-change or intensity data |
| `bubble_plot.R` | Data frame with category, size, and color variables | Bubble plot for multi-dimensional categorical comparisons |
| `chord_diagram.R` | Interaction/co-occurrence matrix | Circular chord diagram for visualizing associations between groups (e.g., virus–host, taxon–sample) |
| `circular_barplot.R` | Grouped data frame | Circular barplot for categorical abundance or count data |
| `circular_barplot_v2.R` | Grouped data frame | Alternative circular barplot layout |
| `alluvial_plot.R` | Categorical flow data frame | Alluvial/Sankey-style plot for visualizing sample composition transitions or taxonomic flows |
| `rna_density_plot.R` | Read length or count distribution table | Density plot for RNA-seq read length or expression distributions |
| `barplot_horizontal.R` | Count or proportion data frame | Horizontal barplot for ranked or comparative categorical data |
| `boxplot_tpm.R` | TPM expression table (samples × genes) | Boxplot of TPM values across samples for QC or group comparison |
| `donut_plot_mirna.R` | miRNA category proportions | Donut chart for visualizing proportional composition of miRNA classes |
| `sunburst_plot.R` | Hierarchical data frame | Sunburst chart for nested taxonomic or functional classification |
| `upset_plot.R` | Binary presence/absence matrix | UpSet plot for set intersection visualization across multiple sample groups |

### Key packages

```r
install.packages(c("ggplot2", "pheatmap", "circlize", "ggalluvial",
                   "UpSetR", "RColorBrewer", "viridis", "scales"))
```

---

## stats/

Scripts for differential expression analysis, diversity metrics, and non-parametric tests.

| Script | Input | Description |
|---|---|---|
| `deseq2_analysis.R` | Raw count matrix + sample metadata CSV | Full DESeq2 pipeline: object construction, size factor estimation, Wald test, DEG extraction, MA plot, PCA, and heatmap |
| `deseq2_lara.R` | Raw count matrix + sample metadata CSV | DESeq2 analysis adapted for a specific experimental design |
| `wilcoxon_test.R` | Numeric data frame with group labels | Wilcoxon rank-sum test for pairwise non-parametric comparison between two groups |
| `wilcoxon_test_auto.R` | Numeric data frame with group labels | Automated Wilcoxon test across multiple variables with multiple testing correction |
| `alpha_diversity_wilcoxon.R` | OTU/species count table | Alpha diversity index calculation (Shannon, Simpson, Chao1) with Wilcoxon test for group comparison |
| `shannon_diversity_index.R` | Species abundance table | Shannon entropy calculation per sample with visualization |

### Key packages

```r
if (!require("BiocManager")) install.packages("BiocManager")
BiocManager::install("DESeq2")
install.packages(c("ggplot2", "vegan", "dplyr", "tidyr", "ggpubr"))
```

---

## Usage

Scripts are designed to be run interactively in RStudio or sourced from the command line. Each script contains clearly defined input file path variables at the top — update these before running.

### RStudio

Open the desired `.R` or `.Rmd` file and run interactively, or source the entire file:

```r
source("stats/deseq2_analysis.R")
source("plots/heatmap.R")
```

### Command line (Rscript)

```bash
Rscript stats/wilcoxon_test.R
Rscript plots/bubble_plot.R
```

### Input format conventions

**Count matrix** (for DESeq2 and heatmaps):
```
gene_id    sample_A_rep1    sample_A_rep2    sample_B_rep1    sample_B_rep2
gene001    120              98               450              512
gene002    0                3                1                0
```

**Sample metadata** (for DESeq2):
```
,Condition
sample_A_rep1,control
sample_A_rep2,control
sample_B_rep1,treated
sample_B_rep2,treated
```

**Species/OTU abundance table** (for diversity scripts):
```
sample_id    species_1    species_2    species_3
sample_A     12           0            45
sample_B     0            8            31
```

---

## Notes

- All visualization scripts produce publication-ready figures; color palettes and theme settings can be adjusted within each script.
- Wilcoxon tests are non-parametric and appropriate for small sample sizes or non-normally distributed data.
