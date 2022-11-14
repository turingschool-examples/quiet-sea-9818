require 'rails_helper'

RSpec.describe Plant do
  describe 'relationships' do
    it { should have_many(:plot_plants)}
    it { should have_many(:plots).through(:plot_plants)}
    it { should have_many(:gardens).through(:plots)}
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :days_to_harvest }
  end
end