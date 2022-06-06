

|           |           |
| ------------- | ------------- |
**Name:**            | Register an account
**Actor:**           | User  
**Description:**     | A user registers an account with the Amicus app
**Precondition(s):** | <ul><li>User has access to an email account</li></ul>
**Scenario:**        | <ol><li>User enters the following information: </br>- Profile Picture </br>- First Name </br>- Second Name </br>- Username</li> <li>System checks if the actor entered the required data</li> <li>User enters an email</li> <li>System chechs if the email is valid</li> <li>User provides an email address<li>System validates email address</li></li><li>User provides a password and confirms it</li><li>System verifies that the password match and the strength</li><li>User submits registration request</li><li>System processes registration</li></ol>  
**Result:**          | User has successfully created an account with Amicus
**Exception:**       | <ul><li>No exceptions</li></ul>
<br><br>

|           |           |
| ------------- | ------------- |
**Name:**            | Log into an Amicus app account
**Actor:**           | User  
**Description:**     | A user logs into an Amicus app account
**Precondition(s):** | <ul><li>An existing Amicus app account</li></ul>
**Scenario:**        | <ol><li>User enters email and password</li><li>System verifies credentials</li><ul><li>If the account credentnials match, continue</li><li>Otherwise throw Exception 1</li></ul></ol>  
**Result:**          | User is logged in or needs to re-enter their credentials after an exception was thrown
**Exception:**       | <ul><li>Exeption 1: Invalid credentials</li></ul>
<br><br>


|           |           |
| ------------- | ------------- |
**Name:**            | Post a new request 
**Actor:**           | User  
**Description:**     | User wants to post a new request
**Precondition(s):** | <ul><li>User has loged into the system</li></ul>
**Scenario:**        | <ol><li>User goes for new request option</li><li>System shows an empty submit request window</li><li>User enters the following information:</br>- Category </br>- Topic </br>- Problem description </br>- Picture </br>- Location </li><li>User chooses to submit the request<li>System proccesses the request and saves it</li><br></ol>  
**Result:**          | User has commited a help request.  
**Exception:**       | <ul><li>4. Not all fields have been filled out correctly</li><li>4.1 Return to step 3</li></ul>
<br><br>

|           |           |
| ------------- | ------------- |
**Name:**            | Choose and Accept request 
**Actor:**           | Expert  
**Description:**     | An expert chooses an optimal request he can provide help for
**Precondition(s):** | <ul><li>User has submitted a help request</li></ul>
**Scenario:**        | <ol><li>Actor opens the expert page</li><li>System displays the request submitted to the expert category</li><li>Expert chooses a fitting help request from the list</li><li>System displays the details of the request<li>Expert gives advice and accepts the request</li><li>System saves the  advice and closes the request</li><br></ol>  
**Result:**          | Expert chose a fitting request that he will provide optimal help for.  
**Exception:**       | <ul><li>Exception 2.1: No request has been submitted</li></ul>
**Extension:**       | <ul><li> 6. System sends notification to the user that created the request
<br><br>



|           |           |
| ------------- | ------------- |
**Name:**            | Look up requester history
**Actor:**           | User  
**Description:**     | A user looks up their submitted help requests
**Precondition(s):** | <ul><li>User is logged in</li><li>User has submitted help requests</li></ul>
**Scenario:**        | <ol><li>User opens history view</li><li>System shows a list with the user closed requests</li><li>User taps on their help requests</li><li>System shows all the details of the request<br></ol>  
**Result:**          | User can see their closed help requests 
**Exception:**       | <ul><li>No exceptions</li></ul>
<br><br>

|           |           |
| ------------- | ------------- |
**Name:**            | Look up expert history
**Actor:**           | User  
**Description:**     | A user looks up requests that they helped with
**Precondition(s):** | <ul><li>User is logged in</li><li>User is an expert</li><li>User has helped with a request before</li></ul>
**Scenario:**        | <ol><li>User opens the homepage</li><li>System shows filtered navigation depending on expertise</li><li>User taps on their helped with requests</li><li>System shows users the requests they helped<br></ol>  
**Result:**          | User can see their helped with requests 
**Exception:**       | <ul><li>No exceptions</li></ul>
<br><br>

  |           |           |
| ------------- | ------------- |
**Name:**            | Look up profile
**Actor:**           | User  
**Description:**     | A user looks up his own profile
**Precondition(s):** | <ul><li>User is logged in</li></ul>
**Scenario:**        | <ol><li>User opens the profile</li><li>System shows the users information</li></ol>  
**Result:**          | Users can see their own profile
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
