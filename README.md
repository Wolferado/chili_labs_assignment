# chily_labs_assignment - Junior Web Developer assignment

## Information regarding Flutter SDK
Flutter 3.22.3 • channel stable • https://github.com/flutter/flutter.git

Framework • revision b0850beeb2 (5 days ago) • 2024-07-16 21:43:41 -0700

Engine • revision 235db911ba

Tools • Dart 3.4.4 • DevTools 2.34.3

## The Task - Create a gif search application using the Giphy service.

### Primary Requirements:

### Techical
- Primary platforms - iOS & Android _(added Platfrom checks for different APIs)_;
- Auto search - requests to retrieve Gif information from the service are made automatically with a small delay after user stops typing _(added 1.5s timer)_;
- Pagination - loading more results when scrolling _(added ScrollController listener)_;
- Vertical & horizontal orientation support _(GridView CrossAxis amount changes based on orientation)_;
- Error handling _(added checks for different HTTP response codes, error in API execution and widgets)_;
- Unit tests - as much as you see fit;

### UI
- Responsive & matching platform guidelines _(I hope?)_;
- At least 2 views sourced by data from Giphy _(Sourced original and downscaled views)_;
- Results are displayed in a grid _(used GridView.builder)_;
- Clicking on a grid item should navigate to a detailed Gif view _(clicking an item opens another Scaffold widget with detailed information about GIF)_.
- Loading indicators _(added widget when fetching data)_;
- Error display _(added widget when receiving error)_;

### Bonus points:
- Using state management approaches or libraries such as BLoC (flutter_bloc), Riverpod or others _(Riverpod has been used)_;
- Using an understandable architecture pattern;
- Page navigation is separate from page widget code (a Coordinator pattern or similar);
- Network availability handling _(sort of? request is not being proceeded due to network issues - returns 400 HTTP response code)_.