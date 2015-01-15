+++
weight = 1
date = "2014-12-23T11:02:30Z"
draft = true

locations = ["blog", "articles"]
title = "Here's my First Post"
description = "This is my first blog post, where I test out some of the layout features of the blog."
image = "escher_eye"
enable_comments = true

[article_menu]

	[[article_menu.items]]
	id = "item_1"
	title = "Item 1"
	url = "#item-1"

	[[article_menu.items]]
	id = "item_2"
	title = "Item 2"
	url = "#item-2"

		[[article_menu.items.items]]
		id = "item_2_sub_1"
		title = "Subitem 1"
		url = "#item-2-sub-1"

		[[article_menu.items.items]]
		id = "item_2_sub_2"
		title = "Subitem 2"
		url = "#item-2-sub-2"

	[[article_menu.items]]
	id = "item_3"
	title = "Item 3"
	url = "#item-3"
+++

<p id="item-1">Here's some Go code. It's probably a bit stupid, but I'm only trying to figure
out whether this stupid theme works. So, does it?</p>

{{< highlight go >}}
func main(a, b: string) {
    if (a != b) {
        fmt.Println("hi: %s", a, b);
    }
}
{{< /highlight >}}

How about a nice blockquote?

<blockquote>
Some guy said this and some guy said that, but in the end, who really knows what anyone said? Words are such ephemeral things.
</blockquote>

Food truck dreamcatcher Williamsburg, Neutra semiotics gastropub heirloom scenester taxidermy four dollar toast cardigan Shoreditch viral freegan. Schlitz authentic jean shorts Godard pug put a bird on it. Cliche viral chillwave cold-pressed street art, Williamsburg 3 wolf moon fashion axe wolf blog wayfarers. Tousled flexitarian iPhone, before they sold out tote bag you probably haven't heard of them pork belly gastropub meditation. Tofu Neutra lo-fi, artisan Carles deep v lumbersexual lomo. Asymmetrical vinyl cold-pressed, bitters direct trade Echo Park XOXO health goth hella lo-fi jean shorts pour-over raw denim. Sartorial hella Vice meggings Truffaut Marfa.

<!--more-->

Paleo narwhal kale chips, direct trade typewriter tattooed lumbersexual McSweeney's flannel listicle. +1 ennui four dollar toast, Kickstarter Brooklyn chia literally leggings Tumblr. Viral Austin gastropub, scenester selfies American Apparel street art asymmetrical. Street art Vice scenester church-key, Echo Park butcher organic tote bag hoodie Helvetica locavore gluten-free irony. Irony wolf shabby chic, beard street art seitan Odd Future small batch. Hashtag food truck aesthetic, taxidermy single-origin coffee flannel forage butcher drinking vinegar mlkshk Godard Kickstarter farm-to-table Marfa health goth. Wayfarers gastropub seitan salvia Marfa High Life.

Artisan Intelligentsia paleo authentic. Keffiyeh four loko artisan fingerstache, Blue Bottle locavore tilde forage ugh try-hard gastropub. Pug Marfa photo booth umami. Trust fund craft beer cray leggings, dreamcatcher High Life beard Helvetica chambray meh hella yr Marfa skateboard. Quinoa stumptown American Apparel, Intelligentsia narwhal Portland meh squid trust fund scenester. Vice Helvetica heirloom Shoreditch, Echo Park sriracha +1 butcher yr semiotics tote bag Brooklyn farm-to-table single-origin coffee. Odd Future Tumblr polaroid before they sold out authentic disrupt.

Tote bag letterpress single-origin coffee, leggings cold-pressed hella Austin jean shorts locavore lomo American Apparel. Wayfarers church-key Brooklyn, drinking vinegar Schlitz cardigan four loko. Tofu before they sold out gentrify meditation shabby chic sustainable, aesthetic mustache post-ironic health goth fanny pack cliche flannel bespoke cornhole. Keffiyeh meggings Kickstarter, sriracha street art wayfarers vegan irony. Cliche High Life fingerstache Portland occupy, umami VHS salvia you probably haven't heard of them. Quinoa umami brunch Etsy Wes Anderson crucifix, Blue Bottle pour-over pickled bespoke. Wes Anderson meditation Schlitz, Brooklyn Tumblr Pinterest brunch next level fixie lomo.

<p id="item-2">Let's try out a list.</p>

- <a name="item-2-sub-1" id="item-2-sub-1">x</a> Here's one thing.
- <a name="item-2-sub-2" id="item-2-sub-2">y</a> And another.
- <a name="item-2-sub-3" id="item-2-sub-3">z</a> And a third for good measure.

Food truck dreamcatcher Williamsburg, Neutra semiotics gastropub heirloom scenester taxidermy four dollar toast cardigan Shoreditch viral freegan. Schlitz authentic jean shorts Godard pug put a bird on it. Cliche viral chillwave cold-pressed street art, Williamsburg 3 wolf moon fashion axe wolf blog wayfarers. Tousled flexitarian iPhone, before they sold out tote bag you probably haven't heard of them pork belly gastropub meditation. Tofu Neutra lo-fi, artisan Carles deep v lumbersexual lomo. Asymmetrical vinyl cold-pressed, bitters direct trade Echo Park XOXO health goth hella lo-fi jean shorts pour-over raw denim. Sartorial hella Vice meggings Truffaut Marfa.

