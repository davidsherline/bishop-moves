require 'bishop_moves'

describe BishopMoves do
  subject(:bishop_moves) do
    BishopMoves.new(starting_position: starting_position,
                    ending_position: ending_position)
               .number_of_moves
  end

  context 'when starting position is 1' do
    let(:starting_position) { 1 }

    context 'when ending position is 1' do
      let(:ending_position) { 1 }

      it 'should return 0' do
        expect(bishop_moves).to be_zero
      end
    end

    context 'when ending position is 2' do
      let(:ending_position) { 2 }

      it 'should return nil' do
        expect(bishop_moves).to be_nil
      end
    end

    context 'when ending position is 3' do
      let(:ending_position) { 3 }

      it 'should return 2' do
        expect(bishop_moves).to eq(2)
      end
    end

    context 'when ending position is 10' do
      let(:ending_position) { 10 }

      it 'should return 1' do
        expect(bishop_moves).to eq(1)
      end
    end
  end

  context 'when starting position is 15' do
    let(:starting_position) { 15 }

    context 'when ending position is 15' do
      let(:ending_position) { 15 }

      it 'should return nil' do
        expect(bishop_moves).to be_zero
      end
    end

    context 'when ending position is 16' do
      let(:ending_position) { 16 }

      it 'should return nil' do
        expect(bishop_moves).to be_nil
      end
    end

    context 'when ending position is 29' do
      let(:ending_position) { 29 }

      it 'should return 1' do
        expect(bishop_moves).to eq(1)
      end
    end

    context 'when ending position is 31' do
      let(:ending_position) { 31 }

      it 'should return 2' do
        expect(bishop_moves).to eq(2)
      end
    end
  end

  context 'when starting_position is 65 (out of bounds)' do
    let(:starting_position) { 65 }
    let(:ending_position) { 35 }

    it 'should raise OutOfBounds' do
      expect { bishop_moves }.to raise_error(Position::OutOfBounds)
    end
  end
end
