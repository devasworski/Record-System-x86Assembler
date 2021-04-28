# Coursework 1 (NETW7006 - Malware Analysis)


<img src="https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fstatic.brookes.ac.uk%2Fabout%2Fidentity%2Flogos%2Fbrookes_logo_charcoal_cmyk.jpg&f=1&nofb=1" height=80>


Module Leader: Dr Muhammad Hilmi Kamarudin

Semester 2 

Due: 5th March 2021.

#### Final Mark: Distinction (88/100)

## Assignment
Write, in 64 bit x86 assembler, a simple record system to keep track of computers and users.

## Requirements

#### The system must be able to store the following information about computers:
- Computer name
- IP address
- OS (can be any one of Linux, Windows, or Mac OSX)
- User ID of main user
- Date of purchase

#### The system must be able to store the following information about people:
- Surname
- First Name
- Dept (can be any one of Development, IT Support, Finance, or HR)
- User ID
- Email address

#### The system must allow the following operations:
- Add/delete user
- Add/delete computer
- Search for computer given a computer name
- Search for a user’s email address given a computer name

#### Following assumptions about the system have been made:
- First names and surnames, all have a maximum size of 64 chars
- Computer names are unique, and are in the form of cXXXXXXX where XXXXXXX is any 7 digit number
- User IDs are unique, and are in the form of pXXXXXXX where XXXXXXX is any 7 digit number
- Email addresses are in the form @helpdesk.co.uk
- There is a maximum of 100 users and 500 computers on the system

## Learning Outcome
This coursework is designed to test your attainment of the following learning outcome:
Design and create assembly language programmes, with an awareness of how assembly programming differs from conventional programming.
