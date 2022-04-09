category_1 = Category.find_by_name("Smartphones")

p_01 = Product.new(name: "iPhone XS", description: "Super retina screen", stock: 10, price: 900, sku: "AIX0120")
p_01.category = category_1
p_01.save

p_02 = Product.new(name: "Xiaomi Mi Mix 3", description: "Borderless, powerful, super camera", stock: 12, price: 400, sku: "XMM0312")
p_02.category = category_1
p_02.save

p_03 = Product.new(name: "Xiaomi Pocophone", description: "The best phone for millenials", stock: 15, price: 300, sku: "XPP0313")
p_03.category = category_1
p_03.save

p_04 = Product.new(name: "Samsung S10", description: "Beautiful, elegant, powerful phone", stock: 10, price: 900, sku: "S100901")
p_04.category = category_1
p_04.save

category_2 = Category.find_by_name("Shoes")

p_05 = Product.new(name: "Zico Beach Sandal", description: "The best sandal ever", stock: 50, price: 5, sku: "ZSD009")
p_05.category = category_2
p_05.save

p_06 = Product.new(name: "Adidas Superstart", description: "The old school sneakers", stock: 13, price: 60, sku: "ASS090")
p_06.category = category_2
p_06.save

p_07 = Product.new(name: "Timberland Premium", description: "The classic yellow boots", stock: 15, price: 100, sku: "TPB132")
p_07.category = category_2
p_07.save

category_3 = Category.find_by_name("Accesories")

p_08 = Product.new(name: "Men Wallet", description: "Waterproof leather wallet", stock: 50, price: 20, sku: "MW2323")
p_08.category = category_3
p_08.save

p_09 = Product.new(name: "Keychain", description: "Keep your keys together. Safe.", stock: 60, price: 2, sku: "KC3245")
p_09.category = category_3
p_09.save

p_10 = Product.new(name: "Casio L12 Watch", description: "Never be late again, arrive on time", stock: 8, price: 50, sku: "CW7788")
p_10.category = category_3
p_10.save

