.data
	
	string_1:		.asciiz  "Vetor ordenado:"
	var1:			.asciiz  "["
	var2:			.asciiz  "]"
	vetor:			.space 20
	
.text

	# $s0 => i;
    # $s1 => contador de i;
    # $s4 => auxiliar;
    # $s5 => condicao de parada;
    # $s6 => recebe valores do vetor para ser printado;
    # $t0 => j;
    # $t3 => contador de j;
    # $t1 => contador global;

	li $s0, 0				#variavel i inicia-se em 0
	li $s1, 5				#contador de i inicia-se em 5
	
main:

	bne $s1, $zero, insert	#se $s1 != 0, entao pula para lable "insert"
	
	li $s0, 0				#var i = 0
	li $s1, 5				#contador de i = 5
	li $s4, 0				#aux = 0
	li $s5, 0				#condicao de parada
	li $t0, 0				#var j = 0
	li $t3, 0				#contador de j = 0
	
	j ordena				#faz o jump e pula para o ordena
	
insert:

	li $v0, 5				#chamada de sistema para fazer o scanf				
	syscall
	
	sw $v0, vetor($s0)		#salva o valor recebido pelo usuário no vetor na posicao $s0
	
	add $s0, $s0, 4			#i += 4
	sub $s1, $s1, 1			#contador--
	
	j main					#faz o jump e volta pra main
	
ordena:		#primeiro for -> for(i = 0 ; i < 5 ; i++)

	beq $s5, $s1, exit1		#se $s5(condicao de parada) = $s1(contador de i), enquanto i < 5
	lw $s2, vetor($s0)		#registrador $s2 recebe o valor do vetor na posicao i
	
ordena2:	#segundo for -> for(j = 0 ; j < 5 ; j++)

	beq $s5, $t3, next		#se $s5(condicao de parada) = $t3(contador de i), enquanto j < 5
	lw $s3, vetor($t0)		#registrador $s3 recebe o valor do vetor na posicao j
	
	bgt $s3, $s2, aux		#se $s3 > $s2, entao pula para a funcao aux
	
fim_aux:

	add $t0, $t0, 4			#atribui j = j + 4
	add $t3, $t3, 1			#atribui j++
	j ordena2
	
aux:

	add $s4, $s2, $zero		#aux = vetor[i]
	add $s2, $s3, $zero		#vetor[i] = vetor[j]
	add $s3, $s4, $zero		#vetor[j] = aux
	
	sw $s2, vetor($s0)		#armazena no vetor[i] o valor que esta contido no registrador $s2
	sw $s3, vetor($t0)		#armazena no vetor[j] o valor que esta contido no registrador $s3
	
	j fim_aux
	
next:
    
	add $s0, $s0, 4			#i += 4
	add $s5, $s5, 1			#i++
	
	li $t0, 0				#j = 0
	li $t3, 0 				#contador de j = 0
	
	j ordena

exit1:		#reseta os valores de i e contador de i para printar o vetor ordenado

	li $s0, 0				#i = 0
	li $s1, 5				#contador de i = 0
	li $t1, 0				#contador global = 0
	li $s6, 0				#variável que recebe os valores do vetor para serem printados
	
	li $v0, 4
	la $a0, string_1
	syscall
	
	li $v0, 4
	la $a0, var1
	syscall
	
exit2:

	beq $t1, $s1, fim		#quando $s2 = $s1, entao pula para o fim
	lw $s6, vetor($s0)		#o valor do vetor da posicao $s0 vai para $s6
	li $v0, 1				#faz o printf
	move $a0, $s6			#move o valor armazenado em $s6 para o $a0, para que imprima o valor
	syscall
	add $s0, $s0, 4			#i = i + 4
	add $t1, $t1, 1			#contador global++
	
	j exit2
	
fim:

	li $v0, 4
	la $a0, var2
	syscall
