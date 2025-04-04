# Сборка NeoVim
Старался собрать максимально минималистичную сборку NeoVim без всяких лишних наворотов.
Помимо `LSP`, `Mason` и `CMP` установлены плагины, перечисленные ниже

Чтобыть начать работу с каким-то инструментом необходимо через `:Mason` установить cоответствующие
`Language Server Protocol` и `Debug Adapter Protocol`, а также линтеры/форматтеры.
После этого **ОБЯЗАТЕЛЬНО** указать в файлах
* `lua/plugins/conform.lua` названия форматтеров и языков.
* `lua/plugins/nvim-lint.lua` - название линтеров и языков
* `lua/plugins/lsp.lua` - название `LSP` и конфигурировать их, если необходимо

## Плагины
* Bufferline - табы, вкладки как в браузере
* GitSigns - отображение, что было добавлено/изменено в рамках текущего индекса (`:Gitsigns`)
* Neo-Tree - менеджер файловой системы (:Neotree)
* LuaLine - строка состояния снизу, пишет про гит, ошибки и прочее
* Telescope - поиск файлов, вхождений строк по проекту, подсказок и табов (`:Telescope`)
* Cmp - подсказки в коде (выпадающие)
* ToggleTerm - терминал.
* Dressing - всплывающее окно для быстрых действий(переименования выборов и прочего)
* Conform - форматтер - **ВАЖНО! В ЕГО КОНФИГЕ НУЖНО ПЕРЕЧИСЛИТЬ ВСЕ ФОРМАТТЕРЫ ДЛЯ КАЖДОГО ЯЗЫКА, КОТОРЫЕ ИСПОЛЬЗУЮТСЯ**
* Nvim-Lint - линтер. **ВАЖНО! В ЕГО КОНФИГЕ НУЖНО ПЕРЕЧИСЛИТЬ ВСЕ ФОРМАТТЕРЫ ДЛЯ КАЖДОГО ЯЗЫКА, КОТОРЫЕ ИСПОЛЬЗУЮТСЯ**
* Leap - продвинутые перемещения
* Which-Key - панелька с хоткеями
* Dashboard - *(пока не поставил)* дашборд при входе в `Vim`.

## Кастомные кеймапы
* пробел + e - файловая система
* пробел + w - сохранить
* пробел + q - закрыть
* | - разделить окно по-вертикали
* \ - разделить окно по-горизонтали
* ctrl + `h(jkl)` - переместиться на левое(нижнее, верхнее, правое) разделенное окно
* Tab/Shift + Tab - перемещение по буфферам
* ктрл + x - закрыть все буфферы, кроме текущего
* пробел + х - выбрать, какие буферы закрыть
* пробел + ff - найти файлы в проекте
* пробел + fw - найти слова в проекте
* пробел + fb - найти вкладки(буфферы) в проекте
* пробел + fh - найти подсказки в проекте
* пробел + lr - переименовать
* пробел + la - быстрые код экшны
* ctrl + \ - открытие/закрытие терминалах
* пробел + aa - все ошибки и варнинги в проекте
* пробел + aA - ошибки и варнинги в текущем буфере
* shift + K - показать сигнатуру
* ctrl + K - подсказка по текущему вводимому парметру метода
