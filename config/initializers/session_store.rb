# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_meteor_catalog_session',
  :secret      => 'd24f1340e2cf3322950ccd76b692b0a9816c956dbcb04ac10b759612a9fe726be65b5f7724fde96bce92bcd05b42056e202e19e90c6aaf059f3ea59261221dff'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
