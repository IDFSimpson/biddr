class Auction < ActiveRecord::Base
  has_many :bids, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, uniqueness: true
  validates :ends, presence: true
  validates :reserve_price, presence: true, numericality: { greater_than: 0 }


  include AASM
  aasm whiny_transitions: false do
    state :draft, initial: true
    state :published
    state :canceled
    state :reserve_met
    state :reserve_not_met
    state :won

    event :publish do
      transitions from: :draft, to: :published
    end
    event :meet_reserve do
      transitions from: :published, to: :reserve_met
    end
    event :fail do
      transitions from: :published, to: :reserve_not_met
    end
    event :cancel do
      transitions from: [:draft, :published, :reserve_met, :reserve_not_met], to: :canceled
    end
    event :win do
      transitions from: :reserve_met, to: :won
    end
  end
end
