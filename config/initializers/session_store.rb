# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_flagship_session',
  :secret      => 'eb39faa28b9b6a5fd5ebe85e570b25a830d27a36accf2af819f8b601ed69b972432e8211ee240bb59c875519872dc349eadc859a3a0a1492e82b3d9e78190ae0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
