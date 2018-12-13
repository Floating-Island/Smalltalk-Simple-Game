Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #interaction }
RepeatCard >> affect: aPlayerOrCard in: aGame [
	| player effect |
	effect := aGame lastEffectAppliedToAPlayer.
	player := aGame lastPlayerAffectedByAnEffect.
	effect triggerOn: aGame afterMovementOf: player
]

{ #category : #validation }
RepeatCard >> assertCanBePlayedIn: aGame by: aPlayer [
	^ true
]

{ #category : #interaction }
RepeatCard >> playIn: aGame against: aPlayerOrCard [
	aGame updateLastPlayedCard: self.
	self affect: aPlayerOrCard in: aGame
]
