%include "/home/malware/asm/joey_lib_io_v6_release.asm"

global main

section .data

;Main Menu texts
hello1: db "--------------------------------------------------------------------",10,"STUDENT AND COMPUTER ORGANISER 3000",10,"--------------------------------------------------------------------",10,"© Alexander Sworski 19131287",10,0
main_optionselect: db 10,"Please select one of the following options:",10,10,"1. Manage User account",10,"2. Manage Computers",10,"3. Search for Computer",10,"4. Search for email of Main User by Computer",10,10,"Enter the number of the menu you want to enter:",10,0

;error messages
inputerror: db "I am sorry, but I couldn't understand your input",10,"Please try again:",10,0

;generic messages
yes_msg: db "You selected Yes",0
no_msg: db "You selected No",0

;User Management Menu texts
user_menu_welcome: db 10,"You are in the User account management menu",10,"Please select on of the following options:",10,10,"1. Add a User",10,"2. Delete a User",10,"3. Go to Main Menu",10,10,"Enter the number of the menu you want to enter:",10,0
 ;add user texts
add_user_menu_welcome: db "You can now create a new User",10,"Please enter the Surname:",0
ask_for_first_name_input: db "Please enter the First name:",0
ask_for_department_input: db "Please enter the department fo the user:",0
ask_for_user_id_input: db "Please enter the USER ID in the Format XXXXXXX:",0
ask_for_differnt_user_id_input: db "Sorry, but this USER ID is already taken",10,"Please enter a differnt USER ID:",0
ask_for_emai_input: db "Please enter the email of the user:",10,"(@helpdesk.co.uk will be automatically added to your input)",0
confirm_user_input: db "Thank you. The Following User has been created:",0
 ;delte user textss
delte_user_menu_welcome: db "You selected: Delte a user",10,"Is this correct? enter yes(y) or no(n)",0
ask_for_user_id_delete_input: db "Please enter the User ID you want to delete in following format XXXXXXX:",0
confirm_user_deletion: db "The User with following id has been delteted:",0

;Computer Management Menu texts
computer_menu_welcome: db 10,"You are in the Computer management menu",10,"Please select one of following options:",10,"1. Add a Computer",10,"2. Delete a Computer",10,"3. Go to Main Menu",10,10,"Enter the number of the menu you want to enter:",10,0
 ;add computer texts
add_computer_menu_welcome: db "You can now create a new Computer",10,"Please enter the Computer ID in the Format XXXXXXX:",0
ask_for_differn_computer_id_input: db "Sorry, but this Computer ID is allready taken",10,"Please enter a differnt Computer ID:",0
ask_for_ip_input: db "Please enter the Computer IP in the format XXX.XXX.XXX.XXX:",0
ask_for_main_user_id_input: db "Please enter the ID of the main user in the following Format XXXXXXX:",0
ask_for_existing_user_id_input: db "I am sorry, but I can not find this USER ID",10,"Please enter an exisiting USER ID:",0
ask_for_purchase_date_input: db "Please enter the Date of purchase in following Format dd.mm.yyyy:",0
confirm_computer_input: db "Thank you. The Following computer has been created:",0
 ;delete computer texts
delte_computer_menu_welcome: db "You selected: Delte a Computer",10,"Is this correct? enter yes(y) or no(n)",0
ask_for_computer_id_input: db "Please enter the Computer ID you want to deletes in following format XXXXXXX:",0
confirm_computer_deletion: db "The Computer with following id has been delteted:",0

;Computer Search Menu texts
computer_search_welcome: db 10,"You are in the Computer Search menu",0
ask_for_computer_search_id_input: db "Enter the Computer ID you want ot look up in the following format XXXXXXX:",10,"(Press x go back to Main Menu)",0
computer_search_result_output: db "Following Computer has been found:",0
computer_search_error_output: db "The computer could not be found",0



;User Search Menu texts
user_search_welcome: db 10,"You are in the Email adress of main user Search menu",0
ask_for_user_search_id_input: db "Enter the User ID you want ot look up in the following format XXXXXXX:",10,"(Press x go back to Main Menu)",0
user_search_result_output: db "This is the email of the mail user: ",0
user_search_error_output: db "The computer could not be found",0

