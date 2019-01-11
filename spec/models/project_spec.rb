require 'rails_helper'

RSpec.describe Project, type: :model do

  it { should validate_presence_of :title }

  it { should belong_to(:admin).class_name('User').inverse_of(:projects).required }

  # describe 'factories' do
  #   describe 'project' do
  #     let(:project)  { build :project, admin: user }
  #     let(:user)   { build :dummy_user }

  #     specify { expect(project.title).to be_a String }
  #     specify { expect(project.description).to be_a String }
  #     specify { expect(project.admin).to eq user }
  #   end
  # end

end
