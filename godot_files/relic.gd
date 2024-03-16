extends Node3D

signal collected
var label : RichTextLabel
var paper : TextureRect
var showingRelic : bool = false

var texts = [
	"[fill][i][font=\"Century Gothic\"][color=#000000]Обитатели на този свят, обърнете внимание на думите ми, защото говоря като атлантиец, свидетел на сенките, които помрачават нашата някога сияйна цивилизация. В стремежа си към величие ние, атлантите, сме забравили същността на това, което наистина ни поддържа – деликатния баланс между амбиция и смирение, прогрес и благоговение към природата. Заслепени сме от собствените си постижения, опиянени от примамката на властта и завоеванията...[/color][/font][/i][/fill]",
	"[fill][i][font=\"Century Gothic\"][color=#000000]Докато стоим на пропастта на несигурността, нека спрем и помислим върху уроците от нашето минало. Нашата някога горда цивилизация сега е изправена пред гнева на боговете, нашата арогантност ни води до ръба на унищожението. Ние сме се отклонили от пътя на мъдростта, поддавайки се на изкушенията на алчността и високомерието. Но не е твърде късно за изкупление, защото все още можем да се поучим от грешките си и да изковаме нов път напред...[/color][/font][/i][/fill]",
	"[fill][i][font=\"Century Gothic\"][color=#000000]Умолявам ви, събратя, да стъпвате внимателно и със смирение в стремежите си. Не повтаряйте грешките на Атлантида, защото последствията са ужасни. Прегърнете добродетелите на състраданието, сътрудничеството и стопанисването на земята. Нека се стремим да изградим свят, в който преобладават хармонията и балансът, в който уроците от миналото ни водят към по-светло бъдеще. Нека заедно гарантираме, че наследството на Атлантида не е разруха, а просветление и надежда за бъдещите поколения![/color][/font][/i][/fill]"
]

func show_paper(idx):
	showingRelic = true
	paper.visible = true
	label.visible = true
	label.text = texts[idx]
	
func hide_paper():
	showingRelic = false
	paper.visible = false
	label.visible = false
	label.text = ""
	

# Called when the node enters the scene tree for the first time
func _ready():
	connect("body_entered", self._on_area_3d_body_entered)
	label = get_parent().get_parent().get_node("TextureRect/RichTextLabel")
	paper = get_parent().get_parent().get_node("TextureRect")
	
	label.visible = false
	paper.visible = false

# Called when the sphere's collision shape enters another collision shape
func _on_area_3d_body_entered(body):
	if body.name == "Player_character":
		emit_signal("collected")
		
		var relicNum = int(name.right(1))
		show_paper(relicNum - 1)

func _process(delta):
	if Input.is_action_just_pressed("hide paper") && showingRelic == true:
		hide_paper()
		queue_free()
