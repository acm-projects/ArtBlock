import os
import requests


def get_queries(query):
    # todo: handle all-lowercase queries
    url = 'https://api.harvardartmuseums.org/object'
    payload = {'apikey': os.getenv('HAR_ACCESS_TOKEN'), 'classification': '26|21',
                                    'hasimage': '1', 'size': '10'}

    if "&" in query:
        query = query.split("&")
        for filter in query:
            query_type = get_query_type(filter)
            if query_type is None or query_type in payload: # if invalid query or already exists
                print("error: invalid query") # need error handling
            payload[get_query_type(filter)] = filter[filter.index(":")+1:]
    else: # keyword search (includes titles, artists, description, classification, culture, and worktype)
        if ":" in query:
            payload[get_query_type(query)] = query[query.index(":") + 1:]
        else:
            payload['keyword'] = query

    r = requests.get(url, params=payload)
    queries = r.json()
    # print(r.url)
    info = queries['info'] # todo: for next pages
    records = queries['records']
    query_list = []
    for record in records:  # stores everything from request into the array
        if record['primaryimageurl'] is not None:
            query_list.append(record)
    return query_list


def get_query_type(filter):
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


def get_colors(color):
    # hues: Red, Orange, Yellow, Green, Blue, Violet, Brown, Grey, Black, White
    if len(color) == 6 and not color[0].isupper():
        hsl = rgbToHsl(int(color, 16))
        hue = hsl[0]*360
        sat = hsl[1]
        lum = hsl[2]
        if sat < 0.15 and 0.1 < lum < 0.65:
            color = "Grey"
        elif lum <= 0.1:
            color = "Black"
        elif sat < 0.15 and lum >= 0.65:
            color = "White"
        elif 0 <= hue < 15 or 345 <= hue <= 360:
            color = "Red"
        elif 15 <= hue < 45 and lum > 0.75:
            color = "Orange"
        elif 15 <= hue <= 45:
            color = "Brown"
        elif 45 <= hue < 90:
            color = "Yellow"
        elif 90 <= hue < 150:
            color = "Green"
        elif 150 <= hue < 270:
            color = "Blue"
        elif 270 <= hue <= 345:
            color = "Violet"


    print(color)
    # url = 'https://www.rijksmuseum.nl/api/nl/collection'
    # r = requests.get(url, params={'key': os.getenv('RIJ_ACCESS_TOKEN'), 'culture': 'en', 'imgonly': 'True',
    #                               'ps': '10'})
    # colors = r.json()
    colors_list = []
    # for i in range(len(colors['artObjects'])):  # stores everything from request into the array
        # colors_list.append(colors['artObjects'][i])

    url2 = 'https://api.harvardartmuseums.org/object'
    r2 = requests.get(url2, params={'apikey': os.getenv('HAR_ACCESS_TOKEN'), 'classification': '26|21',
                                    'hasimage': '1', 'size': '100'})
    # print(r2.url)
    colors2 = r2.json()
    info = colors2['info']
    records = colors2['records']
    imagesFound2 = 0
    limit = 3
    percentColorThreshold = 0.3
    while imagesFound2 < limit: # implement limit to reduce load
        for record in records:  # stores everything from request into the array
            if record['primaryimageurl'] is not None and record['colorcount'] > 1: # if it has image and multiple colors
                for colorObj in record['colors']: # checks every color stored in the image's data
                    hsl = rgbToHsl(int(colorObj['color'][1:], 16))
                    percentColor = 0
                    if colorObj['hue'] == color and hsl[1] > 0.2 and hsl[2] < 0.8: # doesn't work with grey/white/black!!
                        if colorObj['percent'] < percentColorThreshold and percentColor < percentColorThreshold:
                            percentColor = percentColor + colorObj['percent']
                        else:
                            colors_list.append(record)
                            imagesFound2 += 1
                            print("loop") # testing
                            break
            if imagesFound2 >= limit:
                break
        r2 = requests.get(info['next'])
        colors2 = r2.json()
        info = colors2['info']
        records = colors2['records']

    # stretch goal: cache image results

    return colors_list


'''Converts an RGB color value to HSL. Conversion formula
 * adapted from http://en.wikipedia.org/wiki/HSL_color_space.
 * Assumes r, g, and b are contained in the set [0, 255] and
 * returns h, s, and l in the set [0, 1].
 Source: https://stackoverflow.com/a/9493060/15067876'''


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
