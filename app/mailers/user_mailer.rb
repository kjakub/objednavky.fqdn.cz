class UserMailer < ActionMailer::Base
  default :from => "info@ecozz.cz"
 
  def order_sent(order)
    @costumer = order.costumer
    @order = order
    #@url  = "http://example.com/login"
    mail(:to => @costumer.email, :subject => "Your order from ECOZZ have been shipped")
  end
end
