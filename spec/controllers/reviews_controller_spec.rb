require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do

  feature 'Github repos' do
    scenario 'contact github' do
      github = Github.new
      p '======================'
      response = github.repos.contents.get 'Harker16', 'Testrepo', 'test.rb', 108, accept: 'application/vnd.github.raw'
      p '======================='
      p response
      p '========================'
      # response = Github.repos.list user: 'Harker16'
      # response.each do |repo|
      #   repo.name
      # end


    end
  end

end