;text blocks
email_end: db "@helpdesk.co.uk",0
surname: db "Surname: ",0
firstname: db "First name: ",0
dept: db "Department: ",0
email: db "Email: ",0
user_id: db "User ID: p",0
computer_id: db "Computer ID: c",0
purchase_date: db "Purchase Date: ",0
computer_ip: db "IP Adress: ",0



;File locations
user_file_location: db "users.cvs",0
computer_file_location: db "computers.cvs",0



;index
user_index: dq 0
computer_index: dq 0

;arrays
users: times 26000 db 0
computers: times 2000 dd 0

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


section .text

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
    mov R11, 16
    mul R11
    mov R10, rax
    lea R15, [computers+R10]
    
    mov rax, QWORD [rsp+8]
    mov R11, 16
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
    cmp QWORD [rsp+24], 128
    jne .loop2
    
    mov R14, QWORD[computer_index]
    cmp [rsp+8], R14
    je .end
    inc QWORD [rsp+16]
    inc QWORD [rsp+8]
    jmp .loop1

.end:;make object in index+1 0
    dec QWORD[computer_index]
    pop rbp
    add rsp, 32
    ret

add_computer_id: ;read from rbx
    mov rax, QWORD[computer_index]
    mov R11, 16
    mul R11
    mov R10, rax
    lea rax, [computers+R10]
    mov edx, DWORD ebx
    mov DWORD[rax], edx
    ret
    
add_computer_ip: ;read from rbx
    ;read till dot or null then call atoi put in the 2 8bit register and then left shift to upper 16bit and then fill up lower
    push  rbp
    mov rbp, rsp
    sub rsp, 32 
    
    mov rax, QWORD[computer_index]
    mov R11, 16
    mul R11
    mov R10, rax
    lea rax, [computers+R10+4]
    add_computer_ip_loop1: ;read from rbx
    mov R14,  0
    mov dl, BYTE[rbx]
    add_computer_ip_loop2:
    mov [rsp+R14], dl
    inc rbx
    inc R14
    mov dl, BYTE[rbx]
    cmp dl, 0
    je process_read_ip_part
    cmp dl, 46
    jne add_computer_ip_loop2
process_read_ip_part:
    mov BYTE [rsp+R14], BYTE 0
    mov R15, rax
    mov rdi, rsp
    call atoi
    mov R13, rax 
    mov rax, R15
    mov R12, [rax]
    shl R12, 8
    mov R12B, R13B
    mov [rax], R12
    cmp dl, 0
    je add_computer_ip_end
    inc rbx
    jmp add_computer_ip_loop1
add_computer_ip_end:

    pop rbp
    add rsp, 32
    ret
    
    
add_computer_main_user_id: ;read from rbx
    mov rax, QWORD[computer_index]
    mov R11, 16
    mul R11
    mov R10, rax
    lea rax, [computers+R10+8]
    mov edx, DWORD ebx
    mov [rax], edx
    ret
    
    
add_computer_purchase_date: ;read from rbx
    push  rbp
    mov rbp, rsp
    sub rsp, 32 
    
    mov rax, QWORD[computer_index]
    mov R11, 16
    mul R11
    mov R10, rax
    lea rax, [computers+R10+12]

    mov R14, 0
    mov dl, BYTE[rbx];d
    mov [rsp+R14], dl
    inc rbx
    inc R14
    mov dl, BYTE[rbx];d
    mov [rsp+R14], dl
    inc rbx
    inc R14
    inc rbx;.
    inc R14
    mov BYTE [rsp+R14], BYTE 0  
    mov R15, rax
    mov rdi, rsp
    call atoi
    mov R13, rax 
    mov rax, R15
    mov R12, [rax]
    shl R12, 8
    mov R12B, R13B
    mov [rax], R12
    
     mov R14, 0
    mov dl, BYTE[rbx];m
    mov [rsp+R14], dl
    inc rbx
    inc R14
    mov dl, BYTE[rbx];m
    mov [rsp+R14], dl
    inc rbx
    inc R14
    inc rbx;.
    inc R14
    mov BYTE [rsp+R14], BYTE 0
    mov R15, rax
    mov rdi, rsp
    call atoi
    mov R13, rax 
    mov rax, R15
    mov R12, [rax]
    shl R12, 8
    mov R12B, R13B
    mov [rax], R12
    
    mov R14, 0
    mov dl, BYTE[rbx];y
    mov [rsp+R14], dl
    inc rbx
    inc R14
    mov dl, BYTE[rbx];y
    mov [rsp+R14], dl
    inc rbx
    inc R14
    mov dl, BYTE[rbx];y
    mov [rsp+R14], dl
    inc rbx
    inc R14
    mov dl, BYTE[rbx];y
    mov [rsp+R14], dl
    inc rbx
    inc R14
    inc rbx;.
    inc R14
    mov BYTE [rsp+R14], BYTE 0   
    mov R15, rax
    mov rdi, rsp
    call atoi
    mov R13, rax 
    mov rax, R15
    mov R12, [rax]
    shl R12, 16
    mov R12W, R13W
    mov [rax], R12
    
    pop rbp
    add rsp, 32
    ret
    
