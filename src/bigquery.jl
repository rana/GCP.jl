module Bigquery
using Dates
using LazyJSON
using ..GCP
const baseUrl = "https://www.googleapis.com/bigquery/v2/"
mutable struct GetServiceAccountResponse <: GCP.Abstract
    email::String
    kind::String
    function GetServiceAccountResponse()
        new()
    end
end
mutable struct JsonObject <: GCP.Abstract
    function JsonObject()
        new()
    end
end
mutable struct JsonValue <: GCP.Abstract
    function JsonValue()
        new()
    end
end
mutable struct ProjectList <: GCP.Abstract
    etag::String
    kind::String
    nextPageToken::String
    totalItems::Union{Nothing, Int32}
    function ProjectList()
        new()
    end
end
mutable struct ProjectReference <: GCP.Abstract
    projectId::String
    function ProjectReference()
        new()
    end
end
mutable struct TableDataInsertAllRequest <: GCP.Abstract
    ignoreUnknownValues::Union{Nothing, Bool}
    kind::String
    skipInvalidRows::Union{Nothing, Bool}
    templateSuffix::String
    function TableDataInsertAllRequest()
        new()
    end
end
mutable struct TableDataInsertAllResponse <: GCP.Abstract
    kind::String
    function TableDataInsertAllResponse()
        new()
    end
end
mutable struct DatasetReference <: GCP.Abstract
    datasetId::String
    projectId::String
    function DatasetReference()
        new()
    end
end
mutable struct Dataset <: GCP.Abstract
    creationTime::Union{Nothing, Int64}
    datasetReference::DatasetReference
    defaultPartitionExpirationMs::Union{Nothing, Int64}
    defaultTableExpirationMs::Union{Nothing, Int64}
    description::String
    etag::String
    friendlyName::String
    id::String
    kind::String
    lastModifiedTime::Union{Nothing, Int64}
    location::String
    selfLink::String
    function Dataset()
        new()
    end
end
mutable struct DatasetList <: GCP.Abstract
    datasets::Vector{Dataset}
    etag::String
    kind::String
    nextPageToken::String
    function DatasetList()
        new()
    end
end
mutable struct Clustering <: GCP.Abstract
    fields::Vector{String}
    function Clustering()
        new()
    end
end
mutable struct EncryptionConfiguration <: GCP.Abstract
    kmsKeyName::String
    function EncryptionConfiguration()
        new()
    end
end
mutable struct BigtableColumn <: GCP.Abstract
    encoding::String
    fieldName::String
    onlyReadLatest::Union{Nothing, Bool}
    qualifierEncoded::Union{Nothing, UInt8}
    qualifierString::String
    type_::String
    function BigtableColumn()
        new()
    end
end
mutable struct BigtableColumnFamily <: GCP.Abstract
    columns::Vector{BigtableColumn}
    encoding::String
    familyId::String
    onlyReadLatest::Union{Nothing, Bool}
    type_::String
    function BigtableColumnFamily()
        new()
    end
end
mutable struct BigtableOptions <: GCP.Abstract
    columnFamilies::Vector{BigtableColumnFamily}
    ignoreUnspecifiedColumnFamilies::Union{Nothing, Bool}
    readRowkeyAsString::Union{Nothing, Bool}
    function BigtableOptions()
        new()
    end
end
mutable struct CsvOptions <: GCP.Abstract
    allowJaggedRows::Union{Nothing, Bool}
    allowQuotedNewlines::Union{Nothing, Bool}
    encoding::String
    fieldDelimiter::String
    quote_::String
    skipLeadingRows::Union{Nothing, Int64}
    function CsvOptions()
        new()
    end
end
mutable struct GoogleSheetsOptions <: GCP.Abstract
    range::String
    skipLeadingRows::Union{Nothing, Int64}
    function GoogleSheetsOptions()
        new()
    end
end
mutable struct TableFieldSchema <: GCP.Abstract
    description::String
    fields::Vector{TableFieldSchema}
    mode::String
    name::String
    type_::String
    function TableFieldSchema()
        new()
    end
end
mutable struct TableSchema <: GCP.Abstract
    fields::Vector{TableFieldSchema}
    function TableSchema()
        new()
    end
end
mutable struct ExternalDataConfiguration <: GCP.Abstract
    autodetect::Union{Nothing, Bool}
    bigtableOptions::BigtableOptions
    compression::String
    csvOptions::CsvOptions
    googleSheetsOptions::GoogleSheetsOptions
    hivePartitioningMode::String
    ignoreUnknownValues::Union{Nothing, Bool}
    maxBadRecords::Union{Nothing, Int32}
    schema::TableSchema
    sourceFormat::String
    sourceUris::Vector{String}
    function ExternalDataConfiguration()
        new()
    end
end
mutable struct MaterializedViewDefinition <: GCP.Abstract
    lastRefreshTime::Union{Nothing, Int64}
    query::String
    function MaterializedViewDefinition()
        new()
    end
end
mutable struct BqmlIterationResult <: GCP.Abstract
    durationMs::Union{Nothing, Int64}
    evalLoss::Union{Nothing, Float64}
    index::Union{Nothing, Int32}
    learnRate::Union{Nothing, Float64}
    trainingLoss::Union{Nothing, Float64}
    function BqmlIterationResult()
        new()
    end
end
mutable struct BqmlTrainingRun <: GCP.Abstract
    iterationResults::Vector{BqmlIterationResult}
    startTime::Dates.DateTime
    state::String
    function BqmlTrainingRun()
        new()
    end
end
mutable struct ModelDefinition <: GCP.Abstract
    trainingRuns::Vector{BqmlTrainingRun}
    function ModelDefinition()
        new()
    end
end
mutable struct RangePartitioning <: GCP.Abstract
    field::String
    function RangePartitioning()
        new()
    end
end
mutable struct Streamingbuffer <: GCP.Abstract
    estimatedBytes::Union{Nothing, UInt64}
    estimatedRows::Union{Nothing, UInt64}
    oldestEntryTime::Union{Nothing, UInt64}
    function Streamingbuffer()
        new()
    end
end
mutable struct TableReference <: GCP.Abstract
    datasetId::String
    projectId::String
    tableId::String
    function TableReference()
        new()
    end
end
mutable struct TimePartitioning <: GCP.Abstract
    expirationMs::Union{Nothing, Int64}
    field::String
    requirePartitionFilter::Union{Nothing, Bool}
    type_::String
    function TimePartitioning()
        new()
    end
end
mutable struct UserDefinedFunctionResource <: GCP.Abstract
    inlineCode::String
    resourceUri::String
    function UserDefinedFunctionResource()
        new()
    end
end
mutable struct ViewDefinition <: GCP.Abstract
    query::String
    useLegacySql::Union{Nothing, Bool}
    userDefinedFunctionResources::Vector{UserDefinedFunctionResource}
    function ViewDefinition()
        new()
    end
end
mutable struct Table <: GCP.Abstract
    clustering::Clustering
    creationTime::Union{Nothing, Int64}
    description::String
    encryptionConfiguration::EncryptionConfiguration
    etag::String
    expirationTime::Union{Nothing, Int64}
    externalDataConfiguration::ExternalDataConfiguration
    friendlyName::String
    id::String
    kind::String
    lastModifiedTime::Union{Nothing, UInt64}
    location::String
    materializedView::MaterializedViewDefinition
    model::ModelDefinition
    numBytes::Union{Nothing, Int64}
    numLongTermBytes::Union{Nothing, Int64}
    numPhysicalBytes::Union{Nothing, Int64}
    numRows::Union{Nothing, UInt64}
    rangePartitioning::RangePartitioning
    requirePartitionFilter::Union{Nothing, Bool}
    schema::TableSchema
    selfLink::String
    streamingBuffer::Streamingbuffer
    tableReference::TableReference
    timePartitioning::TimePartitioning
    type_::String
    view::ViewDefinition
    function Table()
        new()
    end
end
mutable struct TableList <: GCP.Abstract
    etag::String
    kind::String
    nextPageToken::String
    tables::Vector{Table}
    totalItems::Union{Nothing, Int32}
    function TableList()
        new()
    end
end
mutable struct JobStatistics4 <: GCP.Abstract
    destinationUriFileCounts::Vector{Int64}
    inputBytes::Union{Nothing, Int64}
    function JobStatistics4()
        new()
    end
end
mutable struct JobStatistics3 <: GCP.Abstract
    badRecords::Union{Nothing, Int64}
    inputFileBytes::Union{Nothing, Int64}
    inputFiles::Union{Nothing, Int64}
    outputBytes::Union{Nothing, Int64}
    outputRows::Union{Nothing, Int64}
    function JobStatistics3()
        new()
    end
end
mutable struct RoutineReference <: GCP.Abstract
    datasetId::String
    projectId::String
    routineId::String
    function RoutineReference()
        new()
    end
end
mutable struct BigQueryModelTraining <: GCP.Abstract
    currentIteration::Union{Nothing, Int32}
    expectedTotalIterations::Union{Nothing, Int64}
    function BigQueryModelTraining()
        new()
    end
end
mutable struct ExplainQueryStep <: GCP.Abstract
    kind::String
    substeps::Vector{String}
    function ExplainQueryStep()
        new()
    end
end
mutable struct ExplainQueryStage <: GCP.Abstract
    completedParallelInputs::Union{Nothing, Int64}
    computeMsAvg::Union{Nothing, Int64}
    computeMsMax::Union{Nothing, Int64}
    computeRatioAvg::Union{Nothing, Float64}
    computeRatioMax::Union{Nothing, Float64}
    endMs::Union{Nothing, Int64}
    id::Union{Nothing, Int64}
    inputStages::Vector{Int64}
    name::String
    parallelInputs::Union{Nothing, Int64}
    readMsAvg::Union{Nothing, Int64}
    readMsMax::Union{Nothing, Int64}
    readRatioAvg::Union{Nothing, Float64}
    readRatioMax::Union{Nothing, Float64}
    recordsRead::Union{Nothing, Int64}
    recordsWritten::Union{Nothing, Int64}
    shuffleOutputBytes::Union{Nothing, Int64}
    shuffleOutputBytesSpilled::Union{Nothing, Int64}
    startMs::Union{Nothing, Int64}
    status::String
    steps::Vector{ExplainQueryStep}
    waitMsAvg::Union{Nothing, Int64}
    waitMsMax::Union{Nothing, Int64}
    waitRatioAvg::Union{Nothing, Float64}
    waitRatioMax::Union{Nothing, Float64}
    writeMsAvg::Union{Nothing, Int64}
    writeMsMax::Union{Nothing, Int64}
    writeRatioAvg::Union{Nothing, Float64}
    writeRatioMax::Union{Nothing, Float64}
    function ExplainQueryStage()
        new()
    end
end
mutable struct QueryTimelineSample <: GCP.Abstract
    activeUnits::Union{Nothing, Int64}
    completedUnits::Union{Nothing, Int64}
    elapsedMs::Union{Nothing, Int64}
    pendingUnits::Union{Nothing, Int64}
    totalSlotMs::Union{Nothing, Int64}
    function QueryTimelineSample()
        new()
    end
end
mutable struct QueryParameterType <: GCP.Abstract
    arrayType::QueryParameterType
    type_::String
    function QueryParameterType()
        new()
    end
end
mutable struct QueryParameterValue <: GCP.Abstract
    arrayValues::Vector{QueryParameterValue}
    value::String
    function QueryParameterValue()
        new()
    end
