#!/usr/bin/python
# Broc Nickodemus
# CS 340 Homework 1
# running with python 2.7

def printNumberOfAmandas(transactionList):
    numAmandas = 0
    for transaction in transactionList:
        if (transaction.name.lower() == 'amanda'):
            numAmandas += 1
    print 'number of Amandas: ' + str(numAmandas)

def printAvgTransAmount(transactionList):
    totalAmount = 0
    numTransactions = 0
    for transaction in transactionList:
        # there may be an empty cell
        if (transaction.price == ''):
            transaction.price = 0
        totalAmount += float(transaction.price)
        numTransactions += 1
    avgTrans = totalAmount / numTransactions
    print 'average sales amount: ' + str(avgTrans)

def writeNewCSV(firstLine, transactionList):
    print 'generating "USA.csv"... ',
    CSVFile = open('USA.csv', 'a')
    CSVFile.write(firstLine)
    for transaction in transactionList:
        if (transaction.country == 'United States'):
            transaction.country = 'USA'
        line = transaction.date + ',' + transaction.product + ',' + str(transaction.price) + ',' \
        + transaction.payment + ',' + transaction.city + ',' + transaction.state + ',' \
        + transaction.country + ',' + transaction.name + ',' + transaction.account \
        + ',' + transaction.lastLogin + ',' + transaction.latitude + ',' + transaction.longitude
        if (line[-1:] != '\n'):  # add a newline if it doesnt exist
            line = line + '\n'
        CSVFile.write(line)
    CSVFile.close()
    print 'done'

class Transaction():
    def __init__ (self):
        self.date = ''
        self.product = ''
        self.price = 0
        self.payment = ''
        self.city = ''
        self.state = ''
        self.country = ''
        self.name = ''
        self.account = ''
        self.lastLogin = ''
        self.latitude = ''
        self.longitude = ''
    def __str__(self):
        s = ''
        s = self.date + ' ' + self.product + ' ' + self.price + ' ' + self.payment + ' ' \
        + self.city + ' ' + self.state + ' ' + self.country + ' ' + self.name + ' ' + self.account \
        + ' ' + self.lastLogin + ' ' + self.latitude + ' ' + self.longitude
        return s
    def __lt__(self, other): # less than attribute signifies to sort based on products
        return self.product < other.product

datafile = open('salesData01.csv', 'r+') # open in read and write mode
transactionList = []

firstLine = datafile.readline()
print firstLine.replace(',',' '),

for line in datafile:
    #print line
    words = line.split(',')
    transaction = Transaction()
    transaction.date = words[0]
    transaction.product = words[1]
    transaction.price = words[2]
    transaction.payment = words[3]
    transaction.city = words[4]
    transaction.state = words[5]
    transaction.country = words[6]
    transaction.name = words[7]
    transaction.account = words[8]
    transaction.lastLogin = words[9]
    transaction.latitude = words[10]
    transaction.longitude = words[11]
    # append the line (transaction)
    transactionList.append(transaction)

# sort the data by product
transactionList.sort()

# print all sales data
for transaction in transactionList:
    print transaction,
print '\n',

# print the number of Amandas in the database
printNumberOfAmandas(transactionList)

# print the average transaction amount
printAvgTransAmount(transactionList)

# writes a new CSV file to disk with USA instead of United States
writeNewCSV(firstLine,transactionList)
