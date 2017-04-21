class DelayTestService
  include ServiceBase

  def call
    delay.echo
  end

  private

  def echo
    puts 'hello FiNC'
   UserMailer.feed_creation(Feed.find(3)).deliver_now 
  end
end
