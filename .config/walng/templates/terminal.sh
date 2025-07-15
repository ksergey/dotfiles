#!/bin/bash

echo "name {{ name }}"
echo "author {{ author }}"
echo "variant {{ variant }}"
echo "system {{ system }}"

{% for name, color in palette -%}
echo -e " - \033[38;2;{{ color | r }};{{ color | g }};{{ color | b }}m {{ name }} #{{ color | hex }}\033[0;00m"
{%- endfor %}
