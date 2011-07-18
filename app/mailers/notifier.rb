class Notifier < ActionMailer::Base
  default :from => 'David P. <dave@somedomain.com>'
  default :to => 'dpetrovics@gmail.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_received.subject
  #
  def order_received(order)
    @order = order

    mail :subject => "order received!"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_shipped.subject
  #
  def order_shipped(order)
    @order = order

    mail :subject => "order shipped!"
  end
end
