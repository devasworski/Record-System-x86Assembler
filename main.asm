%include "/home/malware/asm/joey_lib_io_v6_release.asm"

global main

section .data

;Main Menu texts
hello1: db "--------------------------------------------------------------------",10,"STUDENT AND COMPUTER ORGANISER 3000",10,"--------------------------------------------------------------------",10,"© Alexander Sworski 19131287",10,10,"Today is the: ",0
main_optionselect: db 10,"Please select one of the following options:",10,10,"1. Manage Users",10,"2. Manage Computers",10,"3. Search",10,"4. EXIT",10,10,"Enter the number of the menu you want to enter:",10,0

;error messages
inputerror: db "I am sorry, but I couldn't understand your input",10,"Please try again:",10,0

;generic messages
divider: db 10,"--------------------------------------------------------------------",10,0
error: db "error",0

;User Management Menu texts
user_menu_welcome: db 10,"You are in the User account management menu",10,"Please select on of the following options:",10,10,"1. Add a User",10,"2. Delete a User",10,"3. Go to Main Menu",10,10,"Enter the number of the menu you want to enter:",10,0
 ;add user texts
add_user_menu_welcome: db 10,"You can now create a new User",10,"Please enter the Surname:",0
ask_for_first_name_input: db "Please enter the First name:",0
ask_for_department_input: db "Please choose the department:",10,"1. IT Support",10,"2. Development",10,"3. Finance",10,"4. HR",10,"Enter the number of the department you want to choose:",10,0
ask_for_user_id_input: db "Please enter the USER ID in the Format XXXXXXX:",0
ask_for_differnt_user_id_input: db "Sorry, but this USER ID is already taken",0
ask_for_emai_input: db "Please enter the email of the user:",10,"(@helpdesk.co.uk will be automatically added to your input)",0
confirm_user_input: db "Thank you. The Following User has been created:",10,0
 ;delte user textss
delte_user_menu_welcome: db 10,"You selected: Delte a user",0
ask_for_user_id_delete_input: db "Please enter the User ID you want to delete in following format XXXXXXX:",0
confirm_user_deletion: db "The User has been delteted",0
user_search_error_output: db "The User could not be found",0
; other
user_storage_full: db "The user storage is full. You can not add any new users. Please free some space, by deleting old users in order to add new users",0

;Computer Management Menu texts
computer_menu_welcome: db 10,"You are in the Computer management menu",10,"Please select one of following options:",10,"1. Add a Computer",10,"2. Delete a Computer",10,"3. Go to Main Menu",10,10,"Enter the number of the menu you want to enter:",10,0
 ;add computer texts
add_computer_menu_welcome: db 10,"You can now create a new Computer",0
ask_for_computer_id_input: db "Please enter the Computer ID in the Format XXXXXXX:",0
ask_for_differn_computer_id_input: db "Sorry, but this Computer ID is allready taken",10,"Please enter a differnt Computer ID:",0
ask_for_ip_input: db "Please enter the Computer IP in the format XXX.XXX.XXX.XXX:",0
ask_for_main_user_id_input: db "Please enter the ID of the main user in the following Format XXXXXXX:",0
ask_for_os_input: db "Please choose the OS:",10,"1. Windows",10,"2. Linux",10,"3. MacOS",10,"Enter the number of the OS you want to choose:",0
ask_for_different_main_user_id: db "Sorry, but this User ID does not exists. ",0
ask_for_existing_user_id_input: db "I am sorry, but I can not find this USER ID",10,"Please enter an exisiting USER ID:",0
exit_yes_no: db "Do you want to go back to the main menu? (y/n)",0
ask_for_purchase_date_input: db "Please enter the Date of purchase in following Format dd.mm.yyyy:",0
ask_for_purchase_date_input_future_error: db "I am sorry, but the date you entered is in the future",10,"Please enter the Date of purchase in following Format dd.mm.yyyy:",0
confirm_computer_input: db "Thank you. The Following computer has been created:",10,0
 ;delete computer texts
delte_computer_menu_welcome: db 10,"You selected: Delte a Computer",0
ask_for_delete_computer_id_input: db "Please enter the Computer ID you want to deletes in following format XXXXXXX:",0
confirm_computer_deletion: db "The Computer has been delteted",0
; other
computer_storage_full: db 10,"The computer storage is full. You can not add any new computers. Please free some space, by deleting old computers in order to add new computers",0

;Search Menu texts
search_menu_welcome: db 10,"You are in the Search Menu",10,"Please select one of the following options:",10,10,"1. Search for a Computer",10,"2. Search for a User",10,"3. Search for Computer Main User",10,"4. Print all Users",10,"5. Print all Computers",10,"6. Print amount of Users",10,"7. Print amount of Computers",10,"8. Go to Main Menu",10,10,"Enter the number of the menu you want to enter:",10,0

;Computer Search Menu texts
computer_search_welcome: db 10,"You are in the Computer Search menu",0
ask_for_computer_search_id_input: db 10,"Enter the Computer ID you want ot look up in the following format XXXXXXX:",10,"(Press x go back to Main Menu)",0
computer_search_result_output: db "Following Computer has been found:",0
computer_search_error_output: db "The computer could not be found",0

