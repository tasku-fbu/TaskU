RYP Team - README 
===

TaskU creates a platform for college students to help each other out by completing mini-jobs or services for each other in a convenient and affordable way. 

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description

TaskU helps college students get mini-jobs done in a convenient and affordable way. 

An app where a college student offers a service to another or get a service completed from another person. Examples of these services can be laundry, buying a book, getting a storage place etc.

An app that creates a platform for college students to help each other out


Words that describe our app: convenient, affordable, reliable, collaborative, simple. 

### App Evaluation
- **Category:** Services 
- **Mobile:** First-mobile experience. 
- **Story:** College students are busy, but need money for their personal needs. There are job opportunities available, but there is not enough time to dedicate 8-10 hours a week to a job.
- **Market:** College students 
- **Habit:** Daily. There are mini-tasks to get done all the time! 
- **Scope:** 
    - TASK SEARCH: Students can post a mini-job to get done. These include food delivery within campus, getting you at textbook, priting homework and bringing it to you, delivering items to someone else on campus. 
    - PROFILE VERIFICATION: Users are verified that they are college students through their college email 
    - FORM OF CONTACT: Basic personal information like phone number and email will be available so that both parties can communicate forward. 


## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Sign up and log in
* A whole page of list of tasks (hopefully able to search and filter)
* Request tasks
* Find tasks
* View task details (a timeline, A posts a order for a service, B accepts, B has done the service, payment gets done, ratings for both sides)

**Optional Nice-to-have Stories**
* View all orders request (like a list)
* View all completed tasks completed
* A map to see "orders" happening around me
* A map on the service track page 
* Verify ids for students

### 2. Screen Archetypes

* A page to sign up and log in
   * sign up & log in
  
* A page with the list of orders
   * post an task request
   * accept a task 
   * see all task
* A page that shows all my task requests (list)
    
* A page that shows all my tasks completed (list)
    
* A page to view the service details (from the orders page or the tasks page)
    * view a timeline (eg. A posts a order for a service, B accepts, B has done the service, payment gets done, ratings)
* a page for my profile & settings

### 3. Navigation

**Tab Navigation** (Tab to Screen)
College Students sign up with their school ID and get verified.
The students can list tasks that they need help with and how much they want to pay for it.
* home (where users view all the services)
* my orders
* my tasks
* user profile & settings

**Flow Navigation** (Screen to Screen)

* home (where users view all the services)
   * post an order
   * accept a task
* my orders
   * service details
* my tasks
   * service details
* user profile & settings

## Wireframes
General idea of our app design: 
<img src="https://scontent.xx.fbcdn.net/v/t1.0-9/65872430_686072558481154_6325560217878659072_n.jpg?_nc_cat=103&_nc_log=1&_nc_oc=AQnxulNY7v1W7FlahTCFXL60AZAELciLKm0KlG0Qjr1fIPID1B2ND7jJWiPyD_ttgxEm885K60UDVFnL7CJFGrxd&_nc_ht=scontent.xx&oh=c291b12e060b7a7631cc09066f9a820b&oe=5DB2394D" width=600>

<img src ="https://scontent.xx.fbcdn.net/v/t1.0-9/66856933_2386910351376390_4200663759938650112_n.jpg?_nc_cat=103&_nc_log=1&_nc_oc=AQneEZ59t34MGEafOyM9xDQ5rPZQy0curk51d9VTAKCzVYT9VDCpGj4VitPk0JN00QYPzyX24hZhyIL583cqWCoK&_nc_ht=scontent.xx&oh=888ce65566cdc02bd4acc763de18233b&oe=5DC344F4 "  width=600>

<img src ="https://scontent.xx.fbcdn.net/v/t1.0-9/66402170_2386914894709269_7567247044247552_n.jpg?_nc_cat=110&_nc_log=1&_nc_oc=AQm-EG6So4ashM8BUCEBCX26oS7bjVqKadKFy1dMn3JG2XwCwo5b7G5t2Ku1i4A-cx2dY5n4WznCm1x2ZQLvAM90&_nc_ht=scontent.xx&oh=8ccc4f54cce6307316d418063b29c9e5&oe=5DBAE412"  width=600>



### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models

User (Subclass of PFUser)  

| Property  | Type | Description |
| ------------- | ------------- | ------------- |
| Name | String| The username's full name (optional) |
| Username | String  | The username for the user (required)|
| Password | String  | The password for the user (required)|
| Email | String  | The email address for the user (required) |
| University | String  | The user's university (required)|
| Phone | Number  | The user's phone number (optional) Used as a point of contact|
| Profile picture | PFFile  | The user's profile picture (optional)|
| Payment informaition | Number  | The user's credit card information (Secured) (Optional, still figuring out how to store this safely) |


Task 

| Property  | Type | Description |
| ------------- | ------------- | ------------- |
| Category | String| The category name in which the task belongs (required) |
| User | Pointer  | Pointer to user who created this task (required) |
| Image | PFFile  | An image of the task (optional) |
| Starting address | PFGeopoint  | The location where the mission starts (required) |
| Ending address | PFGeopoint  | The location where the mission ends (required)|
| Date | Date  | The date when the mission needs to be accomplished (required) |
| Task difficulty | String  | Describes the complexity of the task (required) |
| Task description | String  | Additional details/special requests for the task (optional) |


Request 

| Property  | Type | Description |
| ------------- | ------------- | ------------- |
| Task | Pointer| Pointer to the task created by the user who requested it |
| Completion Status | Boolean  | Returns whether the request has been accomplished or not|


Mission 

| Property  | Type | Description |
| ------------- | ------------- | ------------- |
| Task | Pointer| Pointer to the task the current user wants to accomplish |
| Completion Status | Boolean  | Returns whether the mission has been accomplished or not|


### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
List of network requests by screen

Sign Up Screen
- (Create/POST) Create a new user post object 

Login Screen
- (Read/GET) Query users to authenticate user

Home Screen
- (Read/GET) Query all tasks
- (Delete) Delete existing task

Compose Task Screen
- (Create/POST) Create a new task object

My Missions Screen
- (Read/GET) Get all the user’s accepted tasks
- (Update/PUT) Change the status of a task object
- (Delete) Delete existing task

My Requests Screen
- (Read/GET) Get all the user’s requested tasks
- (Create/POST) Post/Change the status of a task object

Profile Screen
- (Read/GET) Query logged in user object
- (Update/PUT) Update user profile image, payment, or account information
  


### Things we need to figure out
- we need a sign up and sign in page
- we need to store the user information -  may be using cloud services
- how to include camera feature for verification
- how to create a mini chat tab space between client and server
- We need to associate a form of payment with the app
- we might want to give users the flexibility to search for services 
    
