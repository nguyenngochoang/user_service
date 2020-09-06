class User < ApplicationRecord
  USER_PARAMS = %i[email last_name first_name gender].freeze

  enum gender: %i[male female other]
end