;User Search Menu texts
user_search_welcome: db 10,"You are in the User Search menu",0
ask_for_user_search_id_input: db 10,"Enter the User ID you want ot look up in the following format XXXXXXX:",10,"(Press x go back to Main Menu)",0
user_search_result_output: db "Following User has been found:",0


;Main User Search Menu texts
computer_user_search_welcome: db 10,"You are in the Email adress of main user Search menu",0
computer_user_search_result_output: db "This is the email of the mail user: ",0
computer_user_search_error_output: db "The computer could not be found",0

;Print texts
print_all_user_welcome: db "Printing all Users",0
print_all_computer_welcome: db "Printing all Comuters",0

;text blocks
email_end: db "@helpdesk.co.uk",0
surname: db "Surname: ",9,9,0
firstname: db "First name: ",9,0
dept: db "Department: ",9,0
email: db "Email: ",9,9,0
user_id: db "User ID: ",9,9,"p",0
computer_id: db "Computer ID: ",9,"c",0
purchase_date: db "Purchase Date: ",9,0
computer_ip: db "IP Adress: ",9,9,0
computer_os: db "OS: ",9,9,0
amount_users: db "Amount Users: ",0
amount_computers: db "Amount Computers: ",0

;curent date
months: db 31,28,31,30,31,30,31,31,30,31,30,31
leapmonths: db 31,29,31,30,31,30,31,31,30,31,30,31
currentdate: times 4 db 0 

;File locations
user_file_location: db "users.cvs",0
computer_file_location: db "computers.cvs",0

;enums
development: db"Development",0
finance: db "Finance",0
it_support: db "IT Support",0
HR: db "HR",0
win: db "Windows",0
lin: db "Linux",0
mac: db "MacOS",0


;index
user_index: dq 0
computer_index: dq 0


;arrays
users: times 20000 db 0
computers: times 8500 db 0

;users: (4*64 + 4)*100 = 26000 byte
;computers: (4)*500 = 2000 doublewords

;Name, FirstName, Department, User ID, email
;string64, string64, string64, INT32, string64
;Computer ID, IP part1, IP part2, IP part3, IP part4, User ID, purchase day, purchase month, purchase year
; INT32, INT8, INT8, INT8, INT8, INT32, INT8, INT8, INT16

;Computer ID, IP, USER ID, Date Purchases
; INT32, INT32, INT32, INT32
; INT32[4]
;LastName, FirstName, Department, email, USER ID
; string64, string64, string64, string64, INT32
; struct User

;ComputerID, IP, UserID, Date, OS
; INT32, INT32, INT32, INT32, INT8
; 4+4+4+4+1 = 17byte
; 17*500 = 8500byte
; 0, 4, 8, 12, 16

;SurName, Name, Department, email, UserID
; String65, String65, INT8, String65, INT32
; 65+65+1+65+4 = 200 byte
; 200*100 = 20000 byte
; 0, 65, 130, 131, 196

section .text

print_id: ;read from rdi
    mov R9,7
    mov rax, rdi
    mov R15, rdi
    cmp rdi, 10
    mov rcx, 10
    jl .loopend
.loop:
    xor rdx, rdx
    div rcx
    dec R9
    cmp rax, 10
    jge .loop
.loopend:
    dec R9

.print_loop:
    cmp R9, 0
    jle .end
    mov rdi, '0'
    call print_char_new
    dec R9
    jmp .print_loop
    
.end:
    mov rdi, R15
    call print_uint_new 
    call print_nl_new
    ret

print_current_date:
    xor rdi, rdi
    mov dil, BYTE[R13]
    call print_uint_new
    mov rdi, 46
    call print_char_new
    xor rdi, rdi
    call print_uint_new
    mov dil, BYTE[R13+1]
    call print_uint_new
    mov rdi, 46
    call print_char_new
    xor rdi, rdi
    xor rdi, rdi
    mov di, WORD[R13+2]
    call print_uint_new
    ret
    
get_current_date:
    mov rbp, rsp; for correct debugging 
    push  rbp
    mov rbp, rsp
    sub rsp, 32
    mov R13, QWORD currentdate   
    mov rax, 201
    xor rdi, rdi        
    syscall  
    xor rdx, rdx
    mov rcx, 86400
    div rcx    
    xor rdx, rdx
    mov rcx, 365
    div rcx   
    mov R12, 1970
    add R12, rax
    mov WORD [R13+2], R12W
    mov R10, rdx    
    xor rdx, rdx
    add rax, 2
    mov rcx, 4
    div rcx   
    sub R10, rax
    add R10, 1
    xor rbx, rbx
    mov R11, 1
    cmp rdx, 0
    je .leapyear
    mov rbx, QWORD months
    jmp .monthloop
.leapyear:
    mov rbx, QWORD leapmonths
    jmp .monthloop
.monthloop:
    cmp R10B, BYTE[rbx]
    jle .endmonthloop
    inc R11
    sub R10B, BYTE[rbx]
    inc rbx
    jmp .monthloop
.endmonthloop:
    mov BYTE [R13], R10B
    mov BYTE [R13+1], R11B

    add rsp, 32
    pop rbp
    ret

