class LandingPage < SplashMath

  page_url "#{FigNewton.base_url}"

  link(:sign_in, href: '#login-modal')

end