print_computer: ; index in rax
    mov R11, 16
    mul R11
    mov R10, rax
    
    mov rdi, QWORD computer_id
    call print_string_new
    lea R12D, [computers+R10]
    mov edi, [R12]
    call print_uint_new 
    call print_nl_new
    
    mov rdi, QWORD computer_ip
    call print_string_new
    lea R11, [computers+R10+4]
    mov R12D, [R11]
    mov R13W, R12W
    shr R12, 16
    mov R14W, R12W
    xor rdx, rdx
    mov dx, R14W
    shr dx, 8
    mov rdi, rdx
    call print_int_new
    mov rdi, 46
    call print_char_new
    xor rdx, rdx
    mov dl, R14B
    mov rdi, rdx
    call print_int_new
    mov rdi, 46
    call print_char_new
    xor rdx, rdx
    mov dx, R13W
    shr dx, 8
    mov rdi, rdx
    call print_int_new
    mov rdi, 46
    call print_char_new
    xor rdx, rdx
    mov dl, R13B
    mov rdi, rdx
    call print_int_new
    
    
    call print_nl_new
    mov rdi, QWORD user_id
    call print_string_new
    lea R12D, [computers+R10+8]
    mov edi, [R12]
    call print_uint_new 
    
    call print_nl_new
    mov rdi, QWORD purchase_date
    call print_string_new
    lea R11, [computers+R10+12]
    mov R12D, [R11]
    mov R13W, R12W
    shr R12, 16
    mov R14W, R12W
    xor rdx, rdx
    mov dx, R14W
    shr dx, 8
    mov rdi, rdx
    call print_int_new
    mov rdi, 46
    call print_char_new
    xor rdx, rdx
    mov dl, R14B
    mov rdi, rdx
    call print_int_new
    mov rdi, 46
    call print_char_new
    xor rdx, rdx
    mov dx, R13W
    mov rdi, rdx
    call print_int_new
    
    call print_nl_new
    call print_nl_new
    ret
    
search_computer_id:
    
    push  rbp
    mov rbp, rsp
    sub rsp, 32 
    mov QWORD[rbp-4], 0
    
search_computer_id_loop: ; search id in R13
    mov rdx, QWORD[computer_index]
    cmp [rbp-4], rdx
    je computer_search_failed
    mov rax, [rbp-4]
    mov R11, 16
    mul R11
    mov R10, rax
    lea rax, [computers+R10]
    mov R14, [rbp-4]
    inc QWORD[rbp-4]
    cmp R13D, [rax]
    jne search_computer_id_loop
    mov rax, R14;return index in rax
    pop rbp
    add rsp, 32
    ret
computer_search_failed:
    mov rax, 504 ;return error 504 in rax
    pop rbp
    add rsp, 32
    ret


search_user_id:
    
    push  rbp
    mov rbp, rsp
    sub rsp, 32 
    mov QWORD[rbp-4], 0
    mov rdx, QWORD[user_index]
    
search_user_id_loop: ; search id in R13
    cmp [rbp-4], rdx
    je user_search_failed
    mov rax, [rbp-4]
    mov R11, 260
    mul R11
    mov R10, rax
    lea rax, [users+R10+256]
    mov R14, [rbp-4]
    inc QWORD[rbp-4]
    cmp R13, [rax]
    jne search_user_id_loop
    mov rax, R14;return index in rax
    pop rbp
    add rsp, 32
    ret
