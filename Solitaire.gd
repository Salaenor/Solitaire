extends Node2D


var deck = []
var boardStatus = {1:[], 2: [], 3: [], 4:[], 5:[], 6:[], 7:[], "deck":[]}
var speed = 0.4
var cardHold = []
var suit = ""
var number = ""
var ypos = 15
# Called when the node enters the scene tree for the first time.
func _ready():
	prepare_deck()
	prepare_board(deck)
	flip_up(boardStatus)
	print(boardStatus)
func _process(delta):
	pass;
	
func prepare_deck():
	for i in 13:
		deck.append("hearts-"+str(i+1))
		deck.append("clubs-"+str(i+1))
		deck.append("diamonds-"+str(i+1))
		deck.append("spades-"+str(i+1))
	randomize()
	deck.shuffle()
	

func prepare_board(cards):
	var x: int = 0
	while x < 52:
		match x:
			0:
				card_stack(x, 1, cards, 64, 1, 0)
				x = x + 1
			1:
				card_stack(x, 2, cards, 178, 2, ypos)
				x = x+1
			3:
				card_stack(x, 5, cards, 292, 3, ypos)
				x = x+1
			6:
				card_stack(x, 10, cards, 406, 4, ypos)
				x = x+1
			11:
				card_stack(x, 16, cards, 520, 5, ypos)
				x = x+1
			17:
				card_stack(x, 23, cards, 634, 6, ypos)
				x = x+1
			24:
				card_stack(x, 31, cards, 748, 7, ypos)
				x = x+1
			32:
				var ypos = 90
				while x <= 51:
					var card = preload("res://Card.tscn").instance()
					add_child(card)
					regex_who(cards[x])
					card.id.append(suit)
					card.id.append(int(number))
					boardStatus["deck"].append([card, cards[x]])
					suit = ""
					number = ""
					#card.get_node("Sprite").texture = load("res://Playing Cards/card-"+deck[x]+".png")
					var tween := create_tween();
					tween.tween_property(card, "position", Vector2(888, ypos), speed)
					x = x + 1
			_:
				x = x+1

func card_stack(num, numcomp, cards, xpos, stack, yposmove):
	var ypos = 252
	
	while num <= numcomp:
				
				var card = preload("res://Card.tscn").instance()
				add_child(card)
				regex_who(cards[num])
				card.id.append(suit)
				card.id.append(int(number))
				suit = ""
				number = ""
				boardStatus[stack].append([card, cards[num]])
				#card.get_node("Sprite").texture = load("res://Playing Cards/card-"+deck[num]+".png")
				var tween := create_tween();
				tween.tween_property(card, "position", Vector2(xpos, ypos), speed)
				num = num + 1
				ypos = ypos + yposmove
				
func regex_who(string):
	var dash = false
	for i in string.length():
		if string[i] == "-":
			dash = true
		elif dash == true:
			number += string[i]
		elif dash == false:
			suit += string[i]
				
func flip_up(boardStatus):
	for i in boardStatus.keys():
		if typeof(i) == TYPE_STRING:
			break;
		else:
			boardStatus[i][boardStatus[i].size()-1][0].get_node("Sprite").texture = load("res://Playing Cards/card-"+boardStatus[i][boardStatus[i].size()-1][1]+".png")
		#print(str(boardStatus[i][0]))


