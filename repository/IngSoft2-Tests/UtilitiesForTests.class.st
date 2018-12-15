Class {
	#name : #UtilitiesForTests,
	#superclass : #Object,
	#category : #'IngSoft2-Tests'
}

{ #category : #interaction }
UtilitiesForTests class >> collectionOf20NoEffect [
	| distributor |
	distributor := FixedEffectsDistributor
		withProbabilityOfSpeedUp: 0
		wormhole: 0
		atomic: 0
		noEffect: 100
		moonwalk: 0
		andMaximumMoonwalkSteps: 5.
	^ distributor boardOfLength: 20
]
