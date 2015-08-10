require_relative '../../exercise-12/lib/linguine'

class HomePage < Linguine

  def title
    'Home Page!!'
  end

  def body
    '<h1>Hello!</h1><p>This is a line of text that should be translated into the language of your choice.</p>'
  end

end