end
mutable struct QueryParameter <: GCP.Abstract
    name::String
    parameterType::QueryParameterType
    parameterValue::QueryParameterValue
    function QueryParameter()
        new()
    end
end
mutable struct JobStatistics2 <: GCP.Abstract
    billingTier::Union{Nothing, Int32}
    cacheHit::Union{Nothing, Bool}
    ddlOperationPerformed::String
    ddlTargetRoutine::RoutineReference
    ddlTargetTable::TableReference
    estimatedBytesProcessed::Union{Nothing, Int64}
    modelTraining::BigQueryModelTraining
    modelTrainingCurrentIteration::Union{Nothing, Int32}
    modelTrainingExpectedTotalIteration::Union{Nothing, Int64}
    numDmlAffectedRows::Union{Nothing, Int64}
    queryPlan::Vector{ExplainQueryStage}
    referencedTables::Vector{TableReference}
    schema::TableSchema
    statementType::String
    timeline::Vector{QueryTimelineSample}
    totalBytesBilled::Union{Nothing, Int64}
    totalBytesProcessed::Union{Nothing, Int64}
    totalBytesProcessedAccuracy::String
    totalPartitionsProcessed::Union{Nothing, Int64}
    totalSlotMs::Union{Nothing, Int64}
    undeclaredQueryParameters::Vector{QueryParameter}
    function JobStatistics2()
        new()
    end
end
mutable struct JobStatistics <: GCP.Abstract
    completionRatio::Union{Nothing, Float64}
    creationTime::Union{Nothing, Int64}
    endTime::Union{Nothing, Int64}
    extract::JobStatistics4
    load::JobStatistics3
    numChildJobs::Union{Nothing, Int64}
    parentJobId::String
    query::JobStatistics2
    quotaDeferments::Vector{String}
    startTime::Union{Nothing, Int64}
    totalBytesProcessed::Union{Nothing, Int64}
    totalSlotMs::Union{Nothing, Int64}
    function JobStatistics()
        new()
    end
end
mutable struct ErrorProto <: GCP.Abstract
    debugInfo::String
    location::String
    message::String
    reason::String
    function ErrorProto()
        new()
    end
end
mutable struct JobReference <: GCP.Abstract
    jobId::String
    location::String
    projectId::String
    function JobReference()
        new()
    end
end
mutable struct TableCell <: GCP.Abstract
    function TableCell()
        new()
    end
end
mutable struct TableRow <: GCP.Abstract
    f::Vector{TableCell}
    function TableRow()
        new()
    end
end
mutable struct QueryResponse <: GCP.Abstract
    cacheHit::Union{Nothing, Bool}
    errors::Vector{ErrorProto}
    jobComplete::Union{Nothing, Bool}
    jobReference::JobReference
    kind::String
    numDmlAffectedRows::Union{Nothing, Int64}
    pageToken::String
    rows::Vector{TableRow}
    schema::TableSchema
    totalBytesProcessed::Union{Nothing, Int64}
    totalRows::Union{Nothing, UInt64}
    function QueryResponse()
        new()
    end
end
mutable struct DestinationTableProperties <: GCP.Abstract
    description::String
    friendlyName::String
    function DestinationTableProperties()
        new()
    end
end
mutable struct JobConfigurationLoad <: GCP.Abstract
    allowJaggedRows::Union{Nothing, Bool}
    allowQuotedNewlines::Union{Nothing, Bool}
    autodetect::Union{Nothing, Bool}
    clustering::Clustering
    createDisposition::String
    destinationEncryptionConfiguration::EncryptionConfiguration
    destinationTable::TableReference
    destinationTableProperties::DestinationTableProperties
    encoding::String
    fieldDelimiter::String
    hivePartitioningMode::String
    ignoreUnknownValues::Union{Nothing, Bool}
    maxBadRecords::Union{Nothing, Int32}
    nullMarker::String
    projectionFields::Vector{String}
    quote_::String
    rangePartitioning::RangePartitioning
    schema::TableSchema
    schemaInline::String
    schemaInlineFormat::String
    schemaUpdateOptions::Vector{String}
    skipLeadingRows::Union{Nothing, Int32}
    sourceFormat::String
    sourceUris::Vector{String}
    timePartitioning::TimePartitioning
    useAvroLogicalTypes::Union{Nothing, Bool}
    writeDisposition::String
    function JobConfigurationLoad()
        new()
    end
end
mutable struct JobConfigurationTableCopy <: GCP.Abstract
    createDisposition::String
    destinationEncryptionConfiguration::EncryptionConfiguration
    destinationTable::TableReference
    sourceTable::TableReference
    sourceTables::Vector{TableReference}
    writeDisposition::String
    function JobConfigurationTableCopy()
        new()
    end
end
mutable struct JobConfigurationExtract <: GCP.Abstract
    compression::String
    destinationFormat::String
    destinationUri::String
    destinationUris::Vector{String}
    fieldDelimiter::String
    printHeader::Union{Nothing, Bool}
    sourceTable::TableReference
    function JobConfigurationExtract()
        new()
    end
end
mutable struct JobConfigurationQuery <: GCP.Abstract
    allowLargeResults::Union{Nothing, Bool}
    clustering::Clustering
    createDisposition::String
    defaultDataset::DatasetReference
    destinationEncryptionConfiguration::EncryptionConfiguration
    destinationTable::TableReference
    flattenResults::Union{Nothing, Bool}
    maximumBillingTier::Union{Nothing, Int32}
    maximumBytesBilled::Union{Nothing, Int64}
    parameterMode::String
    preserveNulls::Union{Nothing, Bool}
    priority::String
    query::String
    queryParameters::Vector{QueryParameter}
    rangePartitioning::RangePartitioning
    schemaUpdateOptions::Vector{String}
    timePartitioning::TimePartitioning
    useLegacySql::Union{Nothing, Bool}
    useQueryCache::Union{Nothing, Bool}
    userDefinedFunctionResources::Vector{UserDefinedFunctionResource}
    writeDisposition::String
    function JobConfigurationQuery()
        new()
    end
end
mutable struct JobConfiguration <: GCP.Abstract
    copy::JobConfigurationTableCopy
    dryRun::Union{Nothing, Bool}
    extract::JobConfigurationExtract
    jobTimeoutMs::Union{Nothing, Int64}
    jobType::String
    load::JobConfigurationLoad
    query::JobConfigurationQuery
    function JobConfiguration()
        new()
    end
end
mutable struct JobStatus <: GCP.Abstract
    errorResult::ErrorProto
    errors::Vector{ErrorProto}
    state::String
    function JobStatus()
        new()
    end
end
mutable struct Job <: GCP.Abstract
    configuration::JobConfiguration
    etag::String
    id::String
    jobReference::JobReference
    kind::String
    selfLink::String
    statistics::JobStatistics
    status::JobStatus
    user_email::String
    function Job()
        new()
    end
end
mutable struct TableDataList <: GCP.Abstract
    etag::String
    kind::String
    pageToken::String
    rows::Vector{TableRow}
    totalRows::Union{Nothing, Int64}
    function TableDataList()
        new()
    end
end
mutable struct GetQueryResultsResponse <: GCP.Abstract
    cacheHit::Union{Nothing, Bool}
    errors::Vector{ErrorProto}
    etag::String
    jobComplete::Union{Nothing, Bool}
    jobReference::JobReference
    kind::String
    numDmlAffectedRows::Union{Nothing, Int64}
    pageToken::String
    rows::Vector{TableRow}
    schema::TableSchema
    totalBytesProcessed::Union{Nothing, Int64}
    totalRows::Union{Nothing, UInt64}
    function GetQueryResultsResponse()
        new()
    end
end
mutable struct QueryRequest <: GCP.Abstract
    defaultDataset::DatasetReference
    dryRun::Union{Nothing, Bool}
    kind::String
    location::String
    maxResults::Union{Nothing, UInt32}
    parameterMode::String
    preserveNulls::Union{Nothing, Bool}
    query::String
    queryParameters::Vector{QueryParameter}
    timeoutMs::Union{Nothing, UInt32}
    useLegacySql::Union{Nothing, Bool}
    useQueryCache::Union{Nothing, Bool}
    function QueryRequest()
        new()
    end
end
mutable struct JobList <: GCP.Abstract
    etag::String
    jobs::Vector{Job}
    kind::String
    nextPageToken::String
    function JobList()
        new()
    end
end
mutable struct JobCancelResponse <: GCP.Abstract
    job::Job
    kind::String
    function JobCancelResponse()
        new()
    end
