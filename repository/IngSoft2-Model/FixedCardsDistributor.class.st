Class {
	#name : #FixedCardsDistributor,
	#superclass : #Object,
	#instVars : [
		'fixedCollection'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
FixedCardsDistributor class >> withProbabilities: aDictionary [
	^ self new initializeWithProbabilities: aDictionary
]

{ #category : #interaction }
FixedCardsDistributor >> collectionOf: aSize containingAll: aCardType [
	^ OrderedCollection new: aSize withAll: aCardType new
]

{ #category : #interaction }
FixedCardsDistributor >> deckOfSize: aSize [ 
	| collection |
	collection := OrderedCollection new.
	aSize timesRepeat: [ collection add: self randomElementFromFixedCollection ].
	^ collection
]

{ #category : #initialization }
FixedCardsDistributor >> initializeWithProbabilities: aDictionary [
	self verifyCorrectProbabilitiesSum: aDictionary values.
	fixedCollection := OrderedCollection new.
	aDictionary associationsDo: [ :each | fixedCollection addAll: (self collectionOf: each value containingAll: each key) ]
]

{ #category : #interaction }
FixedCardsDistributor >> randomElementFromFixedCollection [
	^ fixedCollection atRandom
]

{ #category : #validation }
FixedCardsDistributor >> verifyCorrectProbabilitiesSum: aCollection [ 
	^ (aCollection sumNumbers: [ :each | each ]) = 100
		ifFalse: [ AssertionFailure signal: 'The sum of probabilities should be 100' ]
]
