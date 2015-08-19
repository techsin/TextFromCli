require 'twilio-ruby'
require 'yaml'
require "pry"
require "json"
require "open-uri"



@keys = YAML.load_file('../lib/application.yml')
account_sid = @keys['ACCOUNT_SID']
auth_token = @keys['AUTH_TOKEN']
@client = Twilio::REST::Client.new account_sid, auth_token

def sendMsg(number, msg)
	puts "Sending a message to #{number} : \'#{msg}\'"

	@client.account.messages.create( 
	:from => '6463622005',
	:to => number,
	:body => msg
	)
	sleep(2)
	clearWindow
end

def getInput
	gets.chomp
end

def moreMsgs(number)
	endIt = true

	while endIt
		puts '>Please enter a message'
		input = gets.chomp
		if input.nil? || input.empty?
			next
		elsif input == '::exit' 
			endIt = false 
			puts '>byeeeeee'
			break
		elsif input == '::weather'
			puts '>>Enter the zipcode (USA only)'
			zip = gets.chomp
			f = returnTemp(zip)
			puts 'Weather Sent'
			sendMsg(number, "Tempreature is #{f} F in #{zip}!!!")
			next
		elsif input == '::list'
			showCommands
		else
			sendMsg(number,input)
		end
	end
	
end

def firstRun(number)
	if (number.nil? || msg.empty?)
		clearWindow 
		puts '>Please enter a number'
		number = getInput
	end
	number
end

def run(number, msg)
	number = firstRun(number)
	moreMsgs(number)
end

def returnTemp(zip)
	data = JSON.parse(open("http://api.openweathermap.org/data/2.5/weather?units=imperial&zip=#{zip},us").read)
	data['main']['temp']
end

def showCommands
	clearWindow
	puts '''
	::list - shows possible options
	::exit - close the program
	::weather TEXTS the current Tempreature in F and takes in ZIPCODE
	'''
end

def clearWindow
	system "clear" 
	system "cls"
	puts ":::::::::::::::Welcome to proMsg app..:::::::::::::" 
	puts "type ::exit to end proMsg app! or ::weather to text weather. "
	puts "type ::list to see more options ..."
end