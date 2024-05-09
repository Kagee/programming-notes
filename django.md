# Where are the bloody settings
`from django.conf import settings`

# Querysets and annotations
## Efficient way to check if a m2m field has any values
````python
    # get_object_or_404 will do the pk filtering
    qs = OrderItem.objects.annotate(
         # stockitem is m2m, quick way to get boolean "has any stockitems"
        stockitem_count=Count("stockitem"),
    )
    oi = get_object_or_404(qs, pk=pk)
````

# Templating
## Add active class to current page in menu
````jinja
<li>
  {% url 'storage-list' as link %}
  <a class="nav-link{% if request.path == link %} active{% endif %}"
     aria-current="page"
     href="{{ link }}">Storage</a>
</li>
````

## Make list in template
````jinja
 {% with "storage project category orderitems" as select_ids %}
    {% if field.name in select_ids.split %}
        {{ field | add_class:"multiselect-dropdown-upgrade" | as_crispy_field }}
    {% else %}
        {{ field | as_crispy_field }}
    {% endif %}
{% endwith %}
````

# Return file directly
````python
path(
    "favicon.ico",
    lambda _: FileResponse(
        Path("static/images/logo/hlo-cc0-logo-favicon.ico").open("rb"),  # noqa: SIM115
    ),
),
````
