class Event < ActiveRecord::Base

  acts_as_gmappable

  def gmaps4rails_address
    address = self.city + "ul. " + self.street + self.building_number.to_s
  end

  belongs_to :category
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :users
  has_many :comments
  
  validates :name, :presence => true, :length => { :in => 2..64, :too_short => "Nazwa musi miec co najmiej %{count} znakow!", :too_long => "Nazwa moze miec co najwyzej %{count} znakow!"}  
  #validates_date :stop_date
  #validates_datetime :start_date
  validates :start_date, :presence => true
  validates :stop_date, :presence => true, :format => { :with => /(\d{1,2}[-\/]\d{1,2}[-\/]\d{4})|(\d{4}[-\/]\d{1,2}[-\/]\d{1,2})/ }
  validates :description, :presence => true, :length => { :in => 2..2048 }

  validates :city, :presence => true, :length => { :in => 3..65, :too_short => "Za krotka nazwa miasta", :too_long => "Za dluga nazwa miasta"}
  validates :street, :presence => true, :length => { :in => 3..20, :too_short => "Za krotka ulica", :too_long => "Za dluga ulica"}
  validates :building_number, :numericality => true, :presence => true
  validates :door_number, :numericality => true
  
end
