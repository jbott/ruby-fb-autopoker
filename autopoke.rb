require 'rubygems'
require 'mechanize'

email = 'your_email'
password = 'your_password'
totalpokes = 0
puts email

agent = Mechanize.new()
agent.user_agent_alias = "Mac Firefox"
agent.cookie_jar.clear!
page = agent.get "http://m.facebook.com"

lf = page.forms.first
lf.field_with(:name => 'email').value = email
lf.field_with(:name => 'pass').value = password

result = lf.submit(lf.button_with(:name => 'login'))
puts result.title
while(result.title != 'Facebook') do
	if  result.title == 'Remember Browser'
		lf = result.forms.first
		result = lf.submit(lf.button_with(:name => 'submit[Continue]'))
		puts result.title
	elsif result.title == "Review Recent Login"
		lf = result.forms.first
		result = lf.submit(lf.button_with(:name => "submit[Continue]"))
		lf = result.forms.first
		result = lf.submit(lf.button_with(:name => 'submit[This is Okay]'))
		puts result.title	
	end
end
loop do
	print "Scanning Page: " 
	pokes = agent.get "http://m.facebook.com/pokes"
	puts pokes.title
	pokes.links_with(:text => "Poke Back").each do |link|
		totalpokes = totalpokes +1
		puts "Poking! " + totalpokes.to_s + " total."
		link.click
	end
	sleep(30)	
end
