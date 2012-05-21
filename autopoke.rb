require 'rubygems'
require 'mechanize'

email = "EMAIL"
pass = "PASSWORD"
totalpokes = 0
print email + "\n"

agent = Mechanize.new
agent.user_agent_alias = "Mac FireFox"
agent.cookie_jar.clear!
page = agent.get "http://m.facebook.com/"
#puts page.title

login_form = page.forms.first
login_form.field_with(:name => 'email').value = email
login_form.field_with(:name => 'pass').value = pass

result = login_form.submit(login_form.button_with(:name => 'login'))
loop do
	print "Scanning Page:"
	pokes = agent.get "http://m.facebook.com/pokes"
	puts pokes.title
	pokes.links_with(:text => 'Poke back').each do |link|
		totalpokes = totalpokes + 1
		print("Poking! " + totalpokes.to_s + " Total")
		link.click
	end
	#page2 = agent.click(result.link_with(:text => 'Try Again'))
	#puts page2.body
	sleep(5)
end
