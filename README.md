# Planet Adventure! - Tutorial 6: Fitur Tambahan

## 📖 Pendahuluan
Tutorial ini merupakan lanjutan dari **Tutorial 5**, karena tutorial 5 saya sebelumnya juga merupakan kelanjutan dari **Tutorial 4**.  
Pada **Tutorial 6**, saya menambahkan berbagai fitur baru, khususnya pada **GUI Scene**, **nyawa & koin**, **scene navigasi**, dan **transisi antar level**.

---

## 🎮 Fitur yang Ditambahkan
### 1️⃣ Sistem Lives dan Coins
- **Player memiliki 3 nyawa di awal permainan.**
- **Nyawa berkurang** jika player **jatuh ke jurang** atau **mengenai musuh**.
- Jika **nyawa mencapai 0**, pemain akan diarahkan ke **LoseScreen**.
- **Sistem koin:** 
  - **Mulai dari 0.**
  - Jika player **mengambil koin**, jumlah koin bertambah.
  - **Jika nyawa berkurang, koin akan direset ke 0.**
  - Pada **WinScreen**, jumlah koin yang berhasil dikumpulkan akan ditampilkan.
  - **Tantangan:** Score koin sempurna hanya bisa didapat jika pemain menyelesaikan game tanpa kehilangan nyawa!

### 2️⃣ GUI Scene dan Menu Navigasi
- **Main Menu Scene**:
  - **Judul permainan: "Planet Adventure!"**
  - **Tombol New Game** → Memulai game dari Level 1.
  - **Tombol Select Stage** → Memungkinkan pemain memilih Level 1 atau Level 2.

- **Lose Screen Scene**:
  - **Tombol New Game** → Memulai ulang dari Level 1.
  - **Tombol Back to Main Menu** → Kembali ke menu utama.

- **Win Screen Scene**:
  - **Menampilkan jumlah Coins Collected.**
  - **Tombol New Game** → Memulai game dari awal (Level 1).
  - **Tombol Back to Main Menu** → Kembali ke menu utama.

### 3️⃣ Transisi Antar Level
- **Saat berpindah dari Level 1 ke Level 2, transisi dilakukan menggunakan efek fade.**
- **Efek fade dibuat dengan `fade_to_black` dan `fade_to_normal` menggunakan AnimationPlayer.**

---

## 🛠️ Proses Implementasi
### 1️⃣ Implementasi Lives & Coins (Global State)
Untuk menyimpan jumlah nyawa dan koin, saya menggunakan **`global.gd`** yang dimasukkan ke **Autoload**.

```gdscript
extends Node

var lives = 3
var coins = 0

func add_coin():
    coins += 1  # Tambah koin setiap kali diambil

func decrease_lives():
    if lives > 0:
        lives -= 1  # Kurangi nyawa
        coins = 0   # Reset koin saat nyawa berkurang

func reset_game():
    lives = 3  # Reset nyawa ke 3
    coins = 0  # Reset koin ke 0
```

### 2️⃣ Implementasi GUI Lives & Coins
Lives dan koin ditampilkan di layar menggunakan **Label dalam GUI Scene**.

### 3️⃣ Implementasi Navigasi Menu
Pada **Main Menu**, **Lose Screen**, dan **Win Screen**, tombol-tombol mengarahkan pemain ke scene yang sesuai. Saya menggunakan Label dan LinkButton, dibungkus dengan main container supaya rapih.

### 3️⃣ Implementasi Transisi Antar Level
Transisi antar level dibuat menggunakan **CanvasLayer + AnimationPlayer**.

**Struktur Scene `Transition.tscn`:**
```gdscript
extends CanvasLayer

signal on_transition_finished

@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer

func _ready():
    color_rect.visible = false
    animation_player.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(anim_name):
    if anim_name == "fade_to_black":
        on_transition_finished.emit()
        animation_player.play("fade_to_normal")
    elif anim_name == "fade_to_normal":
        color_rect.visible = false

func fade_to_scene(new_scene: String):
    color_rect.visible = true
    animation_player.play("fade_to_black")
    await on_transition_finished
    get_tree().change_scene_to_file(new_scene)
```
