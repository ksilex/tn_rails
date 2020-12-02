vowels = %w[a e i o u y]
vowels_ids = {}

("a".."z").each do |vowel|
  if vowels.include?(vowel)
  vowels_ids[vowel] = vowel.bytes.map{|id| id - 96}
  end
end

print "#{vowels_ids}\n"
