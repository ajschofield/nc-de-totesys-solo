# ToteSys - Data Engineering Project

This is an actively developed fork of a group project completed during
the Northcoders Data Engineering bootcamp. The original repository is
archived and read-only, but this fork is maintained by myself.

You can find the original project source code [here](https://github.com/ajschofield/de-project-bentley).

# Overview
An ETL pipeline that extracts data from the `totesys` operational database
(PostgreSQL), lands it in object storage as CSV, transforms it into a star schema,
and then loads it into a PostgreSQL data warehouse.

The original stack used: Python, PostgrSQL, AWS (Lambda, S3, EventBridge,
Secrets Manager, CloudWatch), Terraform, GitHub Actions, pytest

## Original Pipeline Flow

1. Scheduled trigger using EventBridge (every 30 minutes) invokes the `extract`
   function, which queries `totesys` for new or updated rows and writes CSVs
   to an ingestion bucket
2. An object-created event triggers the `transform` function, which remodels
   the data into dimension and fact tables and writes Parquet files to a second
   bucket
3. A second object-created event triggers the `load` function, which loads the
   Parquet files into the warehouse schema

All of the above infrastructure is defined in Terraform.

## Project Status

The original `totesys` database and the deployed AWS setup no longer exist - 
both were provisioned solely for the duration of the final project during the bootcamp.
In addition, the code in this repository remains as the team left it, and has
many issues:

1. Loading is not idempotent - re-runs have the potential to duplicate dimension rows
2. The transform step reprocesses all historical files on every run, when ideally
   it should be done incrementally
3. Transforming currency depends on scraping `xe.com` in a really weird way - it's
   more akin to a workaround
4. Whilst the testing suite is sufficient, it has known failures and skipped tests

# Project Presentation

Watch the original video [here](https://vimeo.com/1149980207).
