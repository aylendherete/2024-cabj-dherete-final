Class {
	#name : 'DieTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
DieTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
DieTest >> test001ADieIsCreatedWithAnAmountOfFaces [

| aDie |
aDie:= Die of:3.
self assert: ((aDie throw) between:1 and:3).

]

{ #category : 'error testing' }
DieTest >> test002ADieCannotBeCreatedWithLessThanThreeFaces [

self
	should:[Die of:2]
	
	raise: Error 
	withMessage:'A die less than three faces doesnt exist'

]

{ #category : 'tests' }
DieTest >> test003ADieIsBetweenOneAndAnAmountOfFaces [

| aDie |
aDie:= Die of:5.
self assert: ((aDie throw) between:1 and:5). 
]

{ #category : 'tests' }
DieTest >> test004WhenInitializeWithFiveFacesThenAmountOfFacesEqualsFive [

| aDie |
aDie:= Die of:5.
self assert: aDie amountOfFaces equals: 5. 
]
