Class {
	#name : #DeckManager,
	#superclass : #Object,
	#instVars : [
		'deck',
		'discardPile'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
DeckManager class >> assertCollectionOfCards: aCollection [
	aCollection size = (aCollection select: [ :each | each isKindOf: Card ]) size
		ifFalse: [ AssertionFailure new signal: 'Only cards are accepted in a DeckManager...' ]
]

{ #category : #'instance creation' }
DeckManager class >> containing: aCardCollection [
	self assertCollectionOfCards: aCardCollection.
	^ self new initializeContaining: aCardCollection
]

{ #category : #updating }
DeckManager >> addToDiscardPile: aCard [
	self class assertCollectionOfCards: aCard asOrderedCollection.
	discardPile add: aCard
]

{ #category : #interaction }
DeckManager >> cardsInDiscardPile [
	^ discardPile size
]

{ #category : #interaction }
DeckManager >> cardsLeftInDeck [
	^ deck size
]

{ #category : #updating }
DeckManager >> dealTopCard [
	^ deck removeFirst
]

{ #category : #initialization }
DeckManager >> initializeContaining: aCardCollection [
	deck := aCardCollection asOrderedCollection.
	discardPile := OrderedCollection new
]
