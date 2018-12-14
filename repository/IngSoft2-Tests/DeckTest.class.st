Class {
	#name : #DeckTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DeckTest >> testAddingACardToDeckIncreasesCardsLeftByOne [
	| aDeck aCollection overload |
	overload := OverloadCard new.
	aCollection := {overload} asOrderedCollection.
	aDeck := Deck containing: aCollection.
	self assert: aDeck cardsLeft equals: 1.
	aDeck add: overload.
	self assert: aDeck cardsLeft equals: 2
]

{ #category : #tests }
DeckTest >> testAddingACollectionOfCardToDeckAddsItSequentially [
	| aDeck aCollection overload accelleration |
	overload := OverloadCard new.
	accelleration := AccelerationCard new.
	aCollection := {} asOrderedCollection.
	aDeck := Deck containing: aCollection.
	self assert: aDeck cardsLeft equals: 0.
	aDeck
		addAll:
			{overload.
			accelleration.
			overload}.
	aDeck add: overload.
	self assert: aDeck cardsLeft equals: 4.
	self assert: aDeck dealTopCard equals: overload.
	self assert: aDeck dealTopCard equals: accelleration.
	self assert: aDeck dealTopCard equals: overload.
	self assert: aDeck dealTopCard equals: overload.
	self assert: aDeck cardsLeft equals: 0
]

{ #category : #tests }
DeckTest >> testAddingACollectionOfCardToDeckIncreasesCardsLeftByCollectionSize [
	| aDeck aCollection overload |
	overload := OverloadCard new.
	aCollection := {} asOrderedCollection.
	aDeck := Deck containing: aCollection.
	self assert: aDeck cardsLeft equals: 0.
	aDeck addAll: {overload . overload }.
	self assert: aDeck cardsLeft equals: 2
]

{ #category : #tests }
DeckTest >> testDealingTopCardRemovesItFromDeck [
	| aDeck aCollection overload |
	overload := OverloadCard new.
	aCollection := {overload} asOrderedCollection.
	aDeck := Deck containing: aCollection.
	self assert: aDeck cardsLeft equals: 1.
	self assert: aDeck dealTopCard equals: overload.
	self assert: aDeck cardsLeft equals: 0
]

{ #category : #tests }
DeckTest >> testDeckOnlyAcceptsCardsWhileAdding [
	| aDeck aCollection overload |
	overload := OverloadCard new.
	aCollection := {overload} asOrderedCollection.
	aDeck := Deck containing: aCollection.
	self assert: aDeck cardsLeft equals: 1.
	self should: [ aDeck add: 1 ] raise: AssertionFailure withExceptionDo: [ :signal | self assert: signal messageText equals: 'This deck only accepts cards...' ].
	self assert: aDeck cardsLeft equals: 1
]

{ #category : #tests }
DeckTest >> testDeckOnlyAcceptsCollectionOfCardsAtCreation [
	| aCollection |
	aCollection := {1} asOrderedCollection.
	self
		should: [ Deck containing: aCollection ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'This deck only accepts cards...' ]
]
