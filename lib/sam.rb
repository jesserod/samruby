class Sam
public
  attr_accessor :name, :flag, :chrom, :pos, :mapq, :cigar, :mchrom, :mpos, :insert, :seq, :qual, :tags

  def initialize(line=nil)
    @tags = {}
    parse_line(line) if line != nil
  end

  def parse_line(line)
    return false if line[0] == "@"
    
    f = line.chomp.split("\t", -1)
    raise "SAM lines must have at least 11 fields (had #{f.size})" if f.size < 11

    # colnames = %w(1:name 2:flag 3:chr 4:pos 5:mapq 6:cigar 7:mchr 8:mpos 9:insrt 10:seq 11:qual)

    @name = f[0]
    @flag = f[1]
    @chrom = f[2]
    @pos = int_or_neg1(f[3])
    @mapq = int_or_neg1(f[4])
    @cigar = f[5]
    @mchrom = f[6]
    @mpos = int_or_neg1(f[7])
    @insert = int_or_raw(f[8])
    @seq = f[9]
    @qual = f[10]

    @tags = {}
    i = 11
    while i < f.size
      tag = f[i]
      i += 1
      colon_index = tag.rindex(':') 
      raise line if f.rindex == nil
      key = tag[0, colon_index]
      value = int_or_raw(tag[colon_index + 1, tag.size - colon_index] || "")
      @tags[key] = value
    end

    return true;
  end

private

  def int_or_neg1(x)
    Integer(x) rescue -1
  end

  def int_or_raw(x)
    Integer(x) rescue x
  end

end
