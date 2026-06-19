package security

default allow = false

allow {
    not input.secrets_found
    input.high_vulnerabilities == 0
    input.critical_vulnerabilities == 0
}