print_os:; index in rdx
    cmp rdx, 1
    je .w
    cmp rdx, 2
    je .l
    cmp rdx, 3
    je .m
    mov rdi, QWORD error
    jmp .end
.w:
    mov rdi, QWORD win
    jmp .end
.l:
    mov rdi, QWORD lin
    jmp .end
.m:
    mov rdi, QWORD mac
    jmp .end

.end:
    call print_string_new
    ret

print_department:; index in rdx
    cmp rdx, 1
    je .it
    cmp rdx, 2
    je .dev
    cmp rdx, 3
    je .fin
    cmp rdx, 4
    je .hr
    mov rdi, QWORD error
    jmp .end
.it:
    mov rdi, QWORD it_support
    jmp .end
.dev:
    mov rdi, QWORD development
    jmp .end
.fin:
    mov rdi, QWORD finance
    jmp .end
.hr:
    mov rdi, QWORD HR
    jmp .end
.end:
    call print_string_new
    ret


delete_user_from_array: ; index in rax

    push  rbp
    mov rbp, rsp
    sub rsp, 32 
    
    mov QWORD [rsp+16], rax ;index+1
    inc QWORD [rsp+16]
    mov QWORD [rsp+8], rax ;index

.loop1:
    mov QWORD [rsp+24], 0;counter
    mov rax, QWORD [rsp+16]
    mov R11, 200
    mul R11
    mov R10, rax
    lea R15, [users+R10]
    
    mov rax, QWORD [rsp+8]
    mov R11, 200
    mul R11
    mov R10, rax
    lea rcx, [users+R10]
    mov rdx, R15
    
.loop2:
    xor R12, R12
    mov R12B, BYTE[rdx]
    mov BYTE[rcx], R12B
    inc QWORD [rsp+24]
    inc rdx
    inc rcx
    cmp QWORD [rsp+24], 200
    jne .loop2
    
    mov R14, QWORD[user_index]
    cmp [rsp+8], R14
    je .end
    inc QWORD [rsp+16]
    inc QWORD [rsp+8]
    jmp .loop1

.end:
    mov QWORD [rsp+24], 0
    mov rax, QWORD [rsp+16]
    mov R11, 200
    mul R11
    mov R10, rax
    lea rdx, [users+R10]
.endloop:
    xor R12, R12
    mov R12B, 0
    mov BYTE[rdx], R12B
    inc QWORD [rsp+24]
    inc rcx
    cmp QWORD [rsp+24], 200
    jne .endloop
    
    dec QWORD[user_index]
    pop rbp
    add rsp, 32
    ret


delete_computer_from_array: ; index in rax

    push  rbp
    mov rbp, rsp
    sub rsp, 32 
    
    mov QWORD [rsp+16], rax ;index+1
    inc QWORD [rsp+16]
    mov QWORD [rsp+8], rax ;index

.loop1:
    mov QWORD [rsp+24], 0;counter
    mov rax, QWORD [rsp+16]
    mov R11, 17
    mul R11
    mov R10, rax
    lea R15, [computers+R10]
    
    mov rax, QWORD [rsp+8]
    mov R11, 17
    mul R11
    mov R10, rax
    lea rcx, [computers+R10]
    mov rdx, R15
    
.loop2:
    xor R12, R12
    mov R12B, BYTE[rdx]
    mov BYTE[rcx], R12B
    inc QWORD [rsp+24]
    inc rdx
    inc rcx
    cmp QWORD [rsp+24], 16
    jne .loop2
    
    mov R14, QWORD[computer_index]
    cmp [rsp+16], R14
    je .end
    inc QWORD [rsp+16]
    inc QWORD [rsp+8]
    jmp .loop1

.end:
    mov QWORD [rsp+24], 0;counter
    mov rax, QWORD [rsp+16]
    mov R11, 17
    mul R11
    mov R10, rax
    lea rdx, [computers+R10]
.endloop:
    xor R12, R12
    mov R12B, 0
    mov BYTE[rdx], R12B
    inc QWORD [rsp+24]
    inc rcx
    cmp QWORD [rsp+24], 16
    jne .endloop
    
    dec QWORD[computer_index]
    pop rbp
    add rsp, 32
    ret

add_computer_id: ;read from rbx
    mov rax, QWORD[computer_index]
    mov R11, 17
    mul R11
    mov R10, rax
    lea rax, [computers+R10]
    mov edx, DWORD ebx
    mov DWORD[rax], edx
    ret
    
add_computer_ip: ;read from rbx
    push  rbp
    mov rbp, rsp
    sub rsp, 32 
.restart: 
    mov QWORD[rbp-8], 0
    mov rax, QWORD[computer_index]
    mov R11, 17
    mul R11
    mov R10, rax
    lea R15, [computers+R10+4]
.loop1: ;read from rbx
    inc QWORD[rbp-8]
    cmp QWORD[rbp-8], 4
    jg .ip_faulty
    mov R14,  0
    mov dl, BYTE[rbx]
.loop2:
    mov [rsp+R14], dl
    inc rbx
    inc R14
    mov dl, BYTE[rbx]
    cmp dl, 0
    je .process_read_ip_part
    cmp dl, 46
    jne .loop2
