---
tags: api, networking, advanced, blocks
languages: objc
---

# Location Trivia APIs

## The Teams

Every Pair needs an API Key to have their own little Location Trivia world.

| Partner             | API Key                                  |
|------------------|------------------------------------------|
| Joe M | 8efafff01e66130686fb5a76ac9f99abfb55103a |
| Tom O | b78a1d25384c3671e19e8c019639b948f1c73b50 |
| Anish | 700e337294287d9d7281cfa5118c1cbd48672bae |
| Mark | 3806b0c1f68709feddfaa9747606c97b2d9ad4ca |
| Bobby | 26f66f4361cefdc4f61ff6de4a501a471742b94f |
| Jim | 4884f098b2eb01ac21ff346a9c480600a00b6df4 |
| Justin | ecb7a8d78a8a63d5be0a281a456b751ac1ad523b |
| Shmo | 72f30d520fff3835c0e555a3c986f80097611906 |
| Bert | 2a539bd87955fa8bab488604ba15bac3f119be9e |
| Damon | b4a3aa50638487077c57c142834607572b9fdbf2 |
| Nick | 29a7c25f985174cc828695e7812b5681543f9ccf |
| Kavan | d088e02a82b1ce55ea77405342f4ee09cc933f1c |
| Tom P | e53f5077129b204d29eb302a56474e1267dc7ed3 |
| Cooper | d57cdcbc4be184914d099c8ca6e0501b1ac01d10 |
| Nelly | 38be54967779040afcd10e7bb6100a2eabc8cdf2 |
| Ian | 09c3579b6eb3e85f69d2c46834dc6b45f382c602 |

## The API

All requests must be made with a `key` url parameter. The base url is `http://locationtrivia.herokuapp.com/`. To us the Web interface just go to `http://locationtrivia.herokuapp.com/locations?key=<YOUR KEY HERE>`

### Reading From The Api

#### Listing Locations

##### Request

```
GET /locations.json
```

##### Response

```
[
{
id: 22,
latitude: 40.706001,
longitude: -74.008819,
name: "Flatiron School",
trivia: [
{
id: 17,
location_id: 22,
content: "Has new sign",
created_at: "2014-03-20T19:14:52.404Z",
updated_at: "2014-03-20T19:14:52.404Z"
},
{
id: 18,
location_id: 22,
content: "Joe is iOS instructor",
created_at: "2014-03-20T19:15:04.137Z",
updated_at: "2014-03-20T19:15:04.137Z"
},
{
id: 19,
location_id: 22,
content: "Middle team rocks!",
created_at: "2014-03-20T19:15:13.982Z",
updated_at: "2014-03-20T19:15:13.982Z"
}
],
url: "http://locationtrivia.herokuapp.com/locations/22.json?key=76d3473de1e16154f9fe57c1e490e81d6ec676df"
},
{
id: 23,
latitude: 40.689249,
longitude: -74.0445,
name: "Statue of Liberty",
trivia: [
{
id: 20,
location_id: 23,
content: "Official dedication ceremonies held on Thursday, October 28, 1886",
created_at: "2014-03-20T19:16:07.760Z",
updated_at: "2014-03-20T19:16:07.760Z"
},
{
id: 21,
location_id: 23,
content: "Total overall height from the base of the pedestal foundation to the tip of the torch is 305 feet, 6 inches",
created_at: "2014-03-20T19:16:15.058Z",
updated_at: "2014-03-20T19:16:15.058Z"
}
],
url: "http://locationtrivia.herokuapp.com/locations/23.json?key=76d3473de1e16154f9fe57c1e490e81d6ec676df"
}
]
```

#### Creating Locations

##### Request

```
POST /locations.json
```

###### Parameters

| Key                 | Value Data Type | Description                   |
|---------------------|-----------------|-------------------------------|
| location[name]      | string          | The Name of the location      |
| location[latitude]  | float           | The latitude of the location  |
| location[longitude] | float           | The longitude of the locaiton |

##### Response

```
{
    "id": 77,
    "latitude": 34.234,
    "longitude": 83.43,
    "name": "testing",
    "created_at": "2014-07-16T18:03:58.773Z",
    "updated_at": "2014-07-16T18:03:58.773Z",
    "trivia": []
}
```

#### Deleting Locations

##### Request

```
DELETE /locations/:location_id.json
```

##### Response

```
204 No Content
```

#### Creating Trivia

##### Request

```
POST /locations/:location_id/trivia.json
```

###### Parameters

| Key                 | Value Data Type | Description                   |
|---------------------|-----------------|-------------------------------|
| trivium[content]    | string          | The content of the trivia     |

##### Response

```
{
    "id": 102,
    "content": "This is my second trivium",
    "created_at": "2014-07-17T17:56:55.918Z",
    "updated_at": "2014-07-17T17:56:55.918Z",
    "location": {
        "id": 129,
        "name": "Statue Of Liberty",
        "latitude": 40.6892,
        "longitude": -74.0444,
        "created_at": "2014-07-17T14:18:03.611Z",
        "updated_at": "2014-07-17T14:18:03.611Z"
    }
}
```
##### Deleting Trivia

###### Request 

```
DELETE /locations/:location_id/trivia/:trivia_id.json
```

###### Response

```
204 No Content
```

## Instructions
  2. Let's keep things simple. First things first, let's use the API as a backend for the existing LocationTrivia. Add items on the web interface, and then when you reload the app those items should show up on your tableview. For you first edition, I'd just put the code in the Data Store (preferable) or you can just get it to work in your View Controller.
  3. Now let's be able to add Locations. Create a new method that sends the appropriate API request to the backend. You'll have to send parameters. Thankfully this is pretty easy with `AFNetworking`. You'll notice that the method we use has a `params` input. For the `GET` request we did, we put nil in as the params item. The params takes in an `NSDictionary` of keys and values. So if we wanted to do a `POST` request to google.com giving it parameters with a key of `query` and a value of `The Internet` we'd do this:

  ```
  NSDictionary *postParams = @{@"query": @"The Internet"};
  [manager POST:@"http://google.com" parameters:postParams success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Sucess");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Fail");
    }];
  ```
  4. Now Add the Update functionality
  5. Implement [swipe to deelte](http://stackoverflow.com/questions/3309484/uitableviewcell-show-delete-button-on-swipe) for each location.

