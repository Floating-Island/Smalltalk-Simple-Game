Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #interaction }
SpeedCard >> activateOn: aGame to: aPlayer [
	aPlayer = aGame currentPlayerTurn
		ifTrue: [ aGame updatePositionBy: 1 ofThePlayer: aPlayer ]
]

{ #category : #interaction }
SpeedCard >> applyOn: aGame to: aPlayer [
	self validateParameterIsAPlayer: aPlayer.
	aGame updateLastPlayedCard: self.
	aGame addCard: self asociatedWith: aPlayer
]

{ #category : #validation }
SpeedCard >> assertCanBePlayedIn: aGame by: aPlayer [
	aGame turnOf: aPlayer
]

{ #category : #validation }
SpeedCard >> validateParameterIsAPlayer: aPlayer [
	^ (aPlayer isMemberOf: Player)
		ifFalse: [ AssertionFailure new signal: 'Speed Card only applies to players' ]
]
