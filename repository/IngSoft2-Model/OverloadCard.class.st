Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #interaction }
OverloadCard >> activateOn: aGame to: aPlayer [
	aPlayer = aGame currentPlayerTurn
		ifTrue: [ aGame updatePositionBy: 2 negated ofThePlayer: aPlayer ]
]

{ #category : #interaction }
OverloadCard >> applyOn: aGame to: aPlayer [
	self validateParameterIsAPlayer: aPlayer.
	aGame updateLastPlayedCard: self.
	aGame addCard: self asociatedWith: aPlayer
]

{ #category : #validation }
OverloadCard >> assertCanBePlayedIn: aGame by: aPlayer [ 
	aGame turnOf: aPlayer
]

{ #category : #validation }
OverloadCard >> validateParameterIsAPlayer: aPlayer [
	^ (aPlayer isMemberOf: Player)
		ifFalse: [ AssertionFailure new signal: 'Overload Card only applies to players' ]
]
