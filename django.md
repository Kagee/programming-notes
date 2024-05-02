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

# Return file directly
````python
path(
    "favicon.ico",
    lambda _: FileResponse(
        Path("static/images/logo/hlo-cc0-logo-favicon.ico").open("rb"),  # noqa: SIM115
    ),
),
````
