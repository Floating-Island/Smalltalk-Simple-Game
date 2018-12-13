Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #interaction }
OverloadCard >> affect: aPlayer in: aGame [
	aPlayer = aGame currentPlayerTurn
		ifTrue: [ aGame updatePositionBy: 2 negated ofThePlayer: aPlayer ]
]

{ #category : #validation }
OverloadCard >> assertCanBePlayedIn: aGame by: aPlayer [ 
	aGame turnOf: aPlayer
]

{ #category : #interaction }
OverloadCard >> playIn: aGame against: aPlayer [
	self validateIsPlayer: aPlayer.
	aGame updateLastPlayedCard: self.
	aGame addCard: self asociatedWith: aPlayer
]

{ #category : #validation }
OverloadCard >> validateIsPlayer: aPlayer [
	^ (aPlayer isMemberOf: Player)
		ifFalse: [ AssertionFailure new signal: 'Overload Card only applies to players' ]
]
