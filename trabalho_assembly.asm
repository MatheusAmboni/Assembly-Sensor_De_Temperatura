;Aluno: Matheus Costa Amboni
;Matricula: 19201492

;programa que simula uma caldeira de arroz que precisa estar numa temperatura que esteja dentro
;de dois valores

;ordem: inicia programa apertando enter, comeca com 90 graus (valor minimo), entra na funcao aquece, apertando seta
;direita, durante o aquecimento havera um incremento de temperatura ate o valor maximo (100), ao chegar em 100
;inicia-se a funcao esfria pelo botao: seta esquerda. Uma vez rodado o programa aperta no botao backspace pra reiniciar
;o sistema logo apos a temperatura ter regredido ao valor inicial minimo.

      .data DDh   ;dados apartir do endereco de memoria DDh
	DB 77h, 44h, 3Eh, 6Eh, 4Dh, 6Bh, 7Bh, 46h, 7Fh, 4Fh		

.org 1000h

;funcao inicia
inicia:

      in 00h      ;le o conteudo da porta de entrada
      cpi 0Dh     ;compara 0Dh com acumulador
      jnz inicia  ;salta pra inicia se flag não estiver setado

      mvi B, 00h 
      mvi C, E6h
      mvi D, 00h
      mvi E, DDh
      LDAX B      ;carrega o registrador 
      out 06h     ;retorna na porta 06h
      ldax D   
      out 07h

aquece:     ;funcao aquece

      in 00h
      cpi 10h     ;aperta seta pra direita 
      jnz aquece

loop: ;loop pro programa nao parar

inc:  ;funcao incrementa 

 	inx D    ;incrementa em um o acumulador D
	ldax D    ;
	out 7d   
      cpi 4Fh   
     	jnz inc

      mvi B, 00h
      mvi C, DEh
      mvi D, 00h
      mvi E, DDh
      ldax B
      out 05h
      ldax D   
      out 06h
      out 07h

esfria:

      in 00h
      cpi 11h 
      jnz esfria

      mvi B, 00h
      mvi C, DCh
      ldax B
      out 05h
      mvi B, 00h
      mvi C, E6h
      mvi D, 00h
      mvi E, E6h
      ldax B
      out 06h
      ldax D   
      out 07h

dec: 
 	dcx D     
	ldax D    
	out 7d    
      cpi 77h   
     	jnz dec

restart:

      in 00h
      cpi 08h
      jnz restart

jmp loop