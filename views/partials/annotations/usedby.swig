{% set title_displayed = false %}

{% for usedBy in item.usedBy %}

  {% if (view.display.access.indexOf(usedBy.access[0]) != -1) and not (not view.display.alias and usedBy.alias[0]) %}

    {% if not title_displayed %}
      {% set title_displayed = true %}
      <h3 class="sub-heading">Used by</h3>
      <ul class="list-unstyled list-inline">
    {% endif %}

    <li><a href="#{{ usedBy.context.type }}-{{ usedBy.context.name }}"><code>{{ usedBy.context.name }}</code></a></li>
  {% endif %}

{% endfor %}

{% if title_displayed %}
</ul>
{% endif %}
