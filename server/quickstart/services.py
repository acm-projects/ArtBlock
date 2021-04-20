import os
import requests


def curated_images(): # returns 15 of the latest curated images
    url = 'https://api.pexels.com/v1/curated'
    headers = {'Authorization': os.getenv('PEX_ACCESS_KEY')}
    r = requests.get(url, headers=headers)
    response = r.json()
    photos = response['photos']
    img_list = []
    for photo in photos:
        if photo['url'] is not None:
            newRecord = {'url': photo['src']['medium'], 'urlthumb': photo['src']['tiny'], 'urlbig': photo['src']['large2x'],
                         'photographer': photo['photographer'], 'sourceurl': photo['url']}
            img_list.append(newRecord)
    return img_list

def reverse_image(imagePath): # possible todo: take in image through post?
    from dominantcolors import get_image_dominant_colors
    dominant_colors = get_image_dominant_colors(image_path=imagePath, num_colors=1)
    r = dominant_colors[0][0]
    g = dominant_colors[0][1]
    b = dominant_colors[0][2]
    hex = '%02x%02x%02x' % (r,g,b) # convert rgb to hexcode
    return get_colors(hex)

    '''
    filePath = imagePath
    searchUrl = 'http://www.google.com/searchbyimage/upload'
    multipart = {'encoded_image': (filePath, open(filePath, 'rb')), 'image_content': ''}
    # upload image to image hosting website and use that url for get request

    response = requests.post(searchUrl, files=multipart, allow_redirects=False)
    print(response.text)
    fetchUrl = response.headers['Location']
    print(fetchUrl)
    return fetchUrl
    '''


def get_queries(query):
    # todo: handle all-lowercase queries
    url = 'https://api.harvardartmuseums.org/object'
    payload = {'apikey': os.getenv('HAR_ACCESS_TOKEN'), 'classification': '26|21',
               'hasimage': '1', 'size': '10'} # change size as needed

    payload['keyword'] = query
    ''' # unused: was originally for filtering by categories like culture
    if "&" in query:
        query = query.split("&")
        for filter in query:
            query_type = get_query_type(filter)
            if query_type is None or query_type in payload:  # if invalid query or already exists
                print("error: invalid query")  # need error handling
            payload[get_query_type(filter)] = filter[filter.index(":") + 1:]
    else: # keyword search (includes titles, artists, description, classification, culture, and worktype)
        if ":" in query:
            payload[get_query_type(query)] = query[query.index(":") + 1:]
        else:
            payload['keyword'] = query
    '''

    r = requests.get(url, params=payload)
    queries = r.json()
    info = queries['info'] # todo: for next pages
    records = queries['records']
    query_list = []
    for record in records:  # stores everything from request into the array
        if record['primaryimageurl'] is not None:
            newRecord = {'title': record['title'], 'url': record['primaryimageurl']}
            query_list.append(newRecord)
    return query_list