.process_read_ip_part:
    mov BYTE [rsp+R14], BYTE 0
    mov rdi, rsp
    call atoi
    cmp rax, 0
    jl .ip_faulty
    cmp rax, 255
    jg .ip_faulty
    mov BYTE [R15], al
    cmp dl, 0
    je .end
    inc rbx
    inc R15
    jmp .loop1
.end:
    cmp QWORD[rbp-8], 4
    jne .ip_faulty
    pop rbp
    add rsp, 32
    ret
.ip_faulty:
    mov rdi, QWORD ask_for_ip_input
    call print_string_new
    call print_nl_new
    call read_string_new
    mov rbx, rax
    jmp .restart
        
    
add_computer_main_user_id: ;read from rbx
    mov rax, QWORD[computer_index]
    mov R11, 17
    mul R11
    mov R10, rax
    lea rax, [computers+R10+8]
    mov edx, DWORD ebx
    mov [rax], edx
    ret
    
add_computer_os: ;read from rbx
    mov rax, QWORD[computer_index]
    mov R11, 17
    mul R11
    mov R10, rax
    lea rax, [computers+R10+16]
    mov dl, BYTE bl
    mov BYTE [rax], dl
    ret
    
    
add_computer_purchase_date: ;read from rbx
    push  rbp
    mov rbp, rsp
    sub rsp, 32 

.restart:        
    mov rax, QWORD[computer_index]
    mov R11, 17
    mul R11
    mov R10, rax
    lea R15, [computers+R10+12]
    
    mov DWORD[rbp-4], 2
    mov R14, 0
.readdayloop:
    cmp DWORD[rbp-4], 0
    jle .input_error
    mov dl, BYTE[rbx]
    mov [rsp+R14], dl
    inc rbx
    inc R14
    dec DWORD[rbp-4]
    cmp BYTE[rbx], 46
    jne .readdayloop  
    mov BYTE [rsp+R14], BYTE 0 
    mov rdi, rsp
    call atoi
    cmp rax, 0
    jle .input_error
    cmp rax, 31
    jg .input_error

    mov BYTE[R15], al
    
    inc R15
    inc rbx
    
    mov DWORD[rbp-4], 2
    mov R14, 0
.readmonthloop:
    cmp DWORD[rbp-4], 0
    jle .input_error
    mov dl, BYTE[rbx]
    mov [rsp+R14], dl
    inc rbx
    inc R14
    dec DWORD[rbp-4]
    cmp BYTE[rbx], 46
    jne .readmonthloop
    mov BYTE [rsp+R14], BYTE 0 
    mov rdi, rsp
    call atoi
    cmp rax, 0
    jle .input_error
    cmp rax, 12
    jg .input_error
    
    mov BYTE[R15], al
    
    inc R15
    inc rbx
    
    mov DWORD[rbp-4], 4
    mov R14, 0
.readyearloop:
    cmp DWORD[rbp-4], 0
    jle .input_error
    mov dl, BYTE[rbx]
    mov [rsp+R14], dl
    inc rbx
    inc R14
    dec DWORD[rbp-4]
    cmp BYTE[rbx], 0
    jne .readyearloop
    mov BYTE [rsp+R14], BYTE 0 
    mov rdi, rsp
    call atoi
    cmp rax, 1900
    jle .input_error
    cmp rax, 2100
    jg .input_error
    
    mov WORD [R15], ax
    jmp .check_date
.end:
    pop rbp
    add rsp, 32
    ret
.input_error:    
    mov rdi, QWORD ask_for_purchase_date_input
    call print_string_new
    call print_nl_new
    call read_string_new
    mov rbx, rax
    jmp .restart
.check_date:
    call get_current_date
    xor R10, R10
    xor R12, R12
    mov R13, QWORD currentdate
    lea R11, [computers+R10+14]
    mov R10W, WORD[R11]
    mov R12W, WORD[R13+2]
    cmp R10W, R12W
    jl .date_ok
    jg .date_false
    xor R12,R12
    xor R10,R10
    dec R11
    mov R12B, BYTE[R13+1]
    mov R10B, BYTE[R11]
    cmp R10B, R12B
    jl .date_ok
    jg .date_false
    dec R11
    mov R12B, BYTE[R13]
    mov R10B, BYTE[R11]
    cmp R10B, R12B
    jl .date_ok
    jg .date_false
.date_ok:
    jmp .end
.date_false:
    mov rdi, QWORD ask_for_purchase_date_input_future_error
    call print_string_new
    call print_nl_new
    call read_string_new
    mov rbx, rax
    jmp .restart
    
