Class {
	#name : #SpeedUpEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #interaction }
SpeedUpEffect >> triggerOn: aGame afterMovementOf: aPlayer [
	| steps |
	steps := 4.
	aGame updatePositionOf: aPlayer by: steps
]
