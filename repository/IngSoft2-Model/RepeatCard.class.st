Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #interaction }
RepeatCard >> activateOn: aGame to: aPlayerOrCard [
	| player effect |
	effect := aGame lastEffectAppliedToAPlayer.
	player := aGame lastPlayerAffectedByAnEffect.
	effect triggerOn: aGame afterMovementOf: player
]

{ #category : #interaction }
RepeatCard >> applyOn: aGame to: aPlayerOrCard [
	aGame updateLastPlayedCard: self.
	self activateOn: aGame to: aPlayerOrCard
]

{ #category : #validation }
RepeatCard >> assertCanBePlayedIn: aGame by: aPlayer [
	^ true
]
