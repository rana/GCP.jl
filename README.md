# GCP.jl
[Google Cloud Platform (GCP) APIs](https://cloud.google.com/apis/) for the [Julia](https://julialang.org/) programming language.

Currently supports [BigQuery](https://cloud.google.com/bigquery/docs/reference/libraries).

```julia
using GCP
using GCP.Bigquery

CredentialFilename = expanduser("~/secrets/your-project.json")

p = GCP.Project(CredentialFilename, ["cloud-platform"])
dataset = Bigquery.Dataset()
dataset.datasetReference = Bigquery.DatasetReference()
dataset.datasetReference.datasetId = "your-dataset"
res = p.bigquery.datasets.insert(dataset)

@info res
```

See tests for [more example calls](https://github.com/rana/GCP.jl/blob/master/test/bigquery.jl).

A 100% Julia implementation. Not reliant on command line installation of [Google Cloud SDK](https://cloud.google.com/sdk/gcloud/) or Python 2 (which Google Cloud SDK requires).

Auto-generated from [Google API Discovery Service](https://developers.google.com/discovery/).

[More APIs possible](https://github.com/rana/GCP.jl/blob/master/test/runbootstrap.jl) on (pull) request.

Help is welcome.
