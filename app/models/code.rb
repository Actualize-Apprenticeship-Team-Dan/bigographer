class Code < ApplicationRecord
  def self.generate_url
    range = [*'0'..'9',*'a'..'z']
    Array.new(8){ range.sample }.join 
  end
end
