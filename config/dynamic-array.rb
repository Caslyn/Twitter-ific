# Important Methods with Array

# O(1)
[]
[]=
push # can be O(n) / generally O(1)  time
pop # O(1)

# O(n) - slower as the array gets bigger
shift, unshift

# Memory (RAM) & Pointers (Memory Address)

# Think of memory as a series of cells, each of which can hold 64 bits of data.
# What can go into a cell? Integer, Double Point #, 8 (8-bit) ASCII characters ("a" = 97 = 01100001)

# CPU Instructions:
# load the number at 104, load the number at 136, add them and store the result at 144
# ADD i & j (ptr1, ptr2, ptr3) == Add i & j (104, 136, 144)

# Every cell has an address : (80, 88, 96, 104, 112...)
# 8 bits = 1 byte / 8 bytes = 64 bits = "word size"

# The cell doesn't know itself what its address is, only the RAM controller 
# assigns what the cell is.  It quickly accesses any point in the memory. 

# Takeaway: all data in the computer is stored as a series of bits.

# Getting Back to Arrays...

# Arrays are sequences of data.

# arr variable points to a number (like 88) which references where the object lives
arr = Array.new(5) # reserves memory by the computer for storage of your array contents
# arr2 variable points to the same number as arr (88) and thereby points to the same object
arr2 = arr

[markov, curie, gizmo, breakfast]
arr[0] = markov # arr[0] refers to the address where the object markov lives

# in otherwords, everywhere we are passing around pointers to objects (to their memory addresses),
# not the objects themselves

arr[0] = Cat.new() # allocate space to store the cat object, 
# then assign arr[0] to the memory address of that newly created object

m2 = arr[1] # behind the scenes returns '800' -> the address of where the object lives.

# arr starts at 88, and you want the item that lives at position 1
# calculates 88+(8x1) to find position at 1 (8x1 gives you the offset)
# then set m2 to (loading) memory cell 96

# if you had an array of 500 elements
arr[499] #=> 88 + 8 x 499 = x #=> load & return x (memory cell address of object)
arr[0] #=> 88 + (8 x 0)

arr[1] = markov #=> store at cell (88 + (8 x 1)) whatever address markov is at (800)

# so no matter how big the numbers are, it takes the same amount of time to multiply / access them









