# This is just a place to set up our per-deployment variables that we don't
# wan't to put in the repo.

# An ldap_intializer.rb is not required. This information could also be put
# into the evironment files or another initializer. What's important is that
# the information gets to the Application Controller, where it is used as a
# parameter for the authenticates_rpi setup.

# If LDAP information is not set, it will simply not be used: when new users 
# register, they will just not have a name.

# LDAP is achieved with ruby-ldap.
require 'ldap'

LDAP_ADDRESS = 'ldap.server.rpi.edu'
LDAP_PORT = 389
LDAP_DN = 'ou=accounts,dc=rpi,dc=edu'