Paleo narwhal kale chips, direct trade typewriter tattooed lumbersexual McSweeney's flannel listicle. +1 ennui four dollar toast, Kickstarter Brooklyn chia literally leggings Tumblr. Viral Austin gastropub, scenester selfies American Apparel street art asymmetrical. Street art Vice scenester church-key, Echo Park butcher organic tote bag hoodie Helvetica locavore gluten-free irony. Irony wolf shabby chic, beard street art seitan Odd Future small batch. Hashtag food truck aesthetic, taxidermy single-origin coffee flannel forage butcher drinking vinegar mlkshk Godard Kickstarter farm-to-table Marfa health goth. Wayfarers gastropub seitan salvia Marfa High Life.

Artisan Intelligentsia paleo authentic. Keffiyeh four loko artisan fingerstache, Blue Bottle locavore tilde forage ugh try-hard gastropub. Pug Marfa photo booth umami. Trust fund craft beer cray leggings, dreamcatcher High Life beard Helvetica chambray meh hella yr Marfa skateboard. Quinoa stumptown American Apparel, Intelligentsia narwhal Portland meh squid trust fund scenester. Vice Helvetica heirloom Shoreditch, Echo Park sriracha +1 butcher yr semiotics tote bag Brooklyn farm-to-table single-origin coffee. Odd Future Tumblr polaroid before they sold out authentic disrupt.

Tote bag letterpress single-origin coffee, leggings cold-pressed hella Austin jean shorts locavore lomo American Apparel. Wayfarers church-key Brooklyn, drinking vinegar Schlitz cardigan four loko. Tofu before they sold out gentrify meditation shabby chic sustainable, aesthetic mustache post-ironic health goth fanny pack cliche flannel bespoke cornhole. Keffiyeh meggings Kickstarter, sriracha street art wayfarers vegan irony. Cliche High Life fingerstache Portland occupy, umami VHS salvia you probably haven't heard of them. Quinoa umami brunch Etsy Wes Anderson crucifix, Blue Bottle pour-over pickled bespoke. Wes Anderson meditation Schlitz, Brooklyn Tumblr Pinterest brunch next level fixie lomo.

To switch directories, type <kbd id="item-3">cd</kbd> followed by the name of the directory.<br>
To edit settings, press <kbd><kbd>ctrl</kbd> + <kbd>,</kbd></kbd>

Food truck dreamcatcher Williamsburg, Neutra semiotics gastropub heirloom scenester taxidermy four dollar toast cardigan Shoreditch viral freegan. Schlitz authentic jean shorts Godard pug put a bird on it. Cliche viral chillwave cold-pressed street art, Williamsburg 3 wolf moon fashion axe wolf blog wayfarers. Tousled flexitarian iPhone, before they sold out tote bag you probably haven't heard of them pork belly gastropub meditation. Tofu Neutra lo-fi, artisan Carles deep v lumbersexual lomo. Asymmetrical vinyl cold-pressed, bitters direct trade Echo Park XOXO health goth hella lo-fi jean shorts pour-over raw denim. Sartorial hella Vice meggings Truffaut Marfa.

Paleo narwhal kale chips, direct trade typewriter tattooed lumbersexual McSweeney's flannel listicle. +1 ennui four dollar toast, Kickstarter Brooklyn chia literally leggings Tumblr. Viral Austin gastropub, scenester selfies American Apparel street art asymmetrical. Street art Vice scenester church-key, Echo Park butcher organic tote bag hoodie Helvetica locavore gluten-free irony. Irony wolf shabby chic, beard street art seitan Odd Future small batch. Hashtag food truck aesthetic, taxidermy single-origin coffee flannel forage butcher drinking vinegar mlkshk Godard Kickstarter farm-to-table Marfa health goth. Wayfarers gastropub seitan salvia Marfa High Life.

Artisan Intelligentsia paleo authentic. Keffiyeh four loko artisan fingerstache, Blue Bottle locavore tilde forage ugh try-hard gastropub. Pug Marfa photo booth umami. Trust fund craft beer cray leggings, dreamcatcher High Life beard Helvetica chambray meh hella yr Marfa skateboard. Quinoa stumptown American Apparel, Intelligentsia narwhal Portland meh squid trust fund scenester. Vice Helvetica heirloom Shoreditch, Echo Park sriracha +1 butcher yr semiotics tote bag Brooklyn farm-to-table single-origin coffee. Odd Future Tumblr polaroid before they sold out authentic disrupt.

Tote bag letterpress single-origin coffee, leggings cold-pressed hella Austin jean shorts locavore lomo American Apparel. Wayfarers church-key Brooklyn, drinking vinegar Schlitz cardigan four loko. Tofu before they sold out gentrify meditation shabby chic sustainable, aesthetic mustache post-ironic health goth fanny pack cliche flannel bespoke cornhole. Keffiyeh meggings Kickstarter, sriracha street art wayfarers vegan irony. Cliche High Life fingerstache Portland occupy, umami VHS salvia you probably haven't heard of them. Quinoa umami brunch Etsy Wes Anderson crucifix, Blue Bottle pour-over pickled bespoke. Wes Anderson meditation Schlitz, Brooklyn Tumblr Pinterest brunch next level fixie lomo.
