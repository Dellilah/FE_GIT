ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "FreeEvents.com",
  :user_name            => "free.events.2011",
  :password             => "freeevents2011",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

