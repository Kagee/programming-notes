# Where are the bloody settings
`from django.conf import settings`

# Return file directly
````python
path(
    "favicon.ico",
    lambda _: FileResponse(
        Path("static/images/logo/hlo-cc0-logo-favicon.ico").open("rb"),  # noqa: SIM115
    ),
),
````
