require "net/http"
require "json"

module Upload
  CLIENT_ID = ENV["IMGUR_CLIENT_ID"]

  class UploadError < StandardError
  end
  
  def upload
    uri = URI("https://api.imgur.com/3/image")
    req = Net::HTTP::Post.new(uri)
    req["Authorization"] = "Client-ID #{CLIENT_ID}"
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
      raise UploadError.new(res.message)
    end

    @upload_link = JSON.parse(res.body)["data"]["link"]
  end
end
