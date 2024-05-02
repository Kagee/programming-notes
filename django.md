# Where are the bloody settings
`from django.conf import settings`

# Querysets an annotations
````python
   
    qs = OrderItem.objects.filter(pk=pk).annotate(
         # stockitem is m2m, quick way to get boolean "has any stockitems"
        stockitem_count=Count("stockitem"),
    )
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
