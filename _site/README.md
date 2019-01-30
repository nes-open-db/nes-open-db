# NES Open DB
A database for freely licensed NES software.

The goals of this project:

* Create an "App Store" type of experience for the NES homebrew software for every major NES emulator out there
* Provide explicit licensing information of each piece of software and metadata distributed on the site
* Provide a machine-readable API that can be accessed by NES emulators to provide beautiful metadata to go along with the game
* Create a promotional platform for NES Homebrew creators who are willing to distribute their homebrew under a permissive license

Table of Contents
=================

   * [NES Open DB](#nes-open-db)
      * [How to use data and ROMs provided by NES Open DB](#how-to-use-data-and-roms-provided-by-nes-open-db)
      * [I am an author and I want my NES homebrew on the site!](#i-am-an-author-and-i-want-my-nes-homebrew-on-the-site)
         * [How to submit your software using a pull request](#how-to-submit-your-software-using-a-pull-request)
      * [There is something I want to change in the website or the database](#there-is-something-i-want-to-change-in-the-website-or-the-database)
      * [How can I help this project?](#how-can-i-help-this-project)
         * [Homebrew authors](#homebrew-authors)
         * [Curators](#curators)
         * [Developers](#developers)
         * [Designers](#designers)
         * [Reviewers](#reviewers)
      * [Running the development server](#running-the-development-server)
      * [Contact information](#contact-information)

## How to use data and ROMs provided by NES Open DB

If you just want to download some ROMs for your personal use, go head! Go [browse the ROMs](https://nes-open-db.github.io/roms) and see what you can find. Grab what you want and start playing :)

However, if you are planning to redistribute the ROMs or metadata in this database, please take these things into account:

*Always* respect the license given along with the data. For example:

* Make sure you attribute the work correctly. Provide information on the author and better yet, link to the author's website.
* If the ROM is GPL and you are allowing direct downloads of the ROM, you must provide a way for the users to also download the source code for the ROM.
* The license for each piece of software is in its own `roms/<name_of_the_game` directory. The MIT License in the root folder applies to the components of the NES Open DB **ONLY**.

## I am an author and I want my NES homebrew on the site!

Great! As long as you are the owner of all the intellectual property contained in the software, you are free to submit your work.

If you are not technically minded, you can simply contact us (information below) and we might be able to do the work for you. All you need is to send us the ROM and give us permission to distribute it.

However, if you're comfortable with using git, GitHub and editing some JSON files, you can do submit your work directly to the database by issuing a pull request to our issue tracker.

Please note that if your ROM is a minimal-effort project with questionable value to the general public, we might
not add it to the database. Your software does not have to be perfect or even great; just think to yourself
would a random person get some value out of downloading it. If yes, it's probably acceptable.

### How to submit your software using a pull request

1. Fork this repository
2. Go to your new fork and find the ROM index at `_data/roms_index.json`. Add a new entry to the list with as much information about your ROM as possible.
3. Create a new directory under `roms/` and add your ROM file and associated extra content in the new directory.
4. If you would like to make sure how the content looks on the site you can compile the site locally with Jekyll and preview the site. However this is not required, we can fix things when your submission is under review.
5. If you are not sure how to format the data, just take a guess and move on. We will fix everything up when the pull request comes under review.
6. Make a new commit using git
7. Push your git commit to your forked repository
8. Go to our GitHub at https://github.com/nes-open-db/nes-open-db/pulls and submit a new pull request.
9. Provide as much information about your work as possible and any special requests to go with your submission. Also, please write explicitly that you are the owner of the software and allow NES Open DB to distribute your software.

Licensing information and ROM data are essential, but all other information is optional. That said, the more information you can provide and the better it is formatted, the quicker it will be up on the site and the better control you have on how it looks on the site.

## There is something I want to change in the website or the database

Please submit a pull request or an issue to our GitHub page. If your changes are concerning attribution, please note that you *must* provide either a reliable source or proof that you are the owner of the intellectual property concerning the change.

## How can I help this project?

Thank you for your support! There are several fronts that we need help with:

### Homebrew authors

If you are a NES Homebrew developer and want your game listed, you can either send an email (details below) or open up an issue on the issue tracker of this project.

### Curators

If you are a NES enthusiast that wants to curate the data and help developers get their ROMs on the site, please contact or simply go on Google, try some homebrews, and convince the authors to let you submit their work into the database.

### Developers

There are plenty of things you can do as a developer in this project. You may develop plugins for existing emulators that integrate with Nes Open DB.

### Designers

Have you seen the website? Yeah, it needs work... on brand design, graphic design, etc.

### Reviewers

It would be great to host some well-written reviews on the site. If you have lots of knowledge of the NES homebrew
scene and you have the best words, letters, paragraphs and all that stuff, don't hesitate to send a pull request!
The more authoritative person you are in the scene, the more valuable your reviews are to us!

## Running the development server

    bundle install
    bundle exec jekyll serve

## Contact information

Website: http://nes-open-db.github.io

GitHub repository: https://github.com/nes-open-db/nes-open-db

Project Leader: Anton Rissanen, hello@anton.fi, [@antris](https://github.com/antris) on GitHub
