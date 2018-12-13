Class {
	#name : #AtomicEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
AtomicEffect >> triggerOn: aGame afterMovementOf: aPlayer [
	aGame playersPlaying
		do:
			[ :each | aGame updatePositionOf: each by: (aGame positionFor: each) negated + 1 ]
]
