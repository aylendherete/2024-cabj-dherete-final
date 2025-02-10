Class {
	#name : 'Parsecs',
	#superclass : 'Object',
	#instVars : [
		'value'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Parsecs class >> ofValue: aValue [

	^ self new initializeOfValue: aValue
]

{ #category : 'converting' }
Parsecs >> convertToParsec [

	^ value
]

{ #category : 'initialization' }
Parsecs >> initializeOfValue: aValue [

	value := aValue
]
