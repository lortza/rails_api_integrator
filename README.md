# Rails API Integrator

This is a Rails API that consumes several different APIs and outputs a new product that's a compilation of that data.

* Ruby 2.5.0
* Rails 5.2.0
* Postgres
* JSON-API formatting with `gem 'jsonapi-rails'`
* Runs on port 4517 (localhost:4517)

## Getting Started

To run this locally, start `rails server` then browse to:

```
http://localhost:4517
```

## Features

API that provides data for a city name search. Results include:

  - today's weather for the provided city
  - weather for nearby cities
  - photos of that city
  - news stories for that city
  - events in that city for the next 30 days

#### Incorporated APIs

* [GeoDB](http://geodb-city-api.wirefreethought.com/docs/guides/getting-started/test-drive)
* [weatherunderground](https://www.wunderground.com/weather/api/d/docs?d=index)
* [New York Times](https://developer.nytimes.com/)
* [flickr photo search](https://www.flickr.com/services/api/)
* [Eventful](http://api.eventful.com/json/events/)

## Endpoint

The endpoint takes state and city parameters.

```
http://localhost:4517/reports/tx/austin
```

Cities with spaces in the name are okay too.

```
http://localhost:4517/reports/la/new orleans
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

```
{
  "state":"la",
  "city":"new orleans",

  "weather":{
    "current_city":{
      "city":"new orleans",
      "state":"la",
      "local_time":"Mon, 07 May 2018 19:37:40 -0500",
      "description":"Clear",
      "temperature":"86.7 F (30.4 C)"
    },
    "nearby_cities":[
      {
        "city":"Gretna",
        "state":"LA",
        "local_time":"Mon, 07 May 2018 19:32:43 -0500",
        "description":"Clear","temperature":"86.6 F (30.3 C)"
      },
      {
        "city":"Harvey",
        "state":"LA",
        "local_time":"Mon, 07 May 2018 19:34:05 -0500",
        "description":"Clear",
        "temperature":"85.5 F (29.7 C)"
      }
    ]
  },

  "articles":[
    {
      "title":"A New Orleans Restaurant Where Creole Meets Caribbean",
      "url":"https://www.nytimes.com/2016/02/28/travel/new-orleans-restaurant-compere-lapin-review.html"
    },
    {
      "title":"Who Runs the Streets of New Orleans?",
      "url":"https://www.nytimes.com/2015/08/02/magazine/who-runs-the-streets-of-new-orleans.html"
    },
    {
      "title":"What to Do With the Swastika in the Attic?",
      "url":"https://www.nytimes.com/2017/07/07/opinion/sunday/what-to-do-with-the-swastika-in-the-attic.html"
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
```
