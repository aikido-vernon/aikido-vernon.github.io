[git-subtree](https://github.com/apenwarr/git-subtree)

PRÉREQUIS
=========

- git
- git-subtree
- ruby
- sass
- npm
- bower
- grunt

INSTALLATION
============

```bash
git clone git@github.com:aikido-vernon/aikido-vernon.github.io.git
command curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
curl -sSL https://get.rvm.io | bash -s stable --ruby

gem install sass

sudo npm install -g bower grunt-cli

npm install

bower install

grunt serve
```

BRANCHES
========

Développement sur la branche dev, et pour pusher le résultat sur la branche master, faire un :

```bash
git subtree push --prefix dist origin master
````
