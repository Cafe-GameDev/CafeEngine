extends Resource
class_name CardData

enum CardType { MINION, SPELL, WEAPON, HERO, CUSTOM }

@export var card_name: String = ""
@export var description: String = ""
@export var artwork_path: String = ""
@export var mana_cost: int = 0
@export var attack: int = 0 # For Minion/Weapon
@export var health: int = 0 # For Minion/Hero
@export var card_type: CardType = CardType.CUSTOM
@export var keywords: Array[String] # e.g., "Taunt", "Battlecry", "Deathrattle"
@export var effects: Array[Resource] # Array of EffectData or custom card effects