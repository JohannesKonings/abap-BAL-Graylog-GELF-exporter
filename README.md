![abap-log-exporter](docs/logo-abap-log-exporter-horizontal.png)

# abap-log-exporter :construction: WIP

[![Known Vulnerabilities](https://snyk.io/test/github/Goala/abap-log-exporter/badge.svg?targetFile=package.json)](https://snyk.io/test/github/Goala/abap-log-exporter?targetFile=package.json)
![GitHub package.json dependency version (dev dep on branch)](https://img.shields.io/github/package-json/dependency-version/Goala/abap-log-exporter/dev/@abaplint/cli)
![Run abaplint](https://github.com/Goala/abap-log-exporter/workflows/Run%20abaplint/badge.svg)

# architecture

![architecture](./out/architecture/architecture/architecture.png)

# documentation

## components

| component       | variant        | status  |
| ----------------|----------------|---------|
| reader          | BAL            | [WIP](https://github.com/abap-observability-tools/abap-log-exporter/issues?q=is%3Aopen+is%3Aissue+label%3ABAL)     |
|                 | SMICM          | open    |
|                 | SM21           | [#41](https://github.com/abap-observability-tools/abap-log-exporter/issues/41)     |
| converter       | GELF           | WIP     |
|                 | Loki           | open    |
|                 | Tempo          | open    |
| connector       | GELF           | :heavy_check_mark:     |
|                 | Loki           | open    |
|                 | Tempo          | open    |


## customizing

Different scenarios can be customized in the table ZALE_CONFIG. This are the fields for each sceanrio

| Field           | ABAP Field Key | Description                         |
| ----------------|----------------|-------------------------------------|
| READER_CLASS    | RDR_CLASS      | class for the reader component      |
| CONVERTER_CLASS | CVTR_CLASS     | class for the converter component   |
| CONNECTOR_URL   | CNCTR_URL      | URL to the log tool e.g. GrayLog    |
| CONNECTOR_CLASS | CNCTR_CLAS     | class fot the connector component   |

# local tests

[local test folder](local-tests/)

:warning: instead of localhost the URLs have to be customized with the IP of the Ethernet Adapter
