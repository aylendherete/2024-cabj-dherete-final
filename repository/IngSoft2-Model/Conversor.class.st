Class {
	#name : 'Conversor',
	#superclass : 'Object',
	#instVars : [
		'oneToOneRatio'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Conversor class >> totalCells: anAmountOfCells convertionValue: aConvertionValue [

	^ self new
		  initializeTotalCells: anAmountOfCells
		  convertionValue: aConvertionValue
]

{ #category : 'actions' }
Conversor >> convert: aMetric [

	| valueToConvert |
	valueToConvert := aMetric convertToParsec.
	^ (valueToConvert * oneToOneRatio) asInteger
]

{ #category : 'initialization' }
Conversor >> initializeTotalCells: anAmountOfCells convertionValue: aConvertionValue [

	oneToOneRatio := anAmountOfCells / aConvertionValue
]
