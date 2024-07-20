# Entain Technical Task
Thank you for your application for the iOS engineer position at Entain. As part of our interview process, we
have prepared the following technical task to get a better understanding of your skills, thought process and
methodology.

There is no fixed time limit on this task, what matters is that you demonstrate your knowledge and skills to
the best of your ability. Please upload your solution to a private repository and send us a link, include any
testing instructions.
## Task
Create an iOS app that displays ‘Next to Go’ races using our API.
A user should always see 5 races, and they should be sorted by time ascending. Race should disappear
from the list after 1 min past the start time, if you are looking for inspiration look at
https://www.neds.com.au/next-to-go
## Requirements
1. As a user, I should be able to see a time ordered list of races ordered by advertised start ascending
2. As a user, I should not see races that are one minute past the advertised start
3. As a user, I should be able to filter my list of races by the following categories: Horse, Harness &amp;
Greyhound racing
4. As a user, I can deselect all filters to show the next 5 from of all racing categories
5. As a user I should see the meeting name, race number and advertised start as a countdown for
each race.
6. As a user, I should always see 5 races and data should automatically refresh

## Technical Requirements
- Use SwiftUI or UIKit
- Has some level of testing. Full coverage is not necessary, but there should be at least some testing
for key files.
- Documentation
- Use scalable layouts so your app can respond to font scale changes
- (Optional) Use of custom Decodable
- (Optional) Use of SF Symbols for any icons
- (Optional) add accessibility labels such that you can navigate via voiceover

### Categories are defined by IDs and are the following:
- Greyhound racing: category_id: 9daef0d7-bf3c-4f50-921d-8e818c60fe61
- Harness racing: category_id: 161d9be2-e909-4326-8c2c-35ed71fb460b
- Horse racing: category_id: 4a2788f8-e825-4d36-9894-efd4baf1cfae
GET https://api.neds.com.au/rest/v1/racing/?method=nextraces&amp;count=10
Content-type: application/json

## Notes
- As discussed during our technical discussion, the minimum version is set to iOS 15 (iOS 15.5 to be precise)
- there's no way to filter categories returned from the API. That's why the count has been increased to increase the chance we have 5 races per our categories of interests
- For the same reason, filtering by categories is performed on the UI layer and not at the service layer