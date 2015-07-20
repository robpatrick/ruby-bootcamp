shared_examples 'a mover' do
  describe 'movement methods' do

    context 'starting point' do
      it '@position is at start point' do
        expect(subject.send(:position)[:longitude]).to eq(0)
        expect(subject.send(:position)[:latitude]).to eq(0)
      end
    end

    context 'successful invocation' do
      it '#move_left' do
        subject.move_left()
        expect(subject.send(:position)[:longitude]).to eq(0)
        expect(subject.send(:position)[:latitude]).to eq(1)
      end

      it '#move_right' do
        subject.move_right()
        expect(subject.send(:position)[:longitude]).to eq(0)
        expect(subject.send(:position)[:latitude]).to eq(-1)
      end

      it '#move_forwards' do
        subject.move_forwards()
        expect(subject.send(:position)[:longitude]).to eq(1)
        expect(subject.send(:position)[:latitude]).to eq(0)
      end

      it '#move_backwards' do
        subject.move_backwards()
        expect(subject.send(:position)[:longitude]).to eq(-1)
        expect(subject.send(:position)[:latitude]).to eq(0)
      end
    end

    context 'invalid invocation' do
      it '#move with invalid direction' do
        expect { subject.move('Your money maker') }.to raise_error(InvalidDirectionException)
      end
    end

  end
end