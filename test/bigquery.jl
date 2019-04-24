module BigqueryTests

using Test
using Dates
using GCP
using GCP.Bigquery
using ..GCPTests

verbose = 0


@testset "BigQuery" begin

@testset "Datasets" begin

  datasetId = "dataset0"

  @test begin # insert
    p = GCP.Project(GCPTests.CredFilename, ["cloud-platform"])
    dataset = Bigquery.Dataset()
    dataset.datasetReference = Bigquery.DatasetReference()
    dataset.datasetReference.datasetId = datasetId
    res = p.bigquery.datasets.insert(dataset ; verbose=verbose)
    res != nothing
  end
  @test begin # get
    p = GCP.Project(GCPTests.CredFilename, ["cloud-platform"])
    res = p.bigquery.datasets.get(datasetId; verbose=verbose)
    res != nothing
  end
  @test begin # update
    p = GCP.Project(GCPTests.CredFilename, ["cloud-platform"])
    dataset = Bigquery.Dataset()
    dataset.datasetReference = Bigquery.DatasetReference()
    dataset.datasetReference.datasetId = datasetId
    dataset.friendlyName = "friendly-updated"
    res = p.bigquery.datasets.update(dataset, datasetId; verbose=verbose)
    res != nothing
  end
  @test begin # list
    p = GCP.Project(GCPTests.CredFilename, ["cloud-platform"])
    res = p.bigquery.datasets.list(; verbose=verbose)
    res != nothing
  end
  @test begin # patch
    p = GCP.Project(GCPTests.CredFilename, ["cloud-platform"])
    dataset = Bigquery.Dataset()
    dataset.datasetReference = Bigquery.DatasetReference()
    dataset.datasetReference.datasetId = datasetId
    dataset.friendlyName = "friendly-patched"
    res = p.bigquery.datasets.patch(dataset, datasetId; verbose=verbose)
    res != nothing
  end
  @test begin # delete
    p = GCP.Project(GCPTests.CredFilename, ["cloud-platform"])
    p.bigquery.datasets.delete(datasetId; verbose=verbose)
    true
  end

end # Datasets

function datasetInsert(datasetId::String)
  p = GCP.Project(GCPTests.CredFilename, ["cloud-platform"])
  dataset = Bigquery.Dataset()
  dataset.datasetReference = Bigquery.DatasetReference()
  dataset.datasetReference.datasetId = datasetId
  p.bigquery.datasets.insert(dataset)
  true
end
function datasetDelete(datasetId::String)
  p = GCP.Project(GCPTests.CredFilename, ["cloud-platform"])
  p.bigquery.datasets.delete(datasetId)
  true
end

@testset "Tables" begin

  datasetId = "dataset_tables"
  tableId = "test0"

  @test datasetInsert(datasetId)

  @test begin # insert
    p = GCP.Project(GCPTests.CredFilename, ["cloud-platform"])
    table = Bigquery.Table()
    table.tableReference = Bigquery.TableReference()
    table.tableReference.datasetId = datasetId
    table.tableReference.projectId = p.id
    table.tableReference.tableId = tableId
    table.schema = Bigquery.TableSchema()
    table.schema.fields = Vector{Bigquery.TableFieldSchema}()
    fld = Bigquery.TableFieldSchema()
    fld.name = "tme"
    fld.type_ = "TIMESTAMP"
    fld.mode = "REQUIRED"
    push!(table.schema.fields, fld)
    fld = Bigquery.TableFieldSchema()
    fld.name = "val"
    fld.type_ = "FLOAT"
    fld.mode = "REQUIRED"
    push!(table.schema.fields, fld)
    res = p.bigquery.tables.insert(table, datasetId ; verbose=verbose)
    res != nothing
  end
  @test begin # get
    p = GCP.Project(GCPTests.CredFilename, ["cloud-platform"])
    res = p.bigquery.tables.get(datasetId, tableId; verbose=verbose)
    res != nothing
  end
  @test begin # update
    p = GCP.Project(GCPTests.CredFilename, ["cloud-platform"])
    table = Bigquery.Table()
    table.tableReference = Bigquery.TableReference()
    table.tableReference.datasetId = datasetId
    table.tableReference.projectId = p.id
    table.tableReference.tableId = tableId
    table.friendlyName = "friendly-updated"
    res = p.bigquery.tables.update(table, datasetId, tableId; verbose=verbose)
    res != nothing
  end
  @test begin # list
    p = GCP.Project(GCPTests.CredFilename, ["cloud-platform"])
    res = p.bigquery.tables.list(datasetId; verbose=verbose)
    res != nothing
  end
  @test begin # patch
    p = GCP.Project(GCPTests.CredFilename, ["cloud-platform"])
    table = Bigquery.Table()
    table.tableReference = Bigquery.TableReference()
    table.tableReference.datasetId = datasetId
    table.tableReference.projectId = p.id
    table.tableReference.tableId = tableId
    table.friendlyName = "friendly-patched"
    res = p.bigquery.tables.patch(table, datasetId, tableId; verbose=verbose)
    res != nothing
  end
  @test begin # delete
    p = GCP.Project(GCPTests.CredFilename, ["cloud-platform"])
    p.bigquery.tables.delete(datasetId, tableId; verbose=verbose)
    true
  end

  @test datasetDelete(datasetId)

