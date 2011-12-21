# encoding: utf-8
require "open_graph_helper/version"
require 'open_graph_helper/railtie' if defined?(Rails)

# http://developers.facebook.com/docs/opengraph/
module OpenGraphHelper
  def og_title(content)
    tag(:meta, { :property => "og:title", :content => content }, true)
  end

  def og_description(content)
    content = html_escape(strip_tags(content))
    tag(:meta, { :property => "og:description", :content => truncate(content , :length => 100) }, true)
  end

  def og_type(content = "article")
    tag(:meta, { :property => "og:type", :content => content }, true)
  end

  # 50x50 px ~ 150x150 px
  def og_image(content)
    tag(:meta, { :property => "og:image", :content => content }, true)
  end

  def og_url(content)
    tag(:meta, { :property => "og:url", :content => content }, true)
  end

  def og_site_name(content)
    tag(:meta, { :property => "og:site_name", :content => content }, true)
  end

  def og_fb_app_id(content)
    tag(:meta, { :property => "fb:app_id", :content => content }, true)
  end

  def og_fb_admins(content)
    tag(:meta, { :property => "fb:admins", :content => content }, true)
  end

  # types: button_count, standard, box_count
  def fb_like(like_url, custom_options={})
    options = {
      :href => like_url,
      :send => false,
      :layout => "button_count",
      :show_faces => false,
      :width => 90
    }

    options.merge! custom_options

    content_tag(:div, "", :class => "fb-like", :data => options)
  end

  def fb_likebox(page_url, custom_options={})
    options = {
      :href => page_url,
      :width => 240,
      :height => 65,
      :show_faces => false,
      :stream => false,
      :header => true
    }

    options.merge! custom_options

    content_tag(:div, "", :class => "fb-like-box", :data => options)
  end

  def fb_recommendations(site_url, custom_options={})
    options = {
      :site => site_url,
      :width => 300,
      :height => 380,
      :header => false,
      :colorscheme => "light",
      :border_color => "#CCC"
      # :linktarget => "_blank"
    }

    options.merge! custom_options

    content_tag(:div, "", :class => "fb-recommendations", :data => options)
  end

end

