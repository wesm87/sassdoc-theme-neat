
<li class="list-title">
  <a class="list-title__link" href="#{{ type }}">
    {{ (type + 's') }}
  </a>
</li>

{% for item in items %}
  <li class="list-item">
    <a class="list-item__link" href="#{{ item.context.name }}">
      {{ item.context.name }}
    </a>
  </li>
{% endfor %}
