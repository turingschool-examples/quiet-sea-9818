require 'rails_helper'

RSpec.describe Plot do
  describe 'relationships' do
    it { should belong_to(:garden) }
    it { should have_many(:plot_plants) }
    it { should have_many(:plants).through(:plot_plants) }
  end

  describe 'validations' do
    it { should validate_presence_of :number }
    it { should validate_presence_of :size }
    it { should validate_presence_of :direction }
  end
end
