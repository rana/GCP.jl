using JSON
using LazyJSON

# # from : https://github.com/JuliaLang/julia/issues/14695#issuecomment-377662648
# Base.collect(t::Union{Type, DataType, Union{}}) = _collect(t, [])
# _collect(t::Type, list) = t<:Union{} ? push!(list, t) : _collect(t.b, push!(list, t.a))
# _collect(t::Union{DataType,Core.TypeofBottom}, list) = push!(list, t)


abstract type Abstract end

# extract the type from a field type.
#   expecting Abstract struct, Union{Nothing, SomeType}
function jsontyp(t)
  if isa(t, DataType)
    if supertype(t) == Abstract return Abstract end
    return t # String, Int64 ...
  end
  if typeof(t) == Union
    return jsontyp(t.b)
  end
  nothing
end

function json(x, io::IOBuffer=IOBuffer(), inner=false)
  xtype = typeof(x)
  if supertype(xtype) == Abstract
      fst = true
      print(io, '{')
      for fld in fieldnames(xtype)
          if isdefined(x, fld)
            val = getfield(x, fld)
            if val != nothing
              if fst fst = false else print(io, ',') end
              fldname = String(fld)
              # reserved word suffix has '_' at field name end
              fldname = replace(fldname, r"_$" => "")
              print(io, "\"$(fldname)\":")
              jtyp = jsontyp(fieldtype(xtype, fld))
              if jtyp == Abstract
                  json(val, io, true)
              elseif isa(val, Array)
                print(io, '[')
                if length(val) != 0
                  for n in 1:length(val)
                    if n != 1 print(io, ',') end
                    json(val[n], io, true)
                  end
                end
                print(io, ']')
              else
                  # String, Integer, Number (Float)
                  JSON.print(io, val)
              end
            end
          end
      end
      print(io, '}')
  end
  if inner
      return nothing
  end
  String(take!(io))
end

# for creationTime fields
# "creationTime": {
#   "description": "The time when this table was created, in milliseconds since the epoch.",
#   "format": "int64",
#   "type": "string"
# },
function Base.convert(::Type{Int64}, x::LazyJSON.String{String})
  parse(Int64, x)
end

# for lastModifiedTime fields
# "lastModifiedTime": {
#   "description": "[Output-only] The time when this table was last modified, in milliseconds since the epoch.",
#   "format": "uint64",
#   "type": "string"
# },
function Base.convert(::Type{UInt64}, x::LazyJSON.String{String})
  parse(Int64, x)
end


