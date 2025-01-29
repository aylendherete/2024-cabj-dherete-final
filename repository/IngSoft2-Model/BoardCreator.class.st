Class {
	#name : 'BoardCreator',
	#superclass : 'Object',
	#instVars : [
		'wormholeCreator',
		'board',
		'laps'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
BoardCreator class >> with: collectionOfCells ofLaps: numberOfLaps withWormholeCreator: aWormholeCreator [

	(collectionOfCells anySatisfy: [ :cell |
		 cell class ~= Cell and: [ cell class superclass ~= Cell ] ])
		ifTrue: [
		Error signal: 'A board creator must recive a collection of cells' ].

	^ self new
		  initializeWith: collectionOfCells
		  ofLaps: numberOfLaps
		  withWormholeCreator: aWormholeCreator
]

{ #category : 'set and get' }
BoardCreator >> cells [

	^ board size
]

{ #category : 'creation' }
BoardCreator >> createBoard [

	self createWormhole.

	^ board
]

{ #category : 'set and get' }
BoardCreator >> createWormhole [

	board
		at: wormholeCreator beginning cell
		put: wormholeCreator beginning.
	board at: wormholeCreator ending cell put: wormholeCreator ending
]

{ #category : 'initialization' }
BoardCreator >> initializeWith: collectionOfCells ofLaps: numberOfLaps withWormholeCreator: aWormholeCreator [

	laps := numberOfLaps.
	wormholeCreator := aWormholeCreator.
	board := collectionOfCells.
]

{ #category : 'as yet unclassified' }
BoardCreator >> insertCell: aCell inPosition: aPosition [

	board add:aCell beforeIndex: aPosition .
]

{ #category : 'set and get' }
BoardCreator >> laps [

	^ laps
]
