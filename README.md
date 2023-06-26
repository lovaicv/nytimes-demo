# nytimes-demo

how to build and run using Android Studio
1. Clone using Android Studio
2. connect iPhone or Android phone
3. flutter run > to run app 
4. flutter test > to run unit and widget tests

v2.0.0
1. Added most popular articles in the landing page, select article source frop dropdown.
2. App now has offline mode for landing and search page, except live page. As long as app has
   fetched some articles from API previously, it will save the articles in database, when device is
   offline, it will instead fetch article from database instead of API.
3. Updated location tracking, it is working previously but accuraccy is only up to 3 decimal place.
   Now the app will show the whole coordinate wihout limiting decimal place, user should be getting
   most accurate location tracking.
4. Hardcoded text has consolidated to another class and translation service is added for future
   reference.
5. Hardcoded image path has consolidated to another class.
6. Code is formatted using default flutter linter rule.
7. Documentation is added on class and method.
8. Github workflows CI is added,
   - flutter anaylze
   - flutter test
   - flutter build apk / ios

<img src="images/landing.jpg" width=20% height=20%><img src="images/search.jpg" width=20% height=20%><img src="images/webview.jpg" width=20% height=20%>
