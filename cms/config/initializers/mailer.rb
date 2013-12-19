# =================================================
#
# =================================================

ActionMailer::Base.default_url_options = { :host => "qb-it.de" }
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address              => "mail.qb-it.de",
  :port                 => 25,
  :domain               => 'qb-it.de',
  :user_name            => 'no-reply@qb-it.de',
  :password             => 'n0-r3ply',
  :authentication       => 'plain',
  :enable_starttls_auto => false  }  