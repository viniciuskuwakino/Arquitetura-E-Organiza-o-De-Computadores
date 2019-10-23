	.data # Itens subsequentes são armazenados no segmento de dados, exe.: variáveis globais, arrays
	      # Neste código o segmento de dados não é utilizado.
	.text # Itens subsequentes são colocados no segmento de texto.
	.globl main # Declara que o rótulo main é global e pode ser referênciado a partir de outros arquivos

main:	add   $t1,$t2,$t3
	addi  $t1,$t2,-100
	addiu $t1,$t2,-100
	addu  $t1,$t2,$t3
	and   $t1,$t2,$t3
	andi  $t1,$t2,100
	beq   $t1,$t2,exit
	bne   $t1,$t2,exit
	j main
	jal teste
teste:	jr $ra
	lbu   $t1,-100($t2)
	lhu   $t1,-100($t2)
	ll    $t1,-100($t2)
	lui   $t1,100
	lw    $t1,-100($t2)
	nor   $t1,$t2,$t3
	or    $t1,$t2,$t3
	ori   $t1,$t2,100
	slt   $t1,$t2,$t3
	slti  $t1,$t2,-100
	sltiu $t1,$t2,-100
	sltu  $t1,$t2,$t3
	sll   $t1,$t2,10
	srl   $t1,$t2,10
	sb    $t1,-100($t2)
	sc    $t1,-100($t2)
	sh    $t1,-100($t2)
	sw    $t1,-100($t2)
	sub   $t1,$t2,$t3
	subu  $t1,$t2,$t3
exit:
	
