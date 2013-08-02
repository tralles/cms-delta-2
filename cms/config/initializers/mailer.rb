# =================================================
#
# =================================================

ActionMailer::Base.default_url_options = { :host => "qb-portable.local:3000" }
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
                                      :address              => "mail.qb-publish.de",
                                      :port                 => 25,
                                      :domain               => 'qb-publish.de',
                                      :user_name            => 'no-reply@qb-publish.de',
                                      :password             => 'n0r3ply#qbp',
                                      :authentication       => 'plain',
                                      :enable_starttls_auto => false  
                                   }  