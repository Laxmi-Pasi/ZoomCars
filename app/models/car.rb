class Car < ApplicationRecord
  attr_accessor :sell_checked
  attr_accessor :rent_checked
  attr_accessor :invalid_purpose
  has_many :rents
  has_many :users, through: :rents, dependent: :destroy
  belongs_to :owner, class_name: "User"
  has_one_attached :main_car_image, dependent: :destroy
  has_many_attached :car_images
  
  validates :company, :model, :purchase_date, 
            :car_description, :registered_number, presence: true
  validates :seats, :distance_driven, numericality: { only_integer: true }, presence: true       
  enum engine_type: [:Petrol, :Diesel, :Hybrid, :EV ]
  enum car_type: [:Hatchback, :Sedan, :SUV, :Supercar]
  enum transmission_type: [:Manual, :Automatic]
  enum car_status: [:active, :rent, :sold] 

  # to check car images
  def has_car_images?
    car_images_attachments != []
  end
  # serialize :purpose, Array
  validates :sell_price, presence: true, if: :sell_checked
  validates :rent_price, presence: true, if: :rent_checked
  validates :purpose, presence: { message: "Car should be available for one purpose" }, if: :invalid_purpose
end
