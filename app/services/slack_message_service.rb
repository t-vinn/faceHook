class SlackMessageService
  def initialize(post_with_content)
    @content = post_with_content.content
    @class_name = post_with_content.class.name
  end

  def send_to_times
    url = ENV['URL_SLACK']
    msg = @class_name + " was posted. The message was \n" + \
          @content
    HTTParty.delay.post(url, body: { "text": msg.to_s }.to_json)
  end

  private

    attr_reader :post_with_content
end
