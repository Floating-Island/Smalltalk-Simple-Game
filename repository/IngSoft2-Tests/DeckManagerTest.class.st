Class {
	#name : #DeckManagerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DeckManagerTest >> testAddToDiscardPileAddsItToDiscardPile [
	| deckManager cardCollection overload accelleration |
	overload := OverloadCard new.
	accelleration := AccelerationCard new.
	cardCollection := {overload.
	accelleration} asOrderedCollection.
	deckManager := DeckManager containing: cardCollection.
	self assert: deckManager cardsInDiscardPile equals: 0.
	deckManager toDiscardPile: accelleration.
	self assert: deckManager cardsInDiscardPile equals: 1.
]

{ #category : #tests }
DeckManagerTest >> testAddToDiscardPileRaisesExceptionWhenNotACard [
	| deckManager cardCollection overload accelleration discarded |
	overload := OverloadCard new.
	accelleration := AccelerationCard new.
	cardCollection := {overload.
	accelleration} asOrderedCollection.
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
DeckManagerTest >> testDealCardsToPlayersRemovesThemFromDeck [
	| deckManager cardCollection overload accelleration player |
	player := Player named: 'Albert'.
	overload := OverloadCard new.
	accelleration := AccelerationCard new.
	cardCollection := {overload.
	accelleration} asOrderedCollection.
	deckManager := DeckManager containing: cardCollection.
	self assert: deckManager cardsLeftInDeck equals: 2.
	deckManager deal: 2 to: player.
	self assert: player cardsInHand equals: cardCollection.
	self assert: deckManager cardsLeftInDeck equals: 2
]

{ #category : #tests }
DeckManagerTest >> testDealTopCardRemovesTopCardFromDeck [
	| deckManager cardCollection overload accelleration |
	overload := OverloadCard new.
	accelleration := AccelerationCard new.
	cardCollection := {overload.
	accelleration} asOrderedCollection.
	deckManager := DeckManager containing: cardCollection.
	self assert: deckManager cardsLeftInDeck equals: 2.
	self assert: deckManager dealTopCard equals: overload.
	self assert: deckManager cardsLeftInDeck equals: 1.
	self assert: deckManager dealTopCard equals: accelleration.
	self assert: deckManager cardsLeftInDeck equals: 0
]

{ #category : #tests }
DeckManagerTest >> testDealTopCardWhileDiscarPileEmptyRaisesException [
	| deckManager cardCollection overload accelleration |
	overload := OverloadCard new.
	accelleration := AccelerationCard new.
	cardCollection := {overload.
	accelleration} asOrderedCollection.
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
	deckManager toDiscardPile: accelleration.
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
