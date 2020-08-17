# Mooncascade 



## Task Description

Write an application that displays a list of employees from a remote server along with their details. If an employee exists in the phone contacts database,
enable the user to open the native contacts display form as well.



## Tasks

- [x] The application has two screens. 
- [x] The first screen is a list view of all employees grouped by position. 
- [x] Groups are sorted alphabetically, employees are sorted by last name. 
- [x] Each employee is unique by their full name (first name + last name) and is displayed only once in the list view.
- [x] The user can use pull-to-refresh to update the data from the servers. 
- [x] If any errors occur with fetching or parsing the data, the list should display a generic error message (list should remain refreshable).
- [x] The application should fetch the phone’s built-in contacts and match them against the list of employees. 
- [x] If the employee has a matching contact in the phone (first and last names are a case-insensitive match), the list element should contain a button which displays the iOS native Contact detail view. 
- [x] If no match is found the button should not be visible.
- [x] Selecting a list element displays a detailed view of the employee’s information. This includes their full name, email, phone number, position and a list of projects they have worked on.
- [x] If the employee matches a valid contact in the phone, a button is visible at the bottom of the screen which takes the user to the native Contact detail view.
- [x] If no match is found the button should not be visible.



## Additional Tasks

- [x] Save last successful server response 
- [ ] ~~Display it on next application launch.~~ **(Caused too much code repeat, so I erased afterwards.)**
- [x] Network request should be still executed whether the data is cached or not.
- [x] Implement search function. Search results should be displayed on matching first name, last name, email, project or position.
- [x] Write README.md file where you explain:
  - [x] What are the requirements to compile and run program? 
  - [x] What architecture pattern did you use (including reference) and why?
  - [x] In case of complex solution/algorithms for some feature, please explain how it works.



## Technical Requirements

- [x] You may use the latest stable version of Xcode or the latest developer beta.
- [x] App must support latest released version of iOS or the latest public beta.
- [x] You may not use third-party external dependencies.
- [x] App must work on all iPhone screen sizes and in both screen orientations.



## Install

~~~shell
~$git clone https://github.com/kahyalar/mooncascade-task.git
~$cd mooncascade-task
~mooncascade-task$ #Open it in XCode and run it on any simulator.
~~~



## Architecture

I used MVC pattern with generic View and ViewController class. These classes are subclasses or UIView and UIViewController respectively. This method allow me to control views and the logic seperation. Besides, removes some of the boilerplate code in each class and just overriding the method if necessary. Basically, each ViewController requires a View to work with and this view is stored as "*customView*" in the ViewController. For better understanding, please check "**View.swift**" and "**ViewController.swift**" in "*Base*" folder.

I also used Singletons for networking, contact fetching and alert generating. Due to nature of Singletons, I was able to write functions and call them effortlessly when it's needed. Besides, in the networking part I used "**Result**" type with custom class "**MCError**" for a better and cleaner code on networking part.

All logical optionals are unwrapper properly with error handling and either it returns the alert message or display the dialog itself.

Finally, for the cleaner code and DRY principle, I created a custom UILabel class with two initializers. I named it "**MCLabel**" and I was able to create a UILabel with different font size in one line. 

```swift
lazy var example = MCLabel(weight: .bold, size: 2.5)
```



## Algorithm

The first trick for me is fetching multiple data from multiple endpoint and work respectively. The trick is networking is asyncronous task and I don't know when the both sources are fetched properly. So, I decided to use "**DispatchGroup**" and for each endpoint I run the GET request function and when my group is finished it will call the *notify()* function of DispatchGroup. So, I was able to handle the data easily there.

It was a little bit tricky to sort for both position and surname parameters. Instead of using a single array, I used two different arrays. One for whole employee list and the other for the positions. I used a lot of "*Higher order functions*" throughout the app and thanks to these functions it was very easy to filter, sort, map these datas to different forms.

Also I created another array *(dataSource)* for search algorithm. So I can store the original data and according to the search parameter, I can easily sort and assign these values to this array and reload the collection view with this array. So, I was listening the listening the search bar's *textDidChange* function, running 5 match functions and collecting the results on their own arrays. Finally, I was changing the "*dataSource*" array's content with these results and that's how my search works.

To match *native contacts* and *network contacts*, I wrote a function which checks network contact's full name and native contact's full name. If it matches it will return the native contact, if not it return nothing due to the optional return type. Then I run this function in collection view's "**cellForItemAt**" function and and this value to "*Employee*" object which then injected to the cell as a dependency.

Finally, to hide and show the native contact button on cell and on the detail page I used dependency injection to inject Employee value to cell and use that value to show or hide the native contact button. Moreover, that value injected to the detail page. Yet again, I checked that value in order to show or hide the native contact button.