end
function Base.convert(::Type{BigQueryModelTraining}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = BigQueryModelTraining()
    if haskey(x, "currentIteration")
        r.currentIteration = convert(Union{Nothing, Int32}, x["currentIteration"])
    end
    if haskey(x, "expectedTotalIterations")
        r.expectedTotalIterations = convert(Union{Nothing, Int64}, x["expectedTotalIterations"])
    end
    r
end
function Base.convert(::Type{BigtableColumn}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = BigtableColumn()
    if haskey(x, "encoding")
        r.encoding = convert(String, x["encoding"])
    end
    if haskey(x, "fieldName")
        r.fieldName = convert(String, x["fieldName"])
    end
    if haskey(x, "onlyReadLatest")
        r.onlyReadLatest = convert(Union{Nothing, Bool}, x["onlyReadLatest"])
    end
    if haskey(x, "qualifierEncoded")
        r.qualifierEncoded = convert(Union{Nothing, UInt8}, x["qualifierEncoded"])
    end
    if haskey(x, "qualifierString")
        r.qualifierString = convert(String, x["qualifierString"])
    end
    if haskey(x, "type")
        r.type_ = convert(String, x["type"])
    end
    r
end
function Base.convert(::Type{BigtableColumnFamily}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = BigtableColumnFamily()
    if haskey(x, "columns")
        r.columns = convert(Vector{BigtableColumn}, x["columns"])
    end
    if haskey(x, "encoding")
        r.encoding = convert(String, x["encoding"])
    end
    if haskey(x, "familyId")
        r.familyId = convert(String, x["familyId"])
    end
    if haskey(x, "onlyReadLatest")
        r.onlyReadLatest = convert(Union{Nothing, Bool}, x["onlyReadLatest"])
    end
    if haskey(x, "type")
        r.type_ = convert(String, x["type"])
    end
    r
end
function Base.convert(::Type{BigtableOptions}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = BigtableOptions()
    if haskey(x, "columnFamilies")
        r.columnFamilies = convert(Vector{BigtableColumnFamily}, x["columnFamilies"])
    end
    if haskey(x, "ignoreUnspecifiedColumnFamilies")
        r.ignoreUnspecifiedColumnFamilies = convert(Union{Nothing, Bool}, x["ignoreUnspecifiedColumnFamilies"])
    end
    if haskey(x, "readRowkeyAsString")
        r.readRowkeyAsString = convert(Union{Nothing, Bool}, x["readRowkeyAsString"])
    end
    r
end
function Base.convert(::Type{BqmlIterationResult}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = BqmlIterationResult()
    if haskey(x, "durationMs")
        r.durationMs = convert(Union{Nothing, Int64}, x["durationMs"])
    end
    if haskey(x, "evalLoss")
        r.evalLoss = convert(Union{Nothing, Float64}, x["evalLoss"])
    end
    if haskey(x, "index")
        r.index = convert(Union{Nothing, Int32}, x["index"])
    end
    if haskey(x, "learnRate")
        r.learnRate = convert(Union{Nothing, Float64}, x["learnRate"])
    end
    if haskey(x, "trainingLoss")
        r.trainingLoss = convert(Union{Nothing, Float64}, x["trainingLoss"])
    end
    r
end
function Base.convert(::Type{BqmlTrainingRun}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = BqmlTrainingRun()
    if haskey(x, "iterationResults")
        r.iterationResults = convert(Vector{BqmlIterationResult}, x["iterationResults"])
    end
    if haskey(x, "startTime")
        r.startTime = convert(Dates.DateTime, x["startTime"])
    end
    if haskey(x, "state")
        r.state = convert(String, x["state"])
    end
    r
end
function Base.convert(::Type{Clustering}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Clustering()
    if haskey(x, "fields")
        r.fields = convert(Vector{String}, x["fields"])
    end
    r
end
function Base.convert(::Type{CsvOptions}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = CsvOptions()
    if haskey(x, "allowJaggedRows")
        r.allowJaggedRows = convert(Union{Nothing, Bool}, x["allowJaggedRows"])
    end
    if haskey(x, "allowQuotedNewlines")
        r.allowQuotedNewlines = convert(Union{Nothing, Bool}, x["allowQuotedNewlines"])
    end
    if haskey(x, "encoding")
        r.encoding = convert(String, x["encoding"])
    end
    if haskey(x, "fieldDelimiter")
        r.fieldDelimiter = convert(String, x["fieldDelimiter"])
    end
    if haskey(x, "quote")
        r.quote_ = convert(String, x["quote"])
    end
    if haskey(x, "skipLeadingRows")
        r.skipLeadingRows = convert(Union{Nothing, Int64}, x["skipLeadingRows"])
    end
    r
end
function Base.convert(::Type{Dataset}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Dataset()
    if haskey(x, "creationTime")
        r.creationTime = convert(Union{Nothing, Int64}, x["creationTime"])
    end
    if haskey(x, "datasetReference")
        r.datasetReference = convert(DatasetReference, x["datasetReference"])
    end
    if haskey(x, "defaultPartitionExpirationMs")
        r.defaultPartitionExpirationMs = convert(Union{Nothing, Int64}, x["defaultPartitionExpirationMs"])
    end
    if haskey(x, "defaultTableExpirationMs")
        r.defaultTableExpirationMs = convert(Union{Nothing, Int64}, x["defaultTableExpirationMs"])
    end
    if haskey(x, "description")
        r.description = convert(String, x["description"])
    end
    if haskey(x, "etag")
        r.etag = convert(String, x["etag"])
    end
    if haskey(x, "friendlyName")
        r.friendlyName = convert(String, x["friendlyName"])
    end
    if haskey(x, "id")
        r.id = convert(String, x["id"])
    end
    if haskey(x, "kind")
        r.kind = convert(String, x["kind"])
    end
    if haskey(x, "lastModifiedTime")
        r.lastModifiedTime = convert(Union{Nothing, Int64}, x["lastModifiedTime"])
    end
    if haskey(x, "location")
        r.location = convert(String, x["location"])
    end
    if haskey(x, "selfLink")
        r.selfLink = convert(String, x["selfLink"])
    end
    r
end
function Base.convert(::Type{DatasetList}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = DatasetList()
    if haskey(x, "datasets")
        r.datasets = convert(Vector{Dataset}, x["datasets"])
    end
    if haskey(x, "etag")
        r.etag = convert(String, x["etag"])
    end
    if haskey(x, "kind")
        r.kind = convert(String, x["kind"])
    end
    if haskey(x, "nextPageToken")
        r.nextPageToken = convert(String, x["nextPageToken"])
    end
    r
end
function Base.convert(::Type{DatasetReference}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = DatasetReference()
    if haskey(x, "datasetId")
        r.datasetId = convert(String, x["datasetId"])
    end
    if haskey(x, "projectId")
        r.projectId = convert(String, x["projectId"])
    end
    r
end
function Base.convert(::Type{DestinationTableProperties}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = DestinationTableProperties()
    if haskey(x, "description")
        r.description = convert(String, x["description"])
    end
    if haskey(x, "friendlyName")
        r.friendlyName = convert(String, x["friendlyName"])
    end
    r
end
function Base.convert(::Type{EncryptionConfiguration}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = EncryptionConfiguration()
    if haskey(x, "kmsKeyName")
        r.kmsKeyName = convert(String, x["kmsKeyName"])
    end
    r
end
function Base.convert(::Type{ErrorProto}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = ErrorProto()
    if haskey(x, "debugInfo")
        r.debugInfo = convert(String, x["debugInfo"])
    end
    if haskey(x, "location")
        r.location = convert(String, x["location"])
    end
    if haskey(x, "message")
        r.message = convert(String, x["message"])
    end
    if haskey(x, "reason")
        r.reason = convert(String, x["reason"])
    end
    r
end
function Base.convert(::Type{ExplainQueryStage}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = ExplainQueryStage()
    if haskey(x, "completedParallelInputs")
        r.completedParallelInputs = convert(Union{Nothing, Int64}, x["completedParallelInputs"])
    end
    if haskey(x, "computeMsAvg")
        r.computeMsAvg = convert(Union{Nothing, Int64}, x["computeMsAvg"])
    end
    if haskey(x, "computeMsMax")
        r.computeMsMax = convert(Union{Nothing, Int64}, x["computeMsMax"])
    end
    if haskey(x, "computeRatioAvg")
        r.computeRatioAvg = convert(Union{Nothing, Float64}, x["computeRatioAvg"])
    end
    if haskey(x, "computeRatioMax")
        r.computeRatioMax = convert(Union{Nothing, Float64}, x["computeRatioMax"])
    end
    if haskey(x, "endMs")
        r.endMs = convert(Union{Nothing, Int64}, x["endMs"])
    end
    if haskey(x, "id")
        r.id = convert(Union{Nothing, Int64}, x["id"])
    end
    if haskey(x, "inputStages")
        r.inputStages = convert(Vector{Int64}, x["inputStages"])
    end
    if haskey(x, "name")
        r.name = convert(String, x["name"])
    end
    if haskey(x, "parallelInputs")
        r.parallelInputs = convert(Union{Nothing, Int64}, x["parallelInputs"])
    end
    if haskey(x, "readMsAvg")
        r.readMsAvg = convert(Union{Nothing, Int64}, x["readMsAvg"])
    end
    if haskey(x, "readMsMax")
        r.readMsMax = convert(Union{Nothing, Int64}, x["readMsMax"])
    end
    if haskey(x, "readRatioAvg")
        r.readRatioAvg = convert(Union{Nothing, Float64}, x["readRatioAvg"])
    end
    if haskey(x, "readRatioMax")
        r.readRatioMax = convert(Union{Nothing, Float64}, x["readRatioMax"])
    end
    if haskey(x, "recordsRead")
        r.recordsRead = convert(Union{Nothing, Int64}, x["recordsRead"])
    end
    if haskey(x, "recordsWritten")
        r.recordsWritten = convert(Union{Nothing, Int64}, x["recordsWritten"])
    end
    if haskey(x, "shuffleOutputBytes")
        r.shuffleOutputBytes = convert(Union{Nothing, Int64}, x["shuffleOutputBytes"])
    end
    if haskey(x, "shuffleOutputBytesSpilled")
        r.shuffleOutputBytesSpilled = convert(Union{Nothing, Int64}, x["shuffleOutputBytesSpilled"])
    end
    if haskey(x, "startMs")
        r.startMs = convert(Union{Nothing, Int64}, x["startMs"])
    end
    if haskey(x, "status")
        r.status = convert(String, x["status"])
    end
    if haskey(x, "steps")
        r.steps = convert(Vector{ExplainQueryStep}, x["steps"])
    end
    if haskey(x, "waitMsAvg")
        r.waitMsAvg = convert(Union{Nothing, Int64}, x["waitMsAvg"])
    end
    if haskey(x, "waitMsMax")
        r.waitMsMax = convert(Union{Nothing, Int64}, x["waitMsMax"])
    end
    if haskey(x, "waitRatioAvg")
        r.waitRatioAvg = convert(Union{Nothing, Float64}, x["waitRatioAvg"])
    end
    if haskey(x, "waitRatioMax")
        r.waitRatioMax = convert(Union{Nothing, Float64}, x["waitRatioMax"])
    end
    if haskey(x, "writeMsAvg")
        r.writeMsAvg = convert(Union{Nothing, Int64}, x["writeMsAvg"])
    end
    if haskey(x, "writeMsMax")
        r.writeMsMax = convert(Union{Nothing, Int64}, x["writeMsMax"])
    end
    if haskey(x, "writeRatioAvg")
        r.writeRatioAvg = convert(Union{Nothing, Float64}, x["writeRatioAvg"])
    end
    if haskey(x, "writeRatioMax")
        r.writeRatioMax = convert(Union{Nothing, Float64}, x["writeRatioMax"])
    end
    r
end
function Base.convert(::Type{ExplainQueryStep}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = ExplainQueryStep()
    if haskey(x, "kind")
        r.kind = convert(String, x["kind"])
    end
    if haskey(x, "substeps")
        r.substeps = convert(Vector{String}, x["substeps"])
    end
    r
end
function Base.convert(::Type{ExternalDataConfiguration}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = ExternalDataConfiguration()
    if haskey(x, "autodetect")
        r.autodetect = convert(Union{Nothing, Bool}, x["autodetect"])
    end
    if haskey(x, "bigtableOptions")
        r.bigtableOptions = convert(BigtableOptions, x["bigtableOptions"])
    end
    if haskey(x, "compression")
        r.compression = convert(String, x["compression"])
    end
    if haskey(x, "csvOptions")
        r.csvOptions = convert(CsvOptions, x["csvOptions"])
    end
    if haskey(x, "googleSheetsOptions")
        r.googleSheetsOptions = convert(GoogleSheetsOptions, x["googleSheetsOptions"])
    end
    if haskey(x, "hivePartitioningMode")
        r.hivePartitioningMode = convert(String, x["hivePartitioningMode"])
    end
    if haskey(x, "ignoreUnknownValues")
        r.ignoreUnknownValues = convert(Union{Nothing, Bool}, x["ignoreUnknownValues"])
    end
    if haskey(x, "maxBadRecords")
        r.maxBadRecords = convert(Union{Nothing, Int32}, x["maxBadRecords"])
    end
    if haskey(x, "schema")
        r.schema = convert(TableSchema, x["schema"])
    end
    if haskey(x, "sourceFormat")
        r.sourceFormat = convert(String, x["sourceFormat"])
    end
    if haskey(x, "sourceUris")
        r.sourceUris = convert(Vector{String}, x["sourceUris"])
    end
    r
end
function Base.convert(::Type{GetQueryResultsResponse}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = GetQueryResultsResponse()
    if haskey(x, "cacheHit")
        r.cacheHit = convert(Union{Nothing, Bool}, x["cacheHit"])
    end
    if haskey(x, "errors")
        r.errors = convert(Vector{ErrorProto}, x["errors"])
    end
    if haskey(x, "etag")
        r.etag = convert(String, x["etag"])
    end
    if haskey(x, "jobComplete")
        r.jobComplete = convert(Union{Nothing, Bool}, x["jobComplete"])
    end
    if haskey(x, "jobReference")
        r.jobReference = convert(JobReference, x["jobReference"])
    end
    if haskey(x, "kind")
        r.kind = convert(String, x["kind"])
    end
    if haskey(x, "numDmlAffectedRows")
        r.numDmlAffectedRows = convert(Union{Nothing, Int64}, x["numDmlAffectedRows"])
    end
    if haskey(x, "pageToken")
        r.pageToken = convert(String, x["pageToken"])
    end
    if haskey(x, "rows")
        r.rows = convert(Vector{TableRow}, x["rows"])
    end
    if haskey(x, "schema")
        r.schema = convert(TableSchema, x["schema"])
    end
    if haskey(x, "totalBytesProcessed")
        r.totalBytesProcessed = convert(Union{Nothing, Int64}, x["totalBytesProcessed"])
    end
    if haskey(x, "totalRows")
        r.totalRows = convert(Union{Nothing, UInt64}, x["totalRows"])
    end
    r
end
function Base.convert(::Type{GetServiceAccountResponse}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = GetServiceAccountResponse()
    if haskey(x, "email")
        r.email = convert(String, x["email"])
    end
    if haskey(x, "kind")
        r.kind = convert(String, x["kind"])
    end
    r
end
function Base.convert(::Type{GoogleSheetsOptions}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = GoogleSheetsOptions()
    if haskey(x, "range")
        r.range = convert(String, x["range"])
    end
    if haskey(x, "skipLeadingRows")
        r.skipLeadingRows = convert(Union{Nothing, Int64}, x["skipLeadingRows"])
    end
    r
end
function Base.convert(::Type{Job}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Job()
    if haskey(x, "configuration")
        r.configuration = convert(JobConfiguration, x["configuration"])
    end
    if haskey(x, "etag")
        r.etag = convert(String, x["etag"])
    end
    if haskey(x, "id")
        r.id = convert(String, x["id"])
    end
    if haskey(x, "jobReference")
        r.jobReference = convert(JobReference, x["jobReference"])
    end
    if haskey(x, "kind")
        r.kind = convert(String, x["kind"])
    end
    if haskey(x, "selfLink")
        r.selfLink = convert(String, x["selfLink"])
    end
    if haskey(x, "statistics")
        r.statistics = convert(JobStatistics, x["statistics"])
    end
    if haskey(x, "status")
        r.status = convert(JobStatus, x["status"])
    end
    if haskey(x, "user_email")
        r.user_email = convert(String, x["user_email"])
    end
    r
end
function Base.convert(::Type{JobCancelResponse}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = JobCancelResponse()
    if haskey(x, "job")
        r.job = convert(Job, x["job"])
    end
    if haskey(x, "kind")
        r.kind = convert(String, x["kind"])
    end
    r
end
function Base.convert(::Type{JobConfiguration}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = JobConfiguration()
    if haskey(x, "copy")
        r.copy = convert(JobConfigurationTableCopy, x["copy"])
    end
    if haskey(x, "dryRun")
        r.dryRun = convert(Union{Nothing, Bool}, x["dryRun"])
    end
    if haskey(x, "extract")
        r.extract = convert(JobConfigurationExtract, x["extract"])
    end
    if haskey(x, "jobTimeoutMs")
        r.jobTimeoutMs = convert(Union{Nothing, Int64}, x["jobTimeoutMs"])
    end
    if haskey(x, "jobType")
        r.jobType = convert(String, x["jobType"])
    end
    if haskey(x, "load")
        r.load = convert(JobConfigurationLoad, x["load"])
    end
    if haskey(x, "query")
        r.query = convert(JobConfigurationQuery, x["query"])
    end
    r
end
function Base.convert(::Type{JobConfigurationExtract}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = JobConfigurationExtract()
    if haskey(x, "compression")
        r.compression = convert(String, x["compression"])
    end
    if haskey(x, "destinationFormat")
        r.destinationFormat = convert(String, x["destinationFormat"])
    end
    if haskey(x, "destinationUri")
        r.destinationUri = convert(String, x["destinationUri"])
    end
    if haskey(x, "destinationUris")
        r.destinationUris = convert(Vector{String}, x["destinationUris"])
    end
    if haskey(x, "fieldDelimiter")
        r.fieldDelimiter = convert(String, x["fieldDelimiter"])
    end
    if haskey(x, "printHeader")
        r.printHeader = convert(Union{Nothing, Bool}, x["printHeader"])
    end
    if haskey(x, "sourceTable")
        r.sourceTable = convert(TableReference, x["sourceTable"])
    end
    r
end
function Base.convert(::Type{JobConfigurationLoad}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = JobConfigurationLoad()
    if haskey(x, "allowJaggedRows")
        r.allowJaggedRows = convert(Union{Nothing, Bool}, x["allowJaggedRows"])
    end
    if haskey(x, "allowQuotedNewlines")
        r.allowQuotedNewlines = convert(Union{Nothing, Bool}, x["allowQuotedNewlines"])
    end
    if haskey(x, "autodetect")
        r.autodetect = convert(Union{Nothing, Bool}, x["autodetect"])
    end
    if haskey(x, "clustering")
        r.clustering = convert(Clustering, x["clustering"])
    end
    if haskey(x, "createDisposition")
        r.createDisposition = convert(String, x["createDisposition"])
    end
    if haskey(x, "destinationEncryptionConfiguration")
        r.destinationEncryptionConfiguration = convert(EncryptionConfiguration, x["destinationEncryptionConfiguration"])
    end
    if haskey(x, "destinationTable")
        r.destinationTable = convert(TableReference, x["destinationTable"])
    end
    if haskey(x, "destinationTableProperties")
        r.destinationTableProperties = convert(DestinationTableProperties, x["destinationTableProperties"])
    end
    if haskey(x, "encoding")
        r.encoding = convert(String, x["encoding"])
    end
    if haskey(x, "fieldDelimiter")
        r.fieldDelimiter = convert(String, x["fieldDelimiter"])
    end
    if haskey(x, "hivePartitioningMode")
        r.hivePartitioningMode = convert(String, x["hivePartitioningMode"])
    end
    if haskey(x, "ignoreUnknownValues")
        r.ignoreUnknownValues = convert(Union{Nothing, Bool}, x["ignoreUnknownValues"])
    end
    if haskey(x, "maxBadRecords")
        r.maxBadRecords = convert(Union{Nothing, Int32}, x["maxBadRecords"])
    end
    if haskey(x, "nullMarker")
        r.nullMarker = convert(String, x["nullMarker"])
    end
    if haskey(x, "projectionFields")
        r.projectionFields = convert(Vector{String}, x["projectionFields"])
    end
    if haskey(x, "quote")
        r.quote_ = convert(String, x["quote"])
    end
    if haskey(x, "rangePartitioning")
        r.rangePartitioning = convert(RangePartitioning, x["rangePartitioning"])
    end
    if haskey(x, "schema")
        r.schema = convert(TableSchema, x["schema"])
    end
    if haskey(x, "schemaInline")
        r.schemaInline = convert(String, x["schemaInline"])
    end
    if haskey(x, "schemaInlineFormat")
        r.schemaInlineFormat = convert(String, x["schemaInlineFormat"])
    end
    if haskey(x, "schemaUpdateOptions")
        r.schemaUpdateOptions = convert(Vector{String}, x["schemaUpdateOptions"])
    end
    if haskey(x, "skipLeadingRows")
        r.skipLeadingRows = convert(Union{Nothing, Int32}, x["skipLeadingRows"])
    end
    if haskey(x, "sourceFormat")
        r.sourceFormat = convert(String, x["sourceFormat"])
    end
    if haskey(x, "sourceUris")
        r.sourceUris = convert(Vector{String}, x["sourceUris"])
    end
    if haskey(x, "timePartitioning")
        r.timePartitioning = convert(TimePartitioning, x["timePartitioning"])
    end
    if haskey(x, "useAvroLogicalTypes")
        r.useAvroLogicalTypes = convert(Union{Nothing, Bool}, x["useAvroLogicalTypes"])
    end
    if haskey(x, "writeDisposition")
        r.writeDisposition = convert(String, x["writeDisposition"])
    end
    r
end
function Base.convert(::Type{JobConfigurationQuery}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = JobConfigurationQuery()
    if haskey(x, "allowLargeResults")
        r.allowLargeResults = convert(Union{Nothing, Bool}, x["allowLargeResults"])
    end
    if haskey(x, "clustering")
        r.clustering = convert(Clustering, x["clustering"])
    end
    if haskey(x, "createDisposition")
        r.createDisposition = convert(String, x["createDisposition"])
    end
    if haskey(x, "defaultDataset")
        r.defaultDataset = convert(DatasetReference, x["defaultDataset"])
    end
    if haskey(x, "destinationEncryptionConfiguration")
        r.destinationEncryptionConfiguration = convert(EncryptionConfiguration, x["destinationEncryptionConfiguration"])
    end
    if haskey(x, "destinationTable")
        r.destinationTable = convert(TableReference, x["destinationTable"])
    end
    if haskey(x, "flattenResults")
        r.flattenResults = convert(Union{Nothing, Bool}, x["flattenResults"])
    end
    if haskey(x, "maximumBillingTier")
        r.maximumBillingTier = convert(Union{Nothing, Int32}, x["maximumBillingTier"])
    end
    if haskey(x, "maximumBytesBilled")
        r.maximumBytesBilled = convert(Union{Nothing, Int64}, x["maximumBytesBilled"])
    end
    if haskey(x, "parameterMode")
        r.parameterMode = convert(String, x["parameterMode"])
    end
    if haskey(x, "preserveNulls")
        r.preserveNulls = convert(Union{Nothing, Bool}, x["preserveNulls"])
    end
    if haskey(x, "priority")
        r.priority = convert(String, x["priority"])
    end
    if haskey(x, "query")
        r.query = convert(String, x["query"])
    end
    if haskey(x, "queryParameters")
        r.queryParameters = convert(Vector{QueryParameter}, x["queryParameters"])
    end
    if haskey(x, "rangePartitioning")
        r.rangePartitioning = convert(RangePartitioning, x["rangePartitioning"])
    end
    if haskey(x, "schemaUpdateOptions")
        r.schemaUpdateOptions = convert(Vector{String}, x["schemaUpdateOptions"])
    end
    if haskey(x, "timePartitioning")
        r.timePartitioning = convert(TimePartitioning, x["timePartitioning"])
    end
    if haskey(x, "useLegacySql")
        r.useLegacySql = convert(Union{Nothing, Bool}, x["useLegacySql"])
    end
    if haskey(x, "useQueryCache")
        r.useQueryCache = convert(Union{Nothing, Bool}, x["useQueryCache"])
    end
    if haskey(x, "userDefinedFunctionResources")
        r.userDefinedFunctionResources = convert(Vector{UserDefinedFunctionResource}, x["userDefinedFunctionResources"])
    end
    if haskey(x, "writeDisposition")
        r.writeDisposition = convert(String, x["writeDisposition"])
    end
    r
end
function Base.convert(::Type{JobConfigurationTableCopy}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = JobConfigurationTableCopy()
    if haskey(x, "createDisposition")
        r.createDisposition = convert(String, x["createDisposition"])
    end
    if haskey(x, "destinationEncryptionConfiguration")
        r.destinationEncryptionConfiguration = convert(EncryptionConfiguration, x["destinationEncryptionConfiguration"])
    end
    if haskey(x, "destinationTable")
        r.destinationTable = convert(TableReference, x["destinationTable"])
    end
    if haskey(x, "sourceTable")
        r.sourceTable = convert(TableReference, x["sourceTable"])
    end
    if haskey(x, "sourceTables")
        r.sourceTables = convert(Vector{TableReference}, x["sourceTables"])
    end
    if haskey(x, "writeDisposition")
        r.writeDisposition = convert(String, x["writeDisposition"])
    end
    r
end
function Base.convert(::Type{JobList}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = JobList()
    if haskey(x, "etag")
        r.etag = convert(String, x["etag"])
    end
    if haskey(x, "jobs")
        r.jobs = convert(Vector{Job}, x["jobs"])
    end
    if haskey(x, "kind")
        r.kind = convert(String, x["kind"])
    end
    if haskey(x, "nextPageToken")
        r.nextPageToken = convert(String, x["nextPageToken"])
    end
    r
end
function Base.convert(::Type{JobReference}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = JobReference()
    if haskey(x, "jobId")
        r.jobId = convert(String, x["jobId"])
    end
    if haskey(x, "location")
        r.location = convert(String, x["location"])
    end
    if haskey(x, "projectId")
        r.projectId = convert(String, x["projectId"])
    end
    r
end
function Base.convert(::Type{JobStatistics}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = JobStatistics()
    if haskey(x, "completionRatio")
        r.completionRatio = convert(Union{Nothing, Float64}, x["completionRatio"])
    end
    if haskey(x, "creationTime")
        r.creationTime = convert(Union{Nothing, Int64}, x["creationTime"])
    end
    if haskey(x, "endTime")
        r.endTime = convert(Union{Nothing, Int64}, x["endTime"])
    end
    if haskey(x, "extract")
        r.extract = convert(JobStatistics4, x["extract"])
    end
    if haskey(x, "load")
        r.load = convert(JobStatistics3, x["load"])
    end
    if haskey(x, "numChildJobs")
        r.numChildJobs = convert(Union{Nothing, Int64}, x["numChildJobs"])
    end
    if haskey(x, "parentJobId")
        r.parentJobId = convert(String, x["parentJobId"])
    end
    if haskey(x, "query")
        r.query = convert(JobStatistics2, x["query"])
    end
    if haskey(x, "quotaDeferments")
        r.quotaDeferments = convert(Vector{String}, x["quotaDeferments"])
    end
    if haskey(x, "startTime")
        r.startTime = convert(Union{Nothing, Int64}, x["startTime"])
    end
    if haskey(x, "totalBytesProcessed")
        r.totalBytesProcessed = convert(Union{Nothing, Int64}, x["totalBytesProcessed"])
    end
    if haskey(x, "totalSlotMs")
        r.totalSlotMs = convert(Union{Nothing, Int64}, x["totalSlotMs"])
    end
    r
end
function Base.convert(::Type{JobStatistics2}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = JobStatistics2()
    if haskey(x, "billingTier")
        r.billingTier = convert(Union{Nothing, Int32}, x["billingTier"])
    end
    if haskey(x, "cacheHit")
        r.cacheHit = convert(Union{Nothing, Bool}, x["cacheHit"])
    end
    if haskey(x, "ddlOperationPerformed")
        r.ddlOperationPerformed = convert(String, x["ddlOperationPerformed"])
    end
    if haskey(x, "ddlTargetRoutine")
        r.ddlTargetRoutine = convert(RoutineReference, x["ddlTargetRoutine"])
    end
    if haskey(x, "ddlTargetTable")
        r.ddlTargetTable = convert(TableReference, x["ddlTargetTable"])
    end
    if haskey(x, "estimatedBytesProcessed")
        r.estimatedBytesProcessed = convert(Union{Nothing, Int64}, x["estimatedBytesProcessed"])
    end
    if haskey(x, "modelTraining")
        r.modelTraining = convert(BigQueryModelTraining, x["modelTraining"])
    end
    if haskey(x, "modelTrainingCurrentIteration")
        r.modelTrainingCurrentIteration = convert(Union{Nothing, Int32}, x["modelTrainingCurrentIteration"])
    end
    if haskey(x, "modelTrainingExpectedTotalIteration")
        r.modelTrainingExpectedTotalIteration = convert(Union{Nothing, Int64}, x["modelTrainingExpectedTotalIteration"])
    end
    if haskey(x, "numDmlAffectedRows")
        r.numDmlAffectedRows = convert(Union{Nothing, Int64}, x["numDmlAffectedRows"])
    end
    if haskey(x, "queryPlan")
        r.queryPlan = convert(Vector{ExplainQueryStage}, x["queryPlan"])
    end
    if haskey(x, "referencedTables")
        r.referencedTables = convert(Vector{TableReference}, x["referencedTables"])
    end
    if haskey(x, "schema")
        r.schema = convert(TableSchema, x["schema"])
    end
    if haskey(x, "statementType")
        r.statementType = convert(String, x["statementType"])
    end
    if haskey(x, "timeline")
        r.timeline = convert(Vector{QueryTimelineSample}, x["timeline"])
    end
    if haskey(x, "totalBytesBilled")
        r.totalBytesBilled = convert(Union{Nothing, Int64}, x["totalBytesBilled"])
    end
    if haskey(x, "totalBytesProcessed")
        r.totalBytesProcessed = convert(Union{Nothing, Int64}, x["totalBytesProcessed"])
    end
    if haskey(x, "totalBytesProcessedAccuracy")
        r.totalBytesProcessedAccuracy = convert(String, x["totalBytesProcessedAccuracy"])
    end
    if haskey(x, "totalPartitionsProcessed")
        r.totalPartitionsProcessed = convert(Union{Nothing, Int64}, x["totalPartitionsProcessed"])
    end
    if haskey(x, "totalSlotMs")
        r.totalSlotMs = convert(Union{Nothing, Int64}, x["totalSlotMs"])
    end
    if haskey(x, "undeclaredQueryParameters")
        r.undeclaredQueryParameters = convert(Vector{QueryParameter}, x["undeclaredQueryParameters"])
    end
    r
end
function Base.convert(::Type{JobStatistics3}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = JobStatistics3()
    if haskey(x, "badRecords")
        r.badRecords = convert(Union{Nothing, Int64}, x["badRecords"])
    end
    if haskey(x, "inputFileBytes")
        r.inputFileBytes = convert(Union{Nothing, Int64}, x["inputFileBytes"])
    end
    if haskey(x, "inputFiles")
        r.inputFiles = convert(Union{Nothing, Int64}, x["inputFiles"])
    end
    if haskey(x, "outputBytes")
        r.outputBytes = convert(Union{Nothing, Int64}, x["outputBytes"])
    end
    if haskey(x, "outputRows")
        r.outputRows = convert(Union{Nothing, Int64}, x["outputRows"])
    end
    r
end
function Base.convert(::Type{JobStatistics4}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = JobStatistics4()
    if haskey(x, "destinationUriFileCounts")
        r.destinationUriFileCounts = convert(Vector{Int64}, x["destinationUriFileCounts"])
    end
    if haskey(x, "inputBytes")
        r.inputBytes = convert(Union{Nothing, Int64}, x["inputBytes"])
    end
    r
end
function Base.convert(::Type{JobStatus}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = JobStatus()
    if haskey(x, "errorResult")
        r.errorResult = convert(ErrorProto, x["errorResult"])
    end
    if haskey(x, "errors")
        r.errors = convert(Vector{ErrorProto}, x["errors"])
    end
    if haskey(x, "state")
        r.state = convert(String, x["state"])
    end
    r
end
function Base.convert(::Type{JsonObject}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = JsonObject()
    r
end
function Base.convert(::Type{JsonValue}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = JsonValue()
    r
end
function Base.convert(::Type{MaterializedViewDefinition}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = MaterializedViewDefinition()
    if haskey(x, "lastRefreshTime")
        r.lastRefreshTime = convert(Union{Nothing, Int64}, x["lastRefreshTime"])
    end
    if haskey(x, "query")
        r.query = convert(String, x["query"])
    end
    r
end
function Base.convert(::Type{ModelDefinition}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = ModelDefinition()
    if haskey(x, "trainingRuns")
        r.trainingRuns = convert(Vector{BqmlTrainingRun}, x["trainingRuns"])
    end
    r
end
function Base.convert(::Type{ProjectList}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = ProjectList()
    if haskey(x, "etag")
        r.etag = convert(String, x["etag"])
    end
    if haskey(x, "kind")
        r.kind = convert(String, x["kind"])
    end
    if haskey(x, "nextPageToken")
        r.nextPageToken = convert(String, x["nextPageToken"])
    end
    if haskey(x, "totalItems")
        r.totalItems = convert(Union{Nothing, Int32}, x["totalItems"])
    end
    r
end
function Base.convert(::Type{ProjectReference}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = ProjectReference()
    if haskey(x, "projectId")
        r.projectId = convert(String, x["projectId"])
    end
    r
end
function Base.convert(::Type{QueryParameter}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = QueryParameter()
    if haskey(x, "name")
        r.name = convert(String, x["name"])
    end
    if haskey(x, "parameterType")
        r.parameterType = convert(QueryParameterType, x["parameterType"])
    end
    if haskey(x, "parameterValue")
        r.parameterValue = convert(QueryParameterValue, x["parameterValue"])
    end
    r
end
function Base.convert(::Type{QueryParameterType}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = QueryParameterType()
    if haskey(x, "arrayType")
        r.arrayType = convert(QueryParameterType, x["arrayType"])
    end
    if haskey(x, "type")
        r.type_ = convert(String, x["type"])
    end
    r
end
function Base.convert(::Type{QueryParameterValue}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = QueryParameterValue()
    if haskey(x, "arrayValues")
        r.arrayValues = convert(Vector{QueryParameterValue}, x["arrayValues"])
    end
    if haskey(x, "value")
        r.value = convert(String, x["value"])
    end
    r
end
function Base.convert(::Type{QueryRequest}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = QueryRequest()
    if haskey(x, "defaultDataset")
        r.defaultDataset = convert(DatasetReference, x["defaultDataset"])
    end
    if haskey(x, "dryRun")
        r.dryRun = convert(Union{Nothing, Bool}, x["dryRun"])
    end
    if haskey(x, "kind")
        r.kind = convert(String, x["kind"])
    end
    if haskey(x, "location")
        r.location = convert(String, x["location"])
    end
    if haskey(x, "maxResults")
        r.maxResults = convert(Union{Nothing, UInt32}, x["maxResults"])
    end
    if haskey(x, "parameterMode")
        r.parameterMode = convert(String, x["parameterMode"])
    end
    if haskey(x, "preserveNulls")
        r.preserveNulls = convert(Union{Nothing, Bool}, x["preserveNulls"])
    end
    if haskey(x, "query")
        r.query = convert(String, x["query"])
    end
    if haskey(x, "queryParameters")
        r.queryParameters = convert(Vector{QueryParameter}, x["queryParameters"])
    end
    if haskey(x, "timeoutMs")
        r.timeoutMs = convert(Union{Nothing, UInt32}, x["timeoutMs"])
    end
    if haskey(x, "useLegacySql")
        r.useLegacySql = convert(Union{Nothing, Bool}, x["useLegacySql"])
    end
    if haskey(x, "useQueryCache")
        r.useQueryCache = convert(Union{Nothing, Bool}, x["useQueryCache"])
    end
    r
end
function Base.convert(::Type{QueryResponse}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = QueryResponse()
    if haskey(x, "cacheHit")
        r.cacheHit = convert(Union{Nothing, Bool}, x["cacheHit"])
    end
    if haskey(x, "errors")
        r.errors = convert(Vector{ErrorProto}, x["errors"])
    end
    if haskey(x, "jobComplete")
        r.jobComplete = convert(Union{Nothing, Bool}, x["jobComplete"])
    end
    if haskey(x, "jobReference")
        r.jobReference = convert(JobReference, x["jobReference"])
    end
    if haskey(x, "kind")
        r.kind = convert(String, x["kind"])
    end
    if haskey(x, "numDmlAffectedRows")
        r.numDmlAffectedRows = convert(Union{Nothing, Int64}, x["numDmlAffectedRows"])
    end
    if haskey(x, "pageToken")
        r.pageToken = convert(String, x["pageToken"])
    end
    if haskey(x, "rows")
        r.rows = convert(Vector{TableRow}, x["rows"])
    end
    if haskey(x, "schema")
        r.schema = convert(TableSchema, x["schema"])
    end
    if haskey(x, "totalBytesProcessed")
        r.totalBytesProcessed = convert(Union{Nothing, Int64}, x["totalBytesProcessed"])
    end
    if haskey(x, "totalRows")
        r.totalRows = convert(Union{Nothing, UInt64}, x["totalRows"])
    end
    r
end
function Base.convert(::Type{QueryTimelineSample}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = QueryTimelineSample()
    if haskey(x, "activeUnits")
        r.activeUnits = convert(Union{Nothing, Int64}, x["activeUnits"])
    end
    if haskey(x, "completedUnits")
        r.completedUnits = convert(Union{Nothing, Int64}, x["completedUnits"])
    end
    if haskey(x, "elapsedMs")
        r.elapsedMs = convert(Union{Nothing, Int64}, x["elapsedMs"])
    end
    if haskey(x, "pendingUnits")
        r.pendingUnits = convert(Union{Nothing, Int64}, x["pendingUnits"])
    end
    if haskey(x, "totalSlotMs")
        r.totalSlotMs = convert(Union{Nothing, Int64}, x["totalSlotMs"])
    end
    r
end
function Base.convert(::Type{RangePartitioning}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = RangePartitioning()
    if haskey(x, "field")
        r.field = convert(String, x["field"])
    end
    r
end
function Base.convert(::Type{RoutineReference}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = RoutineReference()
    if haskey(x, "datasetId")
        r.datasetId = convert(String, x["datasetId"])
    end
    if haskey(x, "projectId")
        r.projectId = convert(String, x["projectId"])
    end
    if haskey(x, "routineId")
        r.routineId = convert(String, x["routineId"])
    end
    r
end
function Base.convert(::Type{Streamingbuffer}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Streamingbuffer()
    if haskey(x, "estimatedBytes")
        r.estimatedBytes = convert(Union{Nothing, UInt64}, x["estimatedBytes"])
    end
    if haskey(x, "estimatedRows")
        r.estimatedRows = convert(Union{Nothing, UInt64}, x["estimatedRows"])
    end
    if haskey(x, "oldestEntryTime")
        r.oldestEntryTime = convert(Union{Nothing, UInt64}, x["oldestEntryTime"])
    end
    r
end
function Base.convert(::Type{Table}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Table()
    if haskey(x, "clustering")
        r.clustering = convert(Clustering, x["clustering"])
    end
    if haskey(x, "creationTime")
        r.creationTime = convert(Union{Nothing, Int64}, x["creationTime"])
    end
    if haskey(x, "description")
        r.description = convert(String, x["description"])
    end
    if haskey(x, "encryptionConfiguration")
        r.encryptionConfiguration = convert(EncryptionConfiguration, x["encryptionConfiguration"])
    end
    if haskey(x, "etag")
        r.etag = convert(String, x["etag"])
    end
    if haskey(x, "expirationTime")
        r.expirationTime = convert(Union{Nothing, Int64}, x["expirationTime"])
    end
    if haskey(x, "externalDataConfiguration")
        r.externalDataConfiguration = convert(ExternalDataConfiguration, x["externalDataConfiguration"])
    end
    if haskey(x, "friendlyName")
        r.friendlyName = convert(String, x["friendlyName"])
    end
    if haskey(x, "id")
        r.id = convert(String, x["id"])
    end
    if haskey(x, "kind")
        r.kind = convert(String, x["kind"])
    end
    if haskey(x, "lastModifiedTime")
        r.lastModifiedTime = convert(Union{Nothing, UInt64}, x["lastModifiedTime"])
    end
    if haskey(x, "location")
        r.location = convert(String, x["location"])
    end
    if haskey(x, "materializedView")
        r.materializedView = convert(MaterializedViewDefinition, x["materializedView"])
    end
    if haskey(x, "model")
        r.model = convert(ModelDefinition, x["model"])
    end
    if haskey(x, "numBytes")
        r.numBytes = convert(Union{Nothing, Int64}, x["numBytes"])
    end
    if haskey(x, "numLongTermBytes")
        r.numLongTermBytes = convert(Union{Nothing, Int64}, x["numLongTermBytes"])
    end
    if haskey(x, "numPhysicalBytes")
        r.numPhysicalBytes = convert(Union{Nothing, Int64}, x["numPhysicalBytes"])
    end
    if haskey(x, "numRows")
        r.numRows = convert(Union{Nothing, UInt64}, x["numRows"])
    end
    if haskey(x, "rangePartitioning")
        r.rangePartitioning = convert(RangePartitioning, x["rangePartitioning"])
    end
    if haskey(x, "requirePartitionFilter")
        r.requirePartitionFilter = convert(Union{Nothing, Bool}, x["requirePartitionFilter"])
    end
    if haskey(x, "schema")
        r.schema = convert(TableSchema, x["schema"])
    end
    if haskey(x, "selfLink")
        r.selfLink = convert(String, x["selfLink"])
    end
    if haskey(x, "streamingBuffer")
        r.streamingBuffer = convert(Streamingbuffer, x["streamingBuffer"])
    end
    if haskey(x, "tableReference")
        r.tableReference = convert(TableReference, x["tableReference"])
    end
    if haskey(x, "timePartitioning")
        r.timePartitioning = convert(TimePartitioning, x["timePartitioning"])
    end
    if haskey(x, "type")
        r.type_ = convert(String, x["type"])
    end
    if haskey(x, "view")
        r.view = convert(ViewDefinition, x["view"])
    end
    r
end
function Base.convert(::Type{TableCell}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = TableCell()
    r
end
function Base.convert(::Type{TableDataInsertAllRequest}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = TableDataInsertAllRequest()
    if haskey(x, "ignoreUnknownValues")
        r.ignoreUnknownValues = convert(Union{Nothing, Bool}, x["ignoreUnknownValues"])
    end
    if haskey(x, "kind")
        r.kind = convert(String, x["kind"])
    end
    if haskey(x, "skipInvalidRows")
        r.skipInvalidRows = convert(Union{Nothing, Bool}, x["skipInvalidRows"])
    end
    if haskey(x, "templateSuffix")
        r.templateSuffix = convert(String, x["templateSuffix"])
    end
    r
end
function Base.convert(::Type{TableDataInsertAllResponse}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = TableDataInsertAllResponse()
    if haskey(x, "kind")
        r.kind = convert(String, x["kind"])
    end
    r
end
function Base.convert(::Type{TableDataList}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = TableDataList()
    if haskey(x, "etag")
        r.etag = convert(String, x["etag"])
    end
    if haskey(x, "kind")
        r.kind = convert(String, x["kind"])
    end
    if haskey(x, "pageToken")
        r.pageToken = convert(String, x["pageToken"])
    end
    if haskey(x, "rows")
        r.rows = convert(Vector{TableRow}, x["rows"])
    end
    if haskey(x, "totalRows")
        r.totalRows = convert(Union{Nothing, Int64}, x["totalRows"])
    end
    r
end
function Base.convert(::Type{TableFieldSchema}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = TableFieldSchema()
    if haskey(x, "description")
        r.description = convert(String, x["description"])
    end
    if haskey(x, "fields")
        r.fields = convert(Vector{TableFieldSchema}, x["fields"])
    end
    if haskey(x, "mode")
        r.mode = convert(String, x["mode"])
    end
    if haskey(x, "name")
        r.name = convert(String, x["name"])
    end
    if haskey(x, "type")
        r.type_ = convert(String, x["type"])
    end
    r
end
function Base.convert(::Type{TableList}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = TableList()
    if haskey(x, "etag")
        r.etag = convert(String, x["etag"])
    end
    if haskey(x, "kind")
        r.kind = convert(String, x["kind"])
    end
    if haskey(x, "nextPageToken")
        r.nextPageToken = convert(String, x["nextPageToken"])
    end
    if haskey(x, "tables")
        r.tables = convert(Vector{Table}, x["tables"])
    end
    if haskey(x, "totalItems")
        r.totalItems = convert(Union{Nothing, Int32}, x["totalItems"])
    end
    r
end
function Base.convert(::Type{TableReference}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = TableReference()
    if haskey(x, "datasetId")
        r.datasetId = convert(String, x["datasetId"])
    end
    if haskey(x, "projectId")
        r.projectId = convert(String, x["projectId"])
    end
    if haskey(x, "tableId")
        r.tableId = convert(String, x["tableId"])
    end
    r
end
function Base.convert(::Type{TableRow}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = TableRow()
    if haskey(x, "f")
        r.f = convert(Vector{TableCell}, x["f"])
    end
    r
end
function Base.convert(::Type{TableSchema}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = TableSchema()
    if haskey(x, "fields")
        r.fields = convert(Vector{TableFieldSchema}, x["fields"])
    end
    r
end
function Base.convert(::Type{TimePartitioning}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = TimePartitioning()
    if haskey(x, "expirationMs")
        r.expirationMs = convert(Union{Nothing, Int64}, x["expirationMs"])
    end
    if haskey(x, "field")
        r.field = convert(String, x["field"])
    end
    if haskey(x, "requirePartitionFilter")
        r.requirePartitionFilter = convert(Union{Nothing, Bool}, x["requirePartitionFilter"])
    end
    if haskey(x, "type")
        r.type_ = convert(String, x["type"])
    end
    r
end
function Base.convert(::Type{UserDefinedFunctionResource}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = UserDefinedFunctionResource()
    if haskey(x, "inlineCode")
        r.inlineCode = convert(String, x["inlineCode"])
    end
    if haskey(x, "resourceUri")
        r.resourceUri = convert(String, x["resourceUri"])
    end
    r
end
function Base.convert(::Type{ViewDefinition}, x::LazyJSON.Object{Nothing, String})
    if x == nothing
        return nothing
    end
    r = ViewDefinition()
    if haskey(x, "query")
        r.query = convert(String, x["query"])
    end
    if haskey(x, "useLegacySql")
        r.useLegacySql = convert(Union{Nothing, Bool}, x["useLegacySql"])
    end
    if haskey(x, "userDefinedFunctionResources")
        r.userDefinedFunctionResources = convert(Vector{UserDefinedFunctionResource}, x["userDefinedFunctionResources"])
    end
    r
end
function Base.convert(::Type{Vector{BigQueryModelTraining}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{BigQueryModelTraining}()
    for v = x
        push!(r, convert(BigQueryModelTraining, v))
    end
    r
end
function Base.convert(::Type{Vector{BigtableColumn}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{BigtableColumn}()
    for v = x
        push!(r, convert(BigtableColumn, v))
    end
    r
end
function Base.convert(::Type{Vector{BigtableColumnFamily}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{BigtableColumnFamily}()
    for v = x
        push!(r, convert(BigtableColumnFamily, v))
    end
    r
end
function Base.convert(::Type{Vector{BigtableOptions}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{BigtableOptions}()
    for v = x
        push!(r, convert(BigtableOptions, v))
    end
    r
end
function Base.convert(::Type{Vector{BqmlIterationResult}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{BqmlIterationResult}()
    for v = x
        push!(r, convert(BqmlIterationResult, v))
    end
    r
end
function Base.convert(::Type{Vector{BqmlTrainingRun}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{BqmlTrainingRun}()
    for v = x
        push!(r, convert(BqmlTrainingRun, v))
    end
    r
end
function Base.convert(::Type{Vector{Clustering}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{Clustering}()
    for v = x
        push!(r, convert(Clustering, v))
    end
    r
end
function Base.convert(::Type{Vector{CsvOptions}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{CsvOptions}()
    for v = x
        push!(r, convert(CsvOptions, v))
    end
    r
end
function Base.convert(::Type{Vector{Dataset}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{Dataset}()
    for v = x
        push!(r, convert(Dataset, v))
    end
    r
end
function Base.convert(::Type{Vector{DatasetList}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{DatasetList}()
    for v = x
        push!(r, convert(DatasetList, v))
    end
    r
end
function Base.convert(::Type{Vector{DatasetReference}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{DatasetReference}()
    for v = x
        push!(r, convert(DatasetReference, v))
    end
    r
end
function Base.convert(::Type{Vector{DestinationTableProperties}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{DestinationTableProperties}()
    for v = x
        push!(r, convert(DestinationTableProperties, v))
    end
    r
end
function Base.convert(::Type{Vector{EncryptionConfiguration}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{EncryptionConfiguration}()
    for v = x
        push!(r, convert(EncryptionConfiguration, v))
    end
    r
end
function Base.convert(::Type{Vector{ErrorProto}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{ErrorProto}()
    for v = x
        push!(r, convert(ErrorProto, v))
    end
    r
end
function Base.convert(::Type{Vector{ExplainQueryStage}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{ExplainQueryStage}()
    for v = x
        push!(r, convert(ExplainQueryStage, v))
    end
    r
end
function Base.convert(::Type{Vector{ExplainQueryStep}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{ExplainQueryStep}()
    for v = x
        push!(r, convert(ExplainQueryStep, v))
    end
    r
end
function Base.convert(::Type{Vector{ExternalDataConfiguration}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{ExternalDataConfiguration}()
    for v = x
        push!(r, convert(ExternalDataConfiguration, v))
    end
    r
end
function Base.convert(::Type{Vector{GetQueryResultsResponse}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{GetQueryResultsResponse}()
    for v = x
        push!(r, convert(GetQueryResultsResponse, v))
    end
    r
end
function Base.convert(::Type{Vector{GetServiceAccountResponse}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{GetServiceAccountResponse}()
    for v = x
        push!(r, convert(GetServiceAccountResponse, v))
    end
    r
end
function Base.convert(::Type{Vector{GoogleSheetsOptions}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{GoogleSheetsOptions}()
    for v = x
        push!(r, convert(GoogleSheetsOptions, v))
    end
    r
end
function Base.convert(::Type{Vector{Job}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{Job}()
    for v = x
        push!(r, convert(Job, v))
    end
    r
end
function Base.convert(::Type{Vector{JobCancelResponse}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{JobCancelResponse}()
    for v = x
        push!(r, convert(JobCancelResponse, v))
    end
    r
end
function Base.convert(::Type{Vector{JobConfiguration}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{JobConfiguration}()
    for v = x
        push!(r, convert(JobConfiguration, v))
    end
    r
end
function Base.convert(::Type{Vector{JobConfigurationExtract}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{JobConfigurationExtract}()
    for v = x
        push!(r, convert(JobConfigurationExtract, v))
    end
    r
end
function Base.convert(::Type{Vector{JobConfigurationLoad}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{JobConfigurationLoad}()
    for v = x
        push!(r, convert(JobConfigurationLoad, v))
    end
    r
end
function Base.convert(::Type{Vector{JobConfigurationQuery}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{JobConfigurationQuery}()
    for v = x
        push!(r, convert(JobConfigurationQuery, v))
    end
    r
end
function Base.convert(::Type{Vector{JobConfigurationTableCopy}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{JobConfigurationTableCopy}()
    for v = x
        push!(r, convert(JobConfigurationTableCopy, v))
    end
    r
end
function Base.convert(::Type{Vector{JobList}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{JobList}()
    for v = x
        push!(r, convert(JobList, v))
    end
    r
end
function Base.convert(::Type{Vector{JobReference}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{JobReference}()
    for v = x
        push!(r, convert(JobReference, v))
    end
    r
end
function Base.convert(::Type{Vector{JobStatistics}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{JobStatistics}()
    for v = x
        push!(r, convert(JobStatistics, v))
    end
    r
end
function Base.convert(::Type{Vector{JobStatistics2}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{JobStatistics2}()
    for v = x
        push!(r, convert(JobStatistics2, v))
    end
    r
end
function Base.convert(::Type{Vector{JobStatistics3}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{JobStatistics3}()
    for v = x
        push!(r, convert(JobStatistics3, v))
    end
    r
end
function Base.convert(::Type{Vector{JobStatistics4}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{JobStatistics4}()
    for v = x
        push!(r, convert(JobStatistics4, v))
    end
    r
end
function Base.convert(::Type{Vector{JobStatus}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{JobStatus}()
    for v = x
        push!(r, convert(JobStatus, v))
    end
    r
end
function Base.convert(::Type{Vector{JsonObject}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{JsonObject}()
    for v = x
        push!(r, convert(JsonObject, v))
    end
    r
end
function Base.convert(::Type{Vector{JsonValue}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{JsonValue}()
    for v = x
        push!(r, convert(JsonValue, v))
    end
    r
end
function Base.convert(::Type{Vector{MaterializedViewDefinition}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{MaterializedViewDefinition}()
    for v = x
        push!(r, convert(MaterializedViewDefinition, v))
    end
    r
end
function Base.convert(::Type{Vector{ModelDefinition}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{ModelDefinition}()
    for v = x
        push!(r, convert(ModelDefinition, v))
    end
    r
end
function Base.convert(::Type{Vector{ProjectList}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{ProjectList}()
    for v = x
        push!(r, convert(ProjectList, v))
    end
    r
end
function Base.convert(::Type{Vector{ProjectReference}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{ProjectReference}()
    for v = x
        push!(r, convert(ProjectReference, v))
    end
    r
end
function Base.convert(::Type{Vector{QueryParameter}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{QueryParameter}()
    for v = x
        push!(r, convert(QueryParameter, v))
    end
    r
end
function Base.convert(::Type{Vector{QueryParameterType}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{QueryParameterType}()
    for v = x
        push!(r, convert(QueryParameterType, v))
    end
    r
end
function Base.convert(::Type{Vector{QueryParameterValue}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{QueryParameterValue}()
    for v = x
        push!(r, convert(QueryParameterValue, v))
    end
    r
end
function Base.convert(::Type{Vector{QueryRequest}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{QueryRequest}()
    for v = x
        push!(r, convert(QueryRequest, v))
    end
    r
end
function Base.convert(::Type{Vector{QueryResponse}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{QueryResponse}()
    for v = x
        push!(r, convert(QueryResponse, v))
    end
    r
end
function Base.convert(::Type{Vector{QueryTimelineSample}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{QueryTimelineSample}()
    for v = x
        push!(r, convert(QueryTimelineSample, v))
    end
    r
end
function Base.convert(::Type{Vector{RangePartitioning}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{RangePartitioning}()
    for v = x
        push!(r, convert(RangePartitioning, v))
    end
    r
end
function Base.convert(::Type{Vector{RoutineReference}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{RoutineReference}()
    for v = x
        push!(r, convert(RoutineReference, v))
    end
    r
end
function Base.convert(::Type{Vector{Streamingbuffer}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{Streamingbuffer}()
    for v = x
        push!(r, convert(Streamingbuffer, v))
    end
    r
end
function Base.convert(::Type{Vector{Table}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{Table}()
    for v = x
        push!(r, convert(Table, v))
    end
    r
end
function Base.convert(::Type{Vector{TableCell}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{TableCell}()
    for v = x
        push!(r, convert(TableCell, v))
    end
    r
end
function Base.convert(::Type{Vector{TableDataInsertAllRequest}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{TableDataInsertAllRequest}()
    for v = x
        push!(r, convert(TableDataInsertAllRequest, v))
    end
    r
end
function Base.convert(::Type{Vector{TableDataInsertAllResponse}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{TableDataInsertAllResponse}()
    for v = x
        push!(r, convert(TableDataInsertAllResponse, v))
    end
    r
end
function Base.convert(::Type{Vector{TableDataList}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{TableDataList}()
    for v = x
        push!(r, convert(TableDataList, v))
    end
    r
end
function Base.convert(::Type{Vector{TableFieldSchema}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{TableFieldSchema}()
    for v = x
        push!(r, convert(TableFieldSchema, v))
    end
    r
end
function Base.convert(::Type{Vector{TableList}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{TableList}()
    for v = x
        push!(r, convert(TableList, v))
    end
    r
end
function Base.convert(::Type{Vector{TableReference}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{TableReference}()
    for v = x
        push!(r, convert(TableReference, v))
    end
    r
end
function Base.convert(::Type{Vector{TableRow}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{TableRow}()
    for v = x
        push!(r, convert(TableRow, v))
    end
    r
end
function Base.convert(::Type{Vector{TableSchema}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{TableSchema}()
    for v = x
        push!(r, convert(TableSchema, v))
    end
    r
end
function Base.convert(::Type{Vector{TimePartitioning}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{TimePartitioning}()
    for v = x
        push!(r, convert(TimePartitioning, v))
    end
    r
end
function Base.convert(::Type{Vector{UserDefinedFunctionResource}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{UserDefinedFunctionResource}()
    for v = x
        push!(r, convert(UserDefinedFunctionResource, v))
    end
    r
end
function Base.convert(::Type{Vector{ViewDefinition}}, x::LazyJSON.Array{Nothing, String})
    if x == nothing
        return nothing
    end
    r = Vector{ViewDefinition}()
    for v = x
        push!(r, convert(ViewDefinition, v))
    end
    r
end
module Datasets
using Dates
using LazyJSON
using JSON
using HTTP
using DataFrames
using ..Bigquery
using ...GCP
mutable struct Resource
    delete
    get
    insert
    list
    patch
    update
    function Resource(project)
        r = new()
        r.delete = function delete(datasetId::String; deleteContents = nothing, kws...)
                headers = project.authorize(; kws...)
                res = HTTP.request("DELETE", "$(Bigquery.baseUrl)projects/$(project.id)/datasets/$(datasetId)", headers; kws...)
                nothing
            end
        r.get = function get(datasetId::String; kws...)
                headers = project.authorize(; kws...)
                res = HTTP.request("GET", "$(Bigquery.baseUrl)projects/$(project.id)/datasets/$(datasetId)", headers; kws...)
                convert(Bigquery.Dataset, LazyJSON.value(String(res.body)))
            end
        r.insert = function insert(body::Bigquery.Dataset; kws...)
                headers = project.authorize(; kws...)
                headers["Content-Type"] = "application/json"
                res = HTTP.request("POST", "$(Bigquery.baseUrl)projects/$(project.id)/datasets", headers, GCP.json(body); kws...)
                convert(Bigquery.Dataset, LazyJSON.value(String(res.body)))
            end
        r.list = function list(; all = nothing, filter = nothing, maxResults = nothing, pageToken = nothing, kws...)
                headers = project.authorize(; kws...)
                res = HTTP.request("GET", "$(Bigquery.baseUrl)projects/$(project.id)/datasets", headers; kws...)
                convert(Bigquery.DatasetList, LazyJSON.value(String(res.body)))
            end
        r.patch = function patch(body::Bigquery.Dataset, datasetId::String; kws...)
                headers = project.authorize(; kws...)
                headers["Content-Type"] = "application/json"
                res = HTTP.request("PATCH", "$(Bigquery.baseUrl)projects/$(project.id)/datasets/$(datasetId)", headers, GCP.json(body); kws...)
                convert(Bigquery.Dataset, LazyJSON.value(String(res.body)))
            end
        r.update = function update(body::Bigquery.Dataset, datasetId::String; kws...)
                headers = project.authorize(; kws...)
                headers["Content-Type"] = "application/json"
                res = HTTP.request("PUT", "$(Bigquery.baseUrl)projects/$(project.id)/datasets/$(datasetId)", headers, GCP.json(body); kws...)
                convert(Bigquery.Dataset, LazyJSON.value(String(res.body)))
            end
        r
    end
end
end
module Jobs
using Dates
using LazyJSON
using JSON
using HTTP
using DataFrames
using ..Bigquery
using ...GCP
mutable struct Resource
    cancel
    get
    getQueryResults
    insert
    list
    query
    function Resource(project)
        r = new()
        r.cancel = function cancel(jobId::String; location = nothing, kws...)
                headers = project.authorize(; kws...)
                res = HTTP.request("POST", "$(Bigquery.baseUrl)projects/$(project.id)/jobs/$(jobId)/cancel", headers; kws...)
                convert(Bigquery.JobCancelResponse, LazyJSON.value(String(res.body)))
            end
        r.get = function get(jobId::String; location = nothing, kws...)
                headers = project.authorize(; kws...)
                res = HTTP.request("GET", "$(Bigquery.baseUrl)projects/$(project.id)/jobs/$(jobId)", headers; kws...)
                convert(Bigquery.Job, LazyJSON.value(String(res.body)))
            end
        r.getQueryResults = function getQueryResults(jobId::String; location = nothing, maxResults = nothing, pageToken = nothing, startIndex = nothing, timeoutMs = nothing, kws...)
                headers = project.authorize(; kws...)
                res = HTTP.request("GET", "$(Bigquery.baseUrl)projects/$(project.id)/queries/$(jobId)", headers; kws...)
                convert(Bigquery.GetQueryResultsResponse, LazyJSON.value(String(res.body)))
            end
        r.insert = function insert(body::Bigquery.Job; kws...)
                headers = project.authorize(; kws...)
                headers["Content-Type"] = "application/json"
                res = HTTP.request("POST", "$(Bigquery.baseUrl)projects/$(project.id)/jobs", headers, GCP.json(body); kws...)
                convert(Bigquery.Job, LazyJSON.value(String(res.body)))
            end
        r.list = function list(; allUsers = nothing, maxCreationTime = nothing, maxResults = nothing, minCreationTime = nothing, pageToken = nothing, projection = nothing, stateFilter = nothing, kws...)
                headers = project.authorize(; kws...)
                res = HTTP.request("GET", "$(Bigquery.baseUrl)projects/$(project.id)/jobs", headers; kws...)
                convert(Bigquery.JobList, LazyJSON.value(String(res.body)))
            end
        r.query = function query(body::Bigquery.QueryRequest; kws...)
                headers = project.authorize(; kws...)
                headers["Content-Type"] = "application/json"
                res = HTTP.request("POST", "$(Bigquery.baseUrl)projects/$(project.id)/queries", headers, GCP.json(body); kws...)
                convert(Bigquery.QueryResponse, LazyJSON.value(String(res.body)))
            end
        r
    end
end
end
module Projects
using Dates
using LazyJSON
using JSON
using HTTP
using DataFrames
using ..Bigquery
using ...GCP
mutable struct Resource
    getServiceAccount
    list
    function Resource(project)
        r = new()
        r.getServiceAccount = function getServiceAccount(; kws...)
                headers = project.authorize(; kws...)
                res = HTTP.request("GET", "$(Bigquery.baseUrl)projects/$(project.id)/serviceAccount", headers; kws...)
                convert(Bigquery.GetServiceAccountResponse, LazyJSON.value(String(res.body)))
            end
        r.list = function list(; maxResults = nothing, pageToken = nothing, kws...)
                headers = project.authorize(; kws...)
                res = HTTP.request("GET", "$(Bigquery.baseUrl)projects", headers; kws...)
                convert(Bigquery.ProjectList, LazyJSON.value(String(res.body)))
            end
        r
    end
end
end
module Tabledata
using Dates
using LazyJSON
using JSON
using HTTP
using DataFrames
using ..Bigquery
using ...GCP
mutable struct Resource
    insertAll
    list
    function Resource(project)
        r = new()
        r.insertAll = function insertAll(val, datasetId::String, tableId::String; kws...)
                begin
                    io = IOBuffer()
                    write(io, "{\"kind\":\"bigquery#tableDataInsertAllRequest\",rows:[")
                    if val isa Array
                        for n = 1:length(val)
                            if n != 1
                                write(io, ",")
                            end
                            write(io, "{json:")
                            write(io, GCP.json(val[n]))
                            write(io, "}")
                        end
                    else
                        write(io, "{json:")
                        write(io, GCP.json(val))
                        write(io, "}")
                    end
                    write(io, "]}")
                end
                headers = project.authorize(; kws...)
                headers["Content-Type"] = "application/json"
                res = HTTP.request("POST", "$(Bigquery.baseUrl)projects/$(project.id)/datasets/$(datasetId)/tables/$(tableId)/insertAll", headers, String(take!(io)); kws...)
                convert(Bigquery.TableDataInsertAllResponse, LazyJSON.value(String(res.body)))
            end
        r.list = function list(datasetId::String, tableId::String; kws...)
                df = DataFrame()
                table = ((project.bigquery).tables).get(datasetId, tableId)
                if table != nothing && (isdefined(table, :schema) && isdefined(table.schema, :fields))
                    converts = Vector{Function}()
                    for fld = (table.schema).fields
                        if fld.type_ == "TIMESTAMP"
                            df[Symbol(fld.name)] = Vector{DateTime}()
                            push!(converts, (str->begin
                                        unix2datetime(parse(Float64, str))
                                    end))
                        elseif fld.type_ == "FLOAT"
                            df[Symbol(fld.name)] = Vector{Float32}()
                            push!(converts, (str->begin
                                        parse(Float32, str)
                                    end))
                        elseif fld.type_ == "INTEGER"
                            df[Symbol(fld.name)] = Vector{Int32}()
                            push!(converts, (str->begin
                                        parse(Int32, str)
                                    end))
                        elseif fld.type_ == "BOOLEAN"
                            df[Symbol(fld.name)] = Vector{Bool}()
                            push!(converts, (str->begin
                                        parse(Bool, String(str))
                                    end))
                        elseif fld.type_ == "STRING"
                            df[Symbol(fld.name)] = Vector{String}()
                            push!(converts, (str->begin
                                        String(str)
                                    end))
                        end
                    end
                end
                headers = project.authorize(; kws...)
                res = HTTP.request("GET", "$(Bigquery.baseUrl)projects/$(project.id)/datasets/$(datasetId)/tables/$(tableId)/data", headers; kws...)
                jres = LazyJSON.value(String(res.body))
                dfFill = function dfFill(jres)
                        if haskey(jres, "rows")
                            dfRow = Vector{Any}()
                            for row = jres["rows"]
                                empty!(dfRow)
                                cols = row["f"]
                                for n = 1:length(cols)
                                    push!(dfRow, (converts[n])((cols[n])["v"]))
                                end
                                push!(df, dfRow)
                            end
                        end
                        @info ("filled", size(df))
                    end
                dfFill(jres)
                while haskey(jres, "pageToken")
                    query = [:pageToken => String(jres["pageToken"])]
                    headers = project.authorize(; kws...)
                    res = HTTP.request("GET", "$(Bigquery.baseUrl)projects/$(project.id)/datasets/$(datasetId)/tables/$(tableId)/data", headers; query=query, kws...)
                    jres = LazyJSON.value(String(res.body))
                    dfFill(jres)
                end
                df
            end
        r
    end
end
end
module Tables
using Dates
using LazyJSON
using JSON
using HTTP
using DataFrames
using ..Bigquery
using ...GCP
mutable struct Resource
    delete
    get
    insert
    list
    patch
    update
    function Resource(project)
        r = new()
        r.delete = function delete(datasetId::String, tableId::String; kws...)
                headers = project.authorize(; kws...)
                res = HTTP.request("DELETE", "$(Bigquery.baseUrl)projects/$(project.id)/datasets/$(datasetId)/tables/$(tableId)", headers; kws...)
                nothing
            end
        r.get = function get(datasetId::String, tableId::String; selectedFields = nothing, kws...)
                headers = project.authorize(; kws...)
                res = HTTP.request("GET", "$(Bigquery.baseUrl)projects/$(project.id)/datasets/$(datasetId)/tables/$(tableId)", headers; kws...)
                convert(Bigquery.Table, LazyJSON.value(String(res.body)))
            end
        r.insert = function insert(body::Bigquery.Table, datasetId::String; kws...)
                headers = project.authorize(; kws...)
                headers["Content-Type"] = "application/json"
                res = HTTP.request("POST", "$(Bigquery.baseUrl)projects/$(project.id)/datasets/$(datasetId)/tables", headers, GCP.json(body); kws...)
                convert(Bigquery.Table, LazyJSON.value(String(res.body)))
            end
        r.list = function list(datasetId::String; maxResults = nothing, pageToken = nothing, kws...)
                headers = project.authorize(; kws...)
                res = HTTP.request("GET", "$(Bigquery.baseUrl)projects/$(project.id)/datasets/$(datasetId)/tables", headers; kws...)
                convert(Bigquery.TableList, LazyJSON.value(String(res.body)))
            end
        r.patch = function patch(body::Bigquery.Table, datasetId::String, tableId::String; kws...)
                headers = project.authorize(; kws...)
                headers["Content-Type"] = "application/json"
                res = HTTP.request("PATCH", "$(Bigquery.baseUrl)projects/$(project.id)/datasets/$(datasetId)/tables/$(tableId)", headers, GCP.json(body); kws...)
                convert(Bigquery.Table, LazyJSON.value(String(res.body)))
            end
        r.update = function update(body::Bigquery.Table, datasetId::String, tableId::String; kws...)
                headers = project.authorize(; kws...)
                headers["Content-Type"] = "application/json"
                res = HTTP.request("PUT", "$(Bigquery.baseUrl)projects/$(project.id)/datasets/$(datasetId)/tables/$(tableId)", headers, GCP.json(body); kws...)
                convert(Bigquery.Table, LazyJSON.value(String(res.body)))
            end
        r
    end
end
end
using .Datasets
using .Jobs
using .Projects
using .Tabledata
using .Tables
mutable struct Service
    datasets::Datasets.Resource
    jobs::Jobs.Resource
    projects::Projects.Resource
    tabledata::Tabledata.Resource
    tables::Tables.Resource
    function Service(project)
        s = new()
        s.datasets = Datasets.Resource(project)
        s.jobs = Jobs.Resource(project)
        s.projects = Projects.Resource(project)
        s.tabledata = Tabledata.Resource(project)
        s.tables = Tables.Resource(project)
        s
    end
end
end