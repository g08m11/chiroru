class Content < ActiveRecord::Base
  module StatusType
    execute_mery   = 1
    execute_style4 = 3
    execute_api    = 4

    NAME = {
        execute_mery    => "Lovely",
        execute_style4  => "Qute",
        execute_api     => "Coupon"
    }.freeze
  end
end
