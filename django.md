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

# Read uploaded file twice
````python
def save(self, *args, **kwargs) -> None:
    self.thumnail_sha1 = ""

    buf = BytesIO()
    if self.thumbnail:
        with self.thumbnail.open("rb") as f:
            tbhash = hashlib.sha1()  # noqa: S324
            if f.multiple_chunks():
                for chunk in f.chunks():
                    tbhash.update(chunk)
                    buf.write(chunk)
            else:
                data = f.read()
                tbhash.update(data)
                buf.write(data)
            self.thumnail_sha1 = tbhash.hexdigest()
        buffile = ImageFile(buf)
        self.thumbnail.file = buffile
    # If we did not do above, this will fail when it can not
    # .seek(0) on the uploaded file (it will work without
    # if the upload comes from a management command)
    super().save(*args, **kwargs)
````
