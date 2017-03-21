
expand = (text)->
  text
    .replace /&/g, '&amp;'
    .replace /</g, '&lt;'
    .replace />/g, '&gt;'
    .replace /\*(.+?)\*/g, '<i>$1</i>'

root = it = []

all = (members) ->
  stack = it
  result = it = []
  members()
  it = stack
  result

array = (count, members) ->
  it.push ['array', count, all members]

object = (count, members) ->
  it.push ['object', count, all members]

field = (name, members) ->
  it.push ['field', name, all members]

string = (count) ->
  it.push ['string', count]

nil = (count) ->
  it.push ['nil', count]


example = () ->
  array 1, ->
    object 50, ->
      field 'project', ->
        string 22
      field 'manager', ->
        string 22
      field 'programs', ->
        array 22, ->
          object 141, ->
            field 'name', ->
              string 141
            field 'description', ->
              string  130
              nil 11
            field 'commiters', ->
              array 141, ->
                string 390

itemz = (node) ->
  switch node[0]
    when 'array' then "<li> ARRAY×#{node[1]} #{listz node[2]}"
    when 'object' then "<li> OBJECT×#{node[1]} #{listz node[2]}"
    when 'field' then "<li> #{node[1]}: #{listz node[2]}"
    else "<li> #{node[0].toUpperCase()}×#{node[1]}"

listz = (members) ->
  "<ul>#{(itemz i for i in members).join "\n"}</ul>\n"

emit = ($item, item) ->
  example()
  $item.append listz root
  # debugger
  # list = listz root
  # tree = JSON.stringify(root[0], null, 2)
  # $item.append """
  #   #{list}
  #   <pre style="background-color:#eee;padding:15px;">#{tree}</pre>
  # """

bind = ($item, item) ->
  $item.dblclick -> wiki.textEditor $item, item

window.plugins.tally = {emit, bind} if window?
module.exports = {expand} if module?

