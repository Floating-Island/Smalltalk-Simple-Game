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
DeckManager >> assertCardsAvailableInDeck [
	self cardsLeftInDeck = 0
		ifTrue: [ [self assertDiscardPileNotEmpty]
				on: AssertionFailure
				do: [ AssertionFailure new signal: 'Deck and discard pile emptied...' ].
			self shuffleDiscardPileIntoDeck ]
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

{ #category : #interaction }
DeckManager >> deal: aNumberOfCards to: aPlayer [ 
	aNumberOfCards timesRepeat: [ aPlayer drawCardFrom: self ]
]

{ #category : #updating }
DeckManager >> dealTopCard [
	| topCard |
	self assertCardsAvailableInDeck.
	^ deck removeFirst
]

{ #category : #initialization }
DeckManager >> initializeContaining: aCardCollection [
	deck := aCardCollection asOrderedCollection.
	discardPile := OrderedCollection new
]

{ #category : #updating }
DeckManager >> shuffleDiscardPileIntoDeck [
	| emptyDeck |
	emptyDeck := deck.
	deck := discardPile shuffled.
	discardPile := emptyDeck
]

{ #category : #updating }
DeckManager >> toDiscardPile: aCard [
	self class assertCollectionOfCards: aCard asOrderedCollection.
	discardPile add: aCard
]
