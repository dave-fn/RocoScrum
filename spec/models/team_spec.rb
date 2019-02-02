require 'rails_helper'

RSpec.describe Team, type: :model do

  it { should respond_to :hashid }

  it { should belong_to(:project).inverse_of(:teams).required }

  it { should have_many(:team_memberships).inverse_of(:team) }
  it { should have_many(:members).through(:team_memberships).source(:user) }
  it { should have_one(:scrum_master).source(:user) }
  it { should have_many(:developers).source(:user) }


  context 'concrete instances' do
    let(:team)  { create :working_team, developer_count: developer_count }
    let!(:roles)  { create :scrum_master_role; create :developer_role, max_participants: 7 }

    describe '#size' do
      let(:developer_count)  { 7 }

      it 'counts all members' do
        expect(team.size).to eq 8
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
          let(:developer_count)  { 0 }

          specify { expect(team).to be_valid }
          pending 'set flag to mark non-compliant as intermediate state -- aside from valid'
        end

        context 'within limits' do
          let(:developer_count)  { 5 }

          specify { expect(team).to be_valid }
        end

        context 'over maximum' do
          let(:developer_count)  { 10 }

          specify { expect { team }.to raise_error Team::Errors::MaxDevelopers }
        end
      end

    end
  end

end
