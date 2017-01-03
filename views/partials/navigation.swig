
<nav class="side-nav">
  <a class="logo-container" href="{{ view.library.homepage }}">
    <img class="logo" alt="{{ view.library.name }} Logo" src="{{ view.logoPath }}">
  </a>

  <ul class="list">
    {% for group_name, group in data.byGroupAndType %}
      <ul class="list-group js-list-group">
        <li class="list-group-title js-list-group-toggle">
          {{group_name}}
        </li>
        {% for type, items in group %}
          {% if type == "mixin" %}
            {% include "type_list.swig" %}
          {% endif %}
        {% endfor %}
          {% for type, items in group %}
            {% if type == "function" %}
              {% include "type_list.swig" %}
            {% endif %}
          {% endfor %}
          {% for type, items in group %}
            {% if type == "variable" %}
              {% include "type_list.swig" %}
            {% endif %}
          {% endfor %}
      </ul>
    {% endfor %}
  </ul>
</nav>
