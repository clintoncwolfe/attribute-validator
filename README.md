# attribute-validator cookbook

A Chef cookbook that applies validation rules to the node attributes during a chef run.  The cookbook itself is rather small; most of the guts are in a gem named 'chec-attribute-validator'.

# Why would I possibly want that?

Attribute merging is *hard*.  It's very easy to accidentally override something (in a role, node, environment, third-order-dependent cookbook....), or fat-finger a attribute name, or have a change in another cookbook stomp on your attributes.  I wanted something industrial-strength that would provide early warning when an attribute was missing, spurious, or had an incoherent value.

I also wanted the cookbook that cares about the validation to be able to define the rules in a simple way, and make it easy to have as much or as little validation as you want to implement.  

# Requirements

Requires the chef-attribute-validator gem installed to the Chef client's gem store.  The cookbook will install it automatically if it is not present.

# Usage

## Writing Rules

Basically, you define rules in node attributes.  A typical use case comes up when you're creating a new cookbook.  Naturally, you expose certain "knobs" as node attributes, which the user of your cookbook can set in any number of ways - application or wrapper cookbooks attribute files, roles, even environments.  You'd like to catch missing or invalid attribute values before you try to converge using them, and throw a meaningful error (something better than "No such method [] for nil:NilClass", for example).

So, to define rules, add a series of hashes in your cookbook attributes.  Each rule has a path, which optionally includes wildcards; the path is then used to select which attributes to apply the rule's checks.  Checks include things like type, presence, regex, and so one; the list is growing, see https://github.com/clintoncwolfe/chef-attribute-validator for the latest.

Here is how to make sure that your feature flags really are booleans, and not 0, 1, "true", etc.

     default['attribute-validator']['rules']['some-rule'] = {
        'path' => '/my-cookbook/feature_*/enabled',
        'type' => 'boolean',
     }


## Enforcing rules via recipes

To enforce the rules, include one of the two recipes in your runlist, or directly in your runlist.

Most people will wnat this one, which will check for invalid attributes and abort the run before any* resources are actually converged:

   include_recipe "attribute-validator::compile-time-check"

* It is possible to converge a resource at compile-time; this is common for setting up package repos, installing gems, etc.  Those resources may still fire, depending on where the compile-time-check recipe is in the runlist.


Alternatively, if you want the run to converge up until reaching your cookbook, and then abort if anything is invalid, you can use:

   include_recipe "attribute-validator::converge-time-check"

This tends to be messier, but that may be OK.

## Calling the Gem Directly

If you'd like to have more control over how violations are handled, you can call the gem directly.


    # In a recipe or LWRP
    include_recipe "attribute-validator::install"
    violations = Chef::Attribute::Validator.new(node).validate_all

For details on the contents of violations, as well as other method calls allowing you to validate rules one at a time, see https://github.com/clintoncwolfe/chef-attribute-validator .

# Attributes

     default['attribute-validator']['rules'][some-rule] = {
        'path' => '/my-cookbook/feature_*/enabled',
        # Checks like type, regex, looks_like, min_children, present, etc 
        ...
     }

     default['attribute-validator']['rules'][another-rule] = { ... }
     

# Recipes

## No default.

This cookbook has no default cookbook.

## attribute-validator::compile-time-check

Calls the install cookbook, then calls validate_all at compile time; if nonzero violations are found, throws an exception, which halts the run.

## attribute-validator::converge-time-check

Calls the install cookbook, then calls validate_all at convergence time (inside a ruby block); if nonzero violations are found, throws an exception, which halts the run.

## attribute-validator::install

Utility recipe; installs and loads the chef-attribute-validator gem at compile-time.

# Bugs, Limitations, Misfeatures, Whinges, Roadmap

## Reporting Issues

Please report issues by opening a github issue at https://github.com/clintoncwolfe/attribute-validator .  You're a thorough person who knows how important it is to give back to the community, so of course you'll be sending along a pull requst with a failing test, and another pull request with a fix.  That's just who you are, you're not bragging.  

## Outstanding Bogs

None known.

## Roadmap

### More options for handling violations

How do you want to handle violations?  Should they always be fatal?  Should we offer a chef_handler that does <what> with them?


# Author

Clinton Wolfe

## Contributing

1. Fork it (https://github.com/clintoncwolfe/attribute-validator)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request at (https://github.com/clintoncwolfe/attribute-validator)
