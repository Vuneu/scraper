class Test
    attr_accessor :image_url 
    #= Array.new(2)
    def scrape_for_image
        doc = Nokogiri::HTML(open("https://www.rottentomatoes.com/search/?search=Paprika"))
        doc.css('script').remove
        image_url = Array.new(2)
        for i in 0..1
            image_url[i] = doc.at_css('ul#movie_results_ul.results_ul li:nth-child(1) img')['src']
        end
    end
end

 # doc.css('ul#movie_results_ul.results_ul li:nth-child(1)').text //li
 # doc.at_css('ul#movie_results_ul.results_ul li:nth-child(1) img')['src'] //image of li             
 
 