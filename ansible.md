# Check mode
```` yaml
# Do "the thing" even if in check mode
check_mode: false

# Always do "the thing" as if --check was used
check_mode: true

# Disable in check mode
when: not ansible_check_mode

# Ignore errors in check mode
ignore_errors: "{{ ansible_check_mode }}"
````
