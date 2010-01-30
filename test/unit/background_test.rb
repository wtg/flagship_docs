require 'test_helper'

class BackgroundTest < ActiveSupport::TestCase
  fixtures :users

  def setup
    @regular = users(:regular)
    @groupie = users(:groupie)
    @admin = users(:admin)
  end

  def test_validation
    background = Background.new()
    assert !background.valid?

    image = File.open("#{RAILS_ROOT}/test/binaries/background_1.jpg")
    background.image = image
    assert background.valid?
  end

  def test_authenticates_access
    background = Background.new()
    image = File.open("#{RAILS_ROOT}/test/binaries/background_1.jpg")
    background.image = image

    assert !background.save

    ActiveRecord::Base.accessor = @regular
    assert !background.save

    ActiveRecord::Base.accessor = @groupie
    assert background.save
  end
end
