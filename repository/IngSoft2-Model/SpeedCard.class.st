Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #interaction }
SpeedCard >> affect: aPlayer in: aGame [
	aPlayer = aGame currentPlayerTurn
		ifTrue: [ aGame updatePositionOf: aPlayer by: 1 ]
]

{ #category : #validation }
SpeedCard >> assertCanBePlayedIn: aGame by: aPlayer [
	aGame hasFinished
		ifTrue: [ AssertionFailure new signal: 'Can''t use card when game has finished' ].
	aGame turnOf: aPlayer
]

{ #category : #interaction }
SpeedCard >> playIn: aGame against: aPlayer [
	self validateIsPlayer: aPlayer.
	aGame updateLastPlayedCard: self.
	aGame addCard: self asociatedWith: aPlayer
]

{ #category : #validation }
SpeedCard >> validateIsPlayer: aPlayer [
	^ (aPlayer isMemberOf: Player)
		ifFalse: [ AssertionFailure new signal: 'Speed Card only applies to players' ]
]
