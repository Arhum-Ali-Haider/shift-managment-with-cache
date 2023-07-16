# Shift Management API

This is a simple Rails API application that provides functionality for managing shifts. It allows users to retrieve shifts within a specified time range and handles caching to optimize performance. The application also includes validations to ensure that shifts have valid durations and prevent duplicates.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [API Endpoints](#api-endpoints)
- [Testing](#testing)


## Installation

1. Make sure you have Ruby (version 3.1.0) and Rails (version 7.0.6) installed on your system.

2. Clone this repository to your local machine.
```
3. bundle install

4. rails db:migrate

5. rails server
```

The API will now be accessible at http://localhost:3000/api/v1/shifts.

##  API Endpoints

Retrieve Shifts

URL: /api/v1/shifts

Method: GET

Parameters:

start_time (required): The start time of the time range to retrieve shifts for.

end_time (required): The end time of the time range to retrieve shifts for.

Response:

Success (HTTP 200 OK): Returns an array of shifts within the specified time range.

Bad Request (HTTP 400 Bad Request): If either start_time or end_time is missing in the request.

Not Found (HTTP 404 Not Found): If no shifts are found for the given time range.


##  Testing

This application comes with a comprehensive test suite using RSpec. To run the tests, use the following command:
```
 rspec
```
