require "net/http"
require "json"

module Upload
  class UploadError < StandardError
  end
  
  def upload
    client_id = ENV["IMGUR_CLIENT_ID"]
    uri = URI("https://api.imgur.com/3/image")
    req = Net::HTTP::Post.new(uri)
    req["Authorization"] = "Client-ID #{client_id}"
    req.set_form(
      [
        ["image", File.open("screenshots/#{name}.png")],
        ["type", "image"],
        ["title", name],
        ["description", "#{name} for Ark Nova SHotW post"]
      ],
      "multipart/form-data"
    )
    req_options = {
      use_ssl: uri.scheme == "https"
    }
    res = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(req)
    end

    if res.code != "200"
      puts JSON.parse(res.body)
      raise UploadError.new(res.message)
    end

    @upload_link = JSON.parse(res.body)["data"]["link"]
  end
end
