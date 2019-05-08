# Containers-OrderedMultiMap
[![Build Status](https://travis-ci.com/Ducasse/Containers-OrderedMultiMap.svg?branch=master)](https://travis-ci.com/Ducasse/Containers-OrderedMultiMap)
[![Coverage Status](https://coveralls.io/repos/github//Ducasse/Containers-OrderedMultiMap/badge.svg?branch=master)](https://coveralls.io/github//Ducasse/Containers-Grid?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)]()
[![Pharo version](https://img.shields.io/badge/Pharo-6.1-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-7.0-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-8.0-%23aac9ff.svg)](https://pharo.org/download)
<!-- [![Build status](https://ci.appveyor.com/api/projects/status/1wdnjvmlxfbml8qo?svg=true)](https://ci.appveyor.com/project/olekscode/dataframe)  -->



This package is part of the Containers project: This project is to collect, clean, 
test and document alternate collection datastructures. Each package is modular so that users 
can only load the collection they need without 100 of related collections.

## Install
To install this project, run the following script in a playground:

```st
Metacello new
	baseline: 'ContainersOrderedMultiMap';
	repository: 'github://Ducasse/Containers-OrderedMultiMap/src';
	load
```

## Example
To have an overview of the features this datastructure provide, have a look at the following code snippet (extracted from a unit test:

```st
CTOrderedMultiMapTest >> testAllAt [
	self assert: (collection allAt: '1') equals: #().
	collection at: '1' add: 'foo'.
	collection at: '1' add: 'bar'.
	self assert: (collection allAt: '1') equals: #( 'foo' 'bar' ).
	self assert: (collection at: '1') equals: 'foo' 
]
```
----
The best way to predict the future is to do it!
Less talking more doing. 
