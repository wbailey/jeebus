require 'rubygems'
require 'benchmark'
require 'ruby-prof'

result = RubyProf.profile do
  "messages.index.filter.label".split('.').reverse.inject([]){|a,s| a << [s,a.last].compact.join('.').to_sym}.reverse
end

RubyProf::GraphPrinter.new(result).print(STDOUT, 0)

result = RubyProf.profile do
  a = "messages.index.filter.label".split('.')
  1.upto(a.size).inject([]) {|s,t| s << a.slice(a.size-t,t).join('.').to_sym}.reverse
end

RubyProf::GraphPrinter.new(result).print(STDOUT, 0)

count = 100000

Benchmark.bm do |b|
  b.report('inject') do
    count.times do
      "messages.index.filter.label".split('.').reverse.inject([]){|a,s| a << [s,a.last].compact.join('.').to_sym}.reverse
    end
  end

  b.report('block') do
    count.times do
      a = "messages.index.filter.label".split('.')
      1.upto(a.size).inject([]) {|s,t| s << a.slice(a.size-t,t).join('.').to_sym}.reverse
    end
  end
end
