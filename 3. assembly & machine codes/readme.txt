1. We use hand calculation to transfer assembly code to machine code instead of a compiler.

2. Since today professor told us that shl is not rotate but shift.

we can change our code like 

shl $1,$1,1(that means rotate)

to 

add $2,$1,$0
shr $2,$2,31
shl $1,$1,1
add $1,$1,$2

we know the mistake we made and the method to fix this.