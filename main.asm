%include "/home/malware/asm/joey_lib_io_v6_release.asm"

global main

section .data

;Main Menu texts
hello1: db "--------------------------------------------------------------------",10,"STUDENT AND COMPUTER ORGANISER 3000",10,"--------------------------------------------------------------------",10,"© Alexander Sworski 19131287",10,0
main_optionselect: db "Please select one of the following options:",10,10,"1. Manage User account",10,"2. Manage Computers",10,"3. Search for Computer",10,"4. Search for Main User of a Computer",10,10,"Enter the number of the menu you want to enter:",10,0

;error messages
inputerror: db "I am sorry, but I couldn't understand your input",10,"Please try again:",10,0

;generic messages
yes_msg: db "You selected Yes",0
no_msg: db "You selected No",0

;User Management Menu texts
user_menu_welcome: db "You are in the User account management menu",10,"Please select on of the following options:",10,10,"1. Add a User",10,"2. Delete a User",10,"3. Go to Main Menu",10,10,"Enter the number of the menu you want to enter:",10,0
 ;add user texts
add_user_menu_welcome: db "You can now create a new User",10,"Please enter the Surname:",0
ask_for_first_name_input: db "Please enter the First name:",0
ask_fordepartment_input: db "Please enter the department fo the user:",0
ask_for_user_id_input: db "Please enter the USER ID in the Format XXXXXXX:",0
ask_for_differnt_user_id_input: db "Sorry, but this USER ID is already taken",10,"Please enter a differnt USER ID:",0
ask_for_emai_input: db "Please enter the email of the user:",10,"(@helpdesk.co.uk will be automatically added to your input)",0
confirm_user_input: db "Thank you. The Following User has been created:",0
 ;delte user texts
delte_user_menu_welcome: db "You selected: Delte a user",10,"Is this correct? enter yes(y) or no(n)",0
ask_for_user_id_delete_input: db "Please enter the User ID you want to delete in following format XXXXXXX:",0
confirm_user_deletion: db "The User with following id has been delteted:",0

;Computer Management Menu texts
computer_menu_welcome: db "You are in the Computer management menu",10,"Please select one of following options:",10,"1.Add a Computer",10,"2. Delete a Computer",10,"3. Go to Main Menu",10,10,"Enter the number of the menu you want to enter:",10,0
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
computer_search_welcome: db "You are in the Computer Search menu",0
ask_for_computer_search_id_input: db "Enter the Computer ID you want ot look up in the following format XXXXXXX:",10,"(Press x go back to Main Menu)",0
computer_search_error_output: db "The computer could not be found"

s

;User Search Menu texts
user_search_welcome: db "You are in the Main User by Computer Search menu",0
ask_for_user_search_id_input: db "Enter the User ID you want ot look up in the following format XXXXXXX:",10,"(Press x go back to Main Menu)",0
user_search_error_output: db "The user could not be found",0



;File locations
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
    jmp main_menu
    
manage_user:
    mov rdi, QWORD user_menu_welcome
    call print_string_new
    call print_nl_new
    
    ;mov rdi, QWORD userfile
    ;call read_files
    mov rdi, [rax]
    call print_string_new
    
    jmp end;

manage_computer:
    mov rdi, QWORD computer_menu_welcome
    call print_string_new
    call print_nl_new
    
    jmp end;
    
search_computer:
    mov rdi, QWORD computer_search_welcome
    call print_string_new
    call print_nl_new
    
    jmp end;

find_main_user:
    mov rdi, QWORD user_search_welcome
    call print_string_new
    call print_nl_new
    
    jmp end;
    
    
yes_or_no:
    call read_char_new
    cmp rax, 121
    jne no
    mov rdi, QWORD yes_msg
    jmp yes_or_no_end
no:    
    mov rdi, QWORD no_msg
yes_or_no_end:
    call print_string_new
    call print_nl_new
    ret
    
end:
    add rsp, 32
    pop rbp
    ret