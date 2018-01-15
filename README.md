# README

Big O Grapher is a web app for analyzing the time complexity of your Ruby code. Simply copy your Ruby code into the textbox, click the gear button, and Big O Grapher will display a graph that demonstrates how efficient your algorithm is.

## Installation

To install the app locally, clone this repo, enter its directory, and then run:

```
bundle
rake db:create
```

Ensure the tests are running correctly with:

```
rails test
```

## Usage

The Ruby code you submit into Big O Grapher must be tweaked slightly for the app to properly analyze it. Here's one example:

Let's say you wanted to analyze the following code:

```
sum = 0
[9, 3, 1, 7, 3, 1, 6].each do |number|
  sum += number
end
```

The app doesn't want to simply measure the efficiency of this exact instance, but it wants to analyze how efficient this algorithm is with **varying amounts of data**. In this example, the array contains 7 elements. But what if there were 100 numbers in it, or 1000? 

To get the app to analyze various data sets for an array, you must replace the array with this:

```
[*]
```

So the code you'd submit to Big O Grapher would look like this exactly: 

```
sum = 0
[*].each do |number|
  sum += number
end
```

since you want to see how this algorithm performs with varying amounts of data.