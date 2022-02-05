{# This template extends the base.tpl template, meaning that base.tpl provides a large framework
   that this template then adds to. See base.tpl for more information. #}
{% extends "base.tpl" %}
{# `block head` means that the next two lines go where the `head` block is defined in base.tpl #}
{%- block head %}
    {# `super()` means that everything that's currently in the `head` block in base.tpl is added first, and then the
       next line is added to the end. #}
    {{- super() }}
    <link rel="next" href="{{comic_base_dir}}/comic/{{ next_id }}/">
{%- endblock %}
{# This is the start of the `content` block. It's part of the <body> of the page. This is where all the visible
   parts of the website after the links bar and before the "Powered by comic_git" footer go. #}
{%- block content %}
	{% if comic_paths|length == 1 %}
		{# When text is surrounded by {{ these double curly braces }}, it's representing a variable that's passed in by
		   the Python script that generates the HTML file. That value is dropped into the existing HTML with no changes.
		   For example, if the value passed in to `base_dir` is `comic_git`, then `/comic` becomes
		   `/comic_git/comic` #}
		<div id="comic-page">
			<div class="comic-page-item">
					<img id="comic-image" onclick="zoomImage('{{ next_id }}')" src="/{{ comic_paths[0] }}" title="{{ alt_text }}"/>
			</div>
		</div>
		<div id="blankPageWide" class="blankPageWide">
			<img id="comic-image" src="/your_content/images/MothorialWideBlank.png" title="{{ alt_text }}"/>
		</div>
		<script>test();</script>
	{% else %}
		{# When text is surrounded by {{ these double curly braces }}, it's representing a variable that's passed in by
		   the Python script that generates the HTML file. That value is dropped into the existing HTML with no changes.
		   For example, if the value passed in to `base_dir` is `comic_git`, then `/comic` becomes
		   `/comic_git/comic` #}
		<div id="warning" class="wideWarning">Looks like you might be on a mobile device! This page is an ultrawide spread and will look better in landscape mode. 
			<div id="thankYou" onclick="hideBox()">Okay</div>
		</div>
		<div id="comic-page">
			<div class="comic-page-item imageLeft">
					<img id="comic-image" src="/{{ comic_paths[0] }}" title="{{ alt_text }}"/>
			</div>
			<div class="comic-page-item imageRight">
					<img id="comic-image" src="/{{ comic_paths[1] }}" title="{{ alt_text }}"/>
			</div>
		</div>
		<div class="blankPage">
			<img id="comic-image" src="/{{ comic_paths[0] }}" title="{{ alt_text }}"/>
		</div>
	{% endif %}	
    {# If blocks let you check the value of a variable and then generate different HTML depending on that variable.
       The if block below will generate non-functioning links for `First` and `Previous` if the current page is the
       first page in the comic, and functioning links otherwise. #}
    <div id="navigation-bar">
    {% if first_id == current_id %}
        <a class="navigation-button-disabled first">‹‹ First</a>
        <a class="navigation-button-disabled previous">‹ Previous</a>
    {% else %}
        <a class="navigation-button first" href="{{comic_base_dir}}/comic/{{ first_id }}/#comic-page">‹‹ First</a>
        <a class="navigation-button previous" href="{{comic_base_dir}}/comic/{{ previous_id }}/#comic-page">‹ Previous</a>
    {% endif %}
    {# The block below is the same as the one above, except it checks if you're on the last page. #}
    {% if last_id == current_id %}
        <a class="navigation-button-disabled next">Next ›</a>
        <a class="navigation-button-disabled last">Last ››</a>
    {% else %}
        <a class="navigation-button next" href="{{comic_base_dir}}/comic/{{ next_id }}/#comic-page">Next ›</a>
        <a class="navigation-button last" href="{{comic_base_dir}}/latest/#comic-page">Last ››</a>
    {% endif %}
    </div>
	<div class = "support">
		<div class = "supportButtons">
			<div class="patreon-button buttons" id="patreon-button"><a class="patreon" href="https://www.patreon.com/bePatron?u=355259" target="_blank">Become a Patron</a></div>
			<div class="patreon-button buttons" id="kofi-button"><a class="kofi" href="https://ko-fi.com/izzybrownie" target="_blank">Buy Us a Coffee!</a></div>
			<div class="patreon-button buttons" id="share-button" onclick="copyToClipboard()"><div class="share">Share the Comic</div></div>
		</div>
	</div>
	<div id="copy-modal" class="">
            <p id="copy-info">Copied URL!</p>
    </div>
    <div id="blurb">
        <h1 id="page-title">{{ page_title }}</h1>
        <h3 id="post-date">Posted on: {{ post_date }}</h3>
        <div id="post-body">
		{{ post_html }}
        </div>
		<hr id="post-body-break">
		{%- if volume %}
            <div id="volume">
                Volume: <a href="/archive/#{{ volume | replace(" ", "-") }}">{{ volume }}</a>
            </div>
        {%- endif %}
        {%- if storyline %}
            <div id="storyline">
                {# `| replace(" ", "-")` takes the value in the variable, in this case `storyline`, and replaces all
                   spaces with hyphens. This is important when building links to other parts of the site. #}
                Storyline: <a href="/archive/#{{ storyline | replace(" ", "-") }}">{{ storyline }}</a>
            </div>
        {%- endif %}
        {%- if characters %}
            <div id="characters">
            Characters:
            {# For loops let you take a list of a values and do something for each of those values. In this case,
               it runs through list of all the characters in this page, as defined by your info.ini file for this page,
               and it generates a link for each of those characters connecting to the `tagged` page for that
               character. #}
            {%- for character in characters %}
                {# The `if not loop.last` block at the end of the next line means that the ", " string will be added
                   after every character link EXCEPT the last one. #}
                <a href="/tagged/{{ character }}/">{{ character }}</a>{% if not loop.last %}, {% endif %}
            {%- endfor %}
            </div>
        {%- endif %}
        {%- if tags %}
            <div id="tags">
            Tags:
            {%- for tag in tags %}
                <a class="tag-link" href="/tagged/{{ tag }}/">{{ tag }}</a>{% if not loop.last %}, {% endif %}
            {%- endfor %}
            </div>
        {%- endif %}
        {% if transcripts %}
        <table id="transcripts-container" border>
            <tr>
                <td id="transcript-panel">
                    <h3>Transcript</h3>
                    <div id="active-transcript">
                    {% for language, transcript in transcripts.items() %}
                        <div class="transcript" id='{{ language }}-transcript'>
                        {{ transcript }}
                        </div>
                    {% endfor %}
                    </div>
                </td>
                <td id="language-list">
                    <label for="language-select">Languages</label>
                    <select id="language-select" size="7">
                        {% for language in transcripts.keys() %}
                        <option>{{ language }}</option>
                        {% endfor %}
                    </select>
                </td>
            </tr>
        </table>
        {% endif %}
    </div>
{%- endblock %}
{%- block script %}
{% if transcripts %}
<script type="module">
    import { init } from "/your_content/themes/default/js/transcript.js";
    init();
</script>
{% endif %}
{%- endblock %}
