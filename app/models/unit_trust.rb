class UnitTrust < ActiveRecord::Base
	belongs_to :user
	has_many :ut_histories

	def calculate_value
		self.price * self.num_units	
	end

	def price_update
		ut=self
		if ut.url.start_with?('https://www.fundsupermart.com.my/main/fundinfo/')
			browser = Watir::Browser.new :phantomjs
			browser.goto ut.url
			if browser.checkbox(id: 'readedAgreement').exist?
				browser.checkbox(id: 'readedAgreement').set(true)
				browser.element(:css => 'input[type=button]').click
				until browser.element(:css => 'table tr td a b').exists? do sleep 1 end
				page2 = Nokogiri::HTML.parse(browser.html)
						ut.update(price:page2.css('table tr td a b').last.ancestors('tr').first.last_element_child.content.gsub!(/.*(\d+[.]\d+).*/,'\1').strip.to_f)
			else
				page2 = Nokogiri::HTML.parse(browser.html)
							ut.update(price:page2.css('table tr td a b').last.ancestors('tr').first.last_element_child.content.gsub!(/.*(\d+[.]\d+).*/,'\1').strip.to_f)
			end 
			browser.close
		elsif ut.url.start_with?('http://www.publicmutual.com.my/application/fund/fundprice.aspx')
			doc = Nokogiri::HTML(open('http://www.publicmutual.com.my/application/fund/fundprice.aspx'))
			doc.css('table.fundtable tr').each do |name|
				if ut.name.include? name.search('td:nth-child(2)').text
					ut.update(price:name.search('td:nth-child(4)').text.to_f)
				end
			end
		elsif ut.url.start_with?('http://my.morningstar.com/ap/quicktake/overview.aspx?') && ut.url.end_with?("Overview")
			doc = Nokogiri::HTML(open(ut.url))			
			ut.update(price:doc.css('#MainContent_QuickTakeMainContent_QuickTakeForm_NAVText').text().to_f)
		end

		if !ut.ut_histories.pluck(:date).include?(ut.updated_at.to_date)
			ut.ut_histories.create(date:ut.updated_at.to_date,price:ut.price,num_units:ut.num_units)
		else
			ut_history=UtHistory.find_by(date:ut.updated_at.to_date)
			ut_history.update(price:ut.price,num_units:ut.num_units)
		end
	end

end
