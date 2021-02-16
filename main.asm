%include "/home/malware/asm/joey_lib_io_v6_release.asm"

global main

section .data

;Main Menu texts
hello1: db "--------------------------------------------------------------------",10,"STUDENT AND COMPUTER ORGANISER 3000",10,"--------------------------------------------------------------------",10,"© Alexander Sworski 19131287",10,0
main_optionselect: db 10,"Please select one of the following options:",10,10,"1. Manage User account",10,"2. Manage Computers",10,"3. Search for Computer",10,"4. Search for email of Main User for a Computer",10,10,"Enter the number of the menu you want to enter:",10,0

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
ask_for_ip_input: db "Please enter the computer ID in the format XXX.XXX.XXX.XXX:",0
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
user_search_result_output: db "This is the email of the mail user:",0
user_search_error_output: db "The computer could not be found",0

;text blocks
email_end: db "@helpdesk.co.uk",0



;File locations
user_file_location: db "users.cvs",0
computer_file_location: db "computers.cvs",0


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

add_user_name: ;index in rax
    mov R11, 260
    mul R11
    mov R10, rax
    lea rax, [users+R10]
add_user_name_loop: ;read in rbx
    mov dl, BYTE[rbx]
    mov [rax], dl
    inc rbx
    inc rax
    cmp dl, 0
    jne add_user_name_loop
    ret

add_user_firstname: ;index in rax
    mov R11, 260
    mul R11
    mov R10, rax
    lea rax, [users+R10+64]
add_user_firstname_loop: ;read in rbx
    mov dl, BYTE[rbx]
    mov [rax], dl
    inc rbx
    inc rax
    cmp dl, 0
    jne add_user_firstname_loop
    ret
    
add_user_department: ;index in rax
    mov R11, 260
    mul R11
    mov R10, rax
    lea rax, [users+R10+128]
add_user_department_loop: ;read in rbx
    mov dl, BYTE[rbx]
    mov [rax], dl
    inc rbx
    inc rax
    cmp dl, 0
    jne add_user_department_loop
    ret
    
add_user_email: ;index in rax
    mov R11, 260
    mul R11
    mov R10, rax
    lea rax, [users+R10+192]
add_user_email_loop: ;read in rbx
    mov dl, BYTE[rbx]
    mov [rax], dl
    inc rbx
    inc rax
    cmp dl, 0
    jne add_user_email_loop
    ret

add_user_id: ;index in rax
    mov R11, 260
    mul R11
    mov R10, rax
    lea rax, [users+R10+256]
    ;read in rbx
    mov edx, DWORD ebx
    mov [rax], edx
    ret
    
write_user:
    mov R11, 260
    mul R11
    mov R10, rax
    lea rdi, [users+R10]
    call print_string_new
    call print_nl_new
    lea rdi, [users+R10+64]
    call print_string_new
    call print_nl_new
    lea rdi, [users+R10+128]
    call print_string_new
    call print_nl_new
    lea rdi, [users+R10+192]
    call print_string_new
    call print_nl_new
    lea R12, [users+R10+256]
    mov rdi, [R12]
    call print_uint_new
    ret
    
    

    
    

main:
    mov rbp, rsp; for correct debugging 
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
    mov rdi, QWORD add_user_menu_welcome
    call print_string_new
    call print_nl_new
    call read_string_new
    ;----- read surname from RAX
    mov rbx, rax
    mov rax, 0 ;index
    call add_user_name
    ;-----
    mov rdi, QWORD ask_for_first_name_input
    call print_string_new
    call print_nl_new
    call read_string_new
    ;----- read firstname from RAX
    mov rbx, rax
    mov rax, 0 ;index 
    call add_user_firstname
    ;-----
    mov rdi, QWORD ask_for_department_input
    call print_string_new
    call print_nl_new
    call read_string_new
    ;----- read department from RAX
    mov rbx, rax
    mov rax, 0 ;index 
    call add_user_department
    ;-----
    mov rdi, QWORD ask_for_user_id_input
    call print_string_new
    call print_nl_new
    call read_int_new
    ;----- read id from RAX
    mov rbx, rax
    mov rax, 0 ;index 
    ; check if ID free before writing
    call add_user_id
    ;-----
    mov rdi, QWORD ask_for_emai_input
    call print_string_new
    call print_nl_new
    call read_string_new
    ;----- email id from RAX
    mov rbx, rax
    mov rax, 0 ;index 
    call add_user_email
    ;-----
    mov rdi, QWORD confirm_user_input
    call print_string_new
    call print_nl_new
    call write_user
    call print_nl_new
    call print_nl_new
    call print_nl_new
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
    ; read ID from RAX
    ;check if ID free
    mov rdi, QWORD ask_for_ip_input
    call print_string_new
    call print_nl_new
    call read_string_new
    ; read ip from RAX
    mov rdi, QWORD ask_for_main_user_id_input
    call print_string_new
    call print_nl_new
    call read_int_new
    ; read main user from RAX
    ; check if ID exists
    mov rdi, QWORD ask_for_user_id_input
    call print_string_new
    call print_nl_new
    call read_string_new
    ; read id from RAX
    mov rdi, QWORD ask_for_purchase_date_input
    call print_string_new
    call print_nl_new
    call read_string_new
    ; date id from RAX
    mov rdi, QWORD confirm_computer_input
    call print_string_new
    call print_nl_new
    ; load computer info in rdi
    call print_string_new
    call print_nl_new
    call print_nl_new
    call print_nl_new
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
    call read_int_new
    ; process computer ID, check computer id and delete computer
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
    cmp bl, 120 ; check if input = x
    je manage_computer
    ;check if computer exists and jmp to search_computer_exists
    mov rdi, QWORD computer_search_error_output
    call print_string_new
    call print_nl_new
    call print_nl_new
    call print_nl_new
    jmp search_computer_loop
search_computer_exists:
    mov rdi, QWORD computer_search_result_output
    call print_string_new
    call print_nl_new
    call print_nl_new
    call print_nl_new
    ; print out computer info
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
    cmp bl, 120 ; check if input = x
    je manage_computer
    ;check if computer exists and jmp to find_computer_exists  
    mov rdi, QWORD user_search_error_output
    call print_string_new
    call print_nl_new
    call print_nl_new
    call print_nl_new
    jmp find_user_loop;
find_computer_exists:
    mov rdi, QWORD user_search_result_output
    call print_string_new
    ; print out email
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