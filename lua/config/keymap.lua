-- Навигация
vim.keymap.set("n", "<leader>e", ":Neotree reveal toggle<CR>", { desc = "Open Neotree" })
-- Tabs (bufferline)
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<s-Tab>", ":BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<leader>x", ":BufferLinePickClose<CR>")
vim.keymap.set("n", "<c-x>", ":BufferLineCloseOthers<CR>")

-- Работа с файлом
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Сохранить файл" }) --Сохранение файла
vim.keymap.set("n", "<leader>ц", ":w<CR>", { desc = "Сохранить файл" }) --Сохранение файла
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Закрыть файл" }) --Закрытие файла
vim.keymap.set(
	"i",
	"jj",
	"<Esc>",
	{ desc = "Выйти в нормальный режим из режима вставки" }
) --Выход из режима вставки
vim.keymap.set(
	"i",
	"оо",
	"<Esc>",
	{ desc = "Выйти в нормальный режим из режима вставки" }
) --Выход из режима вставки

-- Разделение экрана
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>") --Переместиться на верхнее окно
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")
vim.keymap.set("n", "|", ":vsplit<CR>", { desc = "Вертикальное разделение окна" })
vim.keymap.set("n", "\\", ":split<CR>", { desc = "Горизонтальное разделение окна" })

-- Локализация моушнов на русский язык
vim.keymap.set("n", "л", "k")
vim.keymap.set("n", "р", "h")
vim.keymap.set("n", "о", "j")
vim.keymap.set("n", "д", "l")
vim.keymap.set("n", "ц", "w")
vim.keymap.set("n", "у", "e")
vim.keymap.set("n", "и", "b")
vim.keymap.set("n", "к", "r")
vim.keymap.set("n", "в", "d")
vim.keymap.set("n", "ч", "x")
vim.keymap.set("n", "ф", "a")
vim.keymap.set("n", "н", "y")
vim.keymap.set("n", "з", "p")

-- Прочее
vim.keymap.set("n", "q", "") -- Отключение клавиши Q. стоит перебиндить куда-нибудь
