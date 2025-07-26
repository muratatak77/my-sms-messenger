class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  # === Fields ===
  field :to, type: String
  field :body, type: String
  field :status, type: String, default: "pending"
  field :sid, type: String

  # List of all valid message statuses
  STATUSES = %w[pending sent delivered failed].freeze

  # Ensure that the status field only contains a valid value
  validates :status, inclusion: { in: STATUSES }
  validates :to, presence: true
  validates :body, presence: true

  # === Associations ===
  belongs_to :user

  # === Dynamic Methods & Scopes ===
  # - A predicate method, e.g., message.sent? returns true if status is "sent"
  STATUSES.each do |s|
    define_method "#{s}?" do
      status == s
    end

    # Defines class-level scope like Message.pending, Message.failed, etc.
    scope s, -> { where(status: s) }
  end
end
