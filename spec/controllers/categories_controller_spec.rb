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

  describe "new" do
    it "get" do
      get :new

      response.should be_success
      assigns(:category).class.should == Category
    end
  end

  describe "edit" do
    before do
      @category = Category.last
    end

    it "get" do
      get :edit, id: @category.id

      response.should be_success
      assigns(:category).should == @category
    end
  end
end
