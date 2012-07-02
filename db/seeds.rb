# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#



# encoding: utf-8
							###################	
							#stwórz użytkowników#
							###################


if User.where(:login => 'admin').count > 1
  
  remove = User.where(:login => 'admin')
  remove.each do |one|
      one.destroy
  end

end

#stworz admina
#zastrzegam, ze jezeli jest juz admin, to zeby nie wykonywal sie ten kod

if User.where(:login => 'admin').empty?
  user = User.new( :login => 'admin', :email => 'free.events.2011@gmail.com', :password => 'password', :password_confirmation => 'password', :name => 'Alicja', :surname => 'Dalach' )
 user.save

 user.update_attribute(:admin, true)
 admin_visibility = Visibility.new(:email => false, :name => false, :surname => false, :avatar_url => true, :events => false, :user_id => user.id)
 admin_visibility.save
end

#stworz zwyklych uzytkownikow
user = User.new( :login => 'Dellilah', :email => 'alacygan@op.pl', :password => 'password', :password_confirmation => 'password', :name => 'Ona', :surname => 'Nieznajoma' )
 user.save
visibility = Visibility.new(:email => false, :name => true, :surname => false, :avatar_url => true, :events => true, :user_id => user.id)
visibility.save

user = User.new( :login => 'Trololo', :email => 'trololo2012@op.pl', :password => 'password', :password_confirmation => 'password', :name => 'Malgosia', :surname => 'Tracz' )
 user.save
visibility = Visibility.new(:email => true, :name => true, :surname => false, :avatar_url => true, :events => false, :user_id => user.id)
visibility.save

user = User.new( :login => 'Latigra', :email => 'latigra90@o2.pl', :password => 'password', :password_confirmation => 'password', :name => 'Wczorajsza', :surname => 'Panga' )
 user.save
visibility = Visibility.new(:email => true, :name => false, :surname => false, :avatar_url => false, :events => false, :user_id => user.id)
visibility.save
 
#stworz kategorie
Category.create( :name => 'Konferencja')
Category.create( :name => 'Koncert')
Category.create( :name => 'Wystawa')
Category.create( :name => 'Inna')


#stwórz tagi
Tag.create(:name => 'koncert')
Tag.create(:name => 'koleda')
Tag.create(:name => 'piosenka')
							###################	
							#stwórz wydarzenia#
							###################
event = Event.new(:name => 'Koncert Koled', :description => 'Koncert koled czeskich dzieci przy akopaniamencie czarnego bluesa', :city => 'Krakow', :street => 'Stolarska', :building_number => '15', :door_number=> '3', :confirmation => false, :start_date => '2012-02-09 19:14:00 UTC', :stop_date => '2012-02-09 19:14:00 UTC')
event.save
event.update_attribute(:category, Category.find(1))

							# WYSTAWY #

event = Event.new(:name => 'Wystawa Picassa', :description => 'Pierwsza w  tym roku wystawa artysty', :city => 'Krakow', :street => 'Mokra', :building_number => '4', :door_number=> '3', :confirmation => true, :start_date => '2012-02-09 19:14:00 UTC', :stop_date => '2012-02-09 19:14:00 UTC')
event.save
event.update_attribute(:category, Category.find(3))

tag_name = 'sztuka'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'malarstwo'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'wystawa'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'mistrz'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'kubizm'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'kultura'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end


