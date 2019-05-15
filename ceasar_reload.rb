require 'sinatra'
require 'sinatra/reloader' if development?

def ceasar_cipher(secret, shift)
  shift = shift.to_i
  alphabet = ('a'..'z').to_a
  secret = secret.split('')
  cipher = []
  secret.each_with_index do |char, idx|
    cipher_char = char.downcase
    if /[a-z]/.match?(cipher_char)
      cipher_key = (alphabet.index(cipher_char) + shift) % 26
      cipher_char = alphabet[cipher_key]
      cipher_char = cipher_char.upcase if /[A-Z]/.match?(char)
    end
    cipher.push(cipher_char)
  end
  cipher.join('')
end

get '/' do
  secret = params.fetch :secret, ''
  shift = params.fetch :shift, 0
  encrypted = ceasar_cipher(secret, shift)
  erb :index, locals: {:encrypted => encrypted}
end