print_computer: ; index in rax
    mov R11, 17
    mul R11
    mov R10, rax
    
    mov rdi, QWORD computer_id
    call print_string_new
    lea R12D, [computers+R10]
    mov edi, [R12]
    call print_id
    
    mov rdi, QWORD computer_os
    call print_string_new
    lea R12D, [computers+R10+16]
    mov dl, BYTE [R12]
    call print_os 
    call print_nl_new
    
    mov rdi, QWORD computer_ip
    call print_string_new
    xor rdi, rdi
    lea R11, [computers+R10+4]
    mov R12B, BYTE[R11]
    mov dil, R12B
    call print_uint_new
    mov rdi, 46
    call print_char_new
    lea R11, [computers+R10+5]
    mov R12B, BYTE[R11]
    mov dil, R12B
    call print_uint_new
    mov rdi, 46
    call print_char_new
    lea R11, [computers+R10+6]
    mov R12B, BYTE[R11]
    mov dil, R12B
    call print_uint_new
    mov rdi, 46
    call print_char_new
    lea R11, [computers+R10+7]
    mov R12B, BYTE[R11]
    mov dil, R12B
    call print_uint_new
    
    
    call print_nl_new
    mov rdi, QWORD user_id
    call print_string_new
    lea R12D, [computers+R10+8]
    mov edi, [R12]
    call print_id
    
    mov rdi, QWORD purchase_date
    call print_string_new
    xor rdi, rdi
    lea R11, [computers+R10+12]
    mov R12B, BYTE[R11]
    mov dil, R12B
    call print_uint_new
    mov rdi, 46
    call print_char_new
    lea R11, [computers+R10+13]
    mov R12B, BYTE[R11]
    mov dil, R12B
    call print_uint_new
    mov rdi, 46
    call print_char_new
    lea R11, [computers+R10+14]
    mov R12W, WORD[R11]
    mov di, R12W
    call print_int_new
    
    call print_nl_new
    ret
    
search_computer_id:
    
    push  rbp
    mov rbp, rsp
    sub rsp, 32 
    mov QWORD[rbp-8], 0
    
.loop: ; search id in R13
    mov rdx, QWORD[computer_index]
    cmp [rbp-8], rdx
    je .failed
    mov rax, [rbp-8]
    mov R11, 17
    mul R11
    mov R10, rax
    lea rax, [computers+R10]
    mov R14, [rbp-8]
    inc QWORD[rbp-8]
    cmp R13D, [rax]
    jne .loop
    mov rax, R14;return index in rax
    pop rbp
    add rsp, 32
    ret
.failed:
    mov rax, 504 ;return error 504 in rax
    pop rbp
    add rsp, 32
    ret


search_user_id:
    
    push  rbp
    mov rbp, rsp
    sub rsp, 32 
    mov QWORD[rbp-8], 0
    
.loop: ; search id in R13
    mov rdx, QWORD[user_index]
    cmp [rbp-8], rdx
    je .failed
    mov rax, [rbp-8]
    mov R11, 200
    mul R11
    mov R10, rax
    lea rax, [users+R10+196]
    mov R14, [rbp-8]
    inc QWORD[rbp-8]
    cmp R13D, [rax]
    jne .loop
    mov rax, R14;return index in rax
    pop rbp
    add rsp, 32
    ret
.failed:
    mov rax, 504 ;return error 504 in rax
    pop rbp
    add rsp, 32
    ret  

add_user_name:
    mov rax, QWORD[user_index]
    mov R11, 200
    mul R11
    mov R10, rax
    lea rax, [users+R10]
    mov rcx, 0
.loop: ;read from rbx
    cmp rcx, 64
    je .end
    mov dl, BYTE[rbx]
    mov [rax], dl
    inc rbx
    inc rax
    inc rcx
    cmp dl, 0
    jne .loop
.end:
    mov [rax], BYTE 0
    ret

add_user_firstname:
    mov rax, QWORD[user_index]
    mov R11, 200
    mul R11
    mov R10, rax
    lea rax, [users+R10+65]
    mov rcx, 0
.loop: ;read from rbx
    cmp rcx, 64
    je .end
    mov dl, BYTE[rbx]
    mov [rax], dl
    inc rbx
    inc rax
    inc rcx
    cmp dl, 0
    jne .loop
.end:
    mov [rax], BYTE 0
    ret
    
add_user_department:
    mov rax, QWORD[user_index]
    mov R11, 200
    mul R11
    mov R10, rax
    lea rax, [users+R10+130]
    mov dl, BYTE bl
    mov [rax], dl
    ret
    
add_user_email:
    mov rax, QWORD[user_index]
    mov R11, 200
    mul R11
    mov R10, rax
    lea rax, [users+R10+131]
    mov rcx, 0
.loop: ;read from rbx
    cmp rcx, 64
    je .end
    mov dl, BYTE[rbx]
    mov [rax], dl
    inc rbx
    inc rax
    inc rcx
    cmp dl, 0
    jne .loop
.end:
    mov [rax], BYTE 0
    ret

add_user_id:
    mov rax, QWORD[user_index]
    mov R11, 200
    mul R11
    mov R10, rax
    lea rax, [users+R10+196]
    ;read in rbx
    mov edx, DWORD ebx
    mov [rax], edx
    ret
    
print_user: ;index in rax
    mov R11, 200
    mul R11
    mov R10, rax
    mov rdi, QWORD surname
    call print_string_new
    lea rdi, [users+R10]
    call print_string_new
    call print_nl_new
    mov rdi, QWORD firstname
    call print_string_new
    lea rdi, [users+R10+65]
    call print_string_new
    call print_nl_new
    mov rdi, QWORD dept
    call print_string_new
    lea rdi, [users+R10+130]
    mov dl, BYTE [rdi]
    call print_department
    call print_nl_new
    mov rdi, QWORD email
    call print_string_new
    lea rdi, [users+R10+131]
    call print_string_new
    mov rdi, QWORD email_end
    call print_string_new
    call print_nl_new
    mov rdi, QWORD user_id
    call print_string_new
    lea R12, [users+R10+196]
    xor rdi, rdi
    mov edi, [R12D]
    call print_id
    
    ret
    
    

    
    

