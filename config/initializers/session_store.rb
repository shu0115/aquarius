# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_aquarius_session',
  :secret      => 'de7e5f73b30898bc74c567e5f4efb68484c7e02021fd747880567dde7893e2513d458154d30a8b2e8403e4f181a7252ebf5eddaa3d7a66c83570e56853422235'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
