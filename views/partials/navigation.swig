
<nav class="side-nav">
  <ul class="social">
    <li class="social-item">
      <a class="social-link github" href="{{ view.links.github }}">
        GitHub / Install
      </a>
    </li>
  </ul>

  <a class="logo-container" href="{{ view.library.homepage }}">
    <img class="logo" alt="{{ view.library.name }} Logo" src="{{ view.logoPath }}">
  </a>

  <ul class="list">
    {% for group_name, group in data.byGroupAndType %}
      <ul class="list-group">
        <li class="list-group-title">
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