main:
    mov rbp, rsp
    push  rbp
    mov rbp, rsp
    sub rsp, 32

    mov rdi, QWORD hello1
    call print_string_new
    call get_current_date
    call print_current_date
    call print_nl_new
    call print_nl_new
    call main_menu
    pop rbp
    add rsp, 32
    ret
    
main_menu:   
    push  rbp
    mov rbp, rsp
    sub rsp, 32 	
    
.read:    
    mov rdi, QWORD main_optionselect
    call print_string_new
    call print_nl_new
    call read_int_new
    cmp rax, 1
    je .user_menu
    cmp rax, 2
    je .computer_menu
    cmp rax, 3
    je .search_menu
    cmp rax, 4
    je .end
    mov rdi, QWORD inputerror
    call print_string_new
    call print_nl_new
    call print_nl_new
    jmp .read
.user_menu:
    call user_menu
    jmp .read
.computer_menu:
    call computer_menu
    jmp .read
.search_menu:
    call search_menu
    jmp .read
.end:
    pop rbp
    add rsp, 32
    ret
    
user_menu:   
    push  rbp
    mov rbp, rsp
    sub rsp, 32 	    
.selection:    
    mov rdi, QWORD divider
    call print_string_new
    mov rdi, QWORD user_menu_welcome
    call print_string_new
    call print_nl_new
    call read_int_new
    cmp rax, 1
    je .add_user
    cmp rax, 2
    je .delete_user
    cmp rax, 3
    je .end
    mov rdi, QWORD inputerror
    call print_string_new
    call print_nl_new
    call print_nl_new
    jmp .selection
.add_user:
    call add_user
    jmp .selection
.delete_user:
    call delete_user
    jmp .selection
.end:
    mov rdi, QWORD divider
    call print_string_new
    pop rbp
    add rsp, 32
    ret
    
computer_menu:   
    push  rbp
    mov rbp, rsp
    sub rsp, 32 	    
.selection:    
    mov rdi, QWORD divider
    call print_string_new
    mov rdi, QWORD computer_menu_welcome
    call print_string_new
    call print_nl_new
    call read_int_new
    cmp rax, 1
    je .add_computer
    cmp rax, 2
    je .delete_computer
    cmp rax, 3
    je .end
    mov rdi, QWORD inputerror
    call print_string_new
    call print_nl_new
    call print_nl_new
    jmp .selection
.add_computer:
    call add_computer
    jmp .selection
.delete_computer:
    call delete_computer
    jmp .selection
.end:
    mov rdi, QWORD divider
    call print_string_new
    pop rbp
    add rsp, 32
    ret
    
search_menu:   
    push  rbp
    mov rbp, rsp
    sub rsp, 32 	    
.selection:    
    mov rdi, QWORD divider
    call print_string_new
    mov rdi, QWORD search_menu_welcome
    call print_string_new
    call print_nl_new
    call read_int_new
    cmp rax, 1
    je .search_computer
    cmp rax, 2
    je .search_user
    cmp rax, 3
    je .search_main_user
    cmp rax, 4
    je .print_all_user
    cmp rax, 5
    je .print_all_computer
    cmp rax, 6
    je .print_num_users
    cmp rax, 7
    je .print_num_computers
    cmp rax, 8
    je .end
    mov rdi, QWORD inputerror
    call print_string_new
    call print_nl_new
    call print_nl_new
    jmp .selection
.search_computer:
    call search_computer
    jmp .selection
.search_user:
    call search_user
    jmp .selection
.search_main_user:
    call find_main_user
    jmp .selection
.print_all_user:
    call print_all_user
    jmp .selection
.print_all_computer:
    call print_all_computer
    jmp .selection 
.print_num_users:
    call print_num_users
    jmp .selection
.print_num_computers:
    call print_num_computers
    jmp .selection 
.end:
    mov rdi, QWORD divider
    call print_string_new
    pop rbp
    add rsp, 32
    ret
    
 
add_user:
    mov rdx, QWORD[user_index]
    cmp rdx, 99
    jge .storage_full
    mov rdi, QWORD add_user_menu_welcome
    call print_string_new
    call print_nl_new
    call read_string_new
    mov rbx, rax
    call add_user_name
    mov rdi, QWORD ask_for_first_name_input
    call print_string_new
    call print_nl_new
    call read_string_new
    mov rbx, rax
    call add_user_firstname
    
.ask_for_dept:    
    mov rdi, QWORD ask_for_department_input
    call print_string_new
    call print_nl_new
    call read_uint_new
    cmp rax, 4
    jg .depterror
    cmp rax, 1
    jl .depterror
    mov rbx, rax
    call add_user_department
    
    
