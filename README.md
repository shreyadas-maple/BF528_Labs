# Single Cell RNAseq with Scanpy

## Setup
Make a .yml file that contains needed packages (this can be updated as you go). Initially,
we will want to install the following packages:

- scanpy=1.11.1
- ipykernel=6.29.5


Create the environment first using the command: `conda env create -f <name_of_file.yml>` 

Make a new jupyter notebook (.ipynb) and use the created environment as the kernel.

## Introduction

We will be analyzing two samples from this publication: https://pmc.ncbi.nlm.nih.gov/articles/PMC7815907/
Specifically, we will be looking at two samples from the postnatal d7 mouse hippocampus. In scanpy,
we will perform QC, and a basic scRNAseq workflow to cluster and annotate the cell populations present.

## Anndata and scanpy 

Anndata is a package in python designed for handling annotated matrix data in-memory and on-disk. It
was initially developed for scanpy, but it is a general framework that could be used in other applications.

[!anndata](docs/anndata.png)

For a brief summary taken directly from the scanpy website (https://scanpy.readthedocs.io/en/stable/usage-principles.html)

"At the most basic level, an AnnData object adata stores a data matrix adata.X, annotation of observations
 adata.obs and variables adata.var as pd.DataFrame and unstructured annotation adata.uns as dict. Names of 
 observations and variables can be accessed via adata.obs_names and adata.var_names, respectively. AnnData 
 objects can be sliced like dataframes, for example, adata_subset = adata[:, list_of_gene_names]"


For scanpy purposes, we will usually import scanpy like so:

```
import scanpy as sc
```

Most of the analysis tools in scanpy can be called with the pattern:

```
sc.tl.<name_of_tool>
```

And most of these tools have an associated plotting function:

```
sc.pl.<name_of_tool/plot>
```

## Sample files

You may find the sample files here: /projectnb/bf528/materials/single_cell/

Each sample is contained within a directory and you will need to use the filtered_feature_bc_matrix/

## Citations

Isaac Virshup, Sergei Rybakov, Fabian J. Theis, Philipp Angerer, F. Alexander Wolf. anndata: Annotated data
JOSS 2024 Sep 16. doi: 10.21105/joss.04371.)

Wolf, F., Angerer, P. & Theis, F. SCANPY: large-scale single-cell gene expression data analysis. 
Genome Biol 19, 15 (2018). https://doi.org/10.1186/s13059-017-1382-0