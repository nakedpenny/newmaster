{# This template extends the base.tpl template, meaning that base.tpl provides a large framework
   that this template then adds to. See base.tpl for more information. #}
{% extends "base.tpl" %}
{# This is the start of the `content` block. It's part of the <body> of the page. This is where all the visible
   parts of the website after the links bar and before the "Powered by comic_git" footer go. #}
{% block content %}
    {# When text is surrounded by {{ these double curly braces }}, it's representing a variable that's passed in by
       the Python script that generates the HTML file. That value is dropped into the existing HTML with no changes.
       For example, if the value passed in to `tag` is `Avery`, then `Posts tagged with "{{ tag }}"` becomes
       `Posts tagged with "Avery"` #}
    <h1 id="page-title">Posts tagged with "{{ tag }}"</h1>

    <div id="blurb">
        <div id="tagged">
            <div class="archive-grid">
			{# For loops let you take a list of a values and do something for each of those values. In this case,
			   it runs through list of all the pages in a particular storyline (Chapter 1, Chapter 2, etc) and creates
			   a tiny thumbnail image with a title and post date, all of which link to that comic page if clicked. #}
			{%- for page in tagged_pages %}
				<a href="{{comic_base_dir}}/comic/{{ page.page_name }}/">
				<div class="archive-thumbnail">
					<div class="archive-thumbnail-page"><img class="thumbtrick" src="/{{ page.thumbnail_path }}"></div>
					<div class="archive-thumbnail-title">{{ page.page_title }}</div>
					<div class="archive-thumbnail-post-date">{{ page.archive_post_date }}</div>
				</div>
				</a>
			{%- endfor %}
			</div>
        </div>
    </div>
{% endblock %}
