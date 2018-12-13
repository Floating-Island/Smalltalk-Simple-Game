Class {
	#name : #RedoCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #interaction }
RedoCard >> affect: aPlayerOrCard in: aGame [
	| card |
	card := aGame lastPlayedCard deepCopy.
	card playIn: aGame against: aPlayerOrCard
]

{ #category : #validation }
RedoCard >> assertCanBePlayedIn: aGame by: aPlayer [
	^ aGame lastPlayedCard assertCanBePlayedIn: aGame by: aPlayer
]

{ #category : #interaction }
RedoCard >> playIn: aGame against: aPlayerOrCard [
	self affect: aPlayerOrCard in: aGame
]
