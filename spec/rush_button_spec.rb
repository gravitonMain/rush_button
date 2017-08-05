require "spec_helper"

include RushButton
RSpec.describe RushButton do
  it "has a version number" do
    expect(VERSION).not_to be nil
  end
  
  describe DashButton do
    let(:db) {DashButton.new(mac_addr)}
    let(:mac_addr) {"FF:FF:FF:FF:FF:FF"}
    
    describe "::new" do
      it "returns mac" do
        expect(db.mac).to eq mac_addr
      end
    end
    
    describe "#on_press" do
      it "returns itself" do
        expect(db.on_press{"test"}).to eq db
      end
    end
    
    describe "#press" do
      it "returns executed block" do
        db.on_press{"test"}
        expect(db.press).to eq "test"
      end
    end
  end
  
  describe DashCapture do
    let(:dc) {DashCapture.new("en0")}
    xcontext "when root" do
      describe "#capture" do
        it "returns MAC address of Dash Button" do
          expect(dc.capture).to match /..:..:..:..:..:../
        end
      end
    end
    context "when not root" do
      describe "::new" do
        xit "returns nil if given nil" do
          expect(DashCapture.new(nil)).to eq nil
        end
        it "raises RuntimeError" do
          expect{dc}.to raise_error RuntimeError
        end
      end
      describe "#capture" do
        it "raises RuntimeError" do
          expect{dc.capture}.to raise_error RuntimeError
        end
      end
    end
  end
end
