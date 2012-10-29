class UserMailer < ActionMailer::Base
  default :from => "info@ecozz.cz"
 
  def order_sent(order)
    @customer = order.customer
    @order = order
    #@url  = "http://example.com/login"
    mail(:to => @customer.email, :subject => "Your order from ECOZZ have been shipped")
  end
end
