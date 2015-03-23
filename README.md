# Fitly Rails

* [Adding Recipes](doc/ADDING_RECIPES.md)
* [Managing Ingredients](doc/INGREDIENTS.md)
* [Understanding Our Models](doc/MODELS.md)


# Required Installs

If you're on OSX, checkout [our-boxen](https://github.com/fitly/our-boxen/). If not, here's the stack (check the [fitly-rails](https://github.com/fitly/our-boxen/blob/master/modules/projects/manifests/fitly-rails.pp)  boxen project repo for our up to date stack

* MySQL 5.5.20
* Redis 2.6.9
* Ruby 2.0.0
* Imagemagick 6.8.0-10
* PhantomJS stable 1.9.0

# Deployment Setup

Read about deployments [here](doc/DEPLOY.md)

# Development Login

After you run `script/seed`, there is a single account created. You should be able to navigate to `/login` and authenticate as `admin` with the password of `passw0rd`

# Environment Variables

To comply with the [12-factor App](http://12factor.net/) conventions, we do our configuration through environment variables

ent variables from a `.env` file (located in the root directory) into Ruby's `ENV` variable

**NOTE:** Since each configuration is potentially different, the `.env` file is excluded from version control. It can be found in the fitly/our-boxen repository [HERE](https://github.com/fitly/our-boxen/blob/master/modules/projects/files/fitly-rails/dotenv).

#### Required Variables
* `IMAGE_MAGICK_HOME` - the path to your `imagemagick` executable. **INCLUDE THE TRAILING SLASH**. To determine where this is, try running:

```bash
# this will point you to the executable. In this example, set IMAGE_MAGICK_HOME to `/path/to/`
which identify # => /path/to/identify
```
* `FITLY_MAIL_USERNAME` - the name of the email account that will send emails. in development, 
                          this can be garbage. In production, it will probably be `service@fitly.org`
* `FITLY_MAIL_PASSWORD` - the outgoing email password. In development, 
                          this can be garbage. In production, it will probably be the password to `service@fitly.org`


* `FITLY_APPLICATION_TOKEN` - this is the token used for csrf

##### Stripe Info ([sign in](https://manage.stripe.com/account) via username 'anthony@fitly.org')

* `STRIPE_TEST_SECRET` - Test version of Stripe Private Key
* `STRIPE_TEST_PUBLIC` - Test version of Stripe Public Key
* `STRIPE_SECRET` - Production version of Stripe Private Key
* `STRIPE_PUBLIC` - Production version of Stripe Public Key

##### AWS Credentials
* `AWS_ACCT_NUM` - Our AWS account number
* `AWS_BUCKET` -  The name of our AWS S3 storage bucket
* `AWS_ACCESS_KEY` -  Our AWS access key
* `AWS_SECRET_ACCESS_KEY` -  Our AWS secret key

##### RDS MySQL credentials
* `DB_HOST` -  The Hostname of our RDS instance
* `DB_PORT` -  The port of our RDS instance (usually 3306)
* `DB_NAME` -  The name of our RDS instance's DB
* `DB_USERNAME` -  The username to access our RDS instance
* `DB_PASSWORD` -  The password for our RDS username

##### Sidekiq Redis URL
* `REDIS_URL` -  Development `Sidekiq`-backing `redis` instance. Can also be set to `ENV['REDISTOGO_URL']` in `production`
* `REDISTOGO_URL` - Our `production` level `redis` URL (currently using [RedisToGo](http://redistogo.com/))

##### GitHub Integration
* `GITHUB_TOKEN` - `fitlybot`'s API token. Used in `party_foul` bug reporting

### Examples

For a *NIX machine, a `.env` file could look like this

```yaml
# on a linux machine, it is probably  '/usr/bin`
# the example below is for an OSX machine with homebrew
IMAGE_MAGICK_HOME: /usr/local/homebrew/bin/

FITLY_MAIL_USERNAME: service@fitly.org
FITLY_MAIL_PASSWORD: garbagepassword

FITLY_APPLICATION_TOKEN: GARBAGE

# Stripe Credentials
STRIPE_TEST_SECRET: <%= ENV['MY_ENV_VARIABLE'] %>
STRIPE_TEST_PUBLIC: <%= ENV['MY_ENV_VARIABLE'] %>
STRIPE_SECRET: GARBAGE
STRIPE_PUBLIC: GARBAGE

# AWS Credentials
AWS_ACCT_NUM: 1234567890
AWS_BUCKET: my-s3-bucket
AWS_ACCESS_KEY: 50M3UGLY5HA
AWS_SECRET_ACCESS_KEY: 50M3UGLY5HA

# RDS MySQL credentials
DB_HOST: myrdshostnmae.us-CARDINAL-1.rds.amazonaws.com
DB_PORT: 3306
DB_NAME: myrdsdb
DB_USERNAME: myrdsusername
DB_PASSWORD: myrdspassword

# Sidekiq Redis URL
REDIS_URL: redis://localhost:6379
REDISTOGO_URL: redis://redistogo:somegarbage@somethingelse.redistogo.com:10081/

GITHUB_TOKEN: abcdefghijklmnopqrstuvwxyznowiknowmyabcs
```
## Deployment

Checkout the [deployment](doc/DEPLOY.md) documentation for instructions.

## Development

To run, make sure you have `ruby` version `2.0.0` installed on your machine.

Next, run

```console
# use fitly/fitly-rails if you have the `hub` gem installed
git clone https://github.com/fitly/fitly-rails
# go into the directory
cd fitly-rails
# run the server. this will also install all the necessary gems
# into vendor/gems using bundler
script/server

# to fill the database
script/seed
```

Then, in another terminal

```console
# this will run `bundle` when your Gemfile changes,
# run tests when `.rb` files change, and
# will setup LiveReload
bundle exec guard
```

Finally, to view the page, run
```console
open localhost:3000
```

or navigate to `http://localhost:3000` in your browser

### Windows

If you're on windows, follow [this](https://github.com/fitly/fitly-rails/wiki/Rails-On-Windows-With-Vagrant) wiki.
