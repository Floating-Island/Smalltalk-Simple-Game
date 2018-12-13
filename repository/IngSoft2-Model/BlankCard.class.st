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
	^ true
]

{ #category : #interaction }
BlankCard >> playIn: aGame against: aPlayerOrCard [
	self affect: aPlayerOrCard in: aGame
]
