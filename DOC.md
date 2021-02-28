# Code Documentation
### A simple record system in x86 assembler
##### by [Alexander Sworski](www.dev-sworski.com)
All rights reserved
### Version 1.0.0

A simple record system in 64 bit x86 assembler to keep track of computers and user.

---

## global variables:
- **currentdate**:
        Contains the current date, will be filled by the function get_current_date
- **users**:
        A array of 100 users
- **computers**:
        A array of 500 computers
- **user_index**:
        The count of how many users are in the array
- **computer_index**:
        The count of how many computer are in the array

---

## functions:

#### _print_id_
Prints the ID int he Fromat XXXXXXX\n
+ parameters:
    + _rdi_: `INT32` ID


#### _print_current_date_
Prints the curent date in the Format d.m.yyyy
call [get_current_date](#_get_current_date_) before

#### _get_current_date_
save the current date to [currentdate](#global-variables) 


#### _print_os_
Prints the name of the OS
+ parameters:
    + _rdx_: `INT8`  index
+ errors:
    + prints error to the screen if index out of bound


#### _print_department_
Prints the name of the department
+ parameters:
    + _rdx_: `INT8`  index
+ errors:
    +  prints error to the screen if index out of bound

#### _delete_user_from_array_
Deletes a User at index from [usera](#global-variables) 
+ parameters:
    + _rax_: `INT64` index
+ comments:
    +  moves all folowing users one place forward in the array
+ **_WARNING:_**
    +   no check if index out of bound 

#### _delete_computer_from_array:_
deletes a Computer at index from [computers](#global-variables) 
+ parameters:
    + _rax_: `INT64` index
+ comments:
    +  moves all folowing computer one place forward in the array
+ **_WARNING:_**
    +   no check if index out of bound 
    
#### _add_computer_id_
Adds a computer id to the new computer in [computers](#global-variables) 
+ parameters:
    + _rbx_: `INT32`computer id

    
#### _add_computer_ip_
Add a IP to the new computer in [computers](#global-variables)
+ parameters:
    + _rbx_: `string*` ip in format `XXX.XXX.XXX.XXX`
+ checks:
    + check 1: input format correct, asks to enter it again if not
    + check 2: checks if the IP is already used by a different computer in the array


    
#### _add_computer_main_user_id_
Adds a user id to the new computer in [computers](#global-variables)
+ parameters:
    + _rbx_: `INT32` user id
+ comments:
    +  should check in advance, if the user id exists


    
#### _add_computer_os_
As the enumaration of the OS to the new computer in [computers](#global-variables)
+ parameters:
    + _rbx_: `INT8` os
+ comments:
    +  check in advance if os enumaration is correct


    
#### _add_computer_purchase_date_
Adds the purchase date to the new computer in [computers](#global-variables)
+ parameters:
    + _rbx_: `string*` date in format dd.mm.yyyy
+ checks:
    +  check 1: date in valid format, other asks to enter again
    + check 2: check of day between 1-31, month between 1-12 and year between 1900-2100, other asks to enter again
    + check 3: check if date equals today or past. If date in future, then asks to enter again



    
#### _print_computer_
Prints computer at index from [computers](#global-variables)
+ parameters:
    + _rax_: `INT64` index 
+ **WARNING:**:
    +  no check for index out of bound


    
#### _search_computer_id_
Searches for a Computer with the ID in [computers](#global-variables)
+ parameters:
    + _R13_: `INT32` Computer ID
+ return:
    + _rax_: `INT64` index
+ error:
    + _rax_ = 504 "computer not found"
+ comments:
    +  No check if ID in valid format. Invalid input will not crash but give error 504


    
#### _search_user_id_
Searches for a User with the ID in [computers](#global-variables)
+ parameters:
    + _R13_: `INT32` User ID
+ return:
    + _rax_: `INT64` index
+ error:
    + _rax_ = 504 "user not found"
+ comments:
    +  No check if ID in valid format. Invalid input will not crash but give error 504


    
#### _add_user_name_
Add User Name of new User in [users](#global-variables)
+ parameters:
    + _rbx_: `string*` name 
+ checks:
    +  check 1: if string lenght between 1 and 64, otherwise asks to enter name again


    
#### _add_user_firstname_
Add User First Name of new User in [users](#global-variables)
+ parameters:
    + _rbx_: `string*` name 
+ checks:
    +  check 1: if string lenght between 1 and 64, otherwise asks to enter frist name again 


    
#### _add_user_department_
Adds the department enummaration to the new user in [users](#global-variables)
+ parameters:
    + _rbx_: `INT8` department
+ comments:
    +  The department will not be checked and should be checked beforehand 


    
#### _add_user_email_
Add the user email to the new user in [users](#global-variables)
+ parameters:
    + _rbx_: `string*` email 
+ checks:
    +  check 1: if string between 1 and 64 chars long, otherwise ask to reenter
    + check 2: check if email has not yet been taken by another user in the array, otherwise ask to reenter 


    
#### _add_user_id_
Add the id to the new user in [users](#global-variables)
+ parameters:
    + _rbx_: `INT32` ID   
+ **WARNING:**:
    +  does not check if ID unique, needs to be checked before!


    
#### _print_user_
Prints the user at index in [users](#global-variables)
+ parameters:
    + _rbx_: `INT64` index 


    
#### _main_
Prints welcoem message
+ commenst:
    + calls [get_current_date](#_get_current_date_)
    + calls [main_menu](#_main_menu_)


    
#### _main_menu_
prints options in the main menu and waits for user selection
Options:
1. [Manage Users](#_user_menu_)
2. [Manage Computers](#_computer_menu_)
3. [Search](#_search_menu_)
4. EXIT
+ checks if user selection valid and then calls the selected menu, otherwise asks for reseletion


    
#### _user_menu_
shows user menu
prints options in the user menu and waits for user selection
Options:
1. [Add Users](#_add_user_)
2. [Delete User](#_delete_user_)
3. [Go back to main menu](#_main_menu_)
+ checks if user selection valid and then calls the selected option, otherwise asks for reseletion


    
#### _computer_menu_
shows computer menu
prints options in the computer menu and waits for user selection
Options:
1. [Add Computer](#_add_computer_)
2. [Delete Computer](#_delete_computer_)
3. [Go back to main menu](#_main_menu_)
+ checks if user selection valid and then calls the selected option, otherwise asks for reseletion


    
#### _search_menu_
 shows search menu
 prints options in the search menu and waits for user selection
 Options:
 1. [Search Computer](#_search_computer_)
 2. [Search Users](#_search_user_)
 3. [Search Main User](#_find_main_user_)
 4. [Print all User](#_print_all_user_)
 5. [Print all Computer](#_print_all_computer_)
 6. [Amount of Users](#_print_num_users_)
 7. [Amount of Computers](#_print_num_computers_)
 8. [Go back to main menu](#_main_menu_)
+ checks if user selection valid and then calls the selected option, otherwise asks for reseletion


    
#### _add_user_
Shows the Input Masks for adding a User
+ checks:
    + check 1: department code betweem 1-3
    + check 2: user id valid format
    + check 3: user id unique
    + check 4: user array still has space


    
#### _delete_user_
Shows the Input Masks for deleting a User
+ checks:
    + check 1: user id valid format
    + check 2: user id exists


    
#### _add_computer_
Shows the Input Masks for adding a Computer
+ checks:
    + check 1: os code betweem 1-3
    + check 2: computer id valid format
    + check 3: computer id unique
    + check 4: computer array still has space
    + check 5: main user id exists
    + check 6: main user id valid format


    
#### _delete_computer_
Shows the Input Masks for deleting a Computer
+ checks:
    + check 1: computer id valid format
    + check 2: compiter id exists


    
#### _search_user_
Shows the Input Masks for searching a User
+ comment:
    + User can exit by enter x  
+ checks:
    + check 1: user id has valid format


    
#### _search_computer_
Shows the Input Masks for searching a computer
+ comment:
    + computer can exit by enter x  
+ checks:
    + check 1: computer id has valid format


    
#### _find_main_user_
Shows the Input Masks for searching a main user of a computer
+ comment:
    + computer can exit by enter x  
+ checks:
    + check 1: computer id has valid format


    
#### _print_all_user_
Prints all users


    
#### _print_all_computer_
Prints all Computers



#### _print_num_users_
Prints the amount of Users currently stored



#### _print_num_computers_
Prints the amount of computers currently stored

