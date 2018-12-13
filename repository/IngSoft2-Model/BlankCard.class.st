Class {
	#name : #BlankCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #interaction }
BlankCard >> affect: aPlayerOrCard in: aGame [
	
]

{ #category : #validation }
BlankCard >> assertCanBePlayedIn: aGame by: aPlayer [
	aGame hasFinished
		ifTrue: [ AssertionFailure new signal: 'Can''t use card when game has finished' ]
]

{ #category : #interaction }
BlankCard >> playIn: aGame against: aPlayerOrCard [
	self affect: aPlayerOrCard in: aGame
]