end # Tables

function tableInsert(datasetId::String, tableId::String)
  datasetInsert(datasetId)
  p = GCP.Project(GCPTests.CredFilename, ["cloud-platform"])
  table = Bigquery.Table()
  table.tableReference = Bigquery.TableReference()
  table.tableReference.datasetId = datasetId
  table.tableReference.projectId = p.id
  table.tableReference.tableId = tableId
  table.schema = Bigquery.TableSchema()
  table.schema.fields = Vector{Bigquery.TableFieldSchema}()
  fld = Bigquery.TableFieldSchema()
  fld.name = "valTimestamp"
  fld.type_ = "TIMESTAMP"
  fld.mode = "REQUIRED"
  push!(table.schema.fields, fld)
  fld = Bigquery.TableFieldSchema()
  fld.name = "valFloat"
  fld.type_ = "FLOAT"
  fld.mode = "REQUIRED"
  push!(table.schema.fields, fld)

  fld = Bigquery.TableFieldSchema()
  fld.name = "valInt"
  fld.type_ = "INTEGER"
  fld.mode = "REQUIRED"
  push!(table.schema.fields, fld)
  fld = Bigquery.TableFieldSchema()
  fld.name = "valBool"
  fld.type_ = "BOOLEAN"
  fld.mode = "REQUIRED"
  push!(table.schema.fields, fld)
  fld = Bigquery.TableFieldSchema()
  fld.name = "valString"
  fld.type_ = "STRING"
  fld.mode = "REQUIRED"
  push!(table.schema.fields, fld)

  res = p.bigquery.tables.insert(table, datasetId ; verbose=verbose)
  true
end
function tableDelete(datasetId::String, tableId::String)
  p = GCP.Project(GCPTests.CredFilename, ["cloud-platform"])
  p.bigquery.tables.delete(datasetId, tableId; verbose=verbose)
  datasetDelete(datasetId)
  true
end
struct TstTck <: GCP.Abstract # must inherit GCP.Abstract to use insertAll
  valTimestamp::DateTime
  valFloat::Float32
  valInt::Int32
  valBool::Bool
  valString::String
end

@testset "Tabledata" begin

  datasetId = "dataset_tabledata"
  tableId = "table_tabledata"

  @test tableInsert(datasetId, tableId)
  @test begin # insertAll
    p = GCP.Project(GCPTests.CredFilename, ["cloud-platform"])
    tck = TstTck(now(), 1.0, 1, true, "abc")
    p.bigquery.tabledata.insertAll(tck, datasetId, tableId ; verbose=verbose)
    tcks = [TstTck(now(), 2.0, 2, true, "abc"), TstTck(now(), 3.0, 3, true, "abc")]
    res = p.bigquery.tabledata.insertAll(tcks, datasetId, tableId ; verbose=verbose)
    res != nothing
  end
  @test tableDelete(datasetId, tableId)

  # @test tableInsert(datasetId, tableId)
  # @test begin # list
  #   # p = GCP.Project(GCPTests.CredFilename, ["cloud-platform"])
  #   # tcks = Vector{TstTck}()
  #   # for n in 1:3
  #   #   push!(tcks, TstTck(now(), n, n, true, "abc"))
  #   # end
  #   # res = p.bigquery.tabledata.insertAll(tcks, datasetId, tableId ; verbose=verbose)
  #   # res = p.bigquery.tabledata.list(datasetId, tableId ; verbose=verbose)
  #   # res = p.bigquery.tabledata.list("oan_cor_tic", "aud_usd")
  #   # @info size(res)
  #   # res = p.bigquery.tables.get(datasetId, tableId ; verbose=verbose)
  #   # @info res
  #   true
  # end
  # @test tableDelete(datasetId, tableId)

end # Tabledata

end # BigQuery


end # module BigqueryTests