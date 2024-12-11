Class {
	#name : 'AccelerationCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'effect' }
AccelerationCard >> applyEffectOn: throwResult for: spaceshipId [

	^ throwResult + 1
]
