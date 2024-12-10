Class {
	#name : 'LoadedEffectManager',
	#superclass : 'Object',
	#instVars : [
		'objects'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'instance creation' }
LoadedEffectManager class >> manage: aCollectionOfObjects [

	^ self new
		  initializeManage: aCollectionOfObjects
		  withProbabilitiesDistribution: 100
]

{ #category : 'creating' }
LoadedEffectManager >> createCollectionSize: aNumber [

	^ objects copy
]

{ #category : 'creating' }
LoadedEffectManager >> giveOneObject [

	^ objects at: 1

]

{ #category : 'initialization' }
LoadedEffectManager >> initializeManage: aCollectionOfObjects withProbabilitiesDistribution: collectionOfProbabilities [

	objects := aCollectionOfObjects
]
