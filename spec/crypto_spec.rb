# frozen_string_literal: true

require_relative '../credit_card'
require_relative '../substitution_cipher'
require_relative '../double_trans_cipher'
require 'minitest/autorun'

describe 'Test card info encryption' do
  before do
    @cc = CreditCard.new('4916603231464963', 'Mar-30-2020',
                         'Soumya Ray', 'Visa')
    @key = 3
    @ciphers = {
      'Caesar' => SubstitutionCipher::Caesar,
      'Permutation' => SubstitutionCipher::Permutation,
      'DoubleTransposition' => DoubleTranspositionCipher
    }
  end

  %w[Caesar Permutation DoubleTransposition].each do |type|
    describe "Using #{type} Cipher" do
      it 'should encrypt card information' do
        enc = @ciphers[type].encrypt(@cc, @key)
        _(enc).wont_equal @cc.to_s
        _(enc).wont_be_nil
      end
      it 'should decrypt text' do
        enc = @ciphers[type].encrypt(@cc, @key)
        dec = @ciphers[type].decrypt(enc, @key)
        _(dec).must_equal @cc.to_s
      end
    end
  end
end
