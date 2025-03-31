# guix-home

This is my personal guix home configuration. It is a work in progress and is not intended for general use.

It is based on <https://github.com/daym/guix-config>.

## Usage

Install guix, clone this repo, navigate to that folder in a terminal and run:

```bash
guix home -L "${PWD}" reconfigure home-config.scm
```

## Roles & Profiles

The [roles and profiles](https://www.puppet.com/docs/puppet/7/the_roles_and_profiles_method.html)
(and modules) method, as popularized by puppet, is used by this configuration.
