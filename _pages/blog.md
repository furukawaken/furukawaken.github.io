---
layout: archive
title: "Blog"
permalink: /blog/
author_profile: true
entries_layout: list
show_excerpts: true
---
{% include base_path %}
{% assign posts = site.posts %}
{% for post in posts %}
  {% include archive-single.html type="post" %}
{% endfor %}