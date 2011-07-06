Overview
============

This gem provides a lightweight class, `Sam`, which can be used to parse SAM files by giving it one SAM line at a time.

To install, just install the `sam` gem:

    sudo gem install sam

Usage
=====

To print the XT:A tag of each entry, you might do this:
    require 'sam'

    for line in gets
      next if line[0] == "@" # Skip header if it exists
      puts Sam.new(line).tags["XT:A"]
    end

You can do something similar with a one-liner at the command line

    cat test.sam | ruby -r sam -ne 'next if $_[0] == "@"; puts Sam.new($_).tags["XT:A"]' 

You can also use the `parse_line` method to reuse the same Sam object

    require 'sam'
    s = Sam.new

    for line in gets
      if s.parse_line(line) # Returns false if line starts with @ (a header line)
        puts s.tags["XT:A"]
      end
    end


Details
=======
The `Sam` class has the following member variables:

* `name`: a string
* `flag`: an integer or a string if `samtools view -X` was used
* `chrom`: a string
* `pos`: an integer (-1 if unmapped)
* `mapq`: an integer (-1 if unspecified)
* `cigar`: a string
* `mchrom`: a string
* `mpos`: an integer (-1 if unmapped)
* `insert`: an integer (or the raw string if not set)
* `seq`: a string
* `qual`: a string
* `tags`: a hash mapping tag names to tag values
