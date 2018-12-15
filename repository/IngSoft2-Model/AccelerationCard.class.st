Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #interaction }
AccelerationCard >> affect: aPlayerCollection in: aGame [
	aGame updatePositionOf: aGame currentPlayerTurn by: 1
]

{ #category : #validation }
AccelerationCard >> assertCanBePlayedIn: aGame by: aPlayer [
	aGame hasFinished
		ifTrue: [ AssertionFailure new signal: 'Can''t use card when game has finished' ].
	aGame turnOf: aPlayer
]

{ #category : #interaction }
AccelerationCard >> playIn: aGame against: aPlayer [
	aGame updateLastPlayedCard: self.
	aGame addCard: self asociatedWith: aGame playersPlaying
]

{ #category : #interaction }
AccelerationCard >> removedFromAHandIn: aGame [ 
]
