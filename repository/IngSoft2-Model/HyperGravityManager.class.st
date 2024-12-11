Class {
	#name : 'HyperGravityManager',
	#superclass : 'Object',
	#instVars : [
		'spaceships'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
HyperGravityManager class >> manage [
	^ (self new) initializeOfHyperGravityManager .
]

{ #category : 'action' }
HyperGravityManager >> handleHyperGravityOn: aSpaceship withValue: value [
	
	spaceships at: aSpaceship put: value

]

{ #category : 'action handling' }
HyperGravityManager >> handleMovementOf:aSpaceship with:throwResult and: aNumberOfMovements [ 

		(spaceships includesKey: aSpaceship) ifTrue: [
		throwResult < (spaceships at: aSpaceship)
			ifTrue: [^ 0.]
			ifFalse:[spaceships removeKey: aSpaceship.]
			].
		
		
	^aNumberOfMovements .
]

{ #category : 'initialization' }
HyperGravityManager >> initializeOfHyperGravityManager [ 
	spaceships := Dictionary new.
]
