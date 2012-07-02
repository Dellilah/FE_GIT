class UserMailer < ActionMailer::Base
  default from: "from@example.com"

def welcome_email(user)
  @user = user
  @url = "http://wierzba.wzks.uj.edu.pl:3309/"
  mail(:to => @user.email, :subject => "Witamy w serwisie")
end

def new_event(user, event)
	@user = user
	@event = event
	@url = "http://wierzba.wzks.uj.edu.pl:3309/events/" + @event.id.to_s
	mail(:to => @user.email, :subject => "W serwisie pojawily sie nowe wydarzenia")
end

def remind_email(user, event)
	@user = user
	@event = event
	@url = "http://wierzba.wzks.uj.edu.pl:3309/events/" + @event.id.to_s
	mail(:to => @user.email, :subject => "Zbliza sie Twoje wydarzenie")
end

def your_new_event(user, event)
	@user = user
	@event = event
	@url = "http://wierzba.wzks.uj.edu.pl:3309/events/" + @event.id.to_s
	mail(:to => @user.email, :subject => "Dodales nowe wydarzenie")
end

def event_to_confirm(user, event)
	@user = user
	@event = event
	@event_url = "http://wierzba.wzks.uj.edu.pl:3309/events/" + @event.id.to_s
	@event_url_confirmation = @event_url + "/admin_confirmation"
	mail(:to => @user.email, :subject => "Dodano wydarzenie. Potwierdz jako administrator")
end

end