def get_colors(color, query=""):
    # doesn't have results for some colors, like #2e2b28

    colorUnsplash = color
    colorHex = "#" + color
    # hues for Harvard API: Red, Orange, Yellow, Green, Blue, Violet, Brown, Grey, Black, White
    if len(color) == 6 and not color[0].isupper(): # todo: need better case handling
        hsl = rgbToHsl(int(color, 16))
        hue = hsl[0] * 360
        sat = hsl[1]
        lum = hsl[2]
        if sat < 0.15 and 0.1 < lum < 0.65:
            color = "Grey"
            colorUnsplash = "black-and-white"
        elif lum <= 0.1:
            color = "Black"
            colorUnsplash = "black"
        elif sat < 0.15 and lum >= 0.65:
            color = "White"
            colorUnsplash = "white"
        elif 0 <= hue < 15 or 345 <= hue <= 360:
            color = "Red"
            colorUnsplash = "red"
        elif 15 <= hue < 45 and lum > 0.75:
            color = "Orange"
            colorUnsplash = "orange"
        elif 15 <= hue <= 45:
            color = "Brown"
            colorUnsplash = "orange"
        elif 45 <= hue < 90:
            color = "Yellow"
            colorUnsplash = "yellow"
        elif 90 <= hue < 150:
            color = "Green"
            colorUnsplash = "green"
        elif 150 <= hue < 270:
            color = "Blue"
            if hue <= 180:
                colorUnsplash = "teal"
            else:
                colorUnsplash = "blue"
        elif 270 <= hue <= 345:
            color = "Violet"
            if hue <= 325:
                colorUnsplash = "magenta"
            else:
                colorUnsplash = "purple"

    print(color)
    print(colorUnsplash)
    colors_list = []

    # This API supports searching by exact hexcode (no ranges) and multiple classifications at once, like painting
    # and drawing (26|21).
    url2 = 'https://api.harvardartmuseums.org/object'
    payload = {'apikey': os.getenv('HAR_ACCESS_TOKEN'), 'classification': '26|21',
               'hasimage': '1', 'size': '10', 'color': colorHex}
    if query != "":
        payload['keyword'] = query
    # only some hex codes return results
    r2 = requests.get(url2, params=payload)
    colors2 = r2.json()
    records = colors2['records']
    for record in records:  # usually this won't run because records will be empty, but sometimes you'll get lucky
        if record['primaryimageurl'] is not None:
            newRecord = {'title': record['title'], 'url': record['primaryimageurl']}
            colors_list.append(newRecord)

    '''
    imagesFound2 = 0
    limit = 3
    # This code goes through every image in the API until it finds enough images containing the specified color.
    # It is very slow.
    del payload['color']  # repeat request without color parameter
    r2 = requests.get(url2, params=payload)
    # print(r2.url)
    colors2 = r2.json()
    info = colors2['info']
    records = colors2['records']
    percentColorThreshold = 0.3
    while imagesFound2 < limit:  # implement limit to reduce load
        for record in records:  # stores everything from request into the array
            if record['primaryimageurl'] is not None and record[
                'colorcount'] > 1:  # if it has image and multiple colors
                for colorObj in record['colors']:  # checks every color stored in the image's data
                    hsl = rgbToHsl(int(colorObj['color'][1:], 16))
                    percentColor = 0
                    if colorObj['hue'] == color and hsl[1] > 0.2 and hsl[
                        2] < 0.8:  # doesn't work with grey/white/black!!
                        if colorObj['percent'] < percentColorThreshold and percentColor < percentColorThreshold:
                            percentColor = percentColor + colorObj['percent']
                        else:
                            newRecord = {'title': record['title'], 'url': record['primaryimageurl']}
                            colors_list.append(newRecord)
                            imagesFound2 += 1
                            print("loop")  # testing
                            break
            if imagesFound2 >= limit:
                break
        r2 = requests.get(info['next'])
        colors2 = r2.json()
        info = colors2['info']
        records = colors2['records']
    '''

    # This API supports searching by color. However, results may be boring. todo
    url3 = 'https://api.unsplash.com/search/photos'
    payload3 = {'client_id': os.getenv('UNS_ACCESS_KEY'), 'query': colorUnsplash, 'color': colorUnsplash,
                'per_page': 10} # change per_page as necessary
    if colorUnsplash == "black_and_white":
        payload3['query'] = "grey"
    if query != "":
        payload3['query'] = query
    r3 = requests.get(url3, params=payload3)
    # print(r3.url)
    colors3 = r3.json()
    records = colors3['results']
    for record in records:
        newRecord = {'title': record['description'], 'url': record['urls']['small'], 'urlthumb': record['urls']['thumb'],
                     'urlbig': record['urls']['regular'], 'photographer': record['user']['name'],
                     'profile': record['user']['links']['self'] + '?utm_source=ArtBlock&utm_medium=referral'}
        # note: title might be very long
        # three different sizes of image: thumb < small < regular
        colors_list.append(newRecord)

    return colors_list


def get_query_type(filter): # unused...
    if "Title:" in filter:
        return "title"
    if "Culture:" in filter:
        return "culture"
    if "Century:" in filter:
        return "century"
    if "Medium:" in filter:
        return "medium"
    if "Period:" in filter:
        return "period"
    if "Person:" in filter:
        return "person"
    if "Place:" in filter:
        return "place"
    if "Technique:" in filter:
        return "technique"
    if "Worktype:" in filter:
        return "worktype"
    else:
        return None


'''
Converts an RGB color value to HSL. Conversion formula
 * adapted from http://en.wikipedia.org/wiki/HSL_color_space.
 * Assumes r, g, and b are contained in the set [0, 255] and
 * returns h, s, and l in the set [0, 1].
 Source: https://stackoverflow.com/a/9493060/15067876
'''


def rgbToHsl(rgb):
    r = (rgb & 0xff0000) >> 16
    g = (rgb & 0xff00) >> 8
    b = (rgb & 0xff)
    r /= 255.0
    g /= 255.0
    b /= 255.0
    maxColor = max(r, g, b)
    minColor = min(r, g, b)
    h = s = l = (maxColor + minColor) / 2.0

    if maxColor == minColor:
        h = s = 0  # achromatic
    else:
        d = float(maxColor - minColor)
        s = d / (2 - maxColor - minColor) if l > 0.5 else d / (maxColor + minColor)
        if maxColor == r:
            h = (g - b) / d + (6 if g < b else 0)
        elif maxColor == g:
            h = (b - r) / d + 2
        else:
            h = (r - g) / d + 4
        h /= 6.0

    return [h, s, l]
