+++
title = "About Me"
hide_title = true
page_class = "about-page"
url = "/about"
+++

<p class="portrait">
	<a href="/img/tjm.jpg">
		<img src="/img/tjm_128x128.jpg" alt="Chubby man on boat looking bemused.">
	</a>
</p>

# Hi, I'm Tom.

In real life, I live in England. This <i class="fa fa-hand-o-right"></i> is me 
gliding up the Mekong river on a boat made of old furniture.

I hope you find this site helpful. Here are my various contact details if 
you'd like to get in touch.

<dl class="contact dl-horizontal">
	<dt><i class="fa fa-envelope"></i></dt>
	<dd>t at this domain</dd>
	<dt><i class="fa fa-twitter"></i></dt>
	<dd>[@earthrimwalker](https://twitter.com/earthrimwalker)</dd>
	<dt><i class="fa fa-github"></i></dt>
	<dd>[github.com/dreamtea](https://github.com/dreamtea)</dd>
	<dt><i class="fa fa-skype"></i></dt>
	<dd>westernsun</dd>
</dt>

## Hire Me

I'm a consultant in web and native software developement. You can hire me to
build your website, write your app or work on your server back end. Here are
a few of the things I can do.

- Responsive front end web development
- Android apps, Java and NDK
- Back end web development
- Native Win32 expert
- C, C++, Go, Python, Javascript, Lua, PHP, ...

Drop me an email or use the form below to talk about how I can help with your 
project. It never hurts to ask!

<form id="contact-form" class="form-horizontal" action="//formspree.io/thomasjamesmoran@gmail.com" method="POST">
	<input type="hidden" name="_subject" value="tjm.io Contact Form">
	<input type="hidden" name="_next" value="http://tjm.io/about/confirm">
	<input type="text" name="_gotcha" style="display: none">

	<div class="form-group">
		<label class="col-sm-2" for="name-input">Name</label>
		<div class="col-sm-10">
			<input id="name-input" class="form-control" type="text" required name="name" placeholder="Your name or company">
		</div>
    </div>
    <div class="form-group">
    	<label class="col-sm-2" for="email-input">Email</label>
    	<div class="col-sm-10">
    		<input id="email-input" class="form-control" type="email" required name="_replyto" placeholder="your@email">
    	</div>
    </div>
    <div class="form-group">
    	<label class="col-sm-2" for="question-input">Query</label>
    	<div class="col-sm-10">
	    	<select id="question-input" class="form-control" name="query">
				<option>Can you...</option>
				<option>How much do you charge?</option>
	    		<option>How does all this work?</option>
				<option>General question</option>
			</select>
		</div>
    </div>	
    <div class="form-group">
    	<label class="col-sm-2" for="message-input">Message</label>
    	<div class="col-sm-10">
    		<textarea id="message-input" class="form-control small" name="message" placeholder="How can I help?" rows=4></textarea>
    	</div> 
    </div>
    <div class="form-group">
    	<div class="col-sm-10 col-sm-offset-2">
    		<button 
    			type="submit" id="send-button" class="btn btn-default" 
    			data-sending-text="<i class=&quot;fa fa-circle-o-notch fa-spin&quot;></i> Sending..."
    			data-sent-text="<i class=&quot;fa fa-thumbs-o-up&quot;></i> Sent"
    		><i class="fa fa-paper-plane-o"></i> Send</button>
    	</div>
    </div>
    <div id="success-alert" class="alert alert-success col-sm-12" role="alert" style="display: none">
		<strong><i class="fa fa-thumbs-o-up"></i> Thanks for your question.</strong> I'll respond as soon as I can.
	</div>
</form>
