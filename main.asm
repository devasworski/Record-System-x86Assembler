%include "/home/malware/asm/joey_lib_io_v6_release.asm"

global main

section .data

hello1: db "--------------------------------------------------------------------",10,"STUDENT AND COMPUTER ORGANISER 3000",10,"--------------------------------------------------------------------",10,"© Alexander Sworski 19131287",10,0
optionselect: db "Please select one of the following options:",10,10,"1. Manage User account",10,"2. Manage Computers",10,"3. Search for Computer",10,"4. Search for Main User of a Computer",10,10,"Enter the number of the menu you want to enter:",10,0
inputerror: db "I am sorry, but I couldn't understand your input.",10,"Please try again:",10,0
selection1: db "You are in the User account management menu",0
selection2: db "You are in the Computer management menu",0
selection3: db "You are in the Computer Search menu",0
selection4: db "You are in the Main User by Computer Search menu",0

user_file_location: db "users.cvs",0
computer_file_location: db "computers.cvs",0


;dummy files

;Name, FirstName, Department, User ID, email
;string64, string64, string64, INT32, string64
user_file: db "Name,Firstname,Dept,1111111,email@adress.com",0
;Computer ID, IP part1, IP part2, IP part3, IP part4, User ID, purchase day, purchase month, purchase year
; INT32, INT8, INT8, INT8, INT8, INT32, INT8, INT8, INT16
computer_file: db "1111111,192,168,0,1,OS,1111111,01,01,2020",0

;Computer ID, IP, USER ID, Date Purchases
; INT32, INT32, INT32, INT32
; INT32[4]
;LastName, FirstName, Department, email, USER ID
; string64, string64, string64, string64, INT32
; struct User


section .text

main:
    mov rbp, rsp; for correct debugging 
    push  rbp
    mov rbp, rsp
    sub rsp, 32

    mov rdi, QWORD hello1
    call print_string_new
    call print_nl_new
    
main_menu:    	
    mov rdi, QWORD optionselect
    call print_string_new
    call print_nl_new
    
    call read_int_new
    call read_main_menu_input
    


read_main_menu_input:
    cmp rax, 1
    je manage_user
    cmp rax, 2
    je manage_computer
    cmp rax, 3
    je search_computer
    cmp rax, 4
    je find_main_user
    mov rdi, QWORD inputerror
    call print_string_new
    call print_nl_new
    jmp main_menu
    
manage_user:
    mov rdi, QWORD selection1
    call print_string_new
    call print_nl_new
    
    ;mov rdi, QWORD userfile
    ;call read_file
    mov rdi, [rax]
    call print_string_new
    
    jmp end;

manage_computer:
    mov rdi, QWORD selection2
    call print_string_new
    call print_nl_new
    
    jmp end;
    
search_computer:
    mov rdi, QWORD selection3
    call print_string_new
    call print_nl_new
    
    jmp end;

find_main_user:
    mov rdi, QWORD selection4
    call print_string_new
    call print_nl_new
    
    jmp end;
    
    
end:
    add rsp, 32
    pop rbp
    ret