user_search_failed:
    mov rax, 504 ;return error 504 in rax
    pop rbp
    add rsp, 32
    ret  

add_user_name:
    mov rax, QWORD[user_index]
    mov R11, 260
    mul R11
    mov R10, rax
    lea rax, [users+R10]
add_user_name_loop: ;read from rbx
    mov dl, BYTE[rbx]
    mov [rax], dl
    inc rbx
    inc rax
    cmp dl, 0
    jne add_user_name_loop
    ret

add_user_firstname:
    mov rax, QWORD[user_index]
    mov R11, 260
    mul R11
    mov R10, rax
    lea rax, [users+R10+64]
add_user_firstname_loop: ;read from rbx
    mov dl, BYTE[rbx]
    mov [rax], dl
    inc rbx
    inc rax
    cmp dl, 0
    jne add_user_firstname_loop
    ret
    
add_user_department:
    mov rax, QWORD[user_index]
    mov R11, 260
    mul R11
    mov R10, rax
    lea rax, [users+R10+128]
add_user_department_loop: ;read from rbx
    mov dl, BYTE[rbx]
    mov [rax], dl
    inc rbx
    inc rax
    cmp dl, 0
    jne add_user_department_loop
    ret
    
add_user_email:
    mov rax, QWORD[user_index]
    mov R11, 260
    mul R11
    mov R10, rax
    lea rax, [users+R10+192]
add_user_email_loop: ;read from rbx
    mov dl, BYTE[rbx]
    mov [rax], dl
    inc rbx
    inc rax
    cmp dl, 0
    jne add_user_email_loop
    ret

add_user_id:
    mov rax, QWORD[user_index]
    mov R11, 260
    mul R11
    mov R10, rax
    lea rax, [users+R10+256]
    ;read in rbx
    mov edx, DWORD ebx
    mov [rax], edx
    ret
    
print_user: ;index in rax
    mov R11, 260
    mul R11
    mov R10, rax
    mov rdi, QWORD surname
    call print_string_new
    lea rdi, [users+R10]
    call print_string_new
    call print_nl_new
    mov rdi, QWORD firstname
    call print_string_new
    lea rdi, [users+R10+64]
    call print_string_new
    call print_nl_new
    mov rdi, QWORD dept
    call print_string_new
    lea rdi, [users+R10+128]
    call print_string_new
    call print_nl_new
    mov rdi, QWORD email
    call print_string_new
    lea rdi, [users+R10+192]
    call print_string_new
    mov rdi, QWORD email_end
    call print_string_new
    call print_nl_new
    mov rdi, QWORD user_id
    call print_string_new
    lea R12, [users+R10+256]
    mov rdi, [R12]
    call print_uint_new ; make it appear in the format XXXXXXX
    ret
    
    

    
    

main:
    mov rbp, rsp
    push  rbp
    mov rbp, rsp
    sub rsp, 32

    mov rdi, QWORD hello1
    call print_string_new
    call print_nl_new
    
main_menu:    	
    mov rdi, QWORD main_optionselect
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
    call print_nl_new
    call print_nl_new
    jmp main_menu
    
manage_user:
    mov rdi, QWORD user_menu_welcome
    call print_string_new
    call print_nl_new    
    call read_int_new
    jmp read_manage_user_menu_input    
    
read_manage_user_menu_input:
    cmp rax, 1
    je add_user
    cmp rax, 2
    je delete_user
    cmp rax, 3
    je main_menu
    mov rdi, QWORD inputerror
    call print_string_new
    call print_nl_new
    call print_nl_new
    call print_nl_new
    jmp manage_user
    
    
add_user:
    ; check user_index below 499, otherwise give error storage full
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
    mov rdi, QWORD ask_for_department_input
    call print_string_new
    call print_nl_new
    call read_string_new
    mov rbx, rax
    call add_user_department
    mov rdi, QWORD ask_for_user_id_input
    call print_string_new
    call print_nl_new
    call read_int_new
    mov rbx, rax
    ; check if ID below 9999999
    ; check if ID free before writing
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
    call print_nl_new
    mov rax, QWORD[user_index]
    call print_user
    call print_nl_new
    call print_nl_new
    call print_nl_new    
    inc QWORD[user_index]
    jmp manage_user
    
    
