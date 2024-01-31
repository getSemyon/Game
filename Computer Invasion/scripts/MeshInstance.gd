extends MeshInstance3D

func _ready():
	# Загружаем меш из ресурса
	var mesh_instance = self

	# Получаем массив вершин
	var vertices = mesh_instance.mesh.surface_get_arrays(0).vertex

	# Получаем массив индексов (треугольников)
	var indices = mesh_instance.mesh.surface_get_arrays(0).index

	# Создаем массив для хранения рёбер
	var edges = []

	# Итерируем по индексам (треугольникам)
	for i in range(0, indices.size(), 3):
		var vertex1 = vertices[indices[i]]
		var vertex2 = vertices[indices[i + 1]]
		var vertex3 = vertices[indices[i + 2]]

		# Добавляем рёбра треугольника в массив
		edges.append([vertex1, vertex2])
		edges.append([vertex2, vertex3])
		edges.append([vertex3, vertex1])

	# Теперь массив edges содержит координаты всех рёбер

	# Пример вывода координат рёбер в консоль
	for edge in edges:
		print("Edge:", edge)
