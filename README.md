# ToteSys - Data Engineering Project

This is an actively developed fork of a group project completed during
the Northcoders Data Engineering bootcamp. The original repository is
archived and read-only, but this fork is maintained by myself.

# Overview
An ETL pipeline that extracts data from the `totesys` operational database
(PostgreSQL), lands it in object storage as CSV, transforms it into a star schema, and then loads it back into a PostgreSQL data warehouse.

The original stack used: Python, PostgrSQL, AWS (Lambda, S3, EventBridge,
Secrets Manager, CloudWatch), Terraform, GitHub Actions, pytest

#



# Main Objectives

Our goal is to create a reliable ETL (Extract, Transform, Load) pipeline that
can:

1. Extract the data from the `totesys` operational database
2. Store the data in AWS S3 buckets - this will be our data lake
3. Transform the data into a suitable schema for the data warehouse
4. Load the transformed data into the data warehouse hosted on AWS

# Key Features

We aim for the project to have certain features. Some are more prioritised than
others.

- Automated data ingestion from `totesys` db
- Data storage for ingested and processed data in S3 buckets
- Data transformation for data warehouse schema
- Automated data loading into the data warehouse schema
- Logging and monitoring with CloudWatch
- Notifications for errors and successful runs (e.g. successful ingestion)
- Visualisation of warehouse data

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
