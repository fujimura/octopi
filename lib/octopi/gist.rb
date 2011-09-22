module Octopi
  class Gist < Base
    autoload :Comment, "octopi/gist/comment"
    autoload :GistFile, "octopi/gist/gist_file"
    autoload :History, "octopi/gist/history"

    def user
      User.new(@attributes["user"])
    end

    def history
      @history ||= @attributes["history"].map do |history|
        Octopi::Gist::History.new(history)
      end
    end

    def files
      @files ||= @attributes["files"].map do |name, attributes| 
        Octopi::Gist::GistFile.new(attributes.merge(:name => name))
      end
    end

    def comments
      @comments ||= @attributes["comments"].map do |comment|
        Octopi::Gist::Comment.new(comment)
      end
    end

    def self.for_user(user)
      collection("/users/#{user}/gists")
    end
  end
end