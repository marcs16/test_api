require 'net/http'
class CreatePostApiJob < ApplicationJob
  queue_as :default

  def perform()
    uri = URI("https://jsonplaceholder.typicode.com/posts")
    req =Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json', charset: 'utf-8')
    req.body = { title: 'foosudes', body: 'barsudes', userId: 1 }.to_json
    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(req)
    end
  end
end
