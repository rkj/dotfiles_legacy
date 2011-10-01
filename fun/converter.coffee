systems = [2, 8, 10, 16, 3]
test = from = to = null
points = tries = 0
rand = (max) ->
  Math.floor(Math.random() * max)
rand_system = ->
  systems[rand(systems.length)]

gen_number = ->
  max = parseInt($("#max_number").val(), 10)
  rand(max)

make_test = ->
  test = null
  times = 0
  test = gen_number() until test > 15 || (times++) > 10
  $("#number").text(test.toString(from))
  $("#number").fadeOut("normal").fadeIn("normal")
  tries = 0

choose_systems = ->
  to = from = rand_system()
  to = rand_system() until from != to
  $("#from").text(from)
  $("#to").text(to)
  make_test()

$("#change_system").click(choose_systems)
choose_systems()

msg = (text, klass) ->
  $("#msg").html("<div class='#{klass}'>#{text}</div>")
  $("#msg").fadeOut("normal").fadeIn("normal")

split_num = (num, base) ->
  str = num.toString(base).split("").reverse()
  terms = ("#{str[i]}*#{base}<sup>#{i}</sup>" for i in [0...(str.length)])
  "#{num.toString(base)}<sub>#{base}</sub> (#{terms.reverse().join("+")})"

solution = ->
  "#{split_num(test, from)}=#{test}<sub>10</sub><br />#{test}<sub>10</sub>= #{split_num(test, to)}"
  
good = ->
  msg("Brawo: <br />#{solution()}.", 'good')

bad = ->
  msg("Niestety źle. Próbuj dalej.", 'bad')

again = ->
  msg("Niestety źle.<br />#{solution()}.<br /> Spróbuj innej zagadki.", 'bad')

check = ->
  tries++
  result = parseInt($("#result").val(), to)
  if test == result
    good()
    $("#points").text("Masz już: #{++points} dobrych odpowiedzi!")
    make_test()
  else
    if tries < 5
      bad()
    else
      again()
      make_test()

$("#test").click(check)
$("#result").keypress (e) ->
  check() if e.which == 13

