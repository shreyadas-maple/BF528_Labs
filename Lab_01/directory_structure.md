# Generalized Nextflow Directory Structure - Project 0

```
nextflow-template/
├── bin
├── envs
│   └── base_env.yml
├── main.nf
├── modules
├── nextflow.config
├── refs
├── results
└── samples
```

**bin/**
  - Per the nextflow documentation, "The bin directory (if it exists) is always added to the $PATH for all tasks. If the tasks are performed on a remote machine, the directory is copied across to the new machine before the task begins."
  - If you need to incorporate any third-party scripts into your workflow, you can place them in the bin/ and set the appropriate permissions for an executable.
  - Make sure to also include a portable shebang line (e.g. #!/usr/bin/env)
  - Various docopt / argparse libraries will allow you to pass CLI arguments to your scripts using nextflow

**envs/**
  - This will contain all of the specification files for the individual environments used by the workflow
  - The base_env.yml contains a minimum specified set of packages needed to run nextflow

**main.nf**
- The main script used to call the workflow

**modules**
- In the interest of portability and reusability, each module should contain a separate process that can be generalized to work with a unified set of inputs
- Directories should follow the form *tool_utility* (i.e. samtools_index)
- These modules will be imported by the main.nf
- If we setup these modules correctly, we will be able to utilize them again in the future for other pipelines requiring the same tool

**nextflow.config**
- The main config file that will specify profiles, parameters, and other options. The main advantage of encoding this information in this config file is that
  if we end up using any values in multiple places in our codebase, and we wish to change those values at some point, we will only need to change the in one
  place (here).

**refs/**
- This directory will be used to store reference genomes or files

**results/**
- This directory will be used to store results
- Remember that you will need to use the `publishDir` directive in order to have nextflow output results to this directory
- We don't need to output everything, just results that we may want to manually inspect or examine
	- QC logs
	- Generated plots
	- Aggregated Results (.csv, .tsv, matrixes)

**samples/**
- This will be where you can store the raw data files for the experiment

**samplesheet.csv**
- This CSV will be kept at the top level and used to construct the initial channels for nextflow. We will encode sample metadata
as well as file paths so that this file may be used to drive the execution of the workflow. This practice also allows our workflow
to be more portable as you can simply supply a different CSV containing other samples if we wished to apply our workflow to another
experiment

