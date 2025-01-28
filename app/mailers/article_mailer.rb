# class ArticleMailer < ApplicationMailer
#     default from: "notifications@example.com"
  
#     # def welcome_email
#     #   @user = params[:user]
#     #   @url  = "http://example.com/login"
#     #   mail(to: @user.email, subject: "Welcome to My Awesome Site")
#     # end


#     def article_created(article)
#       @article = article
#       mail(to: 'admin@example.com', subject: 'New Article Created')
#     end
# end



class ArticleMailer < ApplicationMailer
    default from: "notifications@example.com"
    def article_created(article)
      @article = article
      mail(to: 'admin@example.com', subject: 'New Article Created')
    end
  end
  