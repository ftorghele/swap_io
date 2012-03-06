require 'integration_test_helper'

class PagesTest < ActionDispatch::IntegrationTest

  should 'show pages' do
    visit "/about"
    assert page.has_content?(I18n.t('pages.about.title'))

    visit "/coverage"
    assert page.has_content?(I18n.t('pages.coverage.title'))

    visit "/contact"
    assert page.has_content?(I18n.t('pages.contact.title'))

    visit "/imprint"
    assert page.has_content?(I18n.t('pages.imprint.title'))

    visit "/terms"
    assert page.has_content?(I18n.t('pages.terms.title'))

    visit "/help"
    assert page.has_content?(I18n.t('pages.help.title'))
  end

  should 'show landing page' do
    Factory.create(:newsletter)
    visit "/"
    assert_no_difference "ActionMailer::Base.deliveries.count" do
      fill_in('newsletter_subscriber_email', :with => 'tester@testmail.com')
      click_on I18n.t('pages.welcome.newsletter_sign_up_button')
    end
    assert page.has_content?(I18n.t('newsletter_subscriber.create.success'))
  end

  should 'be able to signout from newsletter' do
    subscriber = Factory.create(:newsletter_subscriber)
    assert_difference "NewsletterSubscriber.count", -1 do
      visit "/newsletter_subscribers/unsubscribe/?token=#{subscriber.signout_hash}"
    end
  end

end
