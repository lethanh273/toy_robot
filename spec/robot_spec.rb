require "./src/robot"

describe Robot do
  context "default position" do
    let(:robot) { Robot.new }
    it { expect(robot.x).to be 0 }
    it { expect(robot.y).to be 0 }
    it { expect(robot.facing).to be :north }
  end

  context "#place" do
    let(:robot) { Robot.new }

    before do
      robot.place 1, 2, :east
    end

    it { expect(robot.x).to be 1 }
    it { expect(robot.y).to be 2 }
    it { expect(robot.facing).to be :east }
  end

  context "#right" do
    before(:all) { @robot = Robot.new }
    before(:each) { @robot.do 'right' }
    subject { @robot.facing }

    it { is_expected.to be :east }
    it { is_expected.to be :south }
    it { is_expected.to be :west }
    it { is_expected.to be :north }
    it { is_expected.to be :east }
  end

  context "#left" do
    before(:all) { @robot = Robot.new }
    before(:each) { @robot.do 'left' }
    subject { @robot.facing }

    it { is_expected.to be :west }
    it { is_expected.to be :south }
    it { is_expected.to be :east }
    it { is_expected.to be :north }
    it { is_expected.to be :west }
  end

  context "#move" do
    let(:robot) { Robot.new }
    context "one move" do
      before do
        robot.do 'move'
      end

      it { expect(robot.x).to be 0 }
      it { expect(robot.y).to be 1 }
      it { expect(robot.facing).to be :north }
    end

    context "two moves" do
      it "it should move towards router configuration" do
        robot.do 'move'
        robot.do 'move'
        expect(robot.x).to be 0
        expect(robot.y).to be 2
        expect(robot.facing).to be :north
      end
    end
  end

  context "scenarios #1" do
    let(:robot) { Robot.new }
    it "should be at 0,1,NORTH" do
      robot.do 'place', [0, 0, :north]
      robot.do 'move'
      expect(capture_stdout { robot.report }).to eq "0,1,NORTH\n"
    end
  end

  context "scenarios #2" do
    let(:robot) { Robot.new }
    it "should be at 0,0,WEST" do
      robot.place 0, 0, :north
      robot.left
      expect(capture_stdout { robot.report }).to eq "0,0,WEST\n"
    end
  end

  context "scenarios #3" do
    let(:robot) { Robot.new }
    before do
      robot.place 1, 2, :east
      robot.move
      robot.move
      robot.left
      robot.move
    end

    it { expect(capture_stdout { robot.report }).to eq "3,3,NORTH\n" }
  end
end
