Class {
	#name : #UtilitiesForTests,
	#superclass : #Object,
	#category : #'IngSoft2-Tests'
}

{ #category : #interaction }
UtilitiesForTests class >> collectionOf20NoEffect [
	| distributor |
	distributor := CollectionBuilder fixedDistribution withNoEffectProbability: 100.
	^ distributor collectionOfLength: 20
]
