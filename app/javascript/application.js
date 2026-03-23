// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "chartkick/chart.js"


document.addEventListener("DOMContentLoaded", () => {
  const container = document.getElementById("variants")
  const addButton = document.getElementById("add-variant")
  console.log(addButton);


  addButton?.addEventListener("click", () => {
    const index = new Date().getTime()

    const template = `
      <div class="variant border p-4 rounded mb-4">
        <input type="hidden" name="product[product_variants_attributes][${index}][_destroy]" value="0" class="destroy-flag">
        <div class="grid grid-cols-4 gap-4">

          <div>
            <label>Tamanho</label>
            <input type="text" name="product[product_variants_attributes][${index}][size]" class="w-full border p-2 rounded">
          </div>

          <div>
            <label>Cor</label>
            <input type="text" name="product[product_variants_attributes][${index}][color]" class="w-full border p-2 rounded">
          </div>

          <div>
            <label>Estoque</label>
            <input type="number" name="product[product_variants_attributes][${index}][stock]" class="w-full border p-2 rounded">
          </div>

          <div class="flex items-end">
            <button type="button" class="remove-variant bg-red-500 text-white px-3 py-2 rounded">
              Remover
            </button>
          </div>

        </div>
      </div>
    `
    container.insertAdjacentHTML("beforeend", template)
  })

  document.addEventListener("click", (e) => {
    if (e.target.classList.contains("remove-variant")) {
      const variant = e.target.closest(".variant")
      const destroyFlag = variant.querySelector(".destroy-flag")
      if (destroyFlag) {
        destroyFlag.value = "1"
      }
      variant.style.display = "none"
    }
  })
})
