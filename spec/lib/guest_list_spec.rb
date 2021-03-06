require 'spec_helper'

describe Bouncer::GuestList do

  before { @user = User.new('Chalmers Hundlebottom') }

  describe "#bouncer_access_list" do
    subject { @user.bouncer_access_list }
    it { should be_a Hash }

    it "should contain :post" do
      @user.bouncer_access_list[:post].should_not be_nil
    end
    it "should contain :show" do
      @user.bouncer_access_list[:post][:show].should_not be_nil
    end
    it "should contain a proc for" do
      @user.bouncer_access_list[:post][:show].should be_a Proc
    end
  end

  describe "can?" do
    before do
      @post = Post.new("Chalmers Hundlebottom")
    end

    it "should have access to :show for post" do
      @user.can?(:show, @post).should be_true
    end

    it "should not have access to :create for post" do
      @user.can?(:create, @post).should be_false
    end
    it "should have have access to :update for post" do
      @user.can?(:update, @post).should be_true
    end
  end

end
