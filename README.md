# ACF Discussion Group
A web app dedicated to Asian Christian Fellowship's large group and discussion group management located at Carnegie Mellon University and University of Pittsburgh.  

## Setting up (project team members)

* Make sure you already went through the "Set up Lab"
* Because we will be using pull requests, click "Fork" on the top right corner. This will create a copy of this repo on your own account. 
* Navigate to the repo on your own account, and click the green button "Clone or download." 
* Click use HTTPS and copy the url there.
* Open terminal and type in "git clone" and paste the url after it so it looks like this:

```
git clone https://github.com/alinayu8/ACFDiscussionGroup.git
```
Next, execute the following commands:
```
bundle install
rake db:migrate
```

## Making pull requests

Say that you made a change to the project, nothing is breaking, and you want to push it to the repo. Because you forked it first and have a copy on your own account, it creates a buffer step that allows others to monitor your work before directly pushing it onto the repo. To make a "pull request" or a "is this okay, can I merge it into the project" request:

* Navigate to your forked repo and click "New pull request"
* Fill out the details about the changes you made
* Click "Send pull request"

If you go to the actual repo and check on the pull requests, you can approve it with "Merge pull request"--but best practice is if someone else merges it after reviewing your code to ensure that the repo only has proper, working code.

Please contact Alina or Tiffany if there are any issues building the repo. Thanks!
