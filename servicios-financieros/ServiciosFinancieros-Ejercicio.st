!classDefinition: #ServiciosFinancierosTest category: #'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ServiciosFinancierosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!


!classDefinition: #AccountSummaryTest category: #'ServiciosFinancieros-Ejercicio'!
ServiciosFinancierosTest subclass: #AccountSummaryTest
	instanceVariableNames: 'accountSummary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountSummaryTest methodsFor: 'tests' stamp: 'AB 10/18/2024 08:16:03'!
test01AccountSummaryForAccountWithoutTransactions

	| account |
	account := ReceptiveAccount new.

	accountSummary := AccountSummary for: account.
	
	self assert: (OrderedCollection with: 'Balance = 0 * pesos') equals: (accountSummary).! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AB 10/18/2024 08:16:08'!
test02AccountSummaryForADeposit

	| account expectedSummary |
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	
	accountSummary := AccountSummary for: account.	
	expectedSummary := OrderedCollection with: 'Depósito por 100 * pesos' with: 'Balance = 100 * pesos'.
	
	self assert: expectedSummary equals: (accountSummary).! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AB 10/18/2024 08:16:11'!
test03AccountSummaryForAWithdraw

	| account expectedSummary |
	account := ReceptiveAccount new.
	Withdraw register: 100 * peso on: account.
	
	accountSummary := AccountSummary for: account.	
	expectedSummary := OrderedCollection with: 'Extracción por 100 * pesos' with: 'Balance = -100 * pesos'.
	
	self assert: expectedSummary equals: (accountSummary).! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AB 10/18/2024 08:16:14'!
test04AccountSummaryForAWithdrawLeg

	| expectedSummary reciver sender |
	sender := ReceptiveAccount new.
	reciver := ReceptiveAccount new.
	
	Transfer register: 100 * peso from: sender to: reciver.
	
	accountSummary := AccountSummary for: sender.	
	expectedSummary := OrderedCollection with: 'Salida por transferencia de 100 * pesos' with: 'Balance = -100 * pesos'.
	
	self assert: expectedSummary equals: (accountSummary).! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AB 10/18/2024 08:16:18'!
test05AccountSummaryForDepositLeg

	| expectedSummary reciver sender |
	sender := ReceptiveAccount new.
	reciver := ReceptiveAccount new.
	
	Transfer register: 100 * peso from: sender to: reciver.
	
	accountSummary := AccountSummary for: reciver.	
	expectedSummary := OrderedCollection with: 'Entrada por transferencia de 100 * pesos' with: 'Balance = 100 * pesos'.
	
	self assert: expectedSummary equals: (accountSummary).! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'AB 10/18/2024 07:26:56'!
test06TryGetAccountSummaryWithAPortfolioThrowAnError

	self should: [AccountSummary for: (Portfolio new)] 
		raise: Error
		withExceptionDo: [:anError | 
			self assert: (anError messageText = AccountSummary cannotCreateAnAccountSummaryWithPortfolioErrorMessage)
		]! !


!classDefinition: #PortfolioTest category: #'ServiciosFinancieros-Ejercicio'!
ServiciosFinancierosTest subclass: #PortfolioTest
	instanceVariableNames: 'emptyAccount accountOne accountTwo transactionOne transactionTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'valid portfolio' stamp: 'AB 10/18/2024 09:40:24'!
test09APortfolioCannotAddTheSameAccountTwice

	| portfolio  |
	
	portfolio := Portfolio with: accountOne.

	self 
		should: [portfolio addAccount: accountOne] 
		raise: Error 
		withExceptionDo: [:anError | self assert: (anError messageText = (Portfolio cannotAddAccountErrorMessage))]! !

!PortfolioTest methodsFor: 'valid portfolio' stamp: 'AB 10/18/2024 09:42:47'!
test10APortfolioCannotAddAnAccountAlreadyIncludedInAPreviouslyAddedPortfolio

	| fatherPortfolio childPortfolio |

	childPortfolio := Portfolio with: accountOne.
	fatherPortfolio := Portfolio with: childPortfolio.

	self should: [fatherPortfolio addAccount: accountOne	] 
		raise: Error 
		withExceptionDo: [:anError | self assert: (anError messageText = (Portfolio cannotAddAccountErrorMessage))]! !

