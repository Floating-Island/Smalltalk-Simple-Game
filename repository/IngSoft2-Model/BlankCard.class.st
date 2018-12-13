Class {
	#name : #BlankCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #interaction }
BlankCard >> activateOn: aGame to: aPlayerOrCard [
	
]

{ #category : #interaction }
BlankCard >> applyOn: aGame to: aPlayerOrCard [
	self activateOn: aGame to: aPlayerOrCard
]

{ #category : #validation }
BlankCard >> assertCanBePlayedIn: aGame by: aPlayer [
	^ true
]
