require_relative '../../exercise-12/lib/linguine'

class HomePage < Linguine

  def title
    "Home Page!!"
  end

  def body
    "<h1>Hello!</h1>"
  end

end

run HomePage.new