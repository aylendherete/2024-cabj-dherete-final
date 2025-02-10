Class {
	#name : 'LightYear',
	#superclass : 'Object',
	#instVars : [
		'value'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
LightYear class >> ofValue: aValue [

	^ self new initializeOfValue: aValue
]

{ #category : 'converting' }
LightYear >> convertToParsec [

	^ value / 3
]

{ #category : 'initialization' }
LightYear >> initializeOfValue: aValue [

	value := aValue
]
