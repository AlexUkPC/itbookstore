require "test_helper"

class OrderMailerTest < ActionMailer::TestCase
  test "received" do
    mail = OrderMailer.received(orders(:one))
    assert_equal "IT Bookstore Order Confirmation", mail.subject
    assert_equal ["alexrogna@yahoo.com"], mail.to
    assert_equal ["orders@itbookstore.co.uk"], mail.from
    # assert_match /1 x Programming Ruby 1.9/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderMailer.shipped(orders(:one))
    assert_equal "IT Bookstore Order Shipped", mail.subject
    assert_equal ["alexrogna@yahoo.com"], mail.to
    assert_equal ["orders@itbookstore.co.uk"], mail.from
    # assert_match /<td[^>]*>1<\/td>\s*<td>Programming Ruby 1.9<\/td>/, mail.body.encoded
  end

end
