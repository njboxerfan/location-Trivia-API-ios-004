---
tags: api, networking, advanced, blocks
languages: objc
---

# Location Trivia APIs

## The Teams

Every Pair needs an API Key to have their own little Location Trivia world.

| Partner Names | API Key                                  |
|---------------|------------------------------------------|
| Al/Matt       |                                          |
| Marcus/Ray    | 474dc75e3d4a6b67a8e053930c10fd26f6e920b9 |
| Heidi/Mike V  | 906a60f5cad51547e571002cd1bba4fa886e6df9 |
| Leo/Zach      | 3b400cdf66b6c4aa6317080bc728452be0921afb |
| Peter/Tarik   | 5f3f20fd994bfa7ff0adf7a4c73454cb267be81e |
| Carter/Dan    | d8e3c881f1641c24e0349752354b3900bf114635 |
| Troy/Steve    | bc5284d4def0d4bd4a8f0d88c681cf4b4987bef8 |
| Mike H/Viktor | ad49ec6eef8ec5f7d53cdbafa2414d0570e8f9de |

## The API

All requests must be made with a `key` url parameter.

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

## Instructions

  1. Let's keep things simple. First things first, let's use the API as a
     backend for the existing LocationTrivia. Add items on the web interface,
     and then when you reload the app those items should show up on your
     tableview. For you first edition, I'd just put the code in the Data Store
     (preferable) or you can just get it to work in your View Controller.
  2. Now let's be able to add Locations. Create a new method that sends the appropriate API request to the backend. You'll have to send parameters. Thankfully this is pretty easy with AFNetworking. You'll notice that the method we use has a `params` input. For the `GET` request we did, we put nil in as the params item. The params takes in an `NSDictionary` of keys and values. So if we wanted to do a `POST` request to google.com giving it parameters with a key of `query` and a value of `The Internet` we'd do this:

  ```
  NSDictionary *postParams = @{@"query": @"The Internet"};
  [manager POST:@"http://google.com" parameters:postParams success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Sucess");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Fail");
    }];
  ```
