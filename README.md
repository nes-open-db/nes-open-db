# NES Open DB
A database for freely licensed NES software.

The goals of this project:

* Create an "App Store" type of experience for the NES homebrew software for every major NES emulator out there
* Provide explicit licensing information of each piece of software and metadata distributed on the site
* Provide a machine-readable API that can be accessed by NES emulators to provide beautiful metadata to go along with the game
* Create a promotional platform for NES Homebrew creators who are willing to distribute their homebrew under a permissive license

## How to use data provided by NES Open DB

If you just want to download some ROMs for your personal use, go head! Go browse the `roms\` directory and see what you can find. Grab what you want and start playing :)

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
2. Go to your new fork and find the ROM index at `_data/roms_index.json`. Add the ROM information to the list.
3. Create a new directory under `roms/` and add your ROM file and associated extra content in the new directory.
4. If you would like to make sure how the content looks on the site you can compile the site locally with Jekyll and preview the site. However this is not required, we can fix things when your submission is under review.
5. If you are not sure how to format the data, just take a guess and move on. We will fix everything up when the pull request comes under review.
6. Make a new commit using git
7. Push your git commit to your forked repository
8. Go to our GitHub at https://github.com/nes-open-db/nes-open-db/pulls and submit a new pull request.
9. Provide as much information about your work as possible and any special requests to go with your submission. Also, please write explicitly that you are the owner of the software and allow NES Open DB to distribute your software.

Licensing information and ROM data are essential, but all other information is optional. That said, the more information you can provide and the better it is formatted, the quicker it will be up on the site and the better control you have on how it looks on the site.

## Sounds great! How can I help?

If you are a NES Homebrew developer and want your game listed, you can either send an email (details below) or open up an issue on the issue tracker of this project.

If you are a NES enthusiast that wants to curate the data or help in any other way, please contact me (details below) and tell me what you would like to do.

You can read more about contributing in the `CONTRIBUTING.md` document in the root of this project.

Thank you for your support!

## Contact information

Website: http://nes-open-db.github.io

GitHub repository: https://github.com/nes-open-db/nes-open-db

Project Leader: Anton Rissanen, hello@anton.fi, [@antris](https://github.com/antris) on GitHub
