require "singleton"

class Assembrb
  include Singleton

  def initialize
    @config = {}
    @symtab = {}
  end
end

class Register
end

class ax << Register
end

class si << Register
end

def label(symbol)
end

def mov(dst, src)
end

def call(symbol)
end

def ret
end

def dw(word)
end

def assemble
end
