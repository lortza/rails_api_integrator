# Rails API Integrator

[![Maintainability](https://api.codeclimate.com/v1/badges/51fd012d7d70a11a1edc/maintainability)](https://codeclimate.com/github/lortza/rails_api_integrator/maintainability)

This is a Rails API that consumes several different APIs and outputs a new product that's a compilation of that data.

* Ruby 2.5.0
* Rails 5.2.0
* Postgres
* JSON-API formatting with `gem 'jsonapi-rails'`
* Runs on port 3001 (localhost:3001)

This API is presently consumed by the React App [react_rails_api_city_data](https://github.com/lortza/react_rails_api_city_data)

## Features

API that provides data for a city name search. Results include:

  - today's weather for the provided city
  - weather for nearby cities
  - Flikr photos from that city
  - news stories for that city
  - events in that city for the next 30 days
  - consistent DateTime formatting for Events and Articles (ex: `2018-05-19 22:46:58`)

#### Incorporated APIs

All of these APIs have a free tier.

* [GeoDB](http://geodb-city-api.wirefreethought.com/docs/guides/getting-started/test-drive) (requires Credit Card #, but does not charge it)
* [weatherunderground](https://www.wunderground.com/weather/api/d/docs?d=index)
* [New York Times](https://developer.nytimes.com/)
* [flickr photo search](https://www.flickr.com/services/api/)
* [Eventful](http://api.eventful.com/docs)

## Getting Started

To run this locally, start `rails server` then browse to:

```
http://localhost:3001
```

This API is not hosted anywhere, so you will also need API keys for all of the APIs listed above in order to run it locally.

## Endpoint

The endpoint takes state and city parameters.

```
http://localhost:3001/reports/tx/austin
```

Cities with spaces in the name are okay too.

```
http://localhost:3001/reports/la/new orleans
```

## Data Output

Data is separated into 4 main sections:

```
weather
articles
events
photos
```

### Sample Output

Output is formatted in `jsonapi` with the help of `gem 'jsonapi-rails'`.

```
{
  "data":
  {
    "id":"2018-05-08 14:15:10 -0500",
    "type":"reports",
    "attributes":
    {
      "state": "LA",
      "city": "New Orleans",
      "area_weather": {
        "current_city": {
          "city": "New Orleans",
          "state": "LA",
          "local_time": "Fri, 18 May 2018 12:17:32 -0500",
          "description": "Partly Cloudy",
          "temperature": 90.1,
          "icon_url": "http://icons.wxug.com/i/c/k/partlycloudy.gif"
        },
        "nearby_cities": [
          {
            "city": "Marrero",
            "state": "LA",
            "local_time": "Fri, 18 May 2018 12:17:08 -0500",
            "description": "Partly Cloudy",
            "temperature": 88.6,
            "icon_url": "http://icons.wxug.com/i/c/k/partlycloudy.gif"
          },
          {
            "city": "Arabi",
            "state": "LA",
            "local_time": "Fri, 18 May 2018 12:17:33 -0500",
            "description": "Partly Cloudy",
            "temperature": 92.5,
            "icon_url": "http://icons.wxug.com/i/c/k/partlycloudy.gif"
          },
          {
            "city": "Gretna",
            "state": "LA",
            "local_time": "Fri, 18 May 2018 12:12:58 -0500",
            "description": "Scattered Clouds",
            "temperature": 90.5,
            "icon_url": "http://icons.wxug.com/i/c/k/partlycloudy.gif"
          }
        ],
        "major_cities": [
          {
            "city": "Metairie",
            "state": "LA",
            "local_time": "Fri, 18 May 2018 12:17:13 -0500",
            "description": "Scattered Clouds",
            "temperature": 95.5,
            "icon_url": "http://icons.wxug.com/i/c/k/partlycloudy.gif"
          },
          {
            "city": "Shreveport",
            "state": "LA",
            "local_time": "Fri, 18 May 2018 12:12:51 -0500",
            "description": "Clear",
            "temperature": 88.2,
            "icon_url": "http://icons.wxug.com/i/c/k/clear.gif"
          },
          {
            "city": "Baton Rouge",
            "state": "LA",
            "local_time": "Fri, 18 May 2018 12:17:33 -0500",
            "description": "Haze",
            "temperature": 89.8,
            "icon_url": "http://icons.wxug.com/i/c/k/hazy.gif"
          }
        ]
      },

      "articles": [
        {
          "title":"At 91, Ella Brennan Still Feeds (and Leads) New Orleans",
          "url":"https://www.nytimes.com/2017/03/27/dining/ella-brennan-new-orleans-restaurants.html",
          "date": "2017-05-19 22:46:58"
        },
        {
          "title":"In Prospect New Orleans, a Curator Guides 73 Artists Toward Higher Ground",
          "url":"https://www.nytimes.com/2017/11/23/arts/design/prospect-new-orleans-trevor-schoonmaker-artists.html",
          "date": "2017-03-27 17:05:42"
        },
        {
          "title":"Who Runs the Streets of New Orleans?",
          "url":"https://www.nytimes.com/2015/08/02/magazine/who-runs-the-streets-of-new-orleans.html",
          "date": "2015-03-03 20:48:39"
        },
        {
          "title":"What to Do With the Swastika in the Attic?",
          "url":"https://www.nytimes.com/2017/07/07/opinion/sunday/what-to-do-with-the-swastika-in-the-attic.html",
          "date": "2017-07-07 19:54:34"
        },
        {
          "title":"New Orleans and U.S. in Standoff on Detentions",
          "url":"https://www.nytimes.com/2013/08/13/us/new-orleans-and-us-in-standoff-on-detentions.html",
          "date": "2013-08-13 00:00:00"
        }
      ],

      "events":[
        {
          "name":"Company of Thieves (18+ Event)",
          "date":"2018-05-16 20:00:00",
          "url":"http://neworleans.eventful.com/events/company-thieves-18-event-/E0-001-112847870-5?utm_source=apis\u0026utm_medium=apim\u0026utm_campaign=apic",
          "venue":"House of Blues - New Orleans",
          "venue_url":"http://neworleans.eventful.com/venues/house-of-blues-new-orleans-/V0-001-001541179-5?utm_source=apis\u0026utm_medium=apim\u0026utm_campaign=apic"
        },
        {
          "name":"Kermit Ruffins and the BBQ Swingers – 7pm Show",
          "date":"2018-05-19 00:00:00",
          "url":"http://neworleans.eventful.com/events/kermit-ruffins-and-bbq-swingers-7pm-show-/E0-001-114099927-3?utm_source=apis\u0026utm_medium=apim\u0026utm_campaign=apic",
          "venue":"The Little Gem Saloon",
          "venue_url":"http://neworleans.eventful.com/venues/the-little-gem-saloon-/V0-001-006655060-7?utm_source=apis\u0026utm_medium=apim\u0026utm_campaign=apic"
        }
      ],

      "photos":[
        {
          "author":"11018968@N00",
          "caption":"Dough",
          "url":"https://farm1.staticflickr.com/823/41240478964_fef77b43dd.jpg"
        },
        {
          "author":"78348039@N03",
          "caption":"Benachi family tomb. St Louis Cemetery No. 3. New Orleans, La.",
          "url":"https://farm1.staticflickr.com/981/41958002261_4b7632cff3.jpg"
        },
        {
          "author":"11018968@N00",
          "caption":"Muslims on the Bayou",
          "url":"https://farm1.staticflickr.com/825/40151220400_409861e123.jpg"
        },
        {
          "author":"11018968@N00",
          "caption":"Oyster Dinner",
          "url":"https://farm1.staticflickr.com/960/40151216230_2572ac6f95.jpg"
        }
      ]
    }
  },

  "jsonapi": { "version":"1.0" }
}
```
