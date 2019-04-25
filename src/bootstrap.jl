# Generate Julia modules based on Google API Discovery Service.
#    See https://developers.google.com/discovery/
#
module Bootstrap

module Rest
  using HTTP
  using LazyJSON
  using Base.Iterators
  const apisUrl = "https://www.googleapis.com/discovery/v1/apis"
  # draft-zyp-json-schema-03
  # https://tools.ietf.org/html/draft-zyp-json-schema-03
  export JsonSchema
  mutable struct JsonSchema
    name::String
    type::String
    properties
    patternProperties
    additionalProperties
    items::JsonSchema
    additionalItems
    required::Bool
    dependencies
    minimum
    maximum
    exclusiveMinimum
    exclusiveMaximum
    minItems
    maxItems
    uniqueItems
    pattern::String
    minLength
    maxLength
    enum
    default::String
    title::String
    description::String
    format::String
    divisibleBy
    disallow
    extends
    id
    ref # $ref
    schema # $schema
    JsonSchema() = new()
  end
  function Base.convert(::Type{JsonSchema}, x::LazyJSON.Object{Nothing, String})
    # @info "*** convert(::Type{JsonSchema}", x
    if x == nothing return nothing end
    r = JsonSchema()
    for fld in drop(fieldnames(JsonSchema), 1)
      jkey = String(fld)
      if jkey == "ref" || jkey == "schema"
        jkey = "\$"*jkey
      end
      if haskey(x, jkey)
        # @info "$(fld)", fieldtype(JsonSchema, fld)
        setfield!(r, fld, convert(fieldtype(JsonSchema, fld), x[jkey]))
      end
    end
    r
  end
  export Parameter
  mutable struct Parameter
    name::String
    type::String
    format::String
    default::String
    location::String
    required::Bool
    description::String
    ord::Int32 # manually set
    Parameter() = new()
  end
  function Base.isless(x::Parameter, y::Parameter)
    if x.ord > -1 || y.ord > -1
      return x.ord < y.ord
    end
    x.name < y.name
  end
  function Base.convert(::Type{Parameter}, x::LazyJSON.Object{Nothing, String})
    if x == nothing return nothing end
    r = Parameter()
    for fld in drop(fieldnames(Parameter), 1)
      if haskey(x, String(fld))
        setfield!(r, fld, convert(fieldtype(Parameter, fld), x[String(fld)]))
      end
    end
    r
  end
  function Base.convert(::Type{Vector{Parameter}}, x::LazyJSON.Object{Nothing, String})
    if x == nothing return nothing end
    r = Vector{Parameter}()
    for kvp in x
      push!(r, convert(Parameter, kvp.second))
      r[end].name = kvp.first
    end
    r
  end
  export Property
  mutable struct Property
    name::String
    type::String
    format::String
    items::JsonSchema # TODO $ref, object (see Dataset) array of object could be made Dataframe
    # additionalProperties
    required::Bool
    description::String
    default::String
    pattern::String
    ref::String
    Property() = new()
  end
  function Base.convert(::Type{Property}, x::LazyJSON.Object{Nothing, String})
    if x == nothing return nothing end
    r = Property()
    for fld in drop(fieldnames(Property), 1)
      jkey = String(fld)
      if jkey == "ref"
        jkey = "\$"*jkey
      end
      if haskey(x, jkey)
        setfield!(r, fld, convert(fieldtype(Property, fld), x[jkey]))
      end
    end
    r
  end
  function Base.convert(::Type{Vector{Property}}, x::LazyJSON.Object{Nothing, String})
    # @info "convert(Type{Vector{Property}}", x
    if x == nothing return nothing end
    r = Vector{Property}()
    for kvp in x
      push!(r, convert(Property, kvp.second))
      r[end].name = kvp.first
    end
    r
  end
  export Schema
  mutable struct Schema
    name::String
    properties::Vector{Property}
    refs::Vector{Schema}
    expr::Expr
    Schema() = new()
  end
  Base.isless(x::Schema, y::Schema) = x.name < y.name
  function Base.convert(::Type{Schema}, x::LazyJSON.Object{Nothing, String})
    if x == nothing return nothing end
    r = Schema()
    r.refs = Vector{Schema}()
    for fld in drop(fieldnames(Schema), 1)
      if haskey(x, String(fld))
        setfield!(r, fld, convert(fieldtype(Schema, fld), x[String(fld)]))
      end
    end
    r
  end
  function Base.convert(::Type{Dict{String,Schema}}, x::LazyJSON.Object{Nothing, String})
    if x == nothing return nothing end
    r = Dict{String,Schema}()
    for kvp in x
      r[kvp.first] = convert(Schema, kvp.second)
      r[kvp.first].name = kvp.first
    end
    r
  end
  export Method
  mutable struct Method
    name::String
    path::String
    httpMethod::String
    description::String
    parameters::Vector{Parameter}
    parameterOrder::Vector{String}
    request::JsonSchema
    response::JsonSchema
    expr::Expr
    Method() = new()
  end
  Base.isless(x::Method, y::Method) = x.name < y.name
  function Base.convert(::Type{Method}, x::LazyJSON.Object{Nothing,String})
    if x == nothing return nothing end
    r = Method()
    for fld in drop(fieldnames(Method), 1)
      if haskey(x, String(fld))
        setfield!(r, fld, convert(fieldtype(Method, fld), x[String(fld)]))
      end
    end
    r
  end
  function Base.convert(::Type{Vector{Method}}, x::LazyJSON.Object{Nothing,String})
    if x == nothing return nothing end
    r = Vector{Method}()
    for kvp in x
      push!(r, convert(Method, kvp.second))
      r[end].name = kvp.first
    end
    r
  end
  export Resource
  mutable struct Resource
    name::String
    methods::Vector{Method}
    expr::Expr
    Resource() = new()
  end
  function Base.convert(::Type{Resource}, x::LazyJSON.Object{Nothing,String})
    if x == nothing return nothing end
    r = Resource()
    if haskey(x, "methods")
      r.methods = convert(Vector{Method}, x["methods"])
    end
    r
  end
  function Base.convert(::Type{Vector{Resource}}, x::LazyJSON.Object{Nothing,String})
    if x == nothing return nothing end
    r = Vector{Resource}()
    for kvp in x
      push!(r, convert(Resource, kvp.second))
      r[end].name = kvp.first
    end
    r
  end
  export Service
  mutable struct Service
    name::String
    title::String
    description::String
    baseUrl::String
    parameters::Vector{Parameter}
    schemas::Dict{String,Schema}
    resources::Vector{Resource}
    expr::Expr
    Service() = new()
  end
  function Base.convert(::Type{Service}, x::LazyJSON.Object{Nothing,String})
    if x == nothing return nothing end
    r = Service()
    for fld in fieldnames(Service)
      if haskey(x, String(fld))
        setfield!(r, fld, convert(fieldtype(Service, fld), x[String(fld)]))
      end
    end
    r
  end

  function apis(
    ;name::Union{Symbol,Nothing}=nothing
    ,preferred::Union{Bool,Nothing}=nothing
    ,kws...
  )
    query = nothing
    if name != nothing || preferred != nothing
      query = []
      if name != nothing
        push!(query, :name => name)
      end
      if preferred != nothing
        push!(query, :preferred => preferred)
      end
    end
    res = HTTP.get(apisUrl; query=query, kws...)
    LazyJSON.value(String(res.body))
  end
  function get(url::String; kws...)
    res = HTTP.get(url; kws...)
    convert(Service, LazyJSON.value(String(res.body)))
  end
  function getService(name::Symbol; kws...)
    jDirList = apis(;name=name, preferred=true, kws...)
    apiUrl = String(jDirList["items"][1]["discoveryRestUrl"])
    get(apiUrl; kws...)
  end

