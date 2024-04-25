# Use the effing system store
````bash
pip install -r requirements.txt -U --use-feature=truststore
````

# requirements.txt
````bash
SomeProject
SomeProject == 1.3
SomeProject >= 1.2, < 2.0
SomeProject[foo, bar]
SomeProject ~= 1.4.2
SomeProject == 5.4 ; python_version < '3.8'
SomeProject ; sys_platform == 'win32'
requests [security] >= 2.8.1, == 2.8.* ; python_version < "2.7"
````
[Requirement specifiers](https://pip.pypa.io/en/stable/reference/requirement-specifiers/#requirement-specifiers) >= [Version specifiers](https://packaging.python.org/en/latest/specifications/version-specifiers/#id5)
