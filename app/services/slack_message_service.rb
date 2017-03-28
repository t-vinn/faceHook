class SlackMessageService
  include ServiceBase

  def call
    url = Settings.URL_SLACK
    msg = post_with_content.class.name + " was posted. The message was \n" + \
          post_with_content.content
    HTTParty.delay.post(url, body: { "text": msg.to_s }.to_json)
  end

  private

    attr_accessor :post_with_content
end
