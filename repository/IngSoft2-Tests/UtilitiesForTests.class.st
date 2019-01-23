Class {
	#name : #UtilitiesForTests,
	#superclass : #Object,
	#category : #'IngSoft2-Tests'
}

{ #category : #interaction }
UtilitiesForTests class >> collectionOf20NoEffect [
	| distributor |
	distributor := CollectionBuilder fixedDistribution
		with: NoEffect
		Probability: 100.
	^ distributor collectionOfLength: 20
]
