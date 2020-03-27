require "rcellrange/version"

class Rcellrange
  class Error < StandardError; end

  def coord2cell row, col, options={}
    row_range, col_range = [rrangelize(row), rrangelize(col)]
    left_upper = "#{sheet_column(col_range.first)}#{row_range.first}"
    right_bottom = "#{sheet_column(col_range.last)}#{row_range.last}"
    return left_upper if left_upper == right_bottom
    "#{left_upper}:#{right_bottom}"
  end

  CELL_REGEX = %r{([A-Z]+)([0-9]+)}

  def cell2coord range, options={}
    lt, rb = range.split(":")
    c_lt, r_lt = CELL_REGEX.match(lt).captures
    c_rb, r_rb = CELL_REGEX.match(rb || "")&.captures
    c_rb ||= c_lt
    r_rb ||= r_lt
    [r_lt.to_i..r_rb.to_i, decode_column(c_lt)..decode_column(c_rb)]
  end

  private

  def rrangelize n
    case n
    when Integer
      n..n
    when Range
      n
    end
  end

  def sheet_column ncol
    # https://ja.stackoverflow.com/q/6083/6631#6631
    offset = 'A'.ord #65
    base = 26
    value = ncol.dup
    result = []
    while value > 0
      value -= 1
      result << (value%base+offset).chr
      value /= base
    end
    result.reverse.join
  end

  BASE_NUMBER = 'Z'.ord - 'A'.ord + 1

  def decode_column col
    col.split(//).reverse.each_with_index.reduce(0) do |n,(c,i)|
      n + (c.ord - 'A'.ord + 1) * BASE_NUMBER ** i
    end
  end
end
