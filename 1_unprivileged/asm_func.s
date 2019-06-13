.syntax unified

.global	read_sp
read_sp:
	mov r0, sp
	bx	lr

.global	read_msp
read_msp:
	mrs r0, msp
	bx	lr

.global	read_psp
read_psp:
	mrs r0, psp
	bx	lr

.global	read_ctrl
read_ctrl:
	mrs r0, control
	bx	lr

.global	start_user
start_user:
	movs lr, r0	//Parameter 1 pass to lr
	msr psp, r1 //Parameter 2 pass psp special register

	mov r3, #0b11	//bit 1 and bit 0 are SPSEL and nPRIV bit.
	msr control, r3	//Because control register must pass value by register for operator filed bit.
	isb	//To ensure instruction fetch is corrtctness, isb instruction is needed to plug in after privileged or unprivileged operator.
	bx r0 //Jump to user_task function

.global	sw_priv
sw_priv:
	mov r0, #0
	msr control, r0
	isb //To ensure instruction frtch is correctness, isb instruction is needed to plug in after privileged or unprivileged operator.
	bx lr
