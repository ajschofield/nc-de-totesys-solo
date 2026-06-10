# ToteSys - Data Engineering Project

This is an actively developed fork of a group project completed during
the Northcoders Data Engineering bootcamp. The original repository is
archived and read-only, but this fork is maintained by myself.

# Overview
An ETL pipeline that extracts data from the `totesys` operational database
(PostgreSQL), lands it in object storage as CSV, transforms it into a star schema, and then loads it back into a PostgreSQL data warehouse.

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


# Original Contributors

You can find the original project source code [here](https://github.com/ajschofield/de-project-bentley).

<table>
  <tr>
    <td align="center">
      <a href="https://github.com/ellsymonds">
        <img src="https://github.com/ellsymonds.png" width="100px;" alt="ellsymonds"/>
        <br />
        <sub><b>Ellie Symonds</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/lian-manonog">
        <img src="https://github.com/lian-manonog.png" width="100px;" alt="lian-manonog"/>
        <br />
        <sub><b>Lianmei Manon-og</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/T-Aji">
        <img src="https://github.com/T-Aji.png" width="100px;" alt="T-Aji"/>
        <br />
        <sub><b>Tolu Ajibade</b></sub>
      </a>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="https://github.com/HastarTara">
        <img src="https://github.com/HastarTara.png" width="100px;" alt="HastarTara"/>
        <br />
        <sub><b>Joslin Rashleigh</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/bulve-ad">
        <img src="https://github.com/bulve-ad.png" width="100px;" alt="bulve-ad"/>
        <br />
        <sub><b>Anzelika Belotelova</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/ajschofield">
        <img src="https://github.com/ajschofield.png" width="100px;" alt="ajschofield"/>
        <br />
        <sub><b>Alex Schofield</b></sub>
      </a>
    </td>
  </tr>
</table>

# Project Presentation

Watch the original video [here](https://vimeo.com/1149980207).
