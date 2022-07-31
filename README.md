# InterviewApp

Contains implementation of post and their comments persistent in local storage
## Installation

Download the provided apk to install the app.Only internet permission is required.
```bash
flutter pub get 
Flutter run 
```

## Architecture
All the files and code is structured based on TDD approach which makes  testing easier with the benefit of code scalability,code readability and overall code performance.Each feature is divided into three layers: Presentation, domain and data layer.
Presentation layer deals with all the front end work which includes views, bloc and widgets.
Domain layer is a connection layer between data and presentation layer which is useful for code skeleton while designing the features.
Data layer is for data processing before feeding it to the presentation layer.It is the place where apis are called and data is made ready.


## State Management
Uses bloc for state management which separates business logic and presentation code seamlessly and helps in clean code architecture.

## Screenshots
![alt-text-1](/screenshots/s1.png "screenshot1") ![alt-text-2](/screenshots/s2.png "s2")
![alt-text-1](/screenshots/s3.png "screenshot3") ![alt-text-2](/screenshots/s4.png "s4")

## Contributing
Pramod Bhusal



## License
None