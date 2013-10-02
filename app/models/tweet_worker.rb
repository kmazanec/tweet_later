class TweetWorker
  include Sidekiq::Worker

  def perform(tweet_id)
    tweet = Tweet.find(tweet_id)
    user  = tweet.user

    puts "========================================"
    puts "User: #{user}"
    puts "User: #{user.inspect}"
    puts "Tweet: #{tweet}"
    puts "Tweet: #{tweet.inspect}"

    # set up Twitter OAuth client here
    # actually make API call
    # Note: this does not have access to controller/view helpers
    # You'll have to re-initialize everything inside here

    Twitter.configure do |config|
      config.consumer_key = ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']
    end


    twitter_user = Twitter::Client.new(
      :oauth_token => user.oauth_token,
      :oauth_token_secret => user.oauth_secret
    )

    puts "Twitter User: #{twitter_user}"
    puts "Twitter User: #{twitter_user.inspect}"
    puts "========================================"
    
    twitter_user.update(tweet.text)

  end
end
