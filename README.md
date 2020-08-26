
## Description

We want a simple page which shows list of random images from [picsum photos](https://picsum.photos/). For implementing this page you must first fork this repository & use the forked repo for further usage. Also for your convenience, we split the project into two main parts, the first part is mandatory & must be implemented, but the second part is **optional for implementation**, yet you should have a grasp over BLoC pattern, but we highly recommend implementing that:
1. UI with basic functionality
2. implementing a more complex logic

### Step 1: UI
We want a simple page which lazily loads a list of images (meaning the list of images must not be loaded as a whole, instead each time user scrolls to bottom of page, the api must be called to get the next batch of images, **note** each batch must be a size of 10 images). 

### Step 2 (complementary): Logic
For the next step we wnat the api to be called through the bloc pattern (for better understanding of bloc pattern, its better to implement the bloc itself with stream & sink and not use the bloc & flutter_bloc lib) 

#### complementary notes
UI itself does not matter much, we do not want a perfect design for the items so do not put so much effort in that, just a simple design is enough.

So What does matter to us?
- a clean structure of codebase
- clean code practices
- getting familiar with state management practices & patterns
- finally & most important, ability to learn (this project is primarily a test to see how you can learn the things you do not know, so don't be afraid if you don't know a subject, that is our goal)

**Finally** don't be afraid to ask something from your mentor

***Best wishes for you***
