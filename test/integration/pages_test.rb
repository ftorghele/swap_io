require 'integration_test_helper'

class PagesTest < ActionDispatch::IntegrationTest

  should 'show pages' do
    visit "/Idee"
    assert page.has_content?("Die Idee")
    visit "/contact"
    assert page.has_content?("Kontakt")
    visit "/Impressum"
    assert page.has_content?("Impressum")
    assert page.has_content?("AGB")
    visit "/Spielregeln"
    assert page.has_content?("Spielregeln")
    visit "/help"
    assert page.has_content?("So funktioniert's'")
  end

  should 'show landing page' do
    Factory.create(:newsletter)
    visit "/landingpage"
    assert_no_difference "ActionMailer::Base.deliveries.count" do
      fill_in('newsletter_subscriber_email', :with => 'tester@testmail.com')
      click_on "Gebt mir bescheid."
    end
    assert page.has_content?(I18n.t('newsletter_subscriber.create.success'))
  end

  should 'be able to signout from newsletter' do
    subscriber = Factory.create(:newsletter_subscriber)
    assert_difference "NewsletterSubscriber.count", -1 do
      visit "/newsletter_subscribers/unsubscribe/?token=#{subscriber.signout_hash}"
    end
  end

  should 'be able to send email via contact_form' do
    visit "/#{I18n.t('routes.contact.as')}"
    fill_in('email_field', :with => "tester@testmail.com")
    fill_in('subject', :with => "Some content on your site...")
    fill_in('body', :with => "I want to inform you about sth...")
    click_on "Nachricht senden"
    assert page.has_content?( I18n.t('pages.contact.msg.success') )
  end

end
