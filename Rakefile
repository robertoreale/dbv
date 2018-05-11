# inspired by http://marii.info/notes/travis-deploy-to-github-branch/

include FileUtils
require 'tmpdir'

namespace :deploy do
  desc "push built site to target branch"
  task :branch do
    REPO_SLUG = ENV['TRAVIS_REPO_SLUG']
    TARGET_BRANCH = 'book'
    USER = REPO_SLUG.split("/")[0]
    TOKEN = ENV['ACCESS_TOKEN']
    COMMIT_MSG = "Site updated via #{ENV['TRAVIS_COMMIT']}".freeze
    ORIGIN_SLUG = "https://github.com/#{REPO_SLUG}.git".freeze
    ORIGIN = "https://#{USER}:#{TOKEN}@github.com/#{REPO_SLUG}.git".freeze
    puts "Deploying to #{TARGET_BRANCH} branch from Travis as #{USER}"

    Dir.mktmpdir do |tmp|
      system 'make'
      cp_r 'manuscript', tmp
      Dir.chdir tmp
      system 'git init'
      system "git add . && git commit -m '#{COMMIT_MSG}'"
      puts 'git remote add origin ' + ORIGIN_SLUG
      puts "git push origin master:refs/heads/#{TARGET_BRANCH} --force"
    end
  end
end
