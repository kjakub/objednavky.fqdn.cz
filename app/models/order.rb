class Order < ActiveRecord::Base
  belongs_to :admin
  belongs_to :customer
  belongs_to :admin_approver, :class_name => 'Admin'
  
  attr_accessible :comment, :delivery_mode, :customer_id, :tracking_number, :admin_approver_id, :send_notification
  attr_accessible :enclosure
  attr_accessor :send_notification

  has_attached_file :enclosure, :path => ":rails_root/public/system/:attachment/:id/:filename",
      :url => "/system/:attachment/:id/:filename"

  before_save :set_admin_if_me_option, :send_notification_to_approver
  #class metoda
  def self.delivery_modes
    [ "FedEx" ,
      "PPL"     
    ]
  end

  def self.possibly_approvers
    hash = Hash.new
    hash["--customer--"] = -1
    hash["--me--"] = -2
    hash.merge!(Hash[Admin.all.map{|c| [c.email,c.id]}])
    hash
  end

  def approver
    if self.admin_approver_id == -1
      self.customer
    elsif self.admin_approver_id == -2
      self.admin
    else
      self.admin_approver
    end
  end

protected
  def set_admin_if_me_option
    self.admin_approver_id = self.admin if self.admin_approver_id == -2 #if me option is selected
  end

  def send_notification_to_approver
    UserMailer.order_to_approve(self).deliver if self.send_notification == "1"
  end


end
