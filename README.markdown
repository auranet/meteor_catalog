Hobo app for documenting and demonstrating meteor widget.

Installing
----------

    $ git clone git@github.com:auranet/meteor_catalog.git
    $ cd meteor_catalog
    $ git submodule update --init
    $ gem install pg
    $ gem install rails -v 2.3.8
    $ gem install hobo hobosupport hobofields will_paginate --ignore-dependencies # Hobo will install rails 3 otherwise
    $ rake gems:install
    $ gem list

    *** LOCAL GEMS ***

    actionmailer (2.3.8)
    actionpack (2.3.8)
    activerecord (2.3.8)
    activeresource (2.3.8)
    activesupport (2.3.8)
    bluecloth (2.0.9)
    ckuru-tools (0.0.1)
    columnize (0.3.1)
    hobo (1.0.1)
    hobofields (1.0.1)
    hobosupport (1.0.1)
    hpricot (0.8.2)
    linecache (0.43)
    pg (0.9.0)
    rack (1.1.0)
    rails (2.3.8)
    rake (0.8.7)
    ruby-debug (0.10.3)
    ruby-debug-base (0.10.3)
    will_paginate (2.3.15)

    $ rake db:migrate

Getting Started
---------------

1. ./script/server
2. Open a browser and go to http://localhost:8000/
3. You will be prompted to sign up.  This first user will be made an administrator.
4. Content is managed through the *Admin* menu.

Testing
-------

**No tests yet, but eventually tests will be run like so.**

    $ RAILS_ENV=cucumber rake gems:install
    $ rake cucumber
