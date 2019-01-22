Class {
	#name : #CollectionBuilder,
	#superclass : #Object,
	#instVars : [
		'fixedDistributor'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CollectionBuilder class >> fixedDistribution [
	^ self new initializeFixedDistribution
]

{ #category : #updating }
CollectionBuilder >> collectionOf: aSize containingAll: aClass [
	^ OrderedCollection new: aSize withAll: aClass new
]

{ #category : #interaction }
CollectionBuilder >> collectionOfLength: aSize [
	| collection |
	collection := OrderedCollection new.
	aSize timesRepeat: [ collection add: self randomElementFromFixedDistributor ].
	^ collection
]

{ #category : #initialization }
CollectionBuilder >> initializeFixedDistribution [
	fixedDistributor := OrderedCollection new
]

{ #category : #interaction }
CollectionBuilder >> randomElementFromFixedDistributor [
	^ fixedDistributor atRandom
]

{ #category : #updating }
CollectionBuilder >> withSpeedupProbability: aQuantity [
	fixedDistributor addAll: (self collectionOf: aQuantity containingAll: SpeedUpEffect)
]
