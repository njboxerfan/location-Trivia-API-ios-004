---
tags: api, networking, advanced, blocks
languages: objc
---

# Location Trivia APIs

## The Teams

Every Pair needs an API Key to have their own little Location Trivia world.

| Partner             | API Key                                  |
|------------------|------------------------------------------|
| Suma/Tamar/Levan | f870d8df08c31b90085290b6875866a50d2459f7 |
| Charles/Cathy    | 60cf9b8cb6f665ce9c652ae2b70a09b15554531f |
| Jan/Karim        | faba5e7582ed5ce004f85438f6673f181033c8e6 |
| Elliot/Dan W     | 56a90f738656e2374e56debaf4065f27446f3dd9 |
| Rich/Orr         | 7f9b9d733608d95267756b5fcd47784ec57900c4 |
| Mykel/Blake      | 2248eac9ab318ebcf7eb7217c9df7e4b078594ad |
| Rosa/Dan B       | 2facfd9e9707d8910f227977c8620ba6886d8129 |
| Louis/Xida       | 4a9faaf3fb4d7cacee555b5e52eb12fd9ab1ca03 |
| Zak/Ismail       | 32f5fb769729ff0982fd3af912ff270857069c76 |

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

## Instructions

  1. Let's keep things simple. First things first, let's use the API as a
     backend for the existing LocationTrivia. Add items on the web interface,
     and then when you reload the app those items should show up on your
     tableview. For you first edition, I'd just put the code in the Data Store
     (preferable) or you can just get it to work in your View Controller.
  2. Now let's be able to add Locations. Create a new method that sends the appropriate API request to the backend. You'll have to send parameters. Thankfully this is pretty easy with `AFNetworking`. You'll notice that the method we use has a `params` input. For the `GET` request we did, we put nil in as the params item. The params takes in an `NSDictionary` of keys and values. So if we wanted to do a `POST` request to google.com giving it parameters with a key of `query` and a value of `The Internet` we'd do this:

  ```
  NSDictionary *postParams = @{@"query": @"The Internet"};
  [manager POST:@"http://google.com" parameters:postParams success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Sucess");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Fail");
    }];
  ```
    3. Implement [swipe to deelte](http://stackoverflow.com/questions/3309484/uitableviewcell-show-delete-button-on-swipe) for each location.
