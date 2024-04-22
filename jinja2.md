# Conditionals and loops
## If/elif/else/endif
````jinja2
{% if kenny.sick %}
{% elif kenny.dead %}
{% else %}
{% endif %}
````

## For/endfor
````jinja2
{% for key, value in my_dict.items() %}
// loop.index - The current iteration of the loop. (1 indexed)
// loop.first - True if first iteration.
// loop.last - True if last iteration.
// loop.length - The number of items in the sequence.
{% else %}
// There was nothing to loop
{% endfor %}
````

# Macros
````jinja2
{% macro input(name, value='', type='text', size=20) -%}
    <input type="{{ type }}" name="{{ name }}" value="{{
        value|e }}" size="{{ size }}">
{%- endmacro %}
````
