unless Rails.env.test?
  ActionMailer::Base.delivery_method = ENV['MAILER_DELIVERY_METHOD'].try(:to_sym)

  ActionMailer::Base.smtp_settings = {
      address:                ENV['MAILER_SMTP_SERVER'],
      port:                   ENV['MAILER_SMTP_PORT'].try(:to_i) || 587,
      domain:                 ENV['MAILER_SMTP_DOMAIN'],
      user_name:              ENV['MAILER_SMTP_USERNAME'],
      password:               ENV['MAILER_SMTP_PASSWORD'],
      authentication:         ENV['MAILER_SMTP_AUTHENTICATION'] || 'plain',
      enable_starttls_auto:   true
  }
end
