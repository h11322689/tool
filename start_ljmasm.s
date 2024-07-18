/**
 * Start.S : Entry point for EGP OpenGL kernel programs
 */

/**
 * t0 : base address of attribute configuration table
 * t1 : base address of the attribute default table
 * t2 : attribute count
 * t3 : operation index
 * a0 : Offset of current attribute
 * a1 : Address of current attribute to be loaded
 * a2 : stride of current attribute
 * a3 : size of current attribute
 * a4 : index of current attribute
 */

  .text
  .global _start
  .type   _start, @function
_start:
  # Get the base address of the current thread's attribute configuration table.
  addi t0, prgbase, 0
  # Get the base address of the attribute default table.
  addi t1, t0, -0x100
  # Load all attribute defaults into the input registers.
  ldg input0, t1, 32
  # Get the address of the index array address in the property configuration table.
  addi t1, t0, 0x4
  # Get the indices address of the index array.
  ldg t2, t1, 1
  # Configure the new index value to the r1 register, overwriting the r1 register
  # value used to fetch the index in the previous step.
  addi t3, zero, 0
  sne.s t3, t2, t3
  mask	zero, t3, %pcrel_lo(.LBB0_2)
  setpc	a0, %hi(.LBB0_1)
  goto	ra, a0, %lo(.LBB0_1)
.LBB0_1:
  # Get the index cache address of index+indices.
  add.u t3, bsr, t2
  # Get the updated index value.
  ldg bsr, t3, 1
  setpc	a0, %hi(.LBB0_2)
  goto	ra, a0, %lo(.LBB0_2)
.LBB0_2:
  unmask zero, zero, 0
  # Get the value of the attribute count, after that all registers can only be
  # used from t3.
  ldg t2, t0, 1
  # Determine if the attribute count value is 0 to jump out of the loop.
  sne.s t3, t2, zero
  mask zero, t3, %pcrel_lo(.LBB0_4)
  setpc a0, %hi(.loop)
  # Initialize the attribute number for the current loop
  addi t3, zero, 0
  goto ra, a0, %lo(.loop)
.loop:
  # Determine the offset overlay based on the number of the current processing
  # attribute.
  muli a0, t3, 12
  # Get pointer value.
  addi a1, t0, 20
  add.u a1, a1, a0
  ldg a1, a1, 1
  # Get stride value.
  addi a2, t0, 16
  add.u a2, a2, a0
  ldg a2, a2, 1
  # Get the start address of the load data.
  mul.u a2, a2, bsr
  add.u a1, a1, a2
  # Get size value.
  addi a3, t0, 13
  add.u a3, a3, a0
  ldg a3, a3, 1
  # Get index value.
  addi a4, t0, 12
  add.u a4, a4, a0
  ldg a4, a4, 1
  # Jump to the function that load value of an attribute into the input register.
  setpc a0, %hi(.load_attribute)
  goto ra, a0, %lo(.load_attribute)
  # Attribute count -1, used to determine whether to end the loop or not.
  addi t2, t2, -1
  # Update the attribute number for the next loop processing.
  addi t3, t3, 1
  # Determine if the attribute count value is 0 to jump out of the loop.
  sne.s t4, t2, zero
  mask zero, t4,%pcrel_lo(.LBB0_4)
  setpc a0, %hi(.loop)
  goto ra, a0, %lo(.loop)

  # Get the real attribute number based on the index of the valid attribute, if
  # index == 0, go to LBB0_13, if index ! = 0, enter LBB0_12, continue to judge
  # index == 1, and so on, until the corresponding index is found.At this point
  # it is determined from which input register the attribute values are stored.
.load_attribute:
  mov t6, input0, 0
  muli t7, a4, 4
  add.u t6, t6, t7 # t6 is which register to write

  # size = 1
  addi t8, zero, 1
  seq.s t8, t8, a3
  mask zero, t8, %pcrel_lo(.load2)
  setpc a0, %hi(.load1)
  goto zero, a0, %lo(.load1)
.load1:
  pldg t6, a1, 1
  setpc a0, %hi(.load2)
  goto zero, a0, %lo(.load2)
.load2:
  unmask zero, zero, 0
  # size = 2
  addi t8, zero, 2
  seq.s t8, t8, a3
  mask zero, t8, %pcrel_lo(.load4)
  setpc a0, %hi(.load3)
  goto zero, a0, %lo(.load3)
.load3:
  pldg t6, a1, 2
  setpc a0, %hi(.load4)
  goto zero, a0, %lo(.load4)
.load4:
  unmask zero, zero, 0
  # size = 3
  addi t8, zero, 3
  seq.s t8, t8, a3
  mask zero, t8, %pcrel_lo(.load6)
  setpc a0, %hi(.load5)
  goto zero, a0, %lo(.load5)
.load5:
  pldg t6, a1, 3
  setpc a0, %hi(.load6)
  goto zero, a0, %lo(.load6)
.load6:
  unmask zero, zero, 0
  # size = 4
  addi t8, zero, 4
  seq.s t8, t8, a3
  mask zero, t8, %pcrel_lo(.load8)
  setpc a0, %hi(.load7)
  goto zero, a0, %lo(.load7)
.load7:
  pldg t6, a1, 4
  setpc a0, %hi(.load8)
  goto zero, a0, %lo(.load8)
.load8:
  unmask zero, zero, 0

  # Jump back to the instruction pc+1 that jumped into this function.
  goto zero, ra, 0

# out of loop
.LBB0_4:
unmask	zero, zero, 0
# Get thread id
id t0, t0, 0
# Update the base address of the corresponding thread's sp stack space.
muli t1, t0, 512
add.u sp, sp, t1

# # Jump to vert_main function address
setpc t0, %hi(vert_main)
goto  ra, t0, %lo(vert_main)

