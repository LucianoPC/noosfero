class Block < ActiveRecord::Base

  # to be able to generate HTML
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper

  # Block-specific stuff
  include BlockHelper

  acts_as_list :scope => :box
  belongs_to :box

  acts_as_having_settings

  def self.description
    _('A dummy block.')
  end

  # Returns the content to be used for this block.
  #
  # This method can return several types of objects:
  #
  # * <tt>String</tt>: if the string starts with <tt>http://</tt> or <tt>https://</tt>, then it is assumed to be address of an IFRAME. Otherwise it's is used as regular HTML.
  # * <tt>Hash</tt>: the hash is used to build an URL that is used as the address for a IFRAME. 
  # * <tt>Proc</tt>: the Proc is evaluated in the scope of BoxesHelper. The
  # block can then use <tt>render</tt>, <tt>link_to</tt>, etc.
  #
  # See BoxesHelper#extract_block_content for implementation details. 
  def content
    "This is block number %d" % self.id
  end

  # must return a Hash with URL options poiting to the action that edits
  # properties of the block
  def editor
    nil
  end

  # must always return false, except on MainBlock clas.
  def main?
    false
  end

  def owner
    box ? box.owner : nil
  end

  def css_class_name
    self.class.name.underscore.gsub('_', '-')
  end

  # A footer to be appended to the end of the block. Returns an empty string.
  #
  # Override in your subclasses. You can return the same types supported by
  # #content.
  def footer
    ''
  end

end
