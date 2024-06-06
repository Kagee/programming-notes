# String concat
````
jq '.[] | "\(.id) \(.name)"
````
# Build new json
````
jq '.[] | {fullName: ("\(.id) \(.name)")}'
jq '.[] | {id: .id, name: .name}'
````
Use `-c` to get each object output on a single line
