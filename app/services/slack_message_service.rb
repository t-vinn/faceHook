class SlackMessageService
  def initialize(post_with_content)
    @post_with_content = post_with_content
  end

  def send_to_times
    url = ENV['URL_SLACK']
    msg = @post_with_content.class.name + " was posted. The message was \n" + \
          @post_with_content.content
    HTTParty.delay.post(url, body: { "text": msg.to_s }.to_json)
  end

  private

    attr_reader :post_with_content
end
