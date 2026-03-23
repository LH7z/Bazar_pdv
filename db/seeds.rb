# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Product.destroy_all
ProductVariant.destroy_all
Product.create!(
  name: "Calça",
  price: 45,
  active: true,
  product_variants_attributes: [
    { size: "M", color: "Cinza" },
    { size: "G", color: "Preto" }
  ]
)

Product.create!(
  name: "Blusa",
  price: 55,
  active: true,
  product_variants_attributes: [
    { size: "P", color: "Vermelho", stock: 10 },
    { size: "M", color: "Azul", stock: 10 },
    { size: "G", color: "Preto", stock: 10 }
  ]
)

Product.create!(
  name: "Sapato",
  price: 35,
  active: true,
  product_variants_attributes: [
    { size: "36", color: "Cinza", stock: 10 },
    { size: "37", color: "Preto", stock: 10 }
  ]
)

Product.create!(
  name: "Shorts",
  price: 60,
  active: true,
  product_variants_attributes: [
    { size: "35", color: "Cinza", stock: 10 },
    { size: "37", color: "Preto", stock: 10 }
  ]
)

Product.create!(
  name: "Casaco",
  price: 55,
  active: true,
  product_variants_attributes: [
    { size: "M", color: "Cinza", stock: 10 },
    { size: "G", color: "Preto", stock: 10 }
  ]
)

Product.create!(
  name: "Tênis",
  price: 35,
  active: true,
  product_variants_attributes: [
    { size: "36", color: "Cinza", stock: 10 },
    { size: "37", color: "Preto", stock: 10 }
  ]
)

Product.create!(
  name: "Meia",
  price: 5,
  active: true,
  product_variants_attributes: [
    { size: "P", color: "Cinza", stock: 10 },
    { size: "M", color: "Preto", stock: 10 }
  ]
)
