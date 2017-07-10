class Signlogger
    attr_accessor :agent, :login_page_user, :login_form_user, :user_field, :login_page_pass, :login_form_pass, :password_field, :home_page

    def login(url, password)
        begin
            self.agent = Mechanize.new
            self.agent.log = Logger.new "mechanize.log"
            self.login_page_user = agent.get url
            self.login_form_user = self.login_page_user.form_with(action: 'login.php')
            self.user_field = self.login_form_user.field_with(name: "login_username")
            self.user_field.value = 'Fenix'
            self.login_page_pass = self.login_form_user.click_button
            self.login_form_pass = self.login_page_pass.form_with(action: 'login.php?')
            self.password_field = self.login_form_pass.field_with(name: "login_pass")
            self.password_field.value = password
            self.home_page = self.login_form_pass.click_button
            
        rescue Exception => e
            puts e.message
            puts e.backtrace.inspect
        end
    end
end


    # def initialize 
    #     @agent = Mechanize.new
    #     @agent.log = Logger.new "mechanize.log"
    #     @login_page = agent.get "https://web-scraper-two-fultie.c9users.io/users/sign_in"
    #     @login_form = login_page.form
    #     @email_field = login_form.field_with(name: "user[email]") 
    #     @password_field = login_form.field_with(name: "user[password]")
    #     @email_field.value = 'vuneu@outlook.com'
    #     @password_field.value = '123456'
    #     @home_page = login_form.submit
    # end