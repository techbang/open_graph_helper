# encoding: utf-8
require "open_graph_helper/version"
require 'open_graph_helper/railtie' if defined?(Rails)

# http://developers.facebook.com/docs/opengraph/
module OpenGraphHelper
  SOCIAL_PLUGIN_VERSION = :html5

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

  def og_fb_admins(admins)
    # Multiple fb:admins should be specified in separated meta tags
    # See Issue #3
    if admins.is_a? Array
      admins.map { |admin|
        tag(:meta, { :property => "fb:admins", :content => admin }, true)
      }.join.html_safe
    else
      tag(:meta, { :property => "fb:admins", :content => admins }, true)
    end
  end

  def social_plugin(plugin_name, options)
    case SOCIAL_PLUGIN_VERSION
    when :html5
      content_tag(:div, "", class: "fb-#{plugin_name.to_s}", data: options)
    when :iframe
      width = options.delete(:width)
      height = options.delete(:height)
      style = "border:none; overflow:hidden; width:#{width}px; height:#{height}px;"
      src = "https://www.facebook.com/plugins/#{plugin_name}.php?#{options.to_param}"
      content_tag(:iframe, "", :src => src, :scrolling => "no", :frameborder => "0", :style => style, :allowtransparency => "true")
    else
      raise "Unknown Social Plugin Version: #{SOCIAL_PLUGIN_VERSION}"
    end
  end

  # types: button_count, standard, box_count
  def fb_like(like_url, custom_options={})
    options = {
      href: like_url,
      layout: "button_count",
      action: "like",
      share: false,
      show_faces: false,
      width: 90
    }

    options.merge! custom_options

    social_plugin("like", options)
  end

  def fb_page(fans_page_url, custom_options={})
    options = {
      href: fans_page_url,
      small_header: true,
      adapt_container_width: true,
      hide_cover: false,
      show_facepile: false
    }

    options.merge! custom_options

    social_plugin("page", options)
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

    social_plugin("like-box", options)
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

    social_plugin("recommendations", options)
  end

  def fb_comments(url, custom_options={})
    options = {
      :href => url,
      :num_posts => 10
    }

    options.merge! custom_options

    social_plugin("comments", options)
  end

end

