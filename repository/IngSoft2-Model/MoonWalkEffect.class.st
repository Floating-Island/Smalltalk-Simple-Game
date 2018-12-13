Class {
	#name : #MoonWalkEffect,
	#superclass : #Effect,
	#instVars : [
		'steps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonWalkEffect class >> withSteps: anInteger [
	^ self new initializeWithSteps: anInteger
]

{ #category : #initialization }
MoonWalkEffect >> initializeWithSteps: anInteger [
	steps := anInteger
]

{ #category : #accessing }
MoonWalkEffect >> steps [
	^ steps
]

{ #category : #interaction }
MoonWalkEffect >> triggerOn: aGame afterMovementOf: aPlayer [
	| otherPlayers |
	otherPlayers := aGame playersPlaying
		reject: [ :each | each = aPlayer ].
	otherPlayers
		do: [ :each | aGame updatePositionOf: each by: steps negated ]
]
