Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Deck class >> containing: aCollectionOfCards [
	^ self new initializeContaining: aCollectionOfCards
]

{ #category : #interaction }
Deck >> cardsLeft [
	^ cards size
]

{ #category : #updating }
Deck >> dealTopCard [
	^ cards removeFirst
]

{ #category : #initialization }
Deck >> initializeContaining: aCollectionOfCards [
	cards := aCollectionOfCards
]
