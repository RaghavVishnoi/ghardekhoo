class Token
  def generate
    SecureRandom.hex(20).encode('UTF-8')
  end
end