.ask_for_id:
    mov rdi, QWORD ask_for_user_id_input
    call print_string_new
    call print_nl_new
    call read_uint_new
    mov rbx, rax
    
    cmp rbx, 9999999
    jge .ask_for_id
    cmp rbx, 0
    jle .ask_for_id
    
    mov R13, rbx
    call search_user_id
    cmp rax, 504
    jne .id_exists 
        
    call add_user_id

    mov rdi, QWORD ask_for_emai_input
    call print_string_new
    call print_nl_new
    call read_string_new
    mov rbx, rax
    call add_user_email
    mov rdi, QWORD confirm_user_input
    call print_string_new
    call print_nl_new
    mov rax, QWORD[user_index]
    call print_user 
    inc QWORD[user_index]
    ret
.id_exists:
    mov rdi, QWORD ask_for_differnt_user_id_input
    call print_string_new
    call print_nl_new
    jmp .ask_for_id
.storage_full:
    mov rdi, QWORD user_storage_full
    call print_string_new
    call print_nl_new
    ret
.depterror:
    mov rdi, QWORD inputerror
    call print_string_new
    call print_nl_new
    jmp .ask_for_dept
    
    
delete_user:
    mov rdi, QWORD delte_user_menu_welcome
    call print_string_new
    call print_nl_new
    mov rdi, QWORD ask_for_user_id_delete_input
    call print_string_new
    call print_nl_new
    call read_uint_new 
    mov rdi, rax
    mov R13, rax
    cmp R13, 9999999
    jge .id_error
    cmp R13, 0
    jle .id_error
    call search_user_id
    cmp rax, 504
    jne .exists 
    mov rdi, QWORD user_search_error_output
    call print_string_new
    call print_nl_new
    jmp .end
.exists:   
    call delete_user_from_array
    mov rdi, QWORD confirm_user_deletion
    call print_string_new
    call print_nl_new
    jmp .end
.end:
    ret   
.id_error:
    mov rdi, QWORD inputerror 
    call print_string_new
    call print_nl_new
    jmp .end



add_computer:
    mov rdx, QWORD[computer_index]
    cmp rdx, 499
    jge .storage_full
    mov rdi, QWORD add_computer_menu_welcome
    call print_string_new
    call print_nl_new
.ask_for_id:
    mov rdi, QWORD ask_for_computer_id_input
    call print_string_new
    call print_nl_new    
    call read_uint_new
    mov rbx, rax    
    cmp rbx, 9999999
    jge .ask_for_id 
    cmp rbx, 0
    jle .ask_for_id   
    mov R13, rbx
    call search_computer_id
    cmp rax, 504
    jne .id_exists 
    call add_computer_id
.ask_for_os:    
    mov rdi, QWORD ask_for_os_input
    call print_string_new
    call print_nl_new
    call read_uint_new
    cmp rax, 3
    jg .oserror
    cmp rax, 1
    jl .oserror
    mov rbx, rax
    call add_computer_os
    
    mov rdi, QWORD ask_for_ip_input
    call print_string_new
    call print_nl_new
    call read_string_new
    mov rbx, rax
    call add_computer_ip
.ask_for_user_id:    
    mov rdi, QWORD ask_for_main_user_id_input
    call print_string_new
    call print_nl_new
    call read_uint_new
    mov rbx, rax   
    cmp rbx, 9999999
    jge .ask_for_user_id   
    cmp rbx, 0
    jle .ask_for_user_id   
    mov R13, rbx
    call search_user_id
    cmp rax, 504
    je .user_id_not_exists 
    
    call add_computer_main_user_id
    mov rdi, QWORD ask_for_purchase_date_input
    call print_string_new
    call print_nl_new
    call read_string_new
    mov rbx, rax
    call add_computer_purchase_date
    mov rdi, QWORD confirm_computer_input
    call print_string_new
    call print_nl_new
    mov rax, QWORD[computer_index]
    call print_computer
    inc QWORD[computer_index]
    jmp .end
.end:
    ret
.id_exists:
    mov rdi, QWORD ask_for_differn_computer_id_input
    call print_string_new
    call print_nl_new
    jmp .ask_for_id
.user_id_not_exists:
    mov rdi, QWORD ask_for_different_main_user_id
    call print_string_new
    call print_nl_new
    
    mov rdi, QWORD exit_yes_no
    call print_string_new
    call print_nl_new
    call read_string_new
    mov bl, BYTE[rax] 
    cmp bl, 121
    je .end
    
    jmp .ask_for_user_id
.storage_full:
    mov rdi, QWORD computer_storage_full
    call print_string_new
    call print_nl_new
    ret
.oserror:
    mov rdi, QWORD inputerror
    call print_string_new
    call print_nl_new
    jmp .ask_for_os

delete_computer:
    mov rdi, QWORD delte_computer_menu_welcome
    call print_string_new
    call print_nl_new

    mov rdi, QWORD ask_for_computer_id_input
    call print_string_new
    call print_nl_new
    call read_uint_new 
    mov R13, rax
    cmp R13, 9999999
    jge .id_error
    cmp R13, 0
    jle .id_error
    call search_computer_id
    cmp rax, 504
    jne .cp_exists 
    mov rdi, QWORD computer_search_error_output
    call print_string_new
    call print_nl_new
    call print_nl_new
    call print_nl_new
    jmp .end
