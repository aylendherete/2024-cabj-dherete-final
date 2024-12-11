Class {
	#name : 'CollectionOfSpaceships',
	#superclass : 'Object',
	#instVars : [
		'fuel',
		'spaceships'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
CollectionOfSpaceships class >> numberOfSpaceships: anAmountOfSpaceships withAmountOfFuel: anAmountOfFuel [

	^ self new
		  initializeNumberOfSpaceships: anAmountOfSpaceships
		  withAmountOfFuel: anAmountOfFuel
]

{ #category : 'accessing' }
CollectionOfSpaceships >> cellsOfSpaceships [

	| dictionaryOfCellPositions |
	dictionaryOfCellPositions := Dictionary new.
	self each: [ :spaceship |
		dictionaryOfCellPositions
			at: spaceship id
			put: spaceship position cell ].

	^ dictionaryOfCellPositions
]

{ #category : 'enumerating' }
CollectionOfSpaceships >> collect: aBlock [

	^ spaceships collect: aBlock
]

{ #category : 'initialization' }
CollectionOfSpaceships >> collectSpaceships: anAmountOfSpaceships [

	| aSpaceship |
	spaceships := OrderedCollection new.
	anAmountOfSpaceships timesRepeat: [
		aSpaceship := Spaceship launchWithFuel: fuel.
		spaceships add: aSpaceship ].
	Spaceship initialize
]

{ #category : 'collection' }
CollectionOfSpaceships >> detectSpaceshipWithId: aSpaceshipId [

	^ spaceships detect: [ :spaceship | spaceship id = aSpaceshipId ]
]

{ #category : 'collection' }
CollectionOfSpaceships >> each: aBlock [

	spaceships do: [ :spaceship |
			aBlock value: spaceship ]
]

{ #category : 'collection' }
CollectionOfSpaceships >> each: aBlock but: aSpaceshipToSkip [

	spaceships do: [ :spaceship |
		aSpaceshipToSkip = spaceship ifFalse: [
			aBlock value: spaceship ] ]
]

{ #category : 'initialization' }
CollectionOfSpaceships >> initializeNumberOfSpaceships: anAmountOfSpaceships withAmountOfFuel: anAmountOfFuel [

	fuel := anAmountOfFuel.
	self collectSpaceships: anAmountOfSpaceships
]

{ #category : 'accessing' }
CollectionOfSpaceships >> lapsOfSpaceships [

	| dictionaryOfCellPositions |
	dictionaryOfCellPositions := Dictionary new.
	self each: [ :spaceship |
		dictionaryOfCellPositions
			at: spaceship id
			put: spaceship position lap ].

	^ dictionaryOfCellPositions
]

{ #category : 'accessing' }
CollectionOfSpaceships >> positionsOfSpaceships [

	| dictionaryOfCellPositions |
	dictionaryOfCellPositions := Dictionary new.
	self each: [ :spaceship |
		dictionaryOfCellPositions
			at: spaceship id
			put: spaceship position ].

	^ dictionaryOfCellPositions
]

{ #category : 'accessing' }
CollectionOfSpaceships >> ranking [

	| sortedSpaceships |
	sortedSpaceships := spaceships.
	sortedSpaceships sort: [ :a :b | a > b ].

	^ sortedSpaceships collect: [ :spaceship | spaceship ]
]
