# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Team, type: :model do

  it { should respond_to :hashid }

  it { should belong_to(:project).inverse_of(:teams).required }
  it { should have_one(:project_admin).through(:project).class_name('User').source(:admin) }

  it { should have_one(:product).through(:project) }
  it { should have_one(:product_owner).through(:product) }

  it { should have_many(:team_memberships).inverse_of(:team) }
  it { should have_many(:members).through(:team_memberships).source(:user) }
  it { should have_one(:scrum_master).source(:user) }
  it { should have_many(:developers).source(:user) }

  it { should have_many(:sprint_backlog_items).dependent(:nullify).inverse_of(:team) }


  context 'concrete instances' do
    let(:team)  { create :working_team, developer_count: developer_count, project: project }
    let!(:product)  { create :product, :with_product_owner, project: project }
    let(:project)  { create :project }

    before(:each) do
      create :scrum_master_role
      create :developer_role, min_participants: 3, max_participants: 7
    end

    describe '#size' do
      let(:developer_count)  { 7 }

      it 'counts all members' do
        expect(team.size).to eq 9
      end
    end

    describe '#developers' do
      context 'under minimum' do
        let(:developer_count)  { 0 }

        it 'returns team developers' do
          expect(team.developers.size).to eq 0
        end
      end

      context 'within limits' do
        let(:developer_count)  { 5 }

        it 'returns team developers' do
          expect(team.developers.size).to eq 5
        end
      end
    end


    context 'when validating relationship' do

      context 'developers' do
        context 'under minimum' do
          let(:developer_count)  { 2 }

          specify { expect(team).to_not be_valid }
          # pending 'set flag to mark non-compliant as intermediate state -- aside from valid'

          context 'due to removing' do
            let(:developer_count)  { 3 }
            let(:parting_dev)  { team.developers.first }

            pending { expect { team.developers.destroy(parting_dev) }.to raise_error Team::Errors::MinDevelopers }
          end
        end

        context 'within limits' do
          let(:developer_count)  { 5 }

          specify { expect(team).to be_valid }
        end

        context 'over maximum' do
          let(:developer_count)  { 10 }

          pending { expect { team }.to raise_error Team::Errors::MaxDevelopers }
          specify { expect(team).to_not be_valid }
        end
      end

    end
  end

end
