Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
Deck class >> assertCollectionOfCards: aCollection [
	aCollection size = (aCollection select: [ :each | each isKindOf: Card ]) size
		ifFalse: [ AssertionFailure new signal: 'This deck only accepts cards...' ]
]

{ #category : #'instance creation' }
Deck class >> containing: aCollectionOfCards [
	self assertCollectionOfCards: aCollectionOfCards.
	^ self new initializeContaining: aCollectionOfCards
]

{ #category : #updating }
Deck >> add: aCard [
	self addAll: aCard asOrderedCollection
]

{ #category : #updating }
Deck >> addAll: aCollectionOfCards [
	self class assertCollectionOfCards: aCollectionOfCards.
	cards addAll: aCollectionOfCards
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
