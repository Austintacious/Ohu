class ProjectMailer < ActionMailer::Base
  default from: "Ohu"

  def project_confirmation(project, user)
    @user = user
    @project = project
    mail(to: @user.email, subject: "#{project.title} has been created!")
  end

end
