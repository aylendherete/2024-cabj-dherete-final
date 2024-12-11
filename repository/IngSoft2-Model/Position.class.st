Class {
	#name : 'Position',
	#superclass : 'Object',
	#instVars : [
		'cell',
		'lap'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Position class >> startGame [

	^ self new initializeStartGameWithCell: 1 andLap: 1
]

{ #category : 'instance creation' }
Position class >> startGameWithCell: aNumber andLap: anotherNumber [

	^ self new initializeStartGameWithCell: aNumber andLap: anotherNumber
]

{ #category : 'accessing' }
Position >> = aPosition [

	^ self cell = aPosition cell and: self lap = aPosition lap
]

{ #category : 'checking' }
Position >> adjustMovementFor: aNumberOfMovements withLimits: aFinishLine [

	| aux cellXLapsOfFinishLine amountOfCells cellXLapsOfPosition |
	aux := aNumberOfMovements.
	amountOfCells := aFinishLine cell.
	cellXLapsOfFinishLine := (aFinishLine cell) * (aFinishLine lap).
	cellXLapsOfPosition := amountOfCells*(lap-1)+cell.
	
	cellXLapsOfPosition + aNumberOfMovements > cellXLapsOfFinishLine ifTrue: [
		aux := cellXLapsOfFinishLine - cellXLapsOfPosition.
		self updateLap: (aFinishLine lap) - lap ].

	cellXLapsOfPosition + aNumberOfMovements < 1 ifTrue: [
		aux := 1 - cellXLapsOfPosition.
		self updateLap: 1 - lap ].
	
	^ aux
]

{ #category : 'checking' }
Position >> adjustPositionWith: aFinishLine [

	| amountOfCells completedLaps nextCell |
	amountOfCells := aFinishLine cell.

	cell > amountOfCells ifTrue: [
		completedLaps := cell - 1 // amountOfCells + 1 - 1.
		self updateLap: completedLaps.
		nextCell := cell - (completedLaps * amountOfCells).
		self updateCell: nextCell - cell ].

	cell < 1 ifTrue: [
		completedLaps := cell - amountOfCells // amountOfCells + 1.
		self updateLap: completedLaps.
		nextCell := amountOfCells * lap + cell.
		self updateCell: nextCell - cell ].
	^ self
]

{ #category : 'accessing' }
Position >> cell [

	^ cell
]

{ #category : 'initialization' }
Position >> initializeStartGameWithCell: aNumber andLap: anotherNumber [

	cell := aNumber.
	lap := anotherNumber
]

{ #category : 'accessing' }
Position >> lap [

	^ lap
]

{ #category : 'set and get' }
Position >> updateCell: aNumber [

	cell := cell + aNumber
]

{ #category : 'set and get' }
Position >> updateLap: aNumber [

	lap := lap + aNumber
]
