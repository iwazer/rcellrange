RSpec.describe Rcellrange do
  it "has a version number" do
    expect(Rcellrange::VERSION).not_to be nil
  end

  let(:nrow) { 1 }
  let(:ncol) { 1 }
  let(:has_sheet) { false }

  describe "#coord2cell" do
    subject { Rcellrange.new.coord2cell(nrow, ncol, has_sheet: has_sheet) }
    it { is_expected.to eq "A1" }

    context "row is Range" do
      let(:nrow) { 1..2 }
      it { is_expected.to eq "A1:A2" }

    end

    context "col is Range" do
      let(:ncol) { 1..2 }
      it { is_expected.to eq "A1:B1" }
    end

    context "row is 5,000,000" do
      let(:nrow) { 5_000_000 }
      it { is_expected.to eq "A5000000" }
    end

    context "column is ZZZ" do
      let(:ncol) { 18278 }
      it { is_expected.to eq "ZZZ1" }
    end
  end

  describe "#decode_column" do
    subject { Rcellrange.new.send(:decode_column, col) }
    context "with A" do
      let(:col) { "A" }
      it { is_expected.to eq 1 }
    end
    context "with Z" do
      let(:col) { "Z" }
      it { is_expected.to eq 26 }
    end
    context "with AA" do
      let(:col) { "AA" }
      it { is_expected.to eq 27 }
    end
    context "with AZ" do
      let(:col) { "AZ" }
      it { is_expected.to eq 52 }
    end
    context "with XFD" do
      let(:col) { "XFD" }
      it { is_expected.to eq 16384 }
    end
    context "with ZZZ" do
      let(:col) { "ZZZ" }
      it { is_expected.to eq 18278 }
    end
  end

  let(:range) { "A1" }

  describe "#cell2coord" do
    subject { Rcellrange.new.cell2coord(range) }
    it { is_expected.to eq [1..1, 1..1] }

    context "row is Range" do
      let(:range) { "A1:A2" }
      it { is_expected.to eq [1..2, 1..1] }
    end

    context "col is range" do
      let(:range) { "B2:D2" }
      it { is_expected.to eq [2..2, 2..4] }
    end

    context "row is range and col is range with XFD" do
      let(:range) { "XFC1:XFD2" }
      it { is_expected.to eq [1..2, 16383..16384] }
    end

    context "row is range and col is range with ZZZ" do
      let(:range) { "ZZX5:ZZZ10" }
      it { is_expected.to eq [5..10, 18276..18278] }
    end
  end
end
