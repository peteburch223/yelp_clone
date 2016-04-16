require 'rails_helper'

describe Endorsement, type: :model do

  let(:user) { create(:user) }
  let(:review) { build(:review) }
  subject(:endorsement) { build(:endorsement) }
  let(:endorsement2)  { build(:endorsement) }

  it { is_expected.to belong_to :review }
  it { is_expected.to belong_to :user }


  it 'is invalid if the user and review FKs are the same', focus: false do
    link_endorsement_with_review_and_user(review, endorsement, user)
    link_endorsement_with_review_and_user(review, endorsement2, user)
    expect(endorsement2).to have(1).error_on(:user)
  end

end
