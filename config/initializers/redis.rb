ENV["REDISTOGO_URL"] ||= "redis://redistogo:91fd76a157183c1fb7346c02d3488a00@greeneye.redistogo.com:11535/"

uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)

