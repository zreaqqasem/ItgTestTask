# ItgTestTask
Itg Test Task For Ios Position.

# itg test task flow :

1- the code done in swift language 

2- the data store using core data to work ofline when no internet connection

3- the idea of the task is to using gitub api for all users on it and show it in a table view 

the data comes using my own pagination way since data comes 30 one by each api call so i did the following

on first api call the first 30 users save in core data model as an array of UserInfo Model

i searched alot about ios pagination and i didn't found any one as i want to implement it from the bottom 

# so i found an idea and its wark as follow :

at first i just reverse the array of data connect with table view and sort it 

my table view and it's content is upside down 

when refresh i scroll bottom(cause my table is upside down) by 30 rows which 30 is the count of the new users to make users scroll from the last one 

as example pagination of instgram story views or instfram direct and so on.

# when user close app and reopen it it first check if there's previous data from previous launches 

if there's a data i just append these data to usellistviewmodel array and start my next api call from these data.



