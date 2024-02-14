# ChatterBox
Project Description
Our project is a web-based chat application called ChatterBox. 
ChatterBox will be similar to Discord or Microsoft Teams where users can join groups/channels based on interest where you can publicly chat with other people. After making an account, users will be able to edit or update their personal information such as their name, email address, about me, and notification preferences. Users can also send private/direct messages to people outside the channels and (time permitting) be able to add them as friends and delete private/direct messages. 
Users will be able to create and administer new channels, remove users from their channels, and delete messages they deem inappropriate. Admins will also be able to appoint other users in the channel to admin status with all the same abilities (removing users, deleting messages etc). 
(tentative) Admins can set channels to a private, invite only status, where only current members are able to invite people to the channel. They can also set channels to a public status, where users can see the channel but must make a request to join. Once a member of a channel, users can invite friends to the channel, send messages, participate in group discussions, and if the conversations no longer interest them, they are able to leave without admin approval. 
If unable to have private invite only channels, users will be able to see all available channels and join whichever ones they want (default setting unless able to implement private channels).

User Requirements
Register
Log In
Create Channels and invite others to join
Create Channel
Send text messages, directly to another user OR into a channel
Update personal information including name, last name, bio,  and address

EXCLUSIVE ADMINISTRATOR REQUIREMENTS
Manage Channels
Appoint others to become admins
Remove members, delete messages

OPTIONAL REQUIREMENTS
Sending pictures, videos, files
Friend Requests
Delete message in DMs

Functional Requirements
Database for user information, channel information and direct messages
Graphical user interface that allows the users access to all functionalities
Registration: add new user information to database, send confirmation notification
Login: allow access to personal profile information, channel, and message information
Change personal profile information in database
Show available people to chat with
Add new direct message to database
Add new message in channel to database 
Add new channel information to database (automatically promotes the user  associated with the channel creation to administrator status)

EXCLUSIVE ADMINISTRATOR REQUIREMENTS
Change channel information in database
Add new admin to channel information in database 
Remove channel member, messages in channel from database

Non-Functional Requirements
Maintenance: Ensure that bugs can be easily fixed without the website breaking down. Make sure that the website can be updated smoothly and without breaking down. 
Data Backup: using a database to make sure all information can be recovered if the site breaks down.

OPTIONAL NON FUNCTIONAL REQUIREMENTS
System to log user activity, monitor breakdowns etc.
Profile customization
Design: Logos, background colours etc. (would it look like discord or we design our own way?)
User Friendly Environment: Text size ratios, Fonts, Easily navigable 
