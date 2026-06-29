opa eval -d opa/policy.rego \
  -i opa/input.json \
  --format json \
  > scans/opa/opa-result.json