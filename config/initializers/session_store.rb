# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_deploy_session',
  :secret      => '41aa206c107456673e0aefa4a62ee28cc2915f45b0b499132f60d1934609b302b067f5d5681d71b8823b0926bc7340c47ea0fb8c8c8b8e35d86bbf38e9d56e47'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
