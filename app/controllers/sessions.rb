enable :sessions

get '/registrar' do
    erb :registrar    
end

post '/registrar_form' do
    # Capturamos los valores del formulario con 'params'
      p name  = params[:name]
      p email = params[:email]
      p password = params[:password]
     #Creamos una instancia de la clase User con sus atributos necesarios
      user  = User.new(name: name, email: email, password: password)
   # Si el usuario se guardó en la DB, redirige a su perfil, de otra forma
    #vuelve a mostrar el formulario.
    if user.save
      session[:user_id] = user.id
      session[:correct_user] = "Usuario Creado con Exito"
      redirect to '/sesion'
    else
      session[:incorrect_user] = "Error Usuario no Creado con Exito"
      redirect to '/registrar'
  end
end

#---------------

#session se utiliza para las kookis guarde su información el usuario por
#unos momentos y despues pueda cerrar session 
get '/sesion' do
    erb :sesion    
end
#el before es como un filtro el cual se encarga de las sessiones del usuario
#e inpide no enttrar si no a hiniciado session si no la encuentta manda mensaje de error
before '/secret' do
  unless session[:email]
    session[:error] = "No has iniciado sesión"
    #i need to redirect to index to avoid go to /secret again
    redirect to '/'
  end
end

get '/secret' do
   @ulr = Url.where(user_id: current_user.id)
   erb :secret
end 

post '/iniciar_sesion' do
    # Capturamos los valores del formulario con 'params'
      @email = params[:email]
      @password = params[:password]
     #Creamos una instancia de la clase User con sus atributos necesarios
    @user_validate = User.autentic(@email, @password)

    # Si el usuario se guardó en la DB, redirige a su perfil, de otra forma
    # vuelve a mostrar el formulario.
     if @user_validate 
       session[:email] = @email
       session[:user_id] = @user_validate.id
       redirect to '/secret'
  
     else 
       session[:incorrect_login] = "Email y/o password incorrectos"
       redirect to '/sesion'
    end
end
# este lo que hace es limpiar la session una ves que el usuario ya termina se
#al logout, apunta el boton a esto limpia la session y la redirecciona a la raiz 
get '/logout' do
  session.clear
  session[:logout] = "Has cerrado sesión correctamente"
  redirect to '/'
end
