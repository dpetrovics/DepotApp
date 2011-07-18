require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "order_received" do
    mail = Notifier.order_received(orders(:one))
    assert_equal "order received!", mail.subject
    assert_equal ["dpetrovics@gmail.com"], mail.to
    assert_equal ["dave@somedomain.com"], mail.from
    assert_match /Thank you for your recent order/, mail.body.encoded    
  end

  test "order_shipped" do
    mail = Notifier.order_shipped(orders(:one))
    assert_equal "order shipped!", mail.subject
    assert_equal ["dpetrovics@gmail.com"], mail.to
    assert_equal ["dave@somedomain.com"], mail.from
    assert_match /Hi!/, mail.body.encoded
  end

end
