

|           |           |
| ------------- | ------------- |
**Name:**            | Register an account
**Actor:**           | User  
**Description:**     | A user registers an account with the Amicus app
**Precondition(s):** | <ul><li>User has access to an email account</li></ul>
**Scenario:**        | <ol><li>User provides a username for their account</li><li>System checks if the name is taken</li><ul><li>If the name is not taken, continue</li><li>Otherwise prompt for a different name</li></ul><li>User provides an email address<li>System validates email address</li></li><li>User provides a password</li><li>System verifies password strength</li><li>User submits registration request</li><li>System processes registration request</li></ol> 
**Result:**          | User has successfully created an account with Amicus
**Exception:**       | <ul><li>No exceptions</li></ul>
<br><br>

|           |           |
| ------------- | ------------- |
**Name:**            | Log into an Amicus app account
**Actor:**           | User  
**Description:**     | A user logs into an Amicus app account
**Precondition(s):** | <ul><li>An existing Amicus app account</li></ul>
**Scenario:**        | <ol><li>User enters username and password</li><li>System verifies credentials</li><ul><li>If the account credentnials match, continue</li><li>Otherwise throw Exception 1</li></ul></ol>  
**Result:**          | User is logged in or needs to re-enter their credentials after an exception was thrown
**Exception:**       | <ul><li>Exeption 1: Invalid credentials</li></ul>
<br><br>

|           |           |
| ------------- | ------------- |
**Name:**            | Edit user information 
**Actor:**           | User  
**Description:**     | A user edits his/her account
**Precondition(s):** | <ul><li>The user is logged in</li></ul>
**Scenario:**        | <ol><li>Go to profile page</li><li>System shows the profile page</li><li>User can edit different information (email, password, username, birthdate, profile picture)</li><li>System verifies the new input</li><li>User submits the changes</li><li>System updates the informations with the new ones</li><br></ol>  
**Result:**          | User can edit the information  
**Exception:**       | <ul><li>3. The fields are not filled out correctly</li><li>3.1 Return to step 3</li></ul>
<br><br>

|           |           |
| ------------- | ------------- |
**Name:**            | Edit expert categories  
**Actor:**           | User, Expert  
**Description:**     | A user can edit the categories
**Precondition(s):** | <ul><li>The user is logged in</li></ul>
**Scenario:**        | <ol><li>User goes to profile page</li><li>System shows the profile page</li><li>User can add a new category and a picture with the diploma</li><li>System validates the data and saves it</li><br></ol>  
**Result:**          | User can add a new cateogry  
**Exception:**       | <ul><li>4. The data is not valid</li><li>4.1 Return to step 3</li></ul>
**Extension:**       | <ul><li>3. User selects the option to leave a category</li></ul>
<br><br>

|           |           |
| ------------- | ------------- |
**Name:**            | Submit a help request 
**Actor:**           | User  
**Description:**     | User wants to submit a help request
**Precondition(s):** | <ul><li>User has loged into the system</li></ul>
**Scenario:**        | <ol><li>User opens a new help request</li><li>System shows an empty submit request window</li><li>User enters the following information: </br>- Request title </br>- Picture </br>- Description </br>- Category </li><li>User chooses to submit the request<li>System proccesses the request and saves it to the database</li><br></ol>  
**Result:**          | User has commited a help request.  
**Exception:**       | <ul><li>5. Not all fields have been filled out correctly</li><li>5.1 Return to step 3</li></ul>
**Extension:**       | <ul><li>3. User adds his address information</li></ul>
<br><br>

|           |           |
| ------------- | ------------- |
**Name:**            | Choose and Accept request 
**Actor:**           | Expert  
**Description:**     | An expert chooses an optimal request he can provide help for
**Precondition(s):** | <ul><li>User has submitted a help request</li></ul>
**Scenario:**        | <ol><li>Expert opens the request page</li><li>System displays the request submitted to the expert.</li><li>Expert chooses a fitting help request</li><li>System displays the details of the request<li>Expert accepts the request</li><br></ol>  
**Result:**          | Expert chose a fitting request that he will provide optimal help for.  
**Exception:**       | <ul><li>Exception 2.1: No request has been submitted</li><li> Exception 5.1: The Expert denies the request</li></ul>
<br><br>


|           |           |
| ------------- | ------------- |
**Name:**            | Provide help (—> not helping problem gets sent back Close / finish request —> extension to ratings) 
**Actor:**           | User (Expertise & Basic User)  
**Description:**     | Expertise helps the user with the help request
**Precondition(s):** | <ul><li>Both users are logged in</li><li>Expertise category has been validated</li><li>Help request has been published by the user</li><li>Expertise has accepted help request</li></ul>
**Scenario:**        | <ol><li>Expertise chooses to open the accepted help request</li><li>System displays a chat room with options to share information with the user requesting help</li><li>Expertise provides help to user</li><li>System notifies user that help have been provided</li><li>System displays a chat room with options to share information with the user requesting help</li><li>User reads message and closes help request</li><li>System closes help request and give both users the option to give a review</li><li>Users give a review</li><li>System fully closes the help request</li><br></ol>  
**Result:**          | User help request has been solved by the Expertise.
**Extension:**       | <ul><li>3.a. Expertise requests more information from user</li><li>4. System notifies user about the message income</li><li>5. User provides Expertise with more information (pictures, location, ...)</li><li>6. System notifies expertise about the message income</li><li>7. Go to step 3.</li></ul>
**Exception:**       | <ul><li>3.a. Expertise can help the user and rejects help request</li><li>4. System deletes chat room and leaves help request open</li></ul>
<br><br>

|           |           |
| ------------- | ------------- |
**Name:**            | Look up requester history
**Actor:**           | User  
**Description:**     | A user looks up their submitted help requests
**Precondition(s):** | <ul><li>User is logged in</li><li>User has submitted help requests</li></ul>
**Scenario:**        | <ol><li>User opens navigation</li><li>System shows filtered navigation depending on expertise</li><li>User taps on their help requests</li><li>System shows users submitted help requests in a list<br></ol>  
**Result:**          | User can see their submitted help requests 
**Exception:**       | <ul><li>No exceptions</li></ul>
<br><br>

|           |           |
| ------------- | ------------- |
**Name:**            | Look up expert history
**Actor:**           | User  
**Description:**     | A user looks up requests that they helped with
**Precondition(s):** | <ul><li>User is logged in</li><li>User is an expert</li><li>User has helped with a request before</li></ul>
**Scenario:**        | <ol><li>User opens navigation</li><li>System shows filtered navigation depending on expertise</li><li>User taps on their helped with requests</li><li>System shows users the requests they helped with in a list<br></ol>  
**Result:**          | User can see their helped with requests 
**Exception:**       | <ul><li>No exceptions</li></ul>
<br><br>


|           |           |
| ------------- | ------------- |
**Name:**            | Some
**Actor:**           | Some  
**Description:**     | Some
**Precondition(s):** | <ul><li>Some</li><li>Some</li></ul>
**Scenario:**        | <ol><li>Step1</li><li>Step2</li><li>Step3</li><li>Step 4<br></ol>  
**Result:**          | Result.  
**Exception:**       | <ul><li>Exeption1</li><li>Exception 2</li></ul>
<br><br>
