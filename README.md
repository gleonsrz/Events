Events Project

This project consists on using the TicketMaster Discovery Endpoint in order to provide the user a list of events so they can look for them even if they don't have an internet connection.

First of all, it uses the MVVM design pattern and Swift as its programming language. As it opens, it shows the user the events that are retrieved from the endpoint and a searchbar so the user can look for them more easily. 
It also has some messages that give feedback to the user so they are not lost in case something doesn't work or match with what they're looking for. 
What is more, it uses Core Data to store the last retrieved events so the user can check them out every time they want and the next time the user gets online it will load the events from the endpoint and replace the ones stored in Core Data.

Another thing that is important to mention is the connectivity check. The app detects whenever the user has internet connection or not. However, I decided not to reload of make an API call if the user changes the state of their network because it would affect any kind of search they might be doing.
The only case when the app asks for the events after changing the network state is when the app is recently installed and the user connects to an internet connection after opening the app. This decision is because the user doesn't have anything to look at or search so it makes sense.

Coming to testing, they cover a great part of the code including the NetworkManager, the CoreDataManager and the EventListViewModel. It also contains a couple of Mock objects for this purpose.

Last, but not least, the project contains a couple of classes that help with some tasks such as the Constants and an extension to the UIViewController for hiding the keyboard if the user taps on any part of the screen.
