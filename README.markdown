# Open Graph Helper


Common [Open Graph](http://developers.facebook.com/docs/opengraph/) meta tag and [Facebook Social Plugin](http://developers.facebook.com/docs/plugins/) tag helpers.

There are only small subsets of tags are supported (for now).

Pull requests are welcome.

The Facebook Social Plugins can be rendered in HTML5 version (default) or `<iframe>` version.  Their default options are tuned for Techbang.  Override them by passing a Hash; see below.

## Usage

Add this to your `Gemfile`:

    gem 'open_graph_helper'

If you want to use the edge version on Github, specify the `:git` option.

    gem 'open_graph_helper', :github => 'techbang/open_graph_helper'

And run

    bundle install

to install this plug-in.

For Social Plugins, OpenGraphHelper provides 2 versions for that: the new `:html5` and legacy `:iframe`.

`:html5` version is the default option and requires JavaScript SDK.  See [Facebook JavaScript SDK](http://developers.facebook.com/docs/reference/javascript/) for more details.  If you're using [Facebooker2](https://github.com/mmangino/facebooker2), please include the SDK by `<%= fb_connect_async_js %>`.

To switch to `:iframe` version, you need an initializer.  Name it, say, `open_graph_helper.rb`, with one line of content:

```ruby
OpenGraphHelper::SOCIAL_PLUGIN_VERSION = :iframe # HTML5 + JS SDK doesn't need this
```

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

og_fb_admins(%w(123456 789012)) # Accepts an Array for multiple admins
#=> <meta property="fb:admins" content="123456"/>
#   <meta property="fb:admins" content="789012"/>

og_fb_app_id("1234567890")
#=> <meta property="fb:app_id" content="1234567890"/>
```

### Note on Multiple-Value (e.g. `fb:admins`)

According to Open Graph Protocol, multiple-value should be represented as an [Array](http://ogp.me/#array), not separated by a single comma `,` (U+002C).

This pitfall was found when assigning admins for [Facebook Comments Plug-In](https://developers.facebook.com/docs/reference/plugins/comments/). Although the document says:

> To add multiple moderators, separate the uids by comma without spaces.

It does actually not working, and a parser error will be warned by [Open Graph Debugger](https://developers.facebook.com/tools/debug/). A working example should like this:

```html
<meta property="fb:admins" content="123456">
<meta property="fb:admins" content="789012">
```

Therefore, OpenGraphHelper's `og_fb_admins` accepts an array, in which situation it maps each element to a single `fb:admins` meta tag, and concatenates them in a single line.

See this QA: http://stackoverflow.com/a/12007788

## Facebook Social Plugins

There are some default options that was optimized for [Techbang](http://www.techbang.com.tw) sites and may not suits for  your needs.  Override them by passing a Hash as the last argument.

### Like Button

Usage: `fb_like(like_url, options={})`

The default options are:

    :layout => "button_count",
    :action => "like",
    :share => false,
    :show_faces => false,
    :width => 90

For more options, see [Facebook Like Button Documentation](https://developers.facebook.com/docs/plugins/like-button)

Example:

``` ruby
fb_like("http://example.com")
#=> <div class="fb-like" data-href="http://example.com" data-layout="button_count" data-action="like" data-share="false" data-show-faces="false" data-width="90"></div>

fb_like("http://example.com", :width => 120, :layout => "standard")
#=> <div class="fb-like" data-href="http://example.com" data-layout="standard" data-action="like" data-share="false" data-show-faces="false" data-width="120"></div>
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

fb_recommendations("www.example.com", :header => true, :colorscheme => "dark")
#=> <div class="fb-recommendations" data-border-color="#CCC" data-colorscheme="dark" data-header="true" data-height="380" data-site="www.example.com" data-width="300"></div>
```

# License

This software is released under the MIT License

Copyright (c) 2011- Techbang

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
