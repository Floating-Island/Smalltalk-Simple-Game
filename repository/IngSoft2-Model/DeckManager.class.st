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
DeckManager class >> assertCollectionNotEmpty: aCollection [
	aCollection size >= 1
		ifFalse: [ AssertionFailure new signal: 'DeckManager needs at least one card in deck...' ]
]

{ #category : #validation }
DeckManager class >> assertCollectionOfCards: aCollection [
	aCollection size = (aCollection select: [ :each | each isKindOf: Card ]) size
		ifFalse: [ AssertionFailure new signal: 'Only cards are accepted in a DeckManager...' ]
]

{ #category : #'instance creation' }
DeckManager class >> containing: aCardCollection [
	self assertCollectionNotEmpty: aCardCollection.
	self assertCollectionOfCards: aCardCollection.
	^ self new initializeContaining: aCardCollection
]

{ #category : #updating }
DeckManager >> addToDiscardPile: aCard [
	self class assertCollectionOfCards: aCard asOrderedCollection.
	discardPile add: aCard
]

{ #category : #validation }
DeckManager >> assertDiscardPileNotEmpty [
	self cardsInDiscardPile = 0
		ifTrue: [ AssertionFailure new signal: 'Discard pile is empty...' ]
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
	| topCard |
	self assertDiscardPileNotEmpty.
	topCard := deck removeFirst.
	self cardsLeftInDeck = 0
		ifTrue: [ self reShuffleDiscardPileInDeck ].
	^ topCard
]

{ #category : #initialization }
DeckManager >> initializeContaining: aCardCollection [
	deck := aCardCollection asOrderedCollection.
	discardPile := OrderedCollection new
]

{ #category : #updating }
DeckManager >> reShuffleDiscardPileInDeck [
	| emptyDeck |
	emptyDeck := deck.
	deck := discardPile shuffled.
	discardPile := emptyDeck
]
