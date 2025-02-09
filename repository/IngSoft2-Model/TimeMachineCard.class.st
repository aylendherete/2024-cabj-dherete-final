Class {
	#name : 'TimeMachineCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
TimeMachineCard class >> toDoEffectFor: aSpaceshipId [

	^ self new initializeToDoEffectFor: aSpaceshipId.
]

{ #category : 'accessing' }
TimeMachineCard >> activateEffectOn: aGame forSpaceship: anId [
	aGame activateCard: self.
	aGame doTimeMachineEffectToSpacehip: anId.

]

{ #category : 'effect' }
TimeMachineCard >> applyEffectOn: throwResult for: spaceshipId [

	^ throwResult
]

{ #category : 'initialization' }
TimeMachineCard >> initializeToDoEffectFor: aSpaceshipId [

	spaceshipAffected := aSpaceshipId
]