delete_user:
    mov rdi, QWORD delte_user_menu_welcome
    call print_string_new
    call print_nl_new
    call yes_or_no
    jne manage_user
    mov rdi, QWORD ask_for_user_id_delete_input
    call print_string_new
    call print_nl_new
    call read_int_new
    ;process user ID, check user id and delete user
    mov rdi, QWORD confirm_user_deletion
    call print_string_new
    call print_nl_new
    call print_nl_new
    call print_nl_new
    jmp manage_user
    

manage_computer:
    mov rdi, QWORD computer_menu_welcome
    call print_string_new
    call print_nl_new
    
    call read_int_new
    jmp read_manage_computer_menu_input

    
read_manage_computer_menu_input:
    cmp rax, 1
    je add_computer
    cmp rax, 2
    je delete_computer
    cmp rax, 3
    je main_menu
    mov rdi, QWORD inputerror
    call print_string_new
    call print_nl_new
    call print_nl_new
    call print_nl_new
    jmp manage_user

add_computer:
    mov rdi, QWORD add_computer_menu_welcome
    call print_string_new
    call print_nl_new
    call read_int_new
    mov rbx, rax
    ;check if ID free
    call add_computer_id
    mov rdi, QWORD ask_for_ip_input
    call print_string_new
    call print_nl_new
    call read_string_new
    mov rbx, rax
    call add_computer_ip
    mov rdi, QWORD ask_for_main_user_id_input
    call print_string_new
    call print_nl_new
    call read_int_new
    mov rbx, rax
    ; check if ID exists
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
    call print_nl_new
    call print_nl_new
    inc QWORD[computer_index]
    jmp manage_computer

delete_computer:
    mov rdi, QWORD delte_computer_menu_welcome
    call print_string_new
    call print_nl_new
    call yes_or_no
    jne manage_computer
    mov rdi, QWORD ask_for_computer_id_input
    call print_string_new
    call print_nl_new
    call read_uint_new ;DOES NOT READ
    ; process computer ID, check computer id and delete computer
    call search_computer_id
    mov rax, 0; for test
    cmp rax, 504
    push rax
    jne .cp_exists 
    mov rdi, QWORD computer_search_error_output
    call print_string_new
    call print_nl_new
    call print_nl_new
    call print_nl_new
    jmp manage_computer
.cp_exists:   
    pop rax 
    call delete_computer_from_array
    mov rdi, QWORD confirm_computer_deletion
    call print_string_new
    call print_nl_new
    call print_nl_new
    call print_nl_new
    jmp manage_computer
        
                
search_computer:
    mov rdi, QWORD computer_search_welcome
    call print_string_new
    call print_nl_new
search_computer_loop:
    mov rdi, QWORD ask_for_computer_search_id_input
    call print_string_new
    call print_nl_new
    call read_string_new
    mov bl, BYTE[rax] 
    cmp bl, 120
    je manage_computer
    mov rdi, rax
    call atoi
    mov R13, rax
    call search_computer_id
    cmp rax, 504
    jne search_computer_exists    
    mov rdi, QWORD computer_search_error_output
    call print_string_new
    call print_nl_new
    call print_nl_new
    call print_nl_new
    jmp search_computer_loop
search_computer_exists:
    mov rdi, QWORD computer_search_result_output
    push rax
    call print_string_new
    call print_nl_new
    pop rax
    call print_computer
    jmp search_computer_loop
    
    
    jmp end;

find_main_user:
    mov rdi, QWORD user_search_welcome
    call print_string_new
    call print_nl_new
find_user_loop:
    mov rdi, QWORD ask_for_user_search_id_input
    call print_string_new
    call print_nl_new
    call read_string_new
    mov bl, BYTE[rax] 
    cmp bl, 120
    je manage_computer
    mov rdi, rax
    call atoi
    mov R13, rax
    call search_computer_id
    cmp rax, 504
    jne find_computer_exists    
    mov rdi, QWORD user_search_error_output
    call print_string_new
    call print_nl_new
    call print_nl_new
    call print_nl_new
    jmp find_user_loop;
find_computer_exists:
    mov rdi, QWORD user_search_result_output
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
    call print_nl_new
    call print_nl_new
    jmp find_user_loop;
    
    
yes_or_no:
    call read_char_new
    cmp rax, 121
    ret
    
end:
    add rsp, 32
    pop rbp
    ret