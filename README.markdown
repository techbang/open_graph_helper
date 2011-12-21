# Open Graph Helper


Common [Open Graph](http://developers.facebook.com/docs/opengraph/) meta tag and [Facebook Social Plugin](http://developers.facebook.com/docs/plugins/) tag helpers.

There are only small subsets of tags are supported (for now). 

Pull requests are welcome.

The Facebook Social Plugins are rendered in HTML5 version (a `<div>`).  Their default options are tuned for Techbang.  Override them by passing a Hash; see below.

## Usage

Add this to your `Gemfile`:

    gem 'open_graph_helper'

If you want to use the edge version on Github, specify the `:git` option.

    gem 'open_graph_helper', :git => 'git://github.com/techbang/open_graph_helper.git'

And run

    bundle install

to install this plug-in.

You need to include JavaScript SDK in your page to make  Social Plugin works.  See [Facebook JavaScript SDK](http://developers.facebook.com/docs/reference/javascript/) for more details.  

If you're want to use [Facebooker2](https://github.com/mmangino/facebooker2), please include the SDK by `<%= fb_connect_async_js %>`.

The last thing: don't forget to add XML namespaces to the `<html>` tag, or `<meta>` tags won't work.

``` html
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:og="http://ogp.me/ns#"
      xmlns:fb="http://www.facebook.com/2008/fbml">
```

## Open Graph meta tags


Examples: (Sample output from [Facebook Open Graph Documentation](http://developers.facebook.com/docs/opengraph/))

``` ruby
og_title("The Rock")
#=> <meta property="og:title" content="The Rock"/>

og_type("movie") # default is "article"
#=> <meta property="og:type" content="movie"/>

og_url("http://www.imdb.com/title/tt0117500/")
#=> <meta property="og:url" content="http://www.imdb.com/title/tt0117500/"/>

og_image("http://ia.media-imdb.com/rock.jpg")
#=> <meta property="og:image" content="http://ia.media-imdb.com/rock.jpg"/>

og_site_name("IMDb")
#=> <meta property="og:site_name" content="IMDb"/>

og_description("Lorem Ipsum ...")
#=> <meta property="og:description" cotent="Lorem Ipsum ..."/>

og_fb_admins("123456,789012") # don't send an array
#=> <meta property="fb:admins" content="123456,789012"/>

og_fb_app_id("1234567890")
#=> <meta property="fb:app_id" content="1234567890"/>
```

## Facebook Social Plugins

There are some default options that was optimized for [Techbang](http://www.techbang.com.tw) sites and may not suits for  your needs.  Override them by passing a Hash as the last argument.

### Like Button

Usage: `fb_like(like_url, options={})`

The default options are:

    :send => false,
    :layout => "button_count",
    :show_faces => false,
    :width => 90

For more options, see [Facebook Like Button Documentation](http://developers.facebook.com/docs/reference/plugins/like/)

Example:

``` ruby
fb_like("http://example.com")
#=> <div class="fb-like" data-href="http://example.com" data-layout="button_count" data-send="false" data-show-faces="false" data-width="90"></div>

fb_like("http://example.com", :width => 120, :layout => "standard")
#=> <div class="fb-like" data-href="http://example.com" data-layout="standard" data-send="false" data-show-faces="false" data-width="120"></div>
```

### Like Box

Usage: `fb_like_box(page_url, options={})`

The default options are:

    :width => 240,
    :height => 65,
    :show_faces => false,
    :stream => false,
    :header => true

For more options, see [Facebook Like Box Documentation](http://developers.facebook.com/docs/reference/plugins/like-box/)

Example:

``` ruby
fb_like_box("http://www.facebook.com/example")
#=> <div class="fb-like-box" data-header="true" data-height="65" data-href="http://www.facebook.com/example" data-show-faces="false" data-stream="false" data-width="240"></div>

fb_like_box("http://www.facebook.com/example", :width => 180, :show_faces => true)
#=> <div class="fb-like-box" data-header="true" data-height="65" data-href="http://www.facebook.com/example" data-show-faces="true" data-stream="false" data-width="180"></div>
```

### Recommendations

Usage: `fb_recommendations(site_url, options={})`

The default options are:

    :width => 300,
    :height => 380,
    :header => false,
    :colorscheme => "light",
    :border_color => "#CCC"

For more options, see [Facebook Recommendations Documentation](http://developers.facebook.com/docs/reference/plugins/recommendations/)

Example:

``` ruby
fb_recommendations("www.example.com")
#=> <div class="fb-recommendations" data-border-color="#CCC" data-colorscheme="light" data-header="false" data-height="380" data-site="www.example.com" data-width="300"></div>

fb_recommendations("http://www.facebook.com/example", :header => true, :colorscheme => "dark")
#=> <div class="fb-recommendations" data-border-color="#CCC" data-colorscheme="dark" data-header="true" data-height="380" data-site="www.example.com" data-width="300"></div>
```