end # module Rest

module Emit
  using HTTP
  using LazyJSON
  using LazyJSON: convert, value
  using MacroTools: @q, unblock
  using Dates
  using DataFrames
  using ..Rest

  function exprToString(expr::Expr)
    io = IOBuffer()
    print(io, expr)
    String(take!(io))
  end

  # from: https://github.com/JuliaCloud/LazyJSON.jl/blob/035be5ce9bd435157f9291548eba640f507255e6/src/AbstractDict.jl#L64
  isreserved(s::String) = Symbol(s) in (:while, :if, :for, :try, :return, :break, :continue,
  :function, :macro, :quote, :let, :local, :global, :const, :do,
  :struct,
  :type, :immutable, :importall,  # to be deprecated
  :module, :baremodule, :using, :import, :export,
  :end, :else, :catch, :finally, :true, :false)

  # Structs are written to file based dependency chain
  # so that most-dependent Structs are last
  # https://www.geeksforgeeks.org/topological-sorting/
  function topologicalSort(cur::Schema, stack::Vector{Schema})
    if length(cur.refs) != 0
      for nxt in cur.refs
        if cur != nxt
          topologicalSort(nxt, stack)
        end
      end
    end
    if !in(cur, stack)
      push!(stack, cur)
    end
  end

  function getEmit(names::Symbol...; kws...)
    services = Vector{Service}()
    for name in names
      push!(services, Rest.getService(name; kws...))
    end
    emitGcp(services...)
  end

  function emitGcp(services::Service...)
    @info "emitGcp: start ---"
    path = "$(pwd())/src/"
    mkpath(path) # ensure path

    # emit service files
    for service in services
      emitService(service, path)
    end

    eGcpModule = unblock(@q module GCP end)
    # add GCP file includes
    push!(eGcpModule.args[3].args, @q include("util.jl") )
    push!(eGcpModule.args[3].args, @q include("credential.jl") )
    push!(eGcpModule.args[3].args, @q include("session.jl") )
    for service in services
      push!(eGcpModule.args[3].args, @q include($("$(service.name).jl")))
    end # for service file include
    # add usings for generated Services
    for service in services
      push!(eGcpModule.args[3].args, unblock(@q using .$(Symbol(uppercasefirst(service.name)))) )
    end # for: service.name: usings
    # add Project struct
    eProject = unblock(@q mutable struct Project end)
    push!(eGcpModule.args[3].args, eProject)
    # add fields for Project
    push!(eProject.args[3].args, unblock(@q id::String) )
    push!(eProject.args[3].args, unblock(@q credential::Credential) )
    push!(eProject.args[3].args, unblock(@q session::Session) )
    push!(eProject.args[3].args, unblock(@q authorize) )
    for service in services
      fieldName = Symbol(service.name)
      fieldType = Symbol(uppercasefirst(service.name))
      eField = unblock(@q $fieldName::$fieldType.Service)
      push!(eProject.args[3].args, eField)
    end # for: apiName: Project fields
    # add constructor for Project struct
    eProjectCtor = unblock(@q function Project(credential, scopes::AbstractVector{<: AbstractString}) p = new() end)
    push!(eProject.args[3].args, eProjectCtor)
    # initialize resource fields in constructor

    push!(eProjectCtor.args[2].args, unblock(@q begin
      if isa(credential, String) && isfile(credential)
          p.credential = Credential(credential)
      else
          p.credential = credential
      end
      p.session = Session(p.credential, scopes)
      p.id = p.credential.project_id
      p.authorize = function authorize(; kws...)
        auth = GCP.authorize(p.session; kws...)
        headers = Dict{String, String}("Authorization" => "$(auth[:token_type]) $(auth[:access_token])")
        headers
      end
    end ) )
    # push!(eProjectCtor.args[2].args, unblock(@q p.id = credential.project_id ) )
    # push!(eProjectCtor.args[2].args, unblock(@q p.credential = credential ) )
    for service in services
      varName = Symbol(service.name)
      moduleName = Symbol(uppercasefirst(service.name))
      push!(eProjectCtor.args[2].args, unblock(@q p.$varName = $moduleName.Service(p) ) )
    end # for: eProjectCtor: init fields
    push!(eProjectCtor.args[2].args, unblock(@q p))
    # --- End: Generate Project struct ---

    # --- Write GCP module file to disk ---
    filename = "$(path)GCP.jl" # GCP must be uppercase for Pkg test
    @info "emitGcp: write $(filename)"
    open(filename, "w") do f # write file
      write(f, exprToString(eGcpModule))
    end

    @info "emitGcp: done ---"
  end

  # obj input: Property, Parameter, or JsonSchema
  function typeSymbol(obj; schema=nothing, service=nothing)::Union{Symbol, Nothing}
    # type formats: https://developers.google.com/discovery/v1/type-format
    if isdefined(obj, :type)
      if obj.type == "array"
        # @info "TODO $(obj)"
        if isdefined(obj, :items)
          # @info "obj.items", typeof(obj.items).name, typeSymbol(obj.items), obj.items
          elmSym = typeSymbol(obj.items, schema=schema, service=service)
          if elmSym != nothing
            if schema != nothing && service != nothing && haskey(service.schemas, String(elmSym))
              push!(schema.refs, service.schemas[String(elmSym)])
            end
            return Symbol("Vector{$(elmSym)}")
          end
        end
      elseif obj.type == "boolean"
        return Symbol(Bool.name)
      elseif obj.type == "object"
        # @info "TODO $(obj)"
        if isdefined(obj, :properties)
          properties = obj.properties
          if haskey(properties, "kind") && haskey(properties["kind"], "default")
            name = split(properties["kind"]["default"], "#") # "bigquery#dataset"
            name = uppercasefirst(name[2])
            # ensure type is defined; "bigquery#project" does not have a definition
            if haskey(service.schemas, name)
              return Symbol(name)
            end
            return nothing
          end
        end
      elseif obj.type == "string"
        if !isdefined(obj, :format)
          return Symbol(String.name)
        else
          if obj.format == "byte"
            return Symbol(UInt8.name)
          elseif obj.format == "date"
            return Symbol(Date.name)
          elseif obj.format == "date-time"
            return Symbol(DateTime.name)
          elseif obj.format == "int64"
            return Symbol(Int64.name)
          elseif obj.format == "uint64"
            return Symbol(UInt64.name)
          end
        end
      elseif obj.type == "integer"
        if isdefined(obj, :format)
          if obj.format == "int32"
            return Symbol(Int32.name)
          elseif obj.format == "uint32"
            return Symbol(UInt32.name)
          end
        end
      elseif obj.type == "number"
        if isdefined(obj, :format)
          if obj.format == "float"
            return Symbol(Float32.name)
          elseif obj.format == "double"
            return Symbol(Float64.name)
          end
        end
      else
        # @info "TODO $(obj)"
      end
    elseif isdefined(obj, :ref)
      # @info ">>> obj.ref: $(obj.ref)", service == nothing, obj
      if service != nothing && haskey(service.schemas, obj.ref)
        push!(schema.refs, service.schemas[obj.ref])
      end
      return Symbol(obj.ref)
    else # jProperty: no: type, $ref
      # @info "TODO $(obj): no: type, \$ref: TODO"
    end
    nothing
  end

  # function indexof(arr::Vector{Parameter}, itm::Parameter)
  function indexof(arr, itm)
    for n in 1:length(arr)
      if arr[n] == itm
        return n
      end
    end
    -1
  end

  function symbolisprimitivetype(symbol::Symbol)
    try
      return @eval isprimitivetype($symbol)
    catch e
      return false
    end
  end

  function Base.convert(::Type{Expr}, schema::Schema)
    unblock(@q mutable struct $(Symbol(schema.name)) <: GCP.Abstract end )
  end
  function Base.convert(::Type{Expr}, property::Property, schema::Schema, service::Service)
    # @info ">>> $(service.name).$(schema.name).$(property.name)"
    symbol = typeSymbol(property; schema=schema, service=service)
    if isnothing(symbol) return nothing end
    if symbolisprimitivetype(symbol)
      symbol = Symbol("Union{Nothing, $symbol}")
    end
    # uppercasefirst to allow Julia reserve words to be field names
    fldname = property.name
    if isreserved(fldname)
      fldname = fldname * '_'
    end
    unblock(@q $(Symbol(fldname))::$symbol )
  end

  function methodOverride(eFn::Expr, method::Rest.Method, resource::Resource, service::Service)
    if service.name == "bigquery"
      if resource.name == "tabledata"
        if method.name == "insertAll" # bigquery.tabledata.insertAll
          # method parameters
          push!(eFn.args[1].args, unblock(@q val ))
          push!(eFn.args[1].args, unblock(@q datasetId::String ))
          push!(eFn.args[1].args, unblock(@q tableId::String ))
          push!(eFn.args[1].args[2].args, unblock(@q kws... ))
          # method body
          push!(eFn.args[2].args, unblock(@q begin
            io = IOBuffer()
            write(io, "{\"kind\":\"bigquery#tableDataInsertAllRequest\",rows:[")
            if isa(val, Array)
                for n in 1:length(val)
                    if n != 1 write(io, ",") end
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
          end))
          push!(eFn.args[2].args, unblock(@q headers = project.authorize(; kws...) ))
          push!(eFn.args[2].args, unblock(@q headers["Content-Type"] = "application/json" ))
          push!(eFn.args[2].args, unblock(@q res = HTTP.request("POST", "$(Bigquery.baseUrl)projects/$(project.id)/datasets/$(datasetId)/tables/$(tableId)/insertAll", headers, String(take!(io)); kws...) ))
          push!(eFn.args[2].args, unblock(@q convert(Bigquery.TableDataInsertAllResponse, LazyJSON.value(String(res.body))) ))
          return true
        elseif method.name == "list" # bigquery.tabledata.list
          # method parameters
          push!(eFn.args[1].args, unblock(@q datasetId::String ))
          push!(eFn.args[1].args, unblock(@q tableId::String ))
          push!(eFn.args[1].args[2].args, unblock(@q kws... ))
          # method body
          push!(eFn.args[2].args, unblock(@q df = DataFrame() ))
          push!(eFn.args[2].args, unblock(@q table = project.bigquery.tables.get(datasetId, tableId) ))
          push!(eFn.args[2].args, unblock(@q if table != nothing && isdefined(table, :schema) && isdefined(table.schema, :fields)
            converts = Vector{Function}()
            for fld in table.schema.fields
              if fld.type_ == "TIMESTAMP"
                df[Symbol(fld.name)] = Vector{DateTime}()
                push!(converts, (str) -> unix2datetime( parse(Float64, str ) ) )
              elseif fld.type_ == "FLOAT"
                df[Symbol(fld.name)] = Vector{Float32}()
                push!(converts, (str) -> parse(Float32, str ) )
              elseif fld.type_ == "INTEGER"
                df[Symbol(fld.name)] = Vector{Int32}()
                push!(converts, (str) -> parse(Int32, str ) )
              elseif fld.type_ == "BOOLEAN"
                df[Symbol(fld.name)] = Vector{Bool}()
                push!(converts, (str) -> parse(Bool, String(str) ) )
              elseif fld.type_ == "STRING"
                df[Symbol(fld.name)] = Vector{String}()
                push!(converts, (str) -> String(str) )
              end
            end
          end))
          push!(eFn.args[2].args, unblock(@q headers = project.authorize(; kws...) ))
          push!(eFn.args[2].args, unblock(@q res = HTTP.request("GET", "$(Bigquery.baseUrl)projects/$(project.id)/datasets/$(datasetId)/tables/$(tableId)/data", headers; kws...) ))
          push!(eFn.args[2].args, unblock(@q jres = LazyJSON.value(String(res.body)) ))
          # push!(eFn.args[2].args, unblock(@q  ))
          push!(eFn.args[2].args, unblock(@q dfFill = function dfFill(jres)
            if haskey(jres, "rows")
              dfRow = Vector{Any}()
              for row in jres["rows"]
                empty!(dfRow)
                cols = row["f"]
                for n in 1:length(cols)
                  push!(dfRow, converts[n]( cols[n]["v"] ) )
                end
                push!(df, dfRow)
              end
            end
            @info "filled", size(df)
          end))
          push!(eFn.args[2].args, unblock(@q dfFill(jres) ))
          push!(eFn.args[2].args, unblock(@q while haskey(jres, "pageToken")
            query = [:pageToken => String(jres["pageToken"])]
            headers = project.authorize(; kws...)
            res = HTTP.request("GET", "$(Bigquery.baseUrl)projects/$(project.id)/datasets/$(datasetId)/tables/$(tableId)/data", headers; query=query, kws...)
            jres = LazyJSON.value(String(res.body))
            dfFill(jres)
          end))
          push!(eFn.args[2].args, unblock(@q df  ))
          return true
        end
      end
    end
    false
  end

  function Base.convert(::Type{Expr}, method::Rest.Method, resource::Resource, service::Service)
    eFn = unblock(@q function $(Symbol(method.name))(;) end)

    # check for manual overried implementation
    if methodOverride(eFn, method, resource, service)
      return eFn
    end

     # add request body object parameter (if any)
     if isdefined(method, :request)
      reqSym = typeSymbol(method.request)
      if reqSym != nothing
        push!(eFn.args[1].args, unblock(@q $(Symbol("body"))::$(Symbol(uppercasefirst(service.name))).$reqSym  ))
      else
        push!(eFn.args[1].args, unblock(@q $(Symbol("body"))))
      end
    end

    # add parameters to method (if any)
    if isdefined(method, :parameters)
      requiredParameters = Vector{Parameter}()
      optionalParameters = Vector{Parameter}()
      for parameter in method.parameters
        if parameter.name == "projectId" continue end # set by project.id
        # @info "$(service.name).$(resource.name).$(method.name) $(parameter.name) required:$(parameter.required)"
        if parameter.required
          if isdefined(method, :parameterOrder)
            parameter.ord = indexof(method.parameterOrder, parameter.name)
            # @info "parameter.ord", parameter.ord, parameter.name
          end
          push!(requiredParameters, parameter)
        else
          push!(optionalParameters, parameter)
        end
      end
      # for n in 1:length(requiredParameters)
      #   @info "$(service.name).$(resource.name).$(method.name) requiredParameters-$n: $(requiredParameters[n].name) parameter.required:$(requiredParameters[n].required) isdefined(method, :parameterOrder):$(isdefined(method, :parameterOrder))"
      # end
      # for n in 1:length(optionalParameters)
      #   @info "$(service.name).$(resource.name).$(method.name) optionalParameters-$n: $(optionalParameters[n].name) parameter.required:$(optionalParameters[n].required) isdefined(method, :parameterOrder):$(isdefined(method, :parameterOrder))"
      # end
      # add required parameters to method
      for rp in sort!(requiredParameters)
        prmSym = typeSymbol(rp)
        if prmSym != nothing
          push!(eFn.args[1].args, unblock(@q $(Symbol(rp.name))::$prmSym  ))
        else
          push!(eFn.args[1].args, unblock(@q $(Symbol(rp.name))))
        end
      end
      # add optional parameters to method
      if length(optionalParameters) != 0
        for op in optionalParameters
          push!(eFn.args[1].args[2].args, unblock(@q $(Symbol(op.name))=nothing ))
        end
      end
    end # isdefined(method, :parameters)
    # add keyword args parameter
    push!(eFn.args[1].args[2].args, unblock(@q kws... ))

    # --- Generate method block
    path = method.path
    path = replace(path, "+" => "") # bigquery/models may have '+'
    path = replace(path, "{projectId}" => "\$(project.id)")
    path = replace(path, "{" => "\$(")
    path = replace(path, "}" => ")")

    url = Symbol("\"\$($(uppercasefirst(service.name)).baseUrl)$(path)\"")
    push!(eFn.args[2].args, unblock(@q headers = project.authorize(; kws...) ))
    push!(eFn.args[2].args, unblock(@q res = HTTP.request($(method.httpMethod), $url, headers; kws...) ))

    # add body serialization
    if isdefined(method, :request)
      insert!(eFn.args[2].args, 2, :(headers["Content-Type"] = "application/json"))
      # @info "eFn.args[2].args[3].args[2].args", eFn.args[2].args[3].args[2].args
      push!(eFn.args[2].args[3].args[2].args, :(GCP.json(body)) )
    end

    # add response object deserialization (if any)
    if !isdefined(method, :response)
      push!(eFn.args[2].args, unblock(@q nothing ))
    else
      resSym = typeSymbol(method.response)
      if resSym == nothing
        push!(eFn.args[2].args, unblock(@q nothing ))
      else
        if haskey(service.schemas, String(resSym)) # GCP.Abstract
          resSym = Symbol("$(uppercasefirst(service.name)).$resSym")
        end
        push!(eFn.args[2].args, unblock(@q convert($resSym , LazyJSON.value(String(res.body)) ) ))

        # @info "$fieldName::$resSym hasKey", haskey(service.schemas, String(resSym))
        # if occursin("Union", String(resSym)) # primitive union
        #   m = match(r"^Union{Nothing,([\w\d\s]+)}$", String(resSym))
        #   resSym = Symbol(strip(m.captures[1], [' ']))
        #   push!(eFn.args[2].args, unblock(@q parse($resSym , LazyJSON.value(String(res.body)) ) ))
        # else
        #   if haskey(service.schemas, String(resSym)) # GCP.Abstract
        #     resSym = Symbol("$(uppercasefirst(service.name)).$resSym")
        #   end
        #   push!(eFn.args[2].args, unblock(@q convert($resSym , LazyJSON.value(String(res.body)) ) ))
        # end


        # if resSym == :String || haskey(service.schemas, String(resSym))
        #   if haskey(service.schemas, String(resSym)) # GCP.Abstract
        #     resSym = Symbol("$(uppercasefirst(service.name)).$resSym")
        #   end
        #   push!(eFn.args[2].args, unblock(@q convert($resSym , LazyJSON.value(String(res.body)) ) ))
        # else # primitive: Union{Nothing, Int64} etc...
        #   push!(eFn.args[2].args, unblock(@q parse($resSym , LazyJSON.value(String(res.body)) ) ))
        # end

      end
    end

    eFn
  end

  function Base.convert(::Type{Expr}, resource::Resource, service::Service)
    # resource module
    resource.expr = unblock(@q module $(Symbol(uppercasefirst(resource.name))) end)
    # resource module usings
    push!(resource.expr.args[3].args, unblock(@q using Dates ))
    push!(resource.expr.args[3].args, unblock(@q using LazyJSON ))
    push!(resource.expr.args[3].args, unblock(@q using JSON ))
    push!(resource.expr.args[3].args, unblock(@q using HTTP ))
    push!(resource.expr.args[3].args, unblock(@q using DataFrames )) # for Tabledata.list
    push!(resource.expr.args[3].args, unblock(@q using $(Symbol(".."*uppercasefirst(service.name))) ))
    push!(resource.expr.args[3].args, unblock(@q using ...GCP ))
    # add resource struct with method
    eResourceStruct = unblock(@q mutable struct Resource end)
    push!(resource.expr.args[3].args, eResourceStruct)
    if isdefined(resource, :methods)
      # add struct fields for each method
      for method in sort(resource.methods)
        push!(eResourceStruct.args[3].args, unblock(@q $(Symbol(method.name)) ) )
      end
    end
    # add resource constructor
    eResourceCtor = unblock(@q function Resource(project) r = new() end )
    push!(eResourceStruct.args[3].args, eResourceCtor )
    # add method definitions
    for method in sort(resource.methods)
      method.expr = convert(Expr, method, resource, service)
      eMethod = unblock(@q begin
        r.$(Symbol(method.name)) = $(method.expr)
      end)
      push!(eResourceCtor.args[2].args, eMethod)
    end
    push!(eResourceCtor.args[2].args, unblock(@q r))

    resource.expr
  end

  function Base.convert(::Type{Expr}, service::Service)
    # service module
    service.expr = unblock(@q module $(Symbol(uppercasefirst(service.name))) end)
    # service module usings
    push!(service.expr.args[3].args, unblock(@q using Dates ))
    push!(service.expr.args[3].args, unblock(@q using LazyJSON ))
    push!(service.expr.args[3].args, unblock(@q using ..GCP ))
    # service consts
    push!(service.expr.args[3].args, unblock(@q const baseUrl = $(service.baseUrl) ))
    # --- Generate empty struct expressions for each schema
    for schema in values(service.schemas)
      schema.expr = convert(Expr, schema)
    end
    # --- Generate struct fields
    for schema in values(service.schemas)
      # @info "schema.name", schema.name
      if isdefined(schema, :properties)
        for property in schema.properties
          # @info "property", property
          # if isreserved(property.name)
          #   @info "$(schema.name).$(property.name) SKIPPING"
          #   continue
          # end
          propertySchema = convert(Expr, property, schema, service)
          if isnothing(propertySchema)
            @info "$(schema.name).$(property.name) NOTHING"
            continue
          end
          push!(schema.expr.args[3].args, propertySchema)
        end
      end
      # --- Generate struct constructor (for mutable)
      push!(schema.expr.args[3].args, unblock(@q function $(Symbol(schema.name))() new() end ))
    end


    # --- Add schema structs to module

     # n-ref structs last; sort by references
    # topological sort
    stack = Vector{Schema}()
    for schema in filter(v -> length(v.refs) != 0, collect(values(service.schemas)))
      # @info "try sort", schema.name
      topologicalSort(schema, stack)
      # @info "===> sorting:$(schema.name) refs:$(length(schema.refs))"
    end

    # 0-ref structs first; maybe be referenced by other structs
    for schema in sort(filter(v -> length(v.refs) == 0, collect(values(service.schemas))))
      if !in(schema, stack)
        push!(service.expr.args[3].args, schema.expr)
        # @info "===> 0refs:$(schema.name)"
      end
    end

    for schema in stack
      push!(service.expr.args[3].args, schema.expr)
      # @info "===> stack:$(schema.name)"
    end

    # --- Generate convert methods for each struct. Variants include:
    #   Base.convert(::Type{T}, x::LazyJSON.Object{T, Nothing})
    #   TODO Base.convert(::Type{Union{Nothing, T}}, x::LazyJSON.Object{Nothing,T})
    for key in sort(collect(keys(service.schemas)))
      schema = service.schemas[key]
      type = Symbol(schema.name)
      # Generate method stub
      eConvert = unblock(@q begin
        function Base.convert(::Type{$type}, x::LazyJSON.Object{Nothing,String})
          if x == nothing return nothing end
          r = $type()
        end
      end)
      # Generate set field statements
      # @info "$(schema.name)", schema.expr.args[3].args
      for eField in schema.expr.args[3].args[1:end-1] # skip last arg which is constructor
        # @info "$(schema.name).eField", eField
        fieldName = eField.args[1]
        fieldType = eField.args[2]
        fieldNameStr = String(fieldName)
        # reserved word suffix has '_' at field name end
        fieldNameStr = replace(fieldNameStr, r"_$" => "")
        eField = unblock(@q begin
          if haskey(x, $fieldNameStr)
            r.$fieldName = convert($fieldType, x[$fieldNameStr])
          end
        end)
        # add field set to method
        push!(eConvert.args[2].args, eField)
      end # end convert
      # add return statement
      push!(eConvert.args[2].args, unblock(@q r ))
      # add convert method to service module
      push!(service.expr.args[3].args, eConvert)
    end

    # --- Generate convert methods for each struct. Variants include:
    #   Base.convert(::Type{Vector{T}}, x::LazyJSON.Array{Nothing,T})
    for key in sort(collect(keys(service.schemas)))
      schema = service.schemas[key]
      type = Symbol(schema.name)
      # Generate method stub
      eConvert = unblock(@q begin
        function Base.convert(::Type{Vector{$type}}, x::LazyJSON.Array{Nothing,String})
          if x == nothing return nothing end
          r = Vector{$type}()
          for v in x
            push!(r, convert($type, v))
          end
        end
      end)
      # add return statement
      push!(eConvert.args[2].args, unblock(@q r ))
      # add convert method to service module
      push!(service.expr.args[3].args, eConvert)
    end

    # --- Generate Resource modules
    for resource in service.resources
      # @info "resource.name", resource.name
      push!(service.expr.args[3].args, convert(Expr, resource, service))
    end

    # --- Generate Service struct
    # add usings for Service
    for resource in service.resources
      push!(service.expr.args[3].args, unblock(@q using .$(Symbol(uppercasefirst(resource.name)))) )
    end
    # create Service struct
    eService = unblock(@q mutable struct Service end)
    push!(service.expr.args[3].args, eService)
    # add resource fields to Service struct
    for resource in service.resources
      fieldName = Symbol(resource.name)
      fieldType = Symbol(uppercasefirst(resource.name))
      push!(eService.args[3].args, unblock(@q $fieldName::$fieldType.Resource) )
    end # for: eService: fields
    # add constructor for Service struct
    eResourceCtor = unblock(@q function Service(project) s = new() end)
    push!(eService.args[3].args, eResourceCtor)
    # initialize resource fields in constructor
    for resource in service.resources
      varName = Symbol(resource.name)
      moduleName = Symbol(uppercasefirst(resource.name))
      eVar = unblock(@q s.$varName = $moduleName.Resource(project) )
      push!(eResourceCtor.args[2].args, eVar)
    end # for: eResourceCtor: init fields
    push!(eResourceCtor.args[2].args, unblock(@q s))

    service.expr
  end

  function emitService(service::Service, path::String)
    @info "emitService: $(service.name): start ---"

    eServiceModule = convert(Expr, service)

    # --- Write Service module file to disk ---
    filename = "$(path)$(service.name).jl"
    @info "emitService: $(service.name): write $(filename)"
    open(filename, "w") do f # write file
      write(f, exprToString(eServiceModule))
    end

    @info "emitService: $(service.name): done ---"
  end

end # module Emit


end # module Bootstrap