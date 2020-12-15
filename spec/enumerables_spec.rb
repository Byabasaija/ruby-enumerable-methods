require_relative '../methods/enumerables.rb'

describe Enumerable do
    
    arr = [0,1,2,3,4,5,6,7,8,9]
    str = ['chelsea', 'liverpool', 'Arsenal']
    range = (1..5)
    empty_arr = []
     describe "#my_each" do
        it "iterates over a collection" do
            expect(arr.my_each {|index|}).to eq(arr.each {|index|})
        end
        it "tests a block with my_each" do
            compare_arr = []
            arr.each {|index| empty_arr[(index + 1)]}
            arr.my_each {|index| compare_arr[(index + 1)]}
            expect(compare_arr).to eq(empty_arr)
          end
          it "tests my_each on a range" do
            expect(range.my_each {|index|}).to eq(range.each {|index|})
          end
     end

     describe '#my_each_with_index' do
        it "iterates over a collection elements with index" do
          expect(arr.my_each_with_index {|value, index|}).to eq(arr.each_with_index {|value, index|})
        end
    
        it "tests my_each_with_index on block" do
          expect(arr.my_each_with_index {|value, index| puts "#{value} : #{index}"}).to eq(arr.each_with_index {|value, index| puts "#{value} : #{index}"})
        end
    
        it "tets my_each_with_index on range" do
          expect(range.my_each_with_index {|value, index| puts "#{value} : #{index}"}).to eq(range.each_with_index {|value, index| puts "#{value} : #{index}"})
        end
      end

      describe '#my_select' do
        it 'tests my_select for a given collection' do
          expect(arr.my_select(&:even?)).to eq(arr.select(&:even?))
        end
    
        it 'tests my_select on a block' do
          expect(arr.my_select { |item|puts item == 9 }).to eq(arr.select { |item| puts item == 9 })
        end
      end

      describe '#my_all?' do
        it 'tests my_all? on a block' do
          expect(arr.my_all?(&:even?)).to eq(arr.all?(&:even?))
        end
    
        it 'tests my_all? on a range' do
          expect(range.my_all?(6)).to eq(range.all?(6))
        end
    
        it 'tests my_all? on a class' do
          expect(str.my_all?(String)).to eq(str.all?(String))
        end
      end

      describe '#my_any?' do
        it 'tests my_any? on a block' do
          expect(arr.my_any?(&:even?)).to eq(arr.any?(&:even?))
        end
        
        it 'tests my_any? on a range' do
          expect(range.my_any?(1)).to eq(range.any?(1))
        end
    
        it 'tests my_any? on a class' do
          expect(str.my_any?(String)).to eq(str.any?(String))
        end
      end

      describe '#my_none?' do
        it 'tests my_none? on a block' do
          expect(arr.my_none?(&:odd?)).to eq(arr.none?(&:odd?))
        end
    
        it 'tests my_none? on a range' do
          expect(range.my_none?(7)).to eq(range.none?(7))
        end
    
        it 'tests my_none? on a class' do
          expect(str.my_none?(String)).to eq(str.none?(String))
        end
      end

      describe '#my_count' do
        it 'tests my_count iteration with arguments' do
          expect(arr.my_count(&:odd?)).to eq(arr.count(&:odd?))
        end
    
        it 'tests my_count range' do
          expect(range.my_count(2)).to eq(range.count(2))
        end
    
        it 'tests my_count block iteration' do
          expect(str.my_count{ |string| string.length == 7}).to eq(str.count{ |string| string.length == 7 })
        end
      end

      describe '#my_map' do
        it 'tests working with my_map on operations' do
          expect(arr.my_map{ |num| puts num**2 }).to eq(arr.map{ |num|puts num**2 })
        end
    
        it 'tests my_map on a block with arguments' do
          expect(arr.my_map(&:even?)).to eq(arr.map(&:even?))
        end
      end

      describe '#my_inject' do
        it 'tests my_inject operation on a range' do
            expect(range.my_inject(:+)).to eq(range.inject(:+))
        end
    
        it 'tests symbol operation on array using my_inject' do
          expect(arr.my_inject(:+)).to eq(arr.inject(:+))
        end
        
        it 'tests my_inject to return longest word' do
         
            expect(str.my_inject do |memo, word|
                memo.length > word.length ? memo : word end).to eq(str.inject do |memo, word| memo.length > word.length ? memo : word end)
                
            end
        end
end