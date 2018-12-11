# mklogin
Define user accounts and add them to the local machine

Example:

    $ mklogin -d fishwick
       1 Office staff
       2 Vendor
       3 Other external user
    Your choice (1-3): 1
    Full name []: Ulysses K. Fishwick
    Numeric UID [529]: 1080
    Home directory [home/fishwick]: 
    Login shell [/sbin/nologin]: /bin/zsh

    $ sudo su -
    Password:

    # mklogin -y fishwick
    User account added: fishwick
