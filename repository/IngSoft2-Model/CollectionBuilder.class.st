Class {
	#name : #CollectionBuilder,
	#superclass : #Object,
	#instVars : [
		'fixedDistributor',
		'probabilitiesTotal'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CollectionBuilder class >> fixedDistribution [
	^ self new initializeFixedDistribution
]

{ #category : #assertion }
CollectionBuilder >> assertCorrectProbabilitiesTotal [
	^ probabilitiesTotal = 100
		ifFalse: [ AssertionFailure signal: 'The sum of probabilities should be 100' ]
]

{ #category : #updating }
CollectionBuilder >> collectionOf: aSize containingAll: anElement [
	^ OrderedCollection new: aSize withAll: anElement
]

{ #category : #interaction }
CollectionBuilder >> collectionOfLength: aSize [
	| collection |
	self assertCorrectProbabilitiesTotal.
	collection := OrderedCollection new.
	aSize timesRepeat: [ collection add: self randomElementFromFixedDistributor ].
	^ collection
]

{ #category : #initialization }
CollectionBuilder >> initializeFixedDistribution [
	fixedDistributor := OrderedCollection new.
	probabilitiesTotal := 0
]

{ #category : #interaction }
CollectionBuilder >> moonWalkcollectionOf: aQuantity andMaximumSteps: maximumQuantity [
	| collection |
	collection := OrderedCollection new.
	aQuantity timesRepeat: [ collection add: (MoonWalkEffect withSteps: maximumQuantity atRandom) ].
	^ collection
]

{ #category : #interaction }
CollectionBuilder >> randomElementFromFixedDistributor [
	^ fixedDistributor atRandom
]

{ #category : #updating }
CollectionBuilder >> sumProbability: aQuantity [
	probabilitiesTotal := probabilitiesTotal + aQuantity
]

{ #category : #updating }
CollectionBuilder >> with: aClass probability: aQuantity [
	fixedDistributor addAll: (self collectionOf: aQuantity containingAll: aClass new).
	self sumProbability: aQuantity
]

{ #category : #updating }
CollectionBuilder >> withCardFromDeckProbability: aQuantity usingDeck: aDeckManager [
	fixedDistributor addAll: (self collectionOf: aQuantity containingAll: (CardFromDeckEffect withDeck: aDeckManager)).
	self sumProbability: aQuantity
]

{ #category : #updating }
CollectionBuilder >> withMoonWalkProbability: aQuantity withSteps: maximumQuantity [
	fixedDistributor addAll: (self moonWalkcollectionOf: aQuantity andMaximumSteps: maximumQuantity).
	self sumProbability: aQuantity
]
