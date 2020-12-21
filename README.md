# Pullscription.com


Here is a fully working (but not complete) backend/frontend for pullscription.com! 

Here are instructions how to set it up:

### USING OUR ALREADY-CONFIGURED REMOTE HOST

##### First, let's start the django backend

Open a terminal. Type the following commands in this order:

`ssh satsuki@173.255.241.100`

password: fillerpass

```
cd ../../var/www/html/pullscription.com/pullscription/backend/mysite/

python3 manage.py runserver 0.0.0.0:8080
```

This starts the django test server listening over any interface, on port 8080. Don't close this window.

##### Now, the front end!

Open a new terminal window. Log in again:

`ssh satsuki@173.255.241.100`

password: fillerpass

```
cd ../../var/www/html/pullscription.com/pullscription/frontend

elm reactor
```

Leave both windows open, and navigate your browser to [173.255.241.100:8000](http://173.255.241.100:8000). Enjoy.


### TO SET UP ON A PERSONAL SERVER, AT HOME

Download the elm source and place it in the appropriate directory. We will assume you have [elm](http://www.elm-lang.org) installed already.

Because the comic book information is on the server, you **MUST** follow the steps above to get the django backend running on the remote server. All links in the react project are absolute, so there should be few-to-no broken links (that aren't broken already.)

One you have moved the directory to where you'd like it, open a terminal, navigate to the /frontend directory, and run `elm reactor`. Visit [localhost:8000](http://localhost:8000), then naviagate to "src" then click "Main.elm". Enjoy!


