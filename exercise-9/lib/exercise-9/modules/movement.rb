require_relative 'invalid_direction_exception'

module Movement

  def move(direction)
    plane,amount = nil, nil
    if  %i{left right}.include?(direction)
      plane, amount = :latitude, (direction == :left ? 1 : -1)
    elsif %i{forwards backwards}.include?(direction)
      plane, amount = :longitude, (direction == :forwards ? 1 : -1)
    else
      raise InvalidDirectionException, "I just don't move like that"
    end

    position[plane]+= amount
    self
  end

  def move_left
    move :left
  end

  def move_right
    move :right
  end

  def move_forwards
    move :forwards
  end

  def move_backwards
    move :backwards
  end

  private

  def position
    @position ||= {longitude: 0, latitude: 0 }
  end
end