event = Event.new(:name => 'Plakat musi brzmiec', :description => 'Wybierzcie sie na wystawe Plakat musi spiewac: ANEKS, ktora towarzyszy ekspozycji glownej prezentowanej w Muzeum Narodowym w Poznaniu.
W siedzibie Fundacji SPOT. zebrano najwazniejsze zjawiska sztuki plakatowej z pierwszej polowie XXI w. ', :city => 'Poznan', :street => 'Stara', :building_number => '4', :door_number=> '3', :confirmation => true, :start_date => '2012-04-15 12:00:00 UTC', :stop_date => '2012-04-29 20:00:00 UTC')
event.save
event.update_attribute(:category, Category.find(3))

tag_name = 'sztuka'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'plakat'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'wystawa'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'XXIw'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'muzeum'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'narodowe'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

event = Event.new(:name => 'Jenny Holzer', :description => 'Goraco polecamy niezwykla ekspozycje autorstwa Jenny Holzer, jednej z najwazniejszych artystek amerykanskich swojego pokolenia. Mecenasem wystawy jest program rekomendacji Skoda. Wiesz co dobre!', :city => 'Poznan', :street => 'Dziwna', :building_number => '4', :door_number=> '3', :confirmation => false, :start_date => '2012-03-15 12:00:00 UTC', :stop_date => '2012-03-29 20:00:00 UTC')
event.save
event.update_attribute(:category, Category.find(3))
tag_name = 'ekspozycja'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'malarstwo'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'amerykanski'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'Holzer'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end
							# KONCERTY #
							
event = Event.new(:name => 'KONCERT RENATY PRZEMYK', :description => 'Jesli dobra muzyka to tylko z radiowa Trojka! Juz 26. lutego, w studiu im. Agnieszki Osieckiej swoj koncert zagra Renata Przemyk, bedaca jedna z najbardziej wyrazistych artystek na polskiej scenie muzycznej. Idealny sposob na spedzenie niedzielnego wieczoru. Koncertu na zywo mozna wysluchac przy radioodbiorniku, ale ja wole kontakt bezposredni, w studiu', :city => 'Krakow', :street => 'Mickiewicza', :building_number => '4', :door_number=> '3', :confirmation => true, :start_date => '2012-02-25 16:00:00 UTC', :stop_date => '2012-02-25 18:00:00 UTC')
event.save
event.update_attribute(:category, Category.find(2))

tag_name = 'koncert'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'radio'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'przemyk'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'trojka'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'muzyka'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end


event = Event.new(:name => 'Waldemaar', :description => 'Poznanski klub Fabrika zaserwuje Wam spora jego dawke. Na scenie pojawi sie nietuzinkowa szwedzko-niemiecka formacja Waldemaar, ktorej przewodzi dziennikarz, poeta i byly pilkarz - Martin Bengtsson. Grupa promowac bedzie swoj najnowszy album Schizolectric.', :city => 'Poznan', :street => 'Mickiewicza', :building_number => '4', :door_number=> '3', :confirmation => false, :start_date => '2012-02-23 20:30:00 UTC', :stop_date => '2012-02-27 23:59:00 UTC')
event.save
event.update_attribute(:category, Category.find(2))

tag_name = 'poznan'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'waldemaar'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'miedzynarodowy'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'szwedzki'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'niemiecki'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

event = Event.new(:name => 'Yamato', :description => 'Juz wkrotce poczatek nowego roku. Z pewnoscia juz ciesza Was zapowiedzi nadchodzacych wraz z nim wydarzen kulturalnych.
Jednym z nich jest powrot niesamowitych bebniarzy z Japonii. Juz w marcu Yamato zagoszcza w Zabrzu, Warszawie i Poznaniu z nowym programem - GAMUSHARA!
', :city => 'Zabrze', :street => 'Kolorowa', :building_number => '4', :door_number=> '3', :confirmation => false, :start_date => '2012-02-28 20:00:00 UTC', :stop_date => '2012-02-28 23:59:00 UTC')
event.save
event.update_attribute(:category, Category.find(2))

tag_name = 'Yamato'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'bebny'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'Japonia'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'muzyka'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'Zabrze'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'poznan'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end


							# KONFERENCJE #
							
event = Event.new(:name => 'GeoShale2012 Recent Advances in Geology of Fine-grained sediments', :description => 'Konferencja bedzie dotyczyla osadow ilastych, potocznie zwanych lupkami, ktore sa szeroko rozpowszechnione w swiecie. W paleozoicznych basenach sedymentacyjnych Polski wystepuja liczne formacje osadow ilastych i mulowcowych, ktore staly sie ostatnio obiektem wzmozonych badan ze wzgledu na potencjal wystepowania w nich zloz ropy naftowej i gazu ziemnego. Te skaly, badania ich wystepowania, genezy, przemian oraz mozliwosci wykorzystania beda tematem sesji oraz towarzyszacych konferencji wycieczek terenowych', :city => 'Warszawa', :street => 'Stolarska', :building_number => '15', :door_number=> '3', :confirmation => true, :start_date => '2012-02-25 11:00:00 UTC', :stop_date => '2012-02-25 19:00:00 UTC')
event.save
event.update_attribute(:category, Category.find(1))

tag_name = 'konferencja'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'chemia'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'geografia'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'naukowa'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'skaly'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'ropa'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end
tag_name = 'gaz'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end


							
event = Event.new(:name => 'TEATR/TEKST. JOHN BERGER. COMPLICITE', :description => 'Zapraszamy do udzialu w konferencji naukowej, ktora odbedzie sie w ramach miedzynarodowego festiwalu literacko-teatralnego BETWEEN / POMIEDZY. W tym roku oprocz rozwazan nad tworczoscia Johna Bergera i brytyjskiego teatru Complicite skupimy sie na podlegajacym nieustannym zmianom relacjom miedzy tekstem a scena. Naszym zamiarem jest stworzenie dogodnych warunkow do dyskusji na temat roli, jaka odgrywaja dzis dramatopisarze, rezyserzy, producenci, aktorzy i scenografowie. ', :city => 'Sopot', :street => 'Dawna', :building_number => '15', :door_number=> '3', :confirmation => false, :start_date => '2012-02-27 11:00:00 UTC', :stop_date => '2012-02-27 16:00:00 UTC')
event.save
event.update_attribute(:category, Category.find(1))

tag_name = 'berger'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'sztuka'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'teatr'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'literatura'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'naukowa'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'miedzynarodowy'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'festiwal'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end


event = Event.new(:name => 'REWOLUCJA SOCJALNA-rozwoj social media w Polsce', :description => 'Konferencja interdyscyplinarna poswiecona wplywowi mediow spolecznosciowych na zycie
spoleczne, biznes, edukacje oraz rozrywke. Konferencja podzielona jest na cztery bloki
tematyczne, w tym panele dyskusyjne oraz naukowe. W panelach dyskusyjnych omowione
zostana zastosowania social media w edukacji, rozrywce, polityce oraz zyciu codziennym.', :city => 'Krakow', :street => 'Lojasiewicza', :building_number => '4', :door_number=> '3', :confirmation => true, :start_date => '2012-03-01 11:00:00 UTC', :stop_date => '2012-03-03 16:00:00 UTC')
event.save
event.update_attribute(:category, Category.find(1))

tag_name = 'socjalne'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'spolecznosciowe'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'social'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'media'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'interdyscyplinarne'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'panel'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

tag_name = 'dyskusyjny'
if tag = Tag.find(:first, :conditions => ["name = ?", tag_name ])
  event.tags << tag
else
  tag = Tag.create(:name => tag_name)
  event.tags << tag
end

commonvisibility = Visibility.new(:email => true, :name => true, :surname => true, :avatar_url => true, :events => true, :user_id => '0')
commonvisibility.save

users=User.all
users.each do |one_user|
	if one_user.admin 
		one_user.update_attribute(:moderator, false)
	elsif one_user.moderator
		one_user.update_attribute(:admin, false)
	else
		one_user.update_attribute(:moderator, false)
		one_user.update_attribute(:admin, false)
	end
end

######zapisz uż. na wydarzenia
user = User.find(1)
user.events << Event.find(2)
user.events << Event.find(4)
user.events << Event.find(5)

user = User.find(2)
user.events << Event.find(3)
user.events << Event.find(4)
user.events << Event.find(8)

user = User.find(3)
user.events << Event.find(3)
user.events << Event.find(6)
user.events << Event.find(9)

user = User.find(4)
user.events << Event.find(7)


############dodawanie komentarzy do wydarzen
user = User.find(4)
event = Event.find(10)
comment = Comment.create(:content => "Najwyzszy czas na takie wydarzenie! Ja na pewno!", :user_id => user.id, :event_id => event.id)

user = User.find(2)
event = Event.find(10)
comment = Comment.create(:content => "Jak dla mnie temat oklepany, i dorabiana ideaologia. Ale za darmo warto", :user_id => user.id, :event_id => event.id)

###
user = User.find(1)
event = Event.find(9)
comment = Comment.create(:content => "Prawdopodobnie fascynujace. Berger zniewala, polecam", :user_id => user.id, :event_id => event.id)

user = User.find(2)
event = Event.find(9)
comment = Comment.create(:content => "Podpisuje sie pod adminem dwoma rekami :)", :user_id => user.id, :event_id => event.id)

user = User.find(3)
event = Event.find(9)
comment = Comment.create(:content => "czy ktos z Was dysponuje tworczoscia Pana Begera do pozyczernia?", :user_id => user.id, :event_id => event.id)
###
user = User.find(2)
event = Event.find(8)
comment = Comment.create(:content => "Nudy do zwariowania", :user_id => user.id, :event_id => event.id)
###
user = User.find(1)
event = Event.find(7)
comment = Comment.create(:content => "Bylem w zeszlym roku. Nie polecam", :user_id => user.id, :event_id => event.id)

user = User.find(4)
event = Event.find(7)
comment = Comment.create(:content => "Jakis powod?", :user_id => user.id, :event_id => event.id)
###
user = User.find(3)
event = Event.find(5)
comment = Comment.create(:content => "Renata dobra na wszystko!", :user_id => user.id, :event_id => event.id)
###
user = User.find(4)
event = Event.find(4)
comment = Comment.create(:content => "Ta Skoda mnie przekonala. Ale moze jakis blizsze informacje? Jaka sztuka?", :user_id => user.id, :event_id => event.id)

user = User.find(2)
event = Event.find(4)
comment = Comment.create(:content => "Polecam strone Google.pl", :user_id => user.id, :event_id => event.id)
###
user = User.find(3)
event = Event.find(3)
comment = Comment.create(:content => "Wystarczy napis Muzeum Narodowe i juz wszyscy leca", :user_id => user.id, :event_id => event.id)

user = User.find(2)
event = Event.find(3)
comment = Comment.create(:content => "Skoro Ty tak masz...", :user_id => user.id, :event_id => event.id)

user = User.find(3)
event = Event.find(3)
comment = Comment.create(:content => "Ho ho, cieta riposta", :user_id => user.id, :event_id => event.id)


