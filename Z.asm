.data
 array:         .space  400 #array


 in_name:
   .asciiz "\nInsert name: "
 in_date:
   .asciiz "\nInsert date (mmdd): "
 appt:
   .asciiz "\nList: "
 spaz:      .asciiz " "

 .text
 main:      

    la  $s0, array      #load array in s0
    addi    $t0, $zero, 0       #t0=0 counter
    addi    $s1, $zero, 0       #s1=0 array size counter
            j    Input

 Input:
        li  $v0, 4           
    la  $a0, in_date
    syscall             #ask date 
    li  $v0, 5          
    syscall             #read date
    add     $t1, $zero, $t0                #offset in t1
    add     $t1, $t1, $t1           #t1*2
    add     $t1, $t1, $t1           #t1*4
    add     $s2, $t1, $s0           #array with offset in s2
    sw  $v0, 0($s2)     #save date
    addi    $t0, $t0, 1     #t0++
    addi    $s1, $s1, 1     #array size counter +1
    li      $v0, 4
    la      $a0, in_name          
    syscall                         #ask name
        li      $a0, 4                 
    li      $v0, 9
    syscall                         #space for new word (4bytes)
            la      $a0, array
            li      $a1, 4
    li      $v0, 8
    syscall                         #read name
    add     $t1, $zero, $t0                #offset in t1
    add     $t1, $t1, $t1           #t1*2
    add     $t1, $t1, $t1           #t1*4
    add     $s2, $t1, $s0           #array with offset in s2
    sw  $v0, 0($s2)     #save name
    addi    $s1, $s1, 1     #array size counter +1
    addi    $t0, $t0, 1     #t0++
    beq $s1, 10, print          #if array size=10 go to print
    j   Input               #start over until s1=10



  print:
    la  $a0, appt           
    li  $v0, 4          
    syscall             #print list
    addi    $t0, $zero, 0       #t0=0 counter

res:
    add     $t1, $zero, $t0                #offset in t1
    add     $t1, $t1, $t1           #t1*2
    add     $t1, $t1, $t1           #t1*4
    add     $s2, $t1, $s0           #array with offset in s2
    lw  $a0, 0($s2)     #load date
    li  $v0, 1          
    syscall             #print data
    addi    $t0, $t0, 1             #t0++
    la  $a0, spaz               #load space
    li  $v0, 4          
    syscall             #print space
    add     $t1, $zero, $t0                #offset in t1
    add     $t1, $t1, $t1           #t1*2
    add     $t1, $t1, $t1           #t1*4
    add     $s2, $t1, $s0           #array with offset in s2
    lw  $a0, 0($s2)     #load name
    li      $v0, 4
    syscall                         #print name
    addi    $t0, $t0, 1             #t0++
    la      $a0, spaz             
    syscall                         #print space
    addi    $t0, $t0, 1     #t0++ counter
    bne $t0, $s1, res           #start over until t0=s1
    j   end         
 end:
    li  $v0, 10         
    syscall             #the end