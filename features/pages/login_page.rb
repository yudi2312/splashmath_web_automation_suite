class LoginPage < SplashMath

  img(:teacher, alt: 'Teacher')
  img(:parent, alt: 'Parent')
  img(:student, alt: 'Student')

  text_field(:username, id: 'user_login')
  text_field(:password, id: 'user_password')

  button(:sign_in, id: 'login-button')
  link(:forget_password, id: 'forget-password')

  link(:sign_in_with_google, href: /\/users\/auth\/google_oauth2\?source=web&type=(parent|teacher)/)
  link(:sign_in_with_facebook, href: /\/users\/auth\/facebook\?source=web&type=(parent|teacher)/)

  link(:i_have_school_wide_license, text: 'I have a school wide license')

end