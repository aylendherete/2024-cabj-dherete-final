Class {
	#name : 'LoadedDieTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
LoadedDieTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
LoadedDieTest >> test001ALoadedDieIsCreatedWithAnAmountOfFaces [

| aLoadedDie |
aLoadedDie:= LoadedDie of: #(3).
self assert: aLoadedDie throw equals:3.
]

{ #category : 'error testing' }
LoadedDieTest >> test003ALoadedDieCannotHaveLessThanThreeFaces [

self 
	should: [ LoadedDie of:#(2) ]
	raise: Error
	withMessage:'A die less than three faces doesnt exist'
]

{ #category : 'tests - initialization' }
LoadedDieTest >> test004LoadedDieRecivesSequenceThrowsTwoTimesThenEqualsSecondNumber [

| aLoadedDie |
aLoadedDie:= LoadedDie of: #(3 4 5).
aLoadedDie throw.
self assert: aLoadedDie throw equals:4.
]

{ #category : 'tests - initialization' }
LoadedDieTest >> test005WhenASequenceEndsThenThrowStartsItAgain [

| aLoadedDie |
aLoadedDie:= LoadedDie of: #(3).
aLoadedDie throw.
self assert: aLoadedDie throw equals:3.
]

{ #category : 'tests - initialization' }
LoadedDieTest >> test006LoadedDieInitializeWithThreeThenAmountOfFacesEqualsThree [

| aLoadedDie |
aLoadedDie:= LoadedDie of: #(3).
aLoadedDie throw.
self assert: aLoadedDie amountOfFaces equals:3.
]

{ #category : 'tests - initialization' }
LoadedDieTest >> test007LoadedDieInitializeWithSequenceThenAmountOfFacesMaxValueOfSequence [

| aLoadedDie |
aLoadedDie:= LoadedDie of: #(3 2 4).
aLoadedDie throw.
self assert: aLoadedDie amountOfFaces equals:4.
]
