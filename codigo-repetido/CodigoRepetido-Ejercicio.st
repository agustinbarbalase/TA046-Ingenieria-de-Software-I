!classDefinition: #CustomerBookError category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CustomerBookError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #AlreadyExists category: #'CodigoRepetido-Ejercicio'!
CustomerBookError subclass: #AlreadyExists
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CannotBeEmpty category: #'CodigoRepetido-Ejercicio'!
CustomerBookError subclass: #CannotBeEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
CustomerBookError subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
CustomerBookError subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: 'johnLennon paulMcCartney ringoStarr customerBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'assertions' stamp: 'AB 9/13/2024 10:20:21'!
assert: aClosureToMeasure aTimeLapse: aTimeLapse	
	| millisecondsAfterRunning millisecondsBeforeRunning |
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosureToMeasure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < aTimeLapse! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'AB 9/13/2024 10:54:21'!
assertFail: unClosure withError: anError andDo: anotherClosure
	[unClosure value. self fail.]
		on: anError
		do: anotherClosure.! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'AB 9/13/2024 10:18:00'!
assertHave: aNumberOfActiveCostumers activeCostumersAnd: aNumberOfSuspendedCostumers suspendedCostumerIn: aCustomerBook
	self assert: aNumberOfActiveCostumers equals: aCustomerBook numberOfActiveCustomers.
	self assert: aNumberOfSuspendedCostumers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: (aNumberOfActiveCostumers + aNumberOfSuspendedCostumers) equals: aCustomerBook numberOfCustomers.
  ! !


!CustomerBookTest methodsFor: 'testing' stamp: 'AB 9/12/2024 12:46:32'!
setUp
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	johnLennon :=  'John Lennon'.
	ringoStarr := 'Ringo Starr'.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AB 9/13/2024 10:20:21'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	self assert: [ customerBook addCustomerNamed: johnLennon ] aTimeLapse: 50 * millisecond
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AB 9/13/2024 10:20:21'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	customerBook addCustomerNamed: paulMcCartney.	
	self assert: [customerBook removeCustomerNamed: paulMcCartney.] aTimeLapse: 100 * millisecond
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AB 9/13/2024 10:58:39'!
test03CanNotAddACustomerWithEmptyName 
	self assertFail: [customerBook addCustomerNamed: '' value] 
		withError: CannotBeEmpty 
		andDo: [:anError |
			self assert: customerBook isEmpty
		]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AB 9/13/2024 10:58:25'!
test04CanNotRemoveAnInvalidCustomer
	customerBook addCustomerNamed: johnLennon.
	self assertFail: [ customerBook removeCustomerNamed: paulMcCartney ] 
		withError: NotFound 
		andDo:[ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) 
		]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AB 9/13/2024 10:18:00'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	self assertHave: 0 activeCostumersAnd: 1 suspendedCostumerIn: customerBook.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AB 9/13/2024 10:18:00'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.

	self assertHave: 0 activeCostumersAnd: 0 suspendedCostumerIn: customerBook.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AB 9/13/2024 10:58:34'!
test07CanNotSuspendAnInvalidCustomer
	customerBook addCustomerNamed: johnLennon.
	self assertFail: [ customerBook suspendCustomerNamed: ringoStarr ] 
		withError: CantSuspend andDo: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) 
		]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AB 9/13/2024 10:59:10'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	self assertFail: [ customerBook suspendCustomerNamed: johnLennon. ] 
		withError: CantSuspend andDo: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) 
		]
! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'AB 9/13/2024 10:52:11'!
includesCustomerNamed: aName
	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'AB 9/13/2024 10:52:06'!
isEmpty
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'AB 9/13/2024 10:37:40'!
initialize
	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'AB 9/13/2024 10:52:26'!
addCustomerNamed: aName
	aName isEmpty ifTrue: [ ^CannotBeEmpty signal ].
	(self includesCustomerNamed: aName) ifTrue: [ ^AlreadyExists signal ].
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'AB 9/13/2024 10:35:01'!
numberOfActiveCustomers
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'AB 9/13/2024 10:34:56'!
numberOfCustomers
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'AB 9/13/2024 10:34:50'!
numberOfSuspendedCustomers
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'AB 9/13/2024 10:51:47'!
removeCustomerNamed: aName 
	active remove: aName ifAbsent: [
		^suspended remove: aName ifAbsent: 	[^NotFound signal].
	].
! !

!CustomerBook methodsFor: 'customer management' stamp: 'AB 9/13/2024 10:53:12'!
suspendCustomerNamed: aName
	active remove: aName ifAbsent: [^CantSuspend signal].
	suspended add: aName! !
