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
end
