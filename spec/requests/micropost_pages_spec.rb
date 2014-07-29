require 'spec_helper'

describe "MicropostPages" do

	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	let(:other_user) { FactoryGirl.create(:user) }
	before { valid_signin user }

	describe "micropost creation" do
		before { visit root_path }

		describe "with invalid information" do

			it "should not create a micropost" do
				expect { click_button "Post" }.not_to change(Micropost, :count)
			end

			describe "error messages" do
				before { click_button "Post" }
				it { should have_content('error') }
			end
		end

		describe "with valid information" do

			before { fill_in 'micropost_content', with: "Lorem ipsum" }
			it "should create a micropost" do
				expect { click_button "Post" }.to change(Micropost, :count).by(1)
			end
		end
	end

	describe "micropost destruction" do
		before { FactoryGirl.create(:micropost, user: user) }

		describe "as correct user" do
			before { visit root_path }

			it "should delete a micropost" do
				expect { click_link "delete" }.to change(Micropost, :count).by(-1)
			end

			it "should not show delete links for posts by other users" do
				visit user_path(other_user) 
				expect(page).should_not have_link("delete") 
			end
		end

	end

	describe "pagination" do
		before(:all) do 
			60.times { FactoryGirl.create(:micropost, user: user, content: "foo bar") } 
			visit root_path
		end
		after(:all) { User.delete_all }

		it { should have_selector('div.pagination') }

		it "should  paginate over multiple pages" do
			user.feed.paginate(page:1).each do |post|
				expect(page).to have_selector('li', post.content )
			end
		end

	end
end
