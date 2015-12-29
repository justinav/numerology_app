require 'sinatra'

get '/' do
	@person = Person.new
	erb :"/people/new"
end