!PortfolioTest methodsFor: 'valid portfolio' stamp: 'AB 10/18/2024 07:40:59'!
test11APortfolioCannotIncludeIttself

	| portfolio |

	portfolio := Portfolio new.
	
	self 
		should: [portfolio addAccount: portfolio] 
		raise: Error 
		withExceptionDo: [:anError | self assert: (anError messageText = (Portfolio cannotAddAccountErrorMessage))]! !

!PortfolioTest methodsFor: 'valid portfolio' stamp: 'AB 10/18/2024 09:43:37'!
test12CannotAddAnAccountToAPortfolioWhenTheLatterIsAlreadyAChildOfAnotherParentPortfolioThatHadSaidAccount

	| fatherPortfolio childPortfolio  |
	
	childPortfolio := Portfolio new.
	fatherPortfolio := Portfolio with: childPortfolio with: accountOne.

	self should: [childPortfolio addAccount: accountOne] 
		raise: Error 
		withExceptionDo: [:anError | self assert: (anError messageText = (Portfolio cannotAddAccountErrorMessage))]! !

!PortfolioTest methodsFor: 'valid portfolio' stamp: 'AB 10/18/2024 09:44:29'!
test13CannotAddAPortfolioToAnotherPortfolioIfTheFirstIncludesAnAccountThatTheSecondAlreadyHas
	
	| portfolioOne portfolioTwo |

	portfolioOne := Portfolio with: accountOne.
	portfolioTwo := Portfolio with: accountOne.
	
	self 
		should: [portfolioOne addAccount: portfolioTwo		] 
		raise: Error 
		withExceptionDo: [:anError | self assert: (anError messageText = (Portfolio cannotAddAccountErrorMessage))]! !


!PortfolioTest methodsFor: 'setup' stamp: 'AB 10/18/2024 09:29:59'!
setUp
	
	emptyAccount := ReceptiveAccount new.
	
	accountOne := ReceptiveAccount new.
	transactionOne := Deposit register: 100 * peso on: accountOne.
	
	accountTwo := ReceptiveAccount new.
	transactionTwo := Deposit register: 200 * peso on: accountTwo.
	! !


!PortfolioTest methodsFor: 'main protocol testing' stamp: 'AB 10/18/2024 07:27:38'!
test01PortfolioHaveZeroAsBalanceWhenCreated

	self assert: (0 * peso) equals: (Portfolio new balance).! !

!PortfolioTest methodsFor: 'main protocol testing' stamp: 'AB 10/18/2024 09:38:27'!
test02PortfolioWithAnReceptiveAccountWithDepositIncreaseBalance

	| portfolio |

	portfolio := Portfolio with: accountOne.

	self assert: (100 * peso) equals: (portfolio balance).! !

!PortfolioTest methodsFor: 'main protocol testing' stamp: 'AB 10/18/2024 09:39:08'!
test03PortfolioCanHaveAnotherPortfolio

	| portfolio otherPortfolio |
	
	portfolio := Portfolio with: accountOne.
	
	otherPortfolio := Portfolio with: portfolio.

	self assert: (100 * peso) equals: (otherPortfolio balance).! !

!PortfolioTest methodsFor: 'main protocol testing' stamp: 'AB 10/18/2024 09:30:59'!
test04PortfolioDenyIfHaventRegisteredATransaction

	| portfolio |
	
	portfolio := Portfolio new.

	self deny: (portfolio hasRegistered: transactionOne)! !

!PortfolioTest methodsFor: 'main protocol testing' stamp: 'AB 10/18/2024 09:39:27'!
test05PortfolioWithAReceptiveAccountKnowsTransactions

	| portfolio |
	
	portfolio := Portfolio with: accountOne.

	self assert: (portfolio hasRegistered: transactionOne)! !

!PortfolioTest methodsFor: 'main protocol testing' stamp: 'AB 10/18/2024 07:32:11'!
test06AnEmptyPortfolioHaventTransactions

	| portfolio |
	
	portfolio := Portfolio new.

	self assert: (portfolio transactions) equals: (OrderedCollection new).! !

