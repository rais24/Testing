# Deployment

To deploy to all machines in our cluster, run

```bash
# this is simple, but not recommended
script/deploy
```

If you have any trouble, follow [this ascii-cast](http://ascii.io/a/4754).

**NOTE** both `~/.ec2/gsg-keypair` and `~/.ec2/gsg-keypair.pub` come from [here](https://github.com/fitly/our-boxen/tree/master/modules/projects/files/fitly-rails) and should have permission set to `600`

Ideally, we'll work out a deployment script to remove an instance from our
Load Balancer so that we have no-downtime-deploys. Until then, try to run 
deployments on one machine at a time.

**NOTE:** our deployments go off of the `master` branch of our repository. This means
that if you want to deploy some new fix, you'll have to merge it into master.

TBD: setting a branch to deploy from via:

```bash
# set the branch via command line
cap deploy -s BRANCH=some-feature-branch
```

**UNTIL THEN**

```bash
# rinse and repeat for each instance in the cluster...
FILTER=feXX cap deploy
```

# While under load

While our cluster is under load, you may want to add a new machine to the cluster.

## Create an Instance

First, you'll need to create the machine.

Our rails servers have the `app`,`web`, and `sidekiq` roles.

To create a new instance, run the following

```bash
# fe signifies a Front End server
# XX signifies a number (prefixed with 0). Try to keep them sequential
ALIAS=feXX ROLES=app,web,sidekiq cap rubber:create

# ...
# This command will take a while, as it has to install packages and ruby
FILTER=feXX cap rubber:bootstrap
# ...
# This will deploy our codebase
FILTER=feXX cap deploy:cold
```

Once this is complete, go into our `EC2` console and add the instance
to our Elastic Load Balancer (ELB)'s set of machines
