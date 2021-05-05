require "test_helper"

class SupportMailboxTest < ActionMailbox::TestCase
  test "we create a SupportRequest when we get a support email" do
    receive_inbound_email_from_mail(
      to: "support@itbookstore.co.uk",
      from: "chris@somewhere.net",
      subject: "Need help",
      body: "I can't figure out how to check out!!!"
    )

    support_requests = SupportRequest.last
    assert_equal "chris@somewhere.net", support_requests.email
    assert_equal "Need help", support_requests.subject
    assert_equal "I can't figure out how to check out!!!", support_requests.body
    assert_nil support_requests.order
  end
  test "we create a SupportRequest with the most recent order" do
    recent_order = orders(:one)
    older_order = orders(:another_one)
    non_customer = orders(:other_customer)

    receive_inbound_email_from_mail(
      to: "support@itbookstore.co.uk",
      from: recent_order.email,
      subject: "Need help",
      body: "I can't figure out how to check out!!!"
    )

    support_requests = SupportRequest.last
    assert_equal recent_order.email, support_requests.email
    assert_equal "Need help", support_requests.subject
    assert_equal "I can't figure out how to check out!!!", support_requests.body
    assert_equal recent_order, support_requests.order
  end
end
