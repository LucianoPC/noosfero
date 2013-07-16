require_dependency 'comment_group_plugin/ext/article'
require_dependency 'comment_group_plugin/ext/comment'

class CommentGroupPlugin < Noosfero::Plugin

  def self.plugin_name
    "Comment Group"
  end

  def self.plugin_description
    _("A plugin that display comment groups.")
  end

  def load_comments(article)
    article.comments.without_spam.without_group.as_thread
  end

  def comment_form_extra_contents(args)
    comment = args[:comment]
    group_id = comment.group_id || args[:group_id]
    lambda {
      hidden_field_tag('comment[group_id]', group_id) if group_id
    }
  end

  def js_files
    'comment_group_macro.js'
  end

end

require_dependency 'comment_group_plugin/macros/allow_comment'
