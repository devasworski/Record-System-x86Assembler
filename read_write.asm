%include "/home/malware/asm/joey_lib_io_v6_release.asm"

; This file represents a possible sotution to save the user and computer arrays to a file, in order to not lose the saved date when the program finishes.
; This solution presents though is not elegante, as it needs 4 files, which would need to be saved in the save directory as the executable.
; A more elegant solution would be to save all the program data in one file
; or to save the 4 files in a directory hiden from the user

global main

section .data

error: db "error",0


user_file_location: db "users",0
computer_file_location: db "computers",0

user_index_file_location: db "users_index",0
computer_index_file_location: db "computers_index",0

;arrays
users: times 20000 db 0
computers: times 8500 db 0

;index
user_index: dq 0
computer_index: dq 0

section .bss
;File descriptors
user_file_descriptor: resq 1
computer_file_descriptor: resq 1
user_index_file_descriptor: resq 1
computer_index_file_descriptor: resq 1

section .text

main:
    mov rbp, rsp; for correct debugging 
    push  rbp
    mov rbp, rsp
    sub rsp, 32
    
    call read
    call save
    
    add rsp, 32
    pop rbp
    ret

read:
    push  rbp
    mov rbp, rsp
    sub rsp, 32
    mov rax, 2 ;open
    mov rdi, qword user_file_location   
    mov rdx, 0666o
    mov rsi, 0102o
    syscall  
    mov QWORD[user_file_descriptor], rax
    cmp rax, 0
    jl .error 
    mov rdi, rax

    mov rax, 2 ;open
    mov rdi, qword computer_file_location   
    mov rdx, 0666o
    mov rsi, 0102o
    syscall  
    mov QWORD[computer_file_descriptor], rax
    cmp rax, 0
    jl .error 
    mov rdi, rax
    
    mov rax, 2 ;open
    mov rdi, qword user_index_file_location   
    mov rdx, 0666o
    mov rsi, 0102o
    syscall  
    mov QWORD[user_index_file_descriptor], rax
    cmp rax, 0
    jl .error 
    mov rdi, rax

    mov rax, 2 ;open
    mov rdi, qword computer_index_file_location   
    mov rdx, 0666o
    mov rsi, 0102o
    syscall  
    mov QWORD[computer_index_file_descriptor], rax
    cmp rax, 0
    jl .error 
    mov rdi, rax
      
    mov rax, 0 ;read
    mov rdi, qword[user_file_descriptor]
    mov rsi, qword users
    mov rdx, 20000
    syscall
    cmp rax, 0
    jl .error        
    mov rdi, rax
    
    mov rax, 0 ;read
    mov rdi, qword[computer_file_descriptor]
    mov rsi, qword computers
    mov rdx, 8500
    syscall
    cmp rax, 0
    jl .error        
    mov rdi, rax
    
    mov rax, 0 ;read
    mov rdi, qword[user_index_file_descriptor]
    mov rsi, qword user_index
    mov rdx, 4
    syscall
    cmp rax, 0
    jl .error        
    mov rdi, rax
    
    mov rax, 0 ;read
    mov rdi, qword[computer_index_file_descriptor]
    mov rsi, qword computer_index
    mov rdx, 4
    syscall
    cmp rax, 0
    jl .error        
    mov rdi, rax
.end:
    add rsp, 32
    pop rbp
    ret
.error: 
    mov rdi, qword error
    call print_string_new
    call print_nl_new
    jmp .end

save: 
    push  rbp
    mov rbp, rsp
    sub rsp, 32
    mov rax, 1 ;write
    mov rdi, qword[user_file_descriptor]
    mov rsi, qword users
    mov rdx, 20000
    syscall
    cmp rax, 0
    jl .error        
    mov rdi, rax
    
    mov rax, 1 ;write
    mov rdi, qword[computer_file_descriptor]
    mov rsi, qword computers
    mov rdx, 8500
    syscall
    cmp rax, 0
    jl .error        
    mov rdi, rax

    mov rax, 1 ;write
    mov rdi, qword[computer_index_file_descriptor]
    mov rsi, qword computer_index
    mov rdx, 4
    syscall
    cmp rax, 0
    jl .error        
    mov rdi, rax
    
    mov rax, 1 ;write
    mov rdi, qword[user_index_file_descriptor]
    mov rsi, qword user_index
    mov rdx, 4
    syscall
    cmp rax, 0
    jl .error        
    mov rdi, rax
.end:
    add rsp, 32
    pop rbp
    ret
.error: 
    mov rdi, qword error
    call print_string_new
    call print_nl_new
    jmp .end
