require "./src/a"

describe A do
  context "default test" do
    let(:a) { A.new }
    it { expect(a.x).to be 0 }
    it { expect(a.y).to be 0 }
  end

  context "#add" do
    let(:a) { A.new(1,2) }
    it { expect(a.add).to be 3 }
  end
end