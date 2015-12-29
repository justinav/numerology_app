get '/people' do
	@people = Person.all
	erb :"/people/index"
end

get '/people/new' do
	@person = Person.new
	erb :"/people/new"
end  

put '/people/:id' do
	# get record and update here
	@person = Person.find(params[:id])
	@person.first_name = params[:first_name]
	@person.last_name = params[:last_name]
	@person.birthdate = params[:birthdate]
	@person.save
  if @person.valid?
    @person.save
    redirect "/people/#{@person.id}"
  else
    @person.errors.full_messages.each do |message|
      @errors = "#{@errors} #{message}. <br />"
    end
    erb :"/people/edit"
  end
end

get '/people/:id' do
	@person = Person.find(params[:id])
	birthdate_string = @person.birthdate.strftime("%m%d%Y")
	birth_path_number = Person.get_number(birthdate_string)
	@message = Person.get_message(birth_path_number)
	erb :"/people/show"
end

get '/people/:id/edit' do
	@person = Person.find(params[:id])
	erb :'/people/edit'
end

post '/' do
	birthdate = params[:birthdate].gsub("-","")
  @person = Person.create(first_name: params[:first_name], last_name: params[:last_name], birthdate: birthdate)
  
  if (Person.valid_birthdate(birthdate))
    birth_path_number = Person.get_number(birthdate)
    if @person.valid?
      @person.save
      redirect "/people/#{@person.id}"
    end
	else
    @person.errors.full_messages.each do |message|
      @errors = "#{@errors} #{message}. <br />"
    end
		erb :"/people/new"
	end
end

delete '/people/:id' do
 	person = Person.find(params[:id])
 	person.delete
    redirect "/people"
end
