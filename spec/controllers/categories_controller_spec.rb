require 'spec_helper'

describe CategoriesController do
  before do
    5.times { create(:category) }
  end

  describe "index" do
    it "get" do
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

  describe "create" do
    before do
      @params = {
        "category" => {
          "name" => "Category Sample"
        }
      }
    end

    context "create normally" do
      it "create category" do
        post :create, @params

        assigns(:category).should == Category.last
        Category.count.should == 6
        response.should redirect_to(categories_path)
      end
    end

    context "create abnormally" do
      it "return form" do
        @params["category"]["name"] = ""
        post :create, @params

        Category.count.should == 5
        response.should render_template(:new)
      end
    end
  end

  describe "destroy" do
    before do
      @category = create(:category)
    end

    it "destroy category" do
      Category.count.should == 6
      delete :destroy, id: @category.id

      Category.count.should == 5
      response.should redirect_to(categories_path)
    end
  end
end
