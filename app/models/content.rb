class Content < ActiveRecord::Base
  module StatusType
    execute_mery   = 1
    execute_style4 = 3
    execute_api    = 4
    execute_buyma  = 5

    NAME = {
        execute_mery    => "Lovely",
        execute_style4  => "Qute",
        execute_api     => "Coupon",
        execute_buyma     => "Fashion"

    }.freeze
  end
end
