#!/usr/bin/env ruby

#SEO Tool

#by Colin Trierweiler

#Find the total word count, the top ten most used words, and how "interesting" a given text file is

input = File.read(ARGV[0])
wordCounts = [ ]

#remove caps and punctuation
lowercaseLetters = input.downcase.delete(".",",",":",";","\"")

#process words into an array
words = lowercaseLetters.split(/\s+/)

#grab a word count while we're here
totalWordCount = words.length

#exclude stopwords
stopWords = ["i", "a", "about", "an", "and", "are", "as", "at", "be", "been", "being", "by", "but", "com", "de", "en", "for", "from", "had", "have", "he", "her", "his", "how", "if", "in", "is", "it", "not", "of", "on", "or", "she", "than", "that", "the", "there", "this", "to", "was", "what", "when", "where", "which", "who", "will", "with", "would", "they", "www"]

words -= stopWords

#grab a count of unique words that are't stop words

interestWordCount = words.uniq.length

#Count words by counting the difference between the array's size
#with and without the current word
words.each do |firstWord|
	wordCount = words.length - (words - [firstWord]).length
	wordCounts << [wordCount, firstWord]
end
	
#Strip duplicates
wordCounts.uniq!

#Find the top ten
topTen = wordCounts.sort.reverse

#Display results
puts "\nTotal word count: #{totalWordCount}"
puts "Interesting word count: #{interestWordCount}"
print "Interesting ratio: " + sprintf("%0.2f", (interestWordCount.to_f / totalWordCount.to_f) * 100) + "\n\n"
puts "keyword		count		density %"
puts"========	======		========"
0.upto(9) do |i|
	density = (topTen[i][0].to_f / totalWordCount.to_f) * 100 
	puts topTen[i].reverse.join("\t\t") + "\t\t" + sprintf("%0.2f", density)
end