.cp_exists:   
    call delete_computer_from_array
    mov rdi, QWORD confirm_computer_deletion
    call print_string_new
    call print_nl_new
    call print_nl_new
    call print_nl_new
    jmp .end
.end:
    ret
.id_error:
    mov rdi, QWORD inputerror 
    call print_string_new
    call print_nl_new
    jmp .end
        
search_user:
    mov rdi, QWORD user_search_welcome
    call print_string_new
    call print_nl_new
.loop:
    mov rdi, QWORD ask_for_user_search_id_input
    call print_string_new
    call print_nl_new
    call read_string_new
    mov bl, BYTE[rax] 
    cmp bl, 120
    je .end
    mov rdi, rax
    call atoi
    mov R13, rax
    call search_user_id
    cmp rax, 504
    jne .exists    
    mov rdi, QWORD user_search_error_output
    call print_string_new
    call print_nl_new
    jmp .loop
.exists:
    mov rdi, QWORD user_search_result_output
    push rax
    call print_string_new
    call print_nl_new
    pop rax
    call print_user
    jmp .loop
.end:
    ret
                
search_computer:
    mov rdi, QWORD computer_search_welcome
    call print_string_new
    call print_nl_new
.loop:
    mov rdi, QWORD ask_for_computer_search_id_input
    call print_string_new
    call print_nl_new
    call read_string_new
    mov bl, BYTE[rax] 
    cmp bl, 120
    je .end
    mov rdi, rax
    call atoi
    mov R13, rax
    cmp R13, 9999999
    jge .id_error
    cmp R13, 0
    jle .id_error
    call search_computer_id
    cmp rax, 504
    jne .exists    
    mov rdi, QWORD computer_search_error_output
    call print_string_new
    call print_nl_new
    jmp .loop
.exists:
    mov rdi, QWORD computer_search_result_output
    push rax
    call print_string_new
    call print_nl_new
    pop rax
    call print_computer
    jmp .loop
.end:
    ret
.id_error:
    mov rdi, QWORD inputerror 
    call print_string_new
    call print_nl_new
    jmp .loop


find_main_user:
    mov rdi, QWORD computer_user_search_welcome
    call print_string_new
    call print_nl_new
.loop:
    mov rdi, QWORD ask_for_user_search_id_input
    call print_string_new
    call print_nl_new
    call read_string_new
    mov bl, BYTE[rax] 
    cmp bl, 120
    je .end
    mov rdi, rax
    call atoi
    mov R13, rax
    cmp R13, 9999999
    jge .id_error
    cmp R13, 0
    jle .id_error
    call search_computer_id
    cmp rax, 504
    jne .exists    
    mov rdi, QWORD computer_user_search_error_output
    call print_string_new
    call print_nl_new
    jmp .loop;
.exists:
    mov rdi, QWORD computer_user_search_result_output
    push rax
    call print_string_new
    pop rax
    mov R11, 16
    mul R11
    mov R10, rax
    lea rax, [computers+R10+8]
    mov R13, [rax] 
    call search_user_id
    mov R11, 260
    mul R11
    mov R10, rax
    lea rdi, [users+R10+192]
    call print_string_new
    mov rdi, QWORD email_end
    call print_string_new
    call print_nl_new
    jmp .loop
.end:
    ret
.id_error:
    mov rdi, QWORD inputerror 
    call print_string_new
    call print_nl_new
    jmp .loop
    
print_all_user:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov rdi, QWORD divider
    call print_string_new
    mov rdi, QWORD print_all_user_welcome
    call print_string_new
    mov rdi, QWORD divider
    call print_string_new
    call print_nl_new
    mov QWORD [rbp-8], 0
    mov rdx, QWORD [user_index]
    cmp [rbp-8],rdx
    jge .end 
.loop:
    mov rax, QWORD [rbp-8]
    call print_user
    mov rdx, QWORD [user_index]
    inc QWORD [rbp-8]
    call print_nl_new
    cmp [rbp-8],rdx
    jl .loop
.end:
    mov rdi, QWORD divider
    call print_string_new
    pop rbp
    add rsp, 32
    ret


print_all_computer:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov rdi, QWORD divider
    call print_string_new
    mov rdi, QWORD print_all_computer_welcome
    call print_string_new
    mov rdi, QWORD divider
    call print_string_new
    call print_nl_new
    mov QWORD [rbp-8], 0
    mov rdx, QWORD [computer_index]
    cmp [rbp-8],rdx
    jge .end 
.loop:
    mov rax, QWORD [rbp-8]
    call print_computer
    mov rdx, QWORD [computer_index]
    inc QWORD [rbp-8]
    call print_nl_new
    cmp [rbp-8],rdx
    jl .loop
.end:
    mov rdi, QWORD divider
    call print_string_new
    pop rbp
    add rsp, 32
    ret
    
print_num_users:
    mov rdi, QWORD amount_users
    call print_string_new
    mov rdi, QWORD [user_index]
    call print_uint_new
    call print_nl_new
    ret
print_num_computers:
    mov rdi, QWORD amount_computers
    call print_string_new
    mov rdi, QWORD [computer_index]
    call print_uint_new
    call print_nl_new
    ret
