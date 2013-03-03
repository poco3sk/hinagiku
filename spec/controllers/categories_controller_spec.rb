require 'spec_helper'

describe CategoriesController do
  before do
    5.times { create(:category) }
  end

  describe "GET 'index'" do
    it "returns http success" do
      get :index

      response.should be_success
      assigns(:categories).size.should == 5
    end
  end
end
