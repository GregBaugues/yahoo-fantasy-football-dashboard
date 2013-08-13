require 'spec_helper'

describe Projection do

  it 'should fail to update a projection if a player is not in the database' do
    data = Hashie::Mash.new
    data.id = 1
    lambda { Projection.create_from_ffn(data) }.should raise_error
  end



end
