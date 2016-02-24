module BookmarksHelper

  def render_buttons(bookmark)

    unless (controller.controller_name == "topics" && controller.action_name == "index")
      render partial: 'bookmarks/bookmark_options', locals: {bookmark: bookmark}
    end

  end
end
