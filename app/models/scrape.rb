class Scrape
    attr_accessor :title, :hotness, :image_url, :rating, :director, :genre, :release_date, :runtime, :synopsis, :failure
    
    def scrape_new_movie(url)
        begin
            doc = Nokogiri::HTML(open(url))
            doc.css('script').remove
            self.title = doc.at("//h1[@data-type = 'title']").text.strip
            self.hotness = doc.css(".meter-value.superPageFontColor > span").first.text.to_i
            self.image_url = doc.at_css("#movie-image-section img")['src']
            self.rating = doc.css("ul.content-meta.info > li:first-child > div.meta-value").text
            self.director = doc.css("ul.content-meta.info > li:nth-child(3) > div.meta-value > a").text
            self.genre = doc.css("ul.content-meta.info > li:nth-child(2) > div.meta-value > a").text.strip
            self.release_date = doc.css("ul.content-meta.info > li:nth-child(5) > div.meta-value > time").text.strip.to_date
            self.runtime = doc.css("ul.content-meta.info > li:nth-child(8) > div.meta-value > time").text.strip
            s = doc.css("#movieSynopsis").text.strip
            if ! s.valid_encoding?
                s = s.encode("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8')
            end
            self.synopsis = s
            return true
        rescue Exception => e
            self.failure = "Something went wrong with the scrape"
        end
    end
end