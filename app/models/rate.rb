class Rate < ApplicationRecord

after_create_commit { ActionCable.server.broadcast('rate',self)}
end
