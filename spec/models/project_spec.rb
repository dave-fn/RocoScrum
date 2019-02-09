require 'rails_helper'

RSpec.describe Project, type: :model do

  it { should validate_presence_of :title }

  it { should belong_to(:admin).class_name('User').inverse_of(:projects).required }
  it { should have_many(:teams).inverse_of(:project) }

  # describe 'factories' do
  #   describe 'project' do
  #     let(:project)  { build :project, admin: user }
  #     let(:user)   { build :user }

  #     specify { expect(project.title).to be_a String }
  #     specify { expect(project.description).to be_a String }
  #     specify { expect(project.admin).to eq user }
  #   end
  # end

end
