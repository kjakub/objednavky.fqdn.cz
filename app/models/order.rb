class Order < ActiveRecord::Base
  belongs_to :admin
  belongs_to :costumer
  attr_accessible :comment, :delivery_mode, :costumer_id, :tracking_number
  attr_accessible :enclosure
  has_attached_file :enclosure, :path => ":rails_root/public/system/:attachment/:id/:filename",
      :url => "/system/:attachment/:id/:filename"
  
  #class metoda
  def self.delivery_modes
    [ "FedEx" ,
      "PPL"     
    ]
  end

end
