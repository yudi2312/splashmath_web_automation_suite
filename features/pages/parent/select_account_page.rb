class SelectAccountPage < SplashMath

  def select_student(student)
    case student
      when Integer
        self.class.link(:student, xpath: "//div[@class='login-wrap']/ul[#{student+1}]/li/a")
      else
        self.class.image(:student, alt: /#{student.strip}/i)
    end
    self.student_element.click
  end


end