!PortfolioTest methodsFor: 'main protocol testing' stamp: 'AB 10/18/2024 09:39:46'!
test07CanGetTransactionsInPortfolioWithAReceptiveAccount

	| portfolio |
	
	portfolio := Portfolio with: accountOne.

	self assert: (accountOne transactions) equals: (portfolio transactions)! !

!PortfolioTest methodsFor: 'main protocol testing' stamp: 'AB 10/18/2024 09:37:38'!
test08CanGetTransactionsInPortfolioWithAPortfolio

	| portfolio otherPortfolio |
	
	portfolio := Portfolio with: accountOne.
	otherPortfolio := Portfolio with: accountTwo with: portfolio.

	self assert: (otherPortfolio transactions includes: transactionOne).
	self assert: (otherPortfolio transactions includes: transactionTwo).! !


!classDefinition: #ReceptiveAccountTest category: #'ServiciosFinancieros-Ejercicio'!
ServiciosFinancierosTest subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JS 4/30/2024 13:50:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: account transactions includes: deposit.
! !


!classDefinition: #TransferNetSummaryTest category: #'ServiciosFinancieros-Ejercicio'!
ServiciosFinancierosTest subclass: #TransferNetSummaryTest
	instanceVariableNames: 'senderAccount recepterAccount transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferNetSummaryTest methodsFor: 'setup' stamp: 'AB 10/18/2024 09:58:19'!
setUp

	senderAccount := ReceptiveAccount new.
	recepterAccount := ReceptiveAccount new.
	transfer := Transfer register: 100 * peso from: senderAccount to: recepterAccount.
	! !


!TransferNetSummaryTest methodsFor: 'tests' stamp: 'AB 10/18/2024 09:46:54'!
test01TransferNetSummaryForAccountWithoutTransactions

	| summary |
	
	summary := TransferNetSummary for: (ReceptiveAccount new).
	
	self assert: 'Neto de transferencia = 0 * pesos' equals: (summary).! !

!TransferNetSummaryTest methodsFor: 'tests' stamp: 'AB 10/18/2024 09:58:02'!
test02TransferNetSummaryForSender

	| summary |
	
	summary := TransferNetSummary for: senderAccount.
	
	self assert: 'Neto de transferencia = -100 * pesos' equals: (summary).! !

!TransferNetSummaryTest methodsFor: 'tests' stamp: 'AB 10/18/2024 09:58:19'!
test03TransferNetSummaryForReciver

	| summary |
	
	summary := TransferNetSummary for: recepterAccount.
	
	self assert: 'Neto de transferencia = 100 * pesos' equals: (summary).! !

!TransferNetSummaryTest methodsFor: 'tests' stamp: 'AB 10/18/2024 07:47:10'!
test04TryGetTransferNetSummaryWithAPortfolioThrowAnError

	self
		should: [TransferNetSummary for: (Portfolio new)]
		raise: Error
		withExceptionDo: [:anError |
			self assert: (anError messageText = TransferNetSummary cannotCreateAnAccountSummaryWithPortfolioErrorMessage)	
		]! !


!classDefinition: #TransferTest category: #'ServiciosFinancieros-Ejercicio'!
ServiciosFinancierosTest subclass: #TransferTest
	instanceVariableNames: 'senderAccount recepterAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTest methodsFor: 'setup' stamp: 'AB 10/9/2024 10:26:27'!
setUp

	senderAccount := ReceptiveAccount new.
	recepterAccount := ReceptiveAccount new.! !


!TransferTest methodsFor: 'tests' stamp: 'AB 10/18/2024 07:48:30'!
test01ATransferChangeBalanceForBothAccounts

	Transfer register: 100 * peso from: senderAccount to: recepterAccount.
	
	self assert: (-100 * peso) equals: (senderAccount balance).
	self assert: (100 * peso) equals: (recepterAccount balance).! !

!TransferTest methodsFor: 'tests' stamp: 'AB 10/18/2024 07:48:47'!
test02ATransferKnowsYourValue

	| transfer |

	transfer := Transfer register: 100 * peso from: senderAccount to: recepterAccount.
	
	self assert: (100 * peso) equals: (transfer value).! !

!TransferTest methodsFor: 'tests' stamp: 'AB 10/18/2024 07:49:25'!
test03BothAccountHasRegisteredTransferLegs

	| transfer |
	
	transfer := Transfer register: 100 * peso from: senderAccount to: recepterAccount.
	
	self assert: (senderAccount hasRegistered: (transfer withdrawLeg)).
	self assert: (recepterAccount hasRegistered: (transfer depositLeg)).! !

!TransferTest methodsFor: 'tests' stamp: 'AB 10/18/2024 07:49:47'!
test04DepositLegKnowsCounterPart

	| transfer |
	
	transfer := Transfer register: 100 * peso from: senderAccount to: recepterAccount.
	
	self assert: (transfer withdrawLeg) equals: (transfer depositLeg counterPart).! !

!TransferTest methodsFor: 'tests' stamp: 'AB 10/18/2024 07:50:04'!
test05WithdrawKnowsCounterPart

	| transfer |
	
	transfer := Transfer register: 100 * peso from: senderAccount to: recepterAccount.
	
	self assert: (transfer depositLeg) equals: (transfer withdrawLeg counterPart).! !

!TransferTest methodsFor: 'tests' stamp: 'AB 10/18/2024 07:50:51'!
test06CannotCreateTransferWithNonPositiveValue

	self 
		should: [Transfer register: 0 * peso from: senderAccount to: recepterAccount]
		raise: Error
		withExceptionDo: [:anError |
			self assert: (anError messageText = (Transfer transferMustBePositiveMessageError)	)
		].! !

!TransferTest methodsFor: 'tests' stamp: 'AB 10/18/2024 07:51:25'!
test07CannotTransferItself
	
	self 
		should: [Transfer register: 100 * peso from: senderAccount to: senderAccount]
		raise: Error
		withExceptionDo: [:anError |
			self assert: (anError messageText = (Transfer cannotTransferYourselfMessageError)	)
		].! !


!classDefinition: #Account category: #'ServiciosFinancieros-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Account methodsFor: 'initialization' stamp: 'AB 10/17/2024 21:14:10'!
hasAccount: anAccount

	self subclassResponsibility! !

!Account methodsFor: 'initialization' stamp: 'AB 10/9/2024 12:05:42'!
initialize

	self subclassResponsibility! !


!Account methodsFor: 'main protocol' stamp: 'AB 10/9/2024 12:04:07'!
balance 

	self subclassResponsibility! !

!Account methodsFor: 'main protocol' stamp: 'AB 10/18/2024 09:59:40'!
hasRegistered: aTransaction 
	
	self subclassResponsibility! !

!Account methodsFor: 'main protocol' stamp: 'AB 10/9/2024 12:03:42'!
transactions

	self subclassResponsibility! !


