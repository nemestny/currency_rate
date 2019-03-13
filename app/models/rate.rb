class Rate < ApplicationRecord

# after_create_commit { RateChannel.broadcast_to() }
end
