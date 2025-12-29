> [!NOTE]
> Considering that myself and my team have graduated from the Northcoders Data Engineering course, this project will be archived and made read-only.

# ToteSys - Data Engineering Project
[![Python](https://img.shields.io/badge/Python-FFD43B?style=for-the-badge&logo=python&logoColor=blue)](https://www.python.org/)
[![AWS](https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)](https://aws.amazon.com/)
[![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Postgresql](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)](https://github.com/features/actions)

<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/1149980207?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture; clipboard-write; encrypted-media; web-share" referrerpolicy="strict-origin-when-cross-origin" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="Northcoders DE Project Presentation"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>

# Contributors
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

# Summary
The project aims to implement a data platform that can extract data from an
operational database, archive it in a data lake, and make it easily accessible
within a remodelled OLAP data warehouse.

The solution showcases our skills in:

- Python
- PostgreSQL
- Database modelling
- Amazon Web Services (AWS)
- Agile methodologies

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
