Class {
	#name : #DeckManagerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DeckManagerTest >> testAddToDiscardPileAddsItToDiscardPile [
	| deckManager cardCollection overload acceleration |
	overload := OverloadCard new.
	acceleration := AccelerationCard new.
	cardCollection := {overload.
	acceleration} asOrderedCollection.
	deckManager := DeckManager containing: cardCollection.
	self assert: deckManager cardsInDiscardPile equals: 0.
	deckManager toDiscardPile: acceleration.
	self assert: deckManager cardsInDiscardPile equals: 1.
]

{ #category : #tests }
DeckManagerTest >> testAddToDiscardPileRaisesExceptionWhenNotACard [
	| deckManager cardCollection overload acceleration discarded |
	overload := OverloadCard new.
	acceleration := AccelerationCard new.
	cardCollection := {overload.
	acceleration} asOrderedCollection.
	deckManager := DeckManager containing: cardCollection.
	self assert: deckManager cardsLeftInDeck equals: 2.
	discarded := 1.
	self
		should: [ deckManager toDiscardPile: discarded ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'Only cards are accepted in a DeckManager...' ].
	self assert: deckManager cardsInDiscardPile equals: 0
]

{ #category : #tests }
DeckManagerTest >> testCardsLeftGivesCardsInDeck [
	| deckManager cardCollection overload |
	overload := OverloadCard new.
	cardCollection := {overload} asOrderedCollection.
	deckManager := DeckManager containing: cardCollection.
	self assert: deckManager cardsLeftInDeck equals: cardCollection size
]

{ #category : #tests }
DeckManagerTest >> testCreationWithEmptyCollectionRaisesException [
	| deckManager cardCollection |
	cardCollection := {} asOrderedCollection.
	self
		should: [ deckManager := DeckManager containing: cardCollection ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'DeckManager needs at least one card in deck...' ]
]

{ #category : #tests }
DeckManagerTest >> testCreationWithObjectsOtherThanCardsRaisesException [
	| deckManager cardCollection |
	cardCollection := {1} asOrderedCollection.
	self
		should: [ deckManager := DeckManager containing: cardCollection ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'Only cards are accepted in a DeckManager...' ]
]

{ #category : #tests }
DeckManagerTest >> testDealCardsToManyPlayersRemovesThemFromDeck [
	| deckManager cardCollection overload acceleration player |
	player := Player named: 'Albert'.
	overload := OverloadCard new.
	acceleration := AccelerationCard new.
	cardCollection := {overload.
	acceleration} asOrderedCollection.
	deckManager := DeckManager containing: cardCollection.
	self assert: deckManager cardsLeftInDeck equals: 2.
	deckManager
		deal: 1
		toAllIn:
			{player.
			player}.
	self
		assert: player cardsInHand
		equals:
			{overload.
			acceleration} asOrderedCollection.
	self assert: deckManager cardsLeftInDeck equals: 0
]

{ #category : #tests }
DeckManagerTest >> testDealCardsToPlayerRemovesThemFromDeck [
	| deckManager cardCollection overload acceleration player |
	player := Player named: 'Albert'.
	overload := OverloadCard new.
	acceleration := AccelerationCard new.
	cardCollection := {overload.
	acceleration} asOrderedCollection.
	deckManager := DeckManager containing: cardCollection.
	self assert: deckManager cardsLeftInDeck equals: 2.
	deckManager deal: 2 to: player.
	self
		assert: player cardsInHand
		equals:
			{overload.
			acceleration} asOrderedCollection.
	self assert: deckManager cardsLeftInDeck equals: 0
]

{ #category : #tests }
DeckManagerTest >> testDealMoreCardsThanAvailableRaisesException [
	| deckManager cardCollection overload acceleration player |
	player := Player named: 'Albert'.
	overload := OverloadCard new.
	acceleration := AccelerationCard new.
	cardCollection := {overload.
	acceleration} asOrderedCollection.
	deckManager := DeckManager containing: cardCollection.
	self assert: deckManager cardsLeftInDeck equals: 2.
	self
		should: [ deckManager deal: 3 to: player ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'Can''t deal more cards than available...' ]
]

{ #category : #tests }
DeckManagerTest >> testDealMoreCardsThanAvailableToManyPlayersRaisesException [
	| deckManager cardCollection overload acceleration player |
	player := Player named: 'Albert'.
	overload := OverloadCard new.
	acceleration := AccelerationCard new.
	cardCollection := {overload.
	acceleration} asOrderedCollection.
	deckManager := DeckManager containing: cardCollection.
	self assert: deckManager cardsLeftInDeck equals: 2.
	self
		should: [ deckManager
				deal: 3
				toAllIn:
					{player.
					player} ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'Can''t deal more cards than available...' ]
]

{ #category : #tests }
DeckManagerTest >> testDealTopCardRemovesTopCardFromDeck [
	| deckManager cardCollection overload acceleration |
	overload := OverloadCard new.
	acceleration := AccelerationCard new.
	cardCollection := {overload.
	acceleration} asOrderedCollection.
	deckManager := DeckManager containing: cardCollection.
	self assert: deckManager cardsLeftInDeck equals: 2.
	self assert: deckManager dealTopCard equals: overload.
	self assert: deckManager cardsLeftInDeck equals: 1.
	self assert: deckManager dealTopCard equals: acceleration.
	self assert: deckManager cardsLeftInDeck equals: 0
]

{ #category : #tests }
DeckManagerTest >> testDealTopCardWhileDiscarPileEmptyRaisesException [
	| deckManager cardCollection overload acceleration |
	overload := OverloadCard new.
	acceleration := AccelerationCard new.
	cardCollection := {overload.
	acceleration} asOrderedCollection.
	deckManager := DeckManager containing: cardCollection.
	self assert: deckManager cardsInDiscardPile equals: 0.
	self assert: deckManager cardsLeftInDeck equals: 2.
	deckManager dealTopCard.
	self assert: deckManager cardsLeftInDeck equals: 1.
	deckManager dealTopCard.
	self assert: deckManager cardsLeftInDeck equals: 0.
	self assert: deckManager cardsInDiscardPile equals: 0.
	self
		should: [ deckManager dealTopCard ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'Deck and discard pile emptied...' ].
	deckManager toDiscardPile: overload.
	deckManager toDiscardPile: acceleration.
	deckManager dealTopCard.
	self assert: deckManager cardsLeftInDeck equals: 1
]

{ #category : #tests }
DeckManagerTest >> testDeckRefillsWithDiscardPileWhenEmptied [
	| deckManager cardCollection overload discarded |
	overload := OverloadCard new.
	cardCollection := {overload} asOrderedCollection.
	deckManager := DeckManager containing: cardCollection.
	self assert: deckManager cardsLeftInDeck equals: 1.
	self assert: deckManager cardsInDiscardPile equals: 0.
	discarded := deckManager dealTopCard.
	self assert: discarded equals: overload.
	self assert: deckManager cardsLeftInDeck equals: 0.
	self assert: deckManager cardsInDiscardPile equals: 0.
	deckManager toDiscardPile: discarded.
	self assert: deckManager cardsLeftInDeck equals: 0.
	self assert: deckManager cardsInDiscardPile equals: 1.
	discarded := deckManager dealTopCard.
	self assert: discarded equals: overload.
	self assert: deckManager cardsLeftInDeck equals: 0.
	self assert: deckManager cardsInDiscardPile equals: 0
]
