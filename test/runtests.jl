module GCPTests

CredFilename = expanduser("~/secrets/tst-cld.json")

ts = [
  "credential"
  ,"session"
  ,"project"
  ,"bigquery"
]
for t in ts
  include("$(t).jl")
end

end # module GCPTests