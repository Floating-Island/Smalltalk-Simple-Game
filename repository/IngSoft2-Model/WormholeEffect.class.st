Class {
	#name : #WormholeEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #interaction }
WormholeEffect >> triggerOn: aGame afterMovementOf: aPlayer [
	| steps |
	steps := 4 negated.
	aGame updatePositionOf: aPlayer by: steps
]
