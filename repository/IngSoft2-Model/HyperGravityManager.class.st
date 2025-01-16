Class {
	#name : 'HyperGravityManager',
	#superclass : 'Object',
	#instVars : [
		'spaceships',
		'applyReverse'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
HyperGravityManager class >> manage [
	^ (self new) initializeOfHyperGravityManager .
]

{ #category : 'action handling' }
HyperGravityManager >> handleGreaterValueOf: aSpaceship with: aNumberOfMovements [

	spaceships removeKey: aSpaceship.
	^ aNumberOfMovements
]

{ #category : 'action' }
HyperGravityManager >> handleHyperGravityOn: aSpaceship withValue: value [
	
	spaceships at: aSpaceship put: value

]

{ #category : 'action handling' }
HyperGravityManager >> handleLowerValueOf: aSpaceship with: aNumberOfMovements [

	applyReverse
		ifTrue: [
			^ self
				  handleGreaterValueOf: aSpaceship
				  with: aNumberOfMovements negated ]
		ifFalse: [ ^ 0 ]
]

{ #category : 'action handling' }
HyperGravityManager >> handleMovementOf: aSpaceship with: throwResult and: aNumberOfMovements [

	(spaceships includesKey: aSpaceship) ifTrue: [
		throwResult < (spaceships at: aSpaceship)
			ifTrue: [
			^ self handleLowerValueOf: aSpaceship with: aNumberOfMovements ]
			ifFalse: [
			^ self handleGreaterValueOf: aSpaceship with: aNumberOfMovements ] ].
	^ aNumberOfMovements .
]

{ #category : 'as yet unclassified' }
HyperGravityManager >> handleReverseHyperGravityOn: aSpaceship withValue: value [
	
	spaceships at: aSpaceship put: value.
	applyReverse := applyReverse not
]

{ #category : 'initialization' }
HyperGravityManager >> initialize [

	applyReverse := false
]

{ #category : 'initialization' }
HyperGravityManager >> initializeOfHyperGravityManager [ 
	spaceships := Dictionary new.
]
