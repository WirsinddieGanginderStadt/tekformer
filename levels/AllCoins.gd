"""
	AllCoins.GD
	@auth ds
	@desc summary of all coins in one Level to count them if collected
"""

extends Node

var coins_collected := 0
var child_count := 0

func _ready():
	child_count = get_child_count() 
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	for i in get_child_count() : #goes throw every child Note equal to all level Coins
		if get_child(i)._is_coin_collected : #counts coins that are collected
			coins_collected = coins_collected +1
		get_child(i)._is_coin_collected = false # stoping coins from getting collected multipel times

#WIP
func reseting_all_Coins():
	for i in child_count: #goes throw every child Note equal to all level Coins
		#get_child(i).reseting_Coin()
		pass