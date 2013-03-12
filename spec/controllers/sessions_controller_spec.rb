require 'spec_helper'

describe SessionsController do
  describe "create" do
    before do
      @password = "opensesame!"
      @user = create(:user)
    end

    context "login ok" do
      it "redirect root_path" do
        post :create, { login_name: @user.login_name, password: @password }

        response.should redirect_to(:root)
      end
    end

    context "login ng" do
      it "render new 1" do
        post :create, { login_name: "hoge", password: @password }

        response.should render_template(:new)
      end

      it "render new 2" do
        post :create, { login_name: @user.login_name, password: "hoge" }

        response.should render_template(:new)
      end
    end
  end
end
