# NasaApi

An easy to use Ruby wrapper around the [NASA Open APIs](https://api.nasa.gov/)

Currently supports: APOD, EPIC, Earth, Neo, Insight, Mars Rover Photos, TechTransfer and TechPort

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nasa_api'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install nasa_api

## Usage

### Creating API clients

Similar APIs are grouped into clients, as seen below
This means that `planetary_client = NasaApi::Planetary.new()` can be used for APOD, Earth and EPIC calls  

- Planetary: APOD, Earth, EPIC
- Mars: Insight, Mars Rover Photos
- Tech: TechTransfer, TechPort  
- Neo: Neo

If no API key is provided, a default 'DEMO_KEY' is used and is limited to 30 calls an hour from an IP  

Visit [NASA Open APIs](https://api.nasa.gov/) to register for your own API key.
Once you have your key, pass it in when creating clients: `mars_client = NasaApi::Mars.new(api_key: 'YOUR_KEY')`

### Using Clients

All parameters for every API call are supported and matches the parameters from [NASA Open APIs](https://api.nasa.gov/)  
Don't pass api_key directly to a method call, only pass it when creating a client  

Ruby Date and Time objects can be passed and will be converted to the 'YYYY-MM-DD' format that the API expects  

These 2 calls are identical:   
`planetary_client.apod(date: '2021-01-01')`  
`planetary_client.apod(date: Date.new(2021, 1, 1))`

### Planetary

Create a client: `planetary_client = NasaApi::Planetary.new(api_key: 'YOUR_KEY')`

#### APOD (Astronomy Picture of the Day)

Get the APOD for today
```
apod_today = planetary_client.apod()
apod_today.url # image url
apod_today.hd_url
apod_today.explanation

# get the entire response, useful if you want to parse it directly
# every api call returns the entire response through call.response
apod_today.response
```

Get a range of APOD's
```
apod_range = planetary_client.apod(start_date: Date.new(2021, 1, 1), end_date: Date.new(2021, 1, 5))
apod_today.url # array of image urls for these dates
apod_today.date # array of dates
```

Note: There are other parameters available, check the docs and pass them as `parameter: value` to the `apod` method

#### Earth Imagery

Get Satellite image URL of place at this latitude/longitude on this date
```
image = planetary_client.earth_imagery(lon: 100.75, lat: 1.5, date: '2014-02-01')
image.url
image.response # To view the entire response
```

#### Earth Assets

Get date-times and closest available imagery for a supplied location and date
```
assets = planetary_client.earth_assets(lon: 100.75, lat: 1.5, date: Time.new(2014, 02, 01))
assets.date
assets.url
```

Note: There are more results available like `assets.resource`, not all options are listed here, check ResponseHandler::EarthAssets if looking for all possible results

#### EPIC (Earth Polychromatic Imaging Camera)


Often when no date is passed the Nasa API will default to today  

Get a range of pictures and information for today
```
epic = planetary_client.epic()
epic.date # array of date+time when images taken
epic.image_url # array of all images taken today
# much more availabe, use epic.response or check ResponseHandler::Epic to see more
```

### Mars

Create a client: `mars_client = NasaApi::Mars.new(api_key 'YOUR_KEY')`

#### Mars Rover Photos

Get photos from Mars Rovers
```
rover_data = mars_client.photos(rover: 'curiosity', sol: 1000, camera: 'fhaz')
rover_data.photos # Array of hashes for each photo, dates and extra information
```

#### Mars Weather Insight
Nasa Docs state that due to sensor problems on Mars missing data is common  

Get latest weather data from Mars at Elysium Planitia, near Mar's equator  
```
weather_data = mars_client.insight()
weather_data.sol_keys
weather_data.validity_checks
weather_data.response
```

### Tech

Create a client: `tech_client = NasaApi::Tech.new(api_key: 'YOUR_KEY')`

#### TechTransfer
type and item parameters are required  
Available types: patent, patent_issued, software and spinoff  

Get technology and development information for Nasa Engines
```
engine_data = tech_client.transfer(type: 'patent', item: 'engine')
engine_data.results
engine_data.count
```

#### TechPort

id parameter is required

Get data on Nasa project ID 17792
```
project_data = tech_client.port(id: 17792)
project_data.project # for one project
```

Often when providing no parameters Nasa will return everything by default  

Get data on all Nasa projects through TechPort
```
projects_data = tech_client.port()
projects_data.projects # for an array of projects
```

### Neo (Near Earth Object)

Create a client: `neo_client = NasaApi::Neo.new(api_key: 'YOUR_KEY')`

#### NeoLookup

Lookup a specific asteroid (asteroid_id required)
```
asteroid_data = neo_client.lookup(asteroid_id: 3542519)
asteroid_data.name
asteroid_data.is_potentially_hazardous_asteroid
# check ResponseHandler::NeoLookup for more output data
```

#### NeoFeed

Get data on Neo's over a range of dates
```
neo_data = neo_client.feed(start_date: Date.new(2021, 1, 1), end_date: '2021-01-05')
neo_data.near_earth_objects
neo_data.element_count
neo_data.links
```

#### NeoBrowse

Browse the overall asteroid data-set
```
neo_data = neo_client.browse()
neo_data.near_earth_objects
neo_data.response
```

## Development

To run the specs first visit `lib/nasa_api.rb` and provide your API key as the default, as described in the comment    
This is due to the specs rate-limiting 'DEMO_KEY' quickly while testing API calls  

Issue reports and pull requests are highly appreciated, this gem is in early development and has a lot of room for improvement  

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