!classDefinition: #Portfolio category: #'ServiciosFinancieros-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents account name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'main protocol' stamp: 'AB 10/17/2024 22:04:28'!
balance
	
	^accounts 
		inject: 0
		into: [:aCurrentBalance :anAccount | aCurrentBalance + (anAccount balance) ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'AB 10/18/2024 09:59:53'!
hasRegistered: aTransaction 
	
	^accounts anySatisfy: [:anAccount | anAccount hasRegistered: aTransaction]! !

!Portfolio methodsFor: 'main protocol' stamp: 'AB 10/9/2024 11:58:37'!
transactions
	^accounts
		inject: OrderedCollection new
		into: [:aCollection :anAccount | aCollection addAll: (anAccount transactions). aCollection]! !


!Portfolio methodsFor: 'private' stamp: 'AB 10/18/2024 08:54:23'!
addAccount: anAccount 
	
	self canAddAccount: anAccount.
	anAccount addParent: self.
	accounts add: anAccount.! !

!Portfolio methodsFor: 'private' stamp: 'AB 10/17/2024 21:27:09'!
addParent: aPortfolio 
	
	parents add: aPortfolio.! !

!Portfolio methodsFor: 'private' stamp: 'AB 10/18/2024 08:55:33'!
canAddAccount: anAccountToAdd

	^((self = anAccountToAdd) or: ((self parentsWithSelf) anySatisfy: [:aParent | (aParent hasAccount: anAccountToAdd)]))
		ifTrue: [^self error: (Portfolio cannotAddAccountErrorMessage)].		! !

!Portfolio methodsFor: 'private' stamp: 'AB 10/18/2024 08:53:34'!
hasAccount: anAccount
	
	^(accounts anySatisfy: [:aRegisterdAccount | (aRegisterdAccount hasAccount: anAccount) or: (anAccount hasAccount: aRegisterdAccount)])! !

!Portfolio methodsFor: 'private' stamp: 'AB 10/18/2024 08:55:33'!
parentsWithSelf
	
	| parentsWithSelf |
	
	parentsWithSelf := parents.
	parentsWithSelf add: self.
	
	^parentsWithSelf! !


!Portfolio methodsFor: 'initialization' stamp: 'AB 10/17/2024 21:27:42'!
initialize
	
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'errors' stamp: 'AB 10/17/2024 21:09:01'!
cannotAddAccountErrorMessage

	^'Cannot add account'! !


!Portfolio class methodsFor: 'instance creation' stamp: 'AB 10/18/2024 09:36:27'!
with: anAccount 
	
	^self new initialize addAccount: anAccount.
! !

!Portfolio class methodsFor: 'instance creation' stamp: 'AB 10/18/2024 09:37:29'!
with: anAccount with: anotherAccount
	^(self new initialize addAccount: anAccount) addAccount: anotherAccount! !


!classDefinition: #ReceptiveAccount category: #'ServiciosFinancieros-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions parents name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'AB 10/17/2024 21:14:36'!
hasAccount: anAccount
	
	^(self = anAccount)! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'AB 10/17/2024 21:28:45'!
initialize

	transactions := OrderedCollection new.
	parents := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'private' stamp: 'AB 10/17/2024 21:28:31'!
addParent: aPortfolio 

	parents add: aPortfolio.! !

!ReceptiveAccount methodsFor: 'private' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'AB 10/8/2024 23:27:10'!
balance
	
	^transactions 
		inject: 0 * peso
		into: [:aCurrentBalance :aTransaction| aTransaction sumForBalance: aCurrentBalance]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!classDefinition: #AccountTransaction category: #'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'AB 10/8/2024 23:27:33'!
sumForBalance: aCurrentBalance

	self subclassResponsibility.! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'visitor' stamp: 'AB 10/18/2024 07:59:17'!
accept: aVisitor 

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'accessing' stamp: 'AB 10/8/2024 23:27:54'!
sumForBalance: aCurrentBalance 
	
	^aCurrentBalance + value.! !

!Deposit methodsFor: 'accessing' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'visitor' stamp: 'AB 10/18/2024 07:59:54'!
accept: aVisitor 

	aVisitor visitDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLeg category: #'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferLeg methodsFor: 'accessing' stamp: 'AB 10/9/2024 10:14:56'!
counterPart

	self subclassResponsibility.! !

!TransferLeg methodsFor: 'accessing' stamp: 'AB 10/18/2024 08:04:39'!
value
	
	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'AB 10/9/2024 10:15:15'!
initializeFor: aTransfer 

	transfer := aTransfer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: #'ServiciosFinancieros-Ejercicio'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'AB 10/9/2024 10:16:15'!
by: aTransfer on: anAccount 

	| transaction |
	
	transaction := self for: aTransfer.
	anAccount register: transaction.
	
	^transaction.! !

!TransferLeg class methodsFor: 'instance creation' stamp: 'AB 10/9/2024 10:16:10'!
for: aValue 
	
	^self new initializeFor: aValue.! !


!classDefinition: #DepositLeg category: #'ServiciosFinancieros-Ejercicio'!
TransferLeg subclass: #DepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!DepositLeg methodsFor: 'accessing' stamp: 'AB 10/9/2024 10:13:24'!
counterPart
	
	^transfer withdrawLeg.! !

!DepositLeg methodsFor: 'accessing' stamp: 'AB 10/9/2024 10:13:24'!
sumForBalance: aCurrentBalance 
	
	^aCurrentBalance + (transfer value).! !


!DepositLeg methodsFor: 'visitor' stamp: 'AB 10/18/2024 08:05:17'!
accept: aVisitor

	aVisitor visitDepositLeg: self! !


!classDefinition: #WithdrawLeg category: #'ServiciosFinancieros-Ejercicio'!
TransferLeg subclass: #WithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!WithdrawLeg methodsFor: 'accessing' stamp: 'AB 10/9/2024 10:13:30'!
counterPart
	
	^transfer depositLeg.! !

!WithdrawLeg methodsFor: 'accessing' stamp: 'AB 10/9/2024 10:13:30'!
sumForBalance: aCurrentBalance 

	^aCurrentBalance - (transfer value).! !


!WithdrawLeg methodsFor: 'visitor' stamp: 'AB 10/18/2024 08:02:48'!
accept: aVisitor

	aVisitor visitWithdrawLeg: self.! !


!classDefinition: #Withdraw category: #'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'accessing' stamp: 'AB 10/8/2024 23:28:07'!
sumForBalance: aCurrentBalance 
	
	^aCurrentBalance - value.! !

!Withdraw methodsFor: 'accessing' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'visitor' stamp: 'AB 10/18/2024 08:01:21'!
accept: aVisitor

	aVisitor visitWithdraw: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #ReportSummary category: #'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReportSummary
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReportSummary methodsFor: 'visitor' stamp: 'AB 10/18/2024 08:06:15'!
visitDeposit: aDeposit
	
	self subclassResponsibility! !

!ReportSummary methodsFor: 'visitor' stamp: 'AB 10/18/2024 08:05:31'!
visitDepositLeg: aDepositLeg 

	self subclassResponsibility! !

!ReportSummary methodsFor: 'visitor' stamp: 'AB 10/18/2024 08:01:37'!
visitWithdraw: aWithdraw

	self subclassResponsibility! !

!ReportSummary methodsFor: 'visitor' stamp: 'AB 10/18/2024 08:03:02'!
visitWithdrawLeg: aWithdrawLeg 

	self subclassResponsibility! !


!ReportSummary methodsFor: 'private' stamp: 'AB 10/18/2024 08:25:05'!
generateFor: anAccount

	self subclassResponsibility! !


!ReportSummary methodsFor: 'initialization' stamp: 'AB 10/18/2024 08:25:32'!
initializeFor: anAccount 

	self subclassResponsibility! !


!classDefinition: #AccountSummary category: #'ServiciosFinancieros-Ejercicio'!
ReportSummary subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountSummary methodsFor: 'visitor' stamp: 'AB 10/18/2024 08:07:33'!
visitDeposit: aDeposit
	
	summary add: ('Depósito por ', aDeposit value asString)! !

!AccountSummary methodsFor: 'visitor' stamp: 'AB 10/18/2024 08:07:33'!
visitDepositLeg: aDepositLeg

	summary add: ('Entrada por transferencia de ', aDepositLeg value asString)! !

!AccountSummary methodsFor: 'visitor' stamp: 'AB 10/18/2024 08:07:33'!
visitWithdraw: aWithdraw 

	summary add: ('Extracción por ', aWithdraw value asString)! !

!AccountSummary methodsFor: 'visitor' stamp: 'AB 10/18/2024 08:07:33'!
visitWithdrawLeg: aWithdrawLeg 

	summary add: ('Salida por transferencia de ', aWithdrawLeg value asString)! !


!AccountSummary methodsFor: 'initialization' stamp: 'AB 10/18/2024 08:26:02'!
initializeFor: anAccount

	summary := OrderedCollection new.
	^self generateFor: anAccount! !


!AccountSummary methodsFor: 'private' stamp: 'AB 10/18/2024 08:26:10'!
generateFor: anAccount 

	anAccount transactions do: [:anTransaction | 
		anTransaction accept: self.		
	].
	summary add: (('Balance = ', anAccount balance asString)).
	^summary! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: #'ServiciosFinancieros-Ejercicio'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'AB 10/17/2024 20:35:13'!
for: anAccount 
	(anAccount isKindOf: Portfolio) ifTrue: [^self error: (self cannotCreateAnAccountSummaryWithPortfolioErrorMessage)].
	^self new initializeFor: anAccount ! !


!AccountSummary class methodsFor: 'errors' stamp: 'AB 10/17/2024 20:34:39'!
cannotCreateAnAccountSummaryWithPortfolioErrorMessage
	
	^'Cannot create an account summary with portfolio'! !


!classDefinition: #TransferNetSummary category: #'ServiciosFinancieros-Ejercicio'!
ReportSummary subclass: #TransferNetSummary
	instanceVariableNames: 'transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferNetSummary methodsFor: 'initialization' stamp: 'AB 10/18/2024 08:28:46'!
initializeFor: anAccount 

	transferNet := 0 * peso.
	^self generateFor: anAccount.! !


!TransferNetSummary methodsFor: 'visitor' stamp: 'AB 10/18/2024 08:12:23'!
visitDepositLeg: aDepositLeg 

	transferNet := aDepositLeg sumForBalance: transferNet.! !

!TransferNetSummary methodsFor: 'visitor' stamp: 'AB 10/18/2024 08:12:23'!
visitWithdrawLeg: aWithdrawLeg 

	transferNet := aWithdrawLeg sumForBalance: transferNet.! !


!TransferNetSummary methodsFor: 'private' stamp: 'AB 10/18/2024 08:23:49'!
generateFor: anAccount 

	anAccount transactions do: [:anTransaction | 
		anTransaction accept: self.
	].

	^('Neto de transferencia = ', transferNet asString)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNetSummary class' category: #'ServiciosFinancieros-Ejercicio'!
TransferNetSummary class
	instanceVariableNames: ''!

!TransferNetSummary class methodsFor: 'instance creation' stamp: 'AB 10/17/2024 21:00:36'!
for: anAccount 

	(anAccount isKindOf: Portfolio) ifTrue: [^self error: (self cannotCreateAnAccountSummaryWithPortfolioErrorMessage)].
	^self new initializeFor: anAccount ! !


!TransferNetSummary class methodsFor: 'errors' stamp: 'AB 10/17/2024 21:01:04'!
cannotCreateAnAccountSummaryWithPortfolioErrorMessage
	
	^'Cannot create an account summary with portfolio'! !


!classDefinition: #Transfer category: #'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'initialization' stamp: 'AB 10/9/2024 09:02:53'!
initializeWith: aValue from: aWithdrawLeg to: aDepositLeg 
	
	value := aValue.
	withdrawLeg := aWithdrawLeg.
	depositLeg := aDepositLeg.! !


!Transfer methodsFor: 'accessing' stamp: 'AB 10/9/2024 09:02:53'!
depositLeg
	
	^depositLeg.! !

!Transfer methodsFor: 'accessing' stamp: 'AB 10/9/2024 09:02:17'!
value

	^value.! !

!Transfer methodsFor: 'accessing' stamp: 'AB 10/9/2024 09:02:45'!
withdrawLeg
	
	^withdrawLeg.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'AB 10/9/2024 10:28:52'!
register: aValue from: senderAccount to: recepterAccount 
	
	| withdrawLeg depositLeg transfer |
	
	(aValue > 0) ifFalse: [^self error: (self transferMustBePositiveMessageError)].
	(senderAccount = recepterAccount) ifTrue: [^self error: (self cannotTransferYourselfMessageError)].
	
	transfer := self new.
	
	withdrawLeg := WithdrawLeg by: transfer on: senderAccount.
	depositLeg := DepositLeg by: transfer on: recepterAccount.
	
	^transfer initializeWith: aValue from: withdrawLeg to: depositLeg ! !


!Transfer class methodsFor: 'error' stamp: 'AB 10/9/2024 10:28:31'!
cannotTransferYourselfMessageError

	^'Cannot transfer yourself'! !

!Transfer class methodsFor: 'error' stamp: 'AB 10/9/2024 10:27:30'!
transferMustBePositiveMessageError

	^'Transfer must be positive'! !
