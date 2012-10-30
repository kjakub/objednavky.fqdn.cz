class UserMailer < ActionMailer::Base
  default :from => "info@ecozz.cz"
 
  def order_sent(order)
    @customer = order.customer
    @order = order
    #@url  = "http://example.com/login"
    mail(:to => @customer.email, :subject => "Your order from ECOZZ has been shipped")
  end

  def order_to_approve(order)
    @approver = order.approver
    @order = order
    #@url  = "http://example.com/login"
    mail(:to => @approver.email, :subject => "Your order from ECOZZ have to be approved")
  end

end
