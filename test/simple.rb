#!/usr/bin/env ruby

load "#{File.dirname(__FILE__)}/../lib/sam.rb"

lines=[
"readname	0	chrX	46615805	37	76M	*	0	0	AAATCTT...	edaecdd...	XT:A:U	NM:i:0	X0:i:1"
]


for line in lines
  sam = Sam.new(line)

  puts line.gsub("\t", "  \\t  ")
  puts
  for f in [:name, :flag, :chrom, :pos, :mapq, :cigar, :mchrom, :mpos, :insert, :seq, :qual, :tags]
    puts "#{f}\t#{sam.send(f).inspect}"
  end
  puts
end
