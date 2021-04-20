There's other ways to run the server but here's how I do it:
1. Navigate to ArtBlock\server in Windows Explorer
2. Run powershell by typing "powershell" into the file path
3. Type "python manage.py runserver". Server should be running at 127.0.0.1:8000/.

or just skip the second step and type the third command directly into the file path. You might need python3 instead of python.

Ways to access the API are defined in server/server/urls.py. Basically, you have these options which you append to the base url:
* /query/<query>
* /color/hex/<6 digit hexcode, lowercase>
** /color/hex/<6 digit hexcode>&<optional query>
* /image/<file path to image>
* /curated

The response will return a list of images, where each image is stored as a map (or dict in Python). The images themselves will all have the property "url", which links to a regular-sized image file, but may have additional properties. These are defined in server/quickstart/services.py. Basically:
* query results also have "title", from Harvard Art Museum API
* color and reverse image results (usually) also have "title", "urlthumb", "urlbig", "photographer", and "profile". The last two are to meet Unsplash API's attribution requirements.
* curated results also have "urlthumb", "urlbig", "photographer", and "sourceurl". The last two are to meet Pexel API's attribution requirements.

All responses are returned in JSON as JsonResponse objects (see: https://docs.djangoproject.com/en/3.2/ref/request-response/#jsonresponse-objects).