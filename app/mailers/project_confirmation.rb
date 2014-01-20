class ProjectConfirmation < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.project_confirmation.receipt.subject
  #
  def receipt
    @greeting = "Hi"
    mail to: "user@example.com",
      subject: "A New Project Has Been Created!"
  end
end
