tests
testGrow
	1 to: 100 do: [ :i |
		collection at: i put: i negated.
		self assert: collection size equals: i.
		[ :array :factor |
			self assert: array size equals: i.
			1 to: i do: [ :j | self assert: (array at: j) equals: (factor * j) ] ]
				value: collection keys value: 1;
				value: collection values value: -1 ]