require 'net/http'
require 'json'

class PagesController < ApplicationController
  def home
  end

  def search
    jsonBody = Net::HTTP.get_response(URI.parse('http://tw-concurs3.heroku.com/rest/projects/updated-list.json')).body
    json = JSON.parse(jsonBody)
    @result = []
    author = params[:author]

    json.each do |el|
      if el['authors']['first'].downcase.include?(author.downcase) or (!el['authors']['second'].nil? and el['authors']['second'].downcase.include?(author.downcase))
        url = "http://tw-concurs3.heroku.com/rest/projects/show/#{el['id']}.json"
        @result += [url]

        if Project.find_by_urlId(url).nil?
          Project.create(:urlId => url, :clicks => 0)
        end
      end
    end
  end

  def raiseClicksCount
    proj = Project.find_by_urlId(params[:url_string])
    proj[:clicks] += 1
    proj.save
  end
end
