# frozen_string_literal: true

# DoubleTranspositionCipher
module DoubleTranspositionCipher
  def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher

    # 1. find number of rows/cols such that matrix is almost square
    words = document.to_s.split('')
    words_num = words.size
    matrix_num = Math.sqrt(words_num).ceil

    # 2. break plaintext into evenly sized blocks
    (matrix_num**2 - words_num).times { words.push('#') }
    blocks = words.each_slice(matrix_num).to_a

    # 3. sort rows in predictibly random way using key as seed
    rows = [*0..(matrix_num - 1)].shuffle(random: Random.new(key))
    rows.each_with_index { |r, i| rows[i] = blocks[r] }

    # 4. sort columns of each row in predictibly random way
    columns = [*0..(matrix_num - 1)].shuffle(random: Random.new(key))
    columns.each_with_index { |c, i| columns[i] = rows.transpose[c] }

    # 5. return joined cyphertext
    columns.transpose.join
  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    words = ciphertext.split('')
    matrix_num = Math.sqrt(words.size).ceil
    blocks = words.each_slice(matrix_num).to_a

    rows_order = [*0..(matrix_num - 1)].to_a.shuffle(random: Random.new(key))
    cols_order = [*0..(matrix_num - 1)].to_a.shuffle(random: Random.new(key))

    columns_d = []
    rows_d = []
    cols_order.each_with_index { |c, i| columns_d[c] = blocks.transpose[i] }
    rows_order.each_with_index { |r, i| rows_d[r] = columns_d.transpose[i] }
    rows_d.join.delete('#')
  end
end
