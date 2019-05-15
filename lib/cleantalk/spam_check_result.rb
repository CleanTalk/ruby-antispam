class Cleantalk::SpamCheckResult < Cleantalk::Result
  attr_reader :data, :id, :appears, :sha256, :network_type,
              :spam_rate, :frequency, :frequency_time_10m,
              :frequency_time_1h, :frequency_time_24h
end
