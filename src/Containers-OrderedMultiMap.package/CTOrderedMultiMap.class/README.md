I am an implementation of an ordered multi-map. I allow multiple values to be associated with the same key and maintain the order of addition. #at: and its derivatives all operate on the first matching key, while #allAt: returns the complete list of values for a key in the order they were added.

Here is a typical case.

[[[
(CTOrderedMultiMap new at: '1' add: 'foo'; at: '1' add: 'bar'; yourself) allAt: '1'
>>> #('foo' 'bar')
]]]