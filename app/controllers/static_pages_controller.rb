class String
def shuffle
self.split('').shuffle.join
end
end

class StaticPagesController < ApplicationController
  def home
	@shuffle = "Welcome!".shuffle
	@person1 = {nom: "sch", prenome: "s"}
	@person2 = {nom: "dalle", prenome: "s"}
	@person3 = {nom: "martine", prenome: "s"}
	@params = {pere: @person1, mere: @person2, enfant: @person3}
@p=shuffle_tableau(["","bdfd"])
  end

  def shuffle_tableau(s)
    for i in 1..(s.length-1)
	s[i]=s[i].to_s.shuffle
end
s
  end
def help
end
end
