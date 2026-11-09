# my-mise

Личная конфигурация рабочего окружения macOS: языки и инструменты разработки, Homebrew-программы, шрифты, Zsh, Git и Neovim. Основа — `~/home-files` и `~/vim-files`; состав пакетов дополнен по установленному окружению.

**Статус: конфигурация подготовлена, но не применена.** Текущие dotfiles и симлинки продолжают указывать на прежние каталоги. Установки, обновления, запуск служб и изменение настроек системы не выполнялись.

## Содержание

- [Структура репозитория](#структура-репозитория)
- [Как устроен mise](#как-устроен-mise)
- [Установленные программы и шрифты](#установленные-программы-и-шрифты)
- [Zsh и Git](#zsh-и-git)
- [Конфигурация Neovim](#конфигурация-neovim)
- [Симлинки и будущая установка](#симлинки-и-будущая-установка)
- [Холодная проверка](#холодная-проверка)
- [Как поддерживать конфигурацию](#как-поддерживать-конфигурацию)

## Структура репозитория

```text
my-mise/
├── mise.toml                 # Единая декларация окружения и установки
├── .zprofile                # Login-окружение, Homebrew, ссылки на секреты
├── .zshrc                   # mise, completion, Antidote, aliases
├── .zsh_plugins.txt         # Список плагинов Zsh
├── .gitconfig               # Git, LFS и delta
├── .gitignore               # Секреты, локальные настройки, кэши
├── vim/                     # Все конфиги редактора, включая .vimrc и .ctags
├── verify.py                # Проверка данных без запуска конфигурации
├── mise.schema.json         # Официальная схема mise v2026.11.5
├── source-sha256.json        # Контрольные суммы исходников
├── package-metadata.json     # Метаданные API Homebrew и сторонних tap
├── font-inventory.json       # Найденные Nerd Fonts и соответствующие cask
├── homebrew-inventory.json   # Пакеты, основания выбора, счётчики команд
├── INVENTORY.txt             # Читаемый отчёт об инвентаризации
├── CHECKS.txt                # Результаты статических проверок
├── README.md                 # Актуальная документация
└── README.txt                # Архив первоначального переноса
```

Установленные плагины, бинарники и содержимое секретных файлов в репозиторий не входят. Инвентаризация хранит имена пакетов и агрегированные счётчики использования; исходные команды, аргументы и пути рабочих проектов из истории не сохраняются.

## Как устроен mise

Точка входа — [mise.toml](mise.toml). Формат рассчитан на **mise v2026.11.5 или новее** и Apple Silicon macOS с Homebrew в `/opt/homebrew`.

| Раздел | Что описывает |
| --- | --- |
| `min_version` | Минимальную версию mise, понимающую используемый формат |
| `[settings]` | Отключение автоматической установки и чтение проектных файлов версий |
| `[tools]` | Версии языков, LSP и утилит из Go, RubyGems, npm и PyPI |
| `[env]` | `EDITOR`, `GOPATH`, каталог Zsh-кэша и личные пути в `PATH` |
| `[bootstrap.packages]` | Formulae, приложения и шрифты Homebrew |
| `[bootstrap.brew]` | `adopt = true` для принятия существующих приложений по правилам backend |
| `[bootstrap.macos.defaults.NSGlobalDomain]` | Повтор клавиш и отключение press-and-hold |
| `[dotfiles]` | Девять будущих симлинков на файлы этого репозитория |

`auto_install = false` отключает автоматическую установку недостающих инструментов. Явные команды установки всё равно могут менять систему. Автоматических задач, хуков, запуска служб и команд очистки в TOML нет.

### Языки и инструменты разработки

В `[tools]` находятся 14 деклараций:

- **Ruby 3.4.7**, Solargraph и Ruby-provider для Neovim. Версия Ruby взята из прежнего `~/.rbenv/version`.
- **Node LTS**, `vim-language-server`, `basedpyright`, `prettier` и `prettierd`.
- **Python latest**, `black` и `isort`; для их изолированной установки предусмотрен системный `uv`.
- **Go latest** и `gopls`.
- **Rust stable** с профилем `default`, `rust-src` и `rust-analyzer`; профиль включает `rustfmt`.

Lua, OpenJDK, `lua-language-server` и `stylua` описаны как Homebrew-пакеты. `rbenv`, `fnm` и `pyenv` не добавлены повторно: выбор версий передан mise. Аналогично не дублируются Homebrew-варианты Node, Go, Rust и gopls. Установленный `python@3.10` остаётся на машине; нужную проекту версию следует описать в проектной конфигурации mise.

Включено чтение проектных файлов версий Ruby, Node, Python, Go и Rust. Значения `latest`, `lts` и `stable` — плавающие запросы, а не снимок текущих установок. Lockfile пока отсутствует. Проектные Bundler-зависимости и виртуальные окружения не переносятся автоматически.

### Системные пакеты

`brew:имя` обозначает formula, `brew-cask:имя` — приложение, шрифт или другую cask-утилиту. Пакеты сгруппированы в TOML по типу и источнику; для всех указан `os = "macos"`.

Для сторонних tap используются полные имена, например `brew:control-theory/gonzo/gonzo` и `brew-cask:penso/tap/herdr-gpui`. Отдельных shell-команд `brew tap` нет. Метаданные сторонних определений проверены как текст; возможность выполнить все их Ruby DSL-конструкции средствами mise требует отдельной проверки при будущей установке.

Подробности формата: [Homebrew formulae в mise](https://mise.jdx.dev/bootstrap/packages/brew.html) и [Homebrew casks в mise](https://mise.jdx.dev/bootstrap/packages/brew-cask.html).

## Установленные программы и шрифты

Инвентаризация от **9 ноября 2026 года** обнаружила 235 formulae, из них 79 помечены Homebrew как явно установленные, и 59 записей Caskroom. В конфигурацию добавлены **41 formula и 28 cask**, всего теперь **128 пакетов**. Две добавленные cask-записи относятся к шрифтам.

Состав выбран по receipts Homebrew: явно установленные formulae, самостоятельные CLI из истории и установленные cask. Транзитивные библиотеки не импортировались массово. Прежние декларации из исходных dotfiles сохранены, даже если соответствующего пакета сейчас нет на машине.

### Nerd Fonts

В `~/Library/Fonts`, `/Library/Fonts` и `/System/Library/Fonts` разобраны внутренние имена 660 файлов TTF/OTF/TTC. Найдены **234 Nerd-файла**, все сопоставлены с семью установленными cask:

| Семейство | Cask | Файлов |
| --- | --- | ---: |
| Droid Sans Mono | `font-droid-sans-mono-nerd-font` | 3 |
| Fantasque Sans Mono | `font-fantasque-sans-mono-nerd-font` | 12 |
| Fira Code | `font-fira-code-nerd-font` | 18 |
| Iosevka | `font-iosevka-nerd-font` | 81 |
| JetBrains Mono и вариант NL | `font-jetbrains-mono-nerd-font` | 96 |
| Monoid | `font-monoid-nerd-font` | 12 |
| Ubuntu Mono | `font-ubuntu-mono-nerd-font` | 12 |

Недостающая декларация **Ubuntu Mono Nerd Font** добавлена; остальные шесть уже были в конфигурации. Отдельно сохранён установленный **Anthrosevka Mono** из `nanxstats/tap` — это обычный шрифт, он не включён в число Nerd Fonts.

После будущей установки нужное семейство следует выбрать в настройках терминала. Само наличие шрифта не переключает Ghostty, iTerm или Neovim на него. Файлы и точное сопоставление cask перечислены в [font-inventory.json](font-inventory.json).

### Программы по назначению

| Назначение | Примеры пакетов в конфигурации |
| --- | --- |
| Разработка и Git | Git, delta, Git LFS, GitHub CLI, lazygit, ast-grep, golangci-lint, sem-cli |
| Редакторы и терминалы | Neovim, Vim, Helix, VS Code, Sublime Text/Merge, Ghostty, iTerm2, Herdr, Ghostex, Muxy, Orca |
| Контейнеры и Kubernetes | Docker Desktop, docker-completion, dive, kubectl, kubectx, k9s, stern, QEMU |
| Базы данных | PostgreSQL 15, libpq, Redis, MySQL, ClickHouse, pgAdmin, DBeaver, DB Browser for SQLite, pgBadger, pspg |
| Резервные копии и синхронизация | restic, resticprofile, rclone, s3cmd, Syncthing CLI и Syncthing.app |
| Документы и изображения | Pandoc, Poppler, Tesseract, ImageMagick, ExifTool, vips, BasicTeX, LibreOffice, Calibre, GIMP |
| Сеть и диагностика | OpenConnect, proxychains-ng, ngrok, naabu, Wireshark CLI, gonzo, whosthere |
| Повседневные приложения | Firefox, Chrome, Obsidian, KeePassXC, Telegram, VLC, BetterDisplay, Yandex Disk |
| Инструменты для работы с AI | Codex, ChatGPT, Herdr, Ghostex, Orca |

Некоторые программы присутствовали в исходной конфигурации ещё до инвентаризации. Полный список добавлений и исключений находится в [INVENTORY.txt](INVENTORY.txt).

### Что говорит история использования

Это число распознанных команд, а не измерение времени работы. История может быть неполной; алиасы и исторический `PATH` не восстанавливаются. GUI-программы учитываются как установленные — достоверных счётчиков их запусков получить не удалось.

| Команда | Во всей доступной истории | За последние 90 дней |
| --- | ---: | ---: |
| `git` | 2886 | 404 |
| `docker` | 271 | 28 |
| `rg` | 114 | 6 |
| `stern` | 112 | 11 |
| `nvim` | 106 | 44 |
| `codex` | 102 | 102 |
| `kubectl` | 98 | 2 |
| `k9s` | 51 | 25 |
| `herdr` | 37 | 36 |
| `resticprofile` | 19 | 0 |

### Переименования и исключения

- Старые `docker` и `syncthing` объединены с каноническими `docker-desktop` и `syncthing-app`.
- `alacritty`, `shadowsocksx-ng`, `macdown` и `rar` отключены в Homebrew; их записи оставлены комментариями.
- Для Keep, Logisim Evolution, OpenMTP, Stats и WezTerm nightly обнаружены receipts, но соответствующие приложения отсутствуют. Они не добавлены автоматически.
- Старый `ctags` уже заменён декларацией `universal-ctags`; OpenSSL 1.1 не импортирован, OpenSSL 3 остаётся в конфигурации.
- Neovim и Helix на машине установлены из HEAD. Декларации mise выбирают стабильные Homebrew-релизы; совпадение с текущими сборками не обещается.

## Zsh и Git

[.zprofile](.zprofile) задаёт базовое login-окружение, подключает Homebrew и указывает глобальную конфигурацию mise через `MISE_GLOBAL_CONFIG_FILE="$HOME/my-mise/mise.toml"`. [.zshrc](.zshrc) активирует mise, настраивает completion, Antidote, Yandex Cloud и alias `be="bundle exec"`.

При будущем подключении `MISE_GLOBAL_CONFIG_FILE` выберет этот файл вместо стандартного `~/.config/mise/config.toml`. Если стандартный глобальный конфиг уже используется, его настройки нужно сопоставить перед переключением.

Список Zsh-плагинов находится в [.zsh_plugins.txt](.zsh_plugins.txt): completions, autosuggestions, плагины Oh My Zsh, тема, сокращения и справка. Antidote может загружать плагины при реальном запуске; холодная проверка его не вызывает.

[.gitconfig](.gitconfig) сохраняет пользовательские настройки Git: LFS-фильтры, pager delta, rebase при pull, сортировку веток и тегов, `histogram` diff и стиль конфликтов `zdiff3`.

Токены остаются в прежнем `~/home-files/secrets/`. В профиле записаны только пути к `github_token`, `minimax` и `forgejo_token`. При дальнейшем отделении от `home-files` эти три значения нужно передать другим способом. `.gitignore` исключает `.env`, локальные TOML, каталог `secrets`, кэши, swap-файлы и скачанные плагины; шаблоны `.env.example` разрешены.

## Конфигурация Neovim

Каталог называется `vim`, но эта конфигурация рассчитана на **Neovim**. При запуске обычного Vim `.vimrc` выводит `only nvim supported` и прекращает загрузку.

### Порядок загрузки

```text
~/.config/nvim/init.vim  -> vim/init.vim
                              |
                              v
                         ~/.vimrc -> vim/.vimrc
                                        |
                                        v
                                   vim/00_init.lua
                                        |
                                        v
                       01_bundle.vim ... 13_telescope.lua
```

`init.vim` добавляет `~/.vim` в runtimepath. `.vimrc` разрешает свой симлинк и находит соседний `00_init.lua`. Lua-загрузчик сортирует номерные `.vim` и `.lua` по имени, пропускает себя и последовательно загружает остальные файлы. Файлы с одинаковым номером `08_` также идут по имени.

Список плагинов использует **vim-plug** и каталог `~/.vim/bundle`. Этот каталог и `~/.vim/autoload` не входят в сборку и не заменяются целиком.

### Карта файлов

| Файл в `vim/` | Содержимое |
| --- | --- |
| `init.vim`, `.vimrc` | Вход в Neovim, runtimepath и переход к Lua-загрузчику |
| `00_init.lua` | Поиск каталога, порядок загрузки, счётчик повторного чтения конфига |
| `01_bundle.vim` | Декларации vim-plug: инфраструктура, редактор, LSP, Git, тесты, языки, темы |
| `02_options.vim` | UTF-8/CP1251, отступы в два пробела, поиск, clipboard, мышь, русская раскладка, окна |
| `03_globals.vim` | Leader, Ruby-provider, настройки vim-test, esearch, gutentags, NERDTree и других плагинов |
| `04_colorscheme.lua` | Светлая тема `adwaita` при первом чтении конфига |
| `05_autocommands.vim` | Определение filetype, обновление изменённых файлов, удаление хвостовых пробелов при сохранении, терминал |
| `06_mappings.vim` | Основные клавиши через `u-keymapper`: файлы, окна, поиск, Git, quickfix |
| `07_plugins.lua` | Общая настройка плагинов, fzf-lua, Git signs, Neotest, Conform и интеграция Herdr |
| `08_dashboard.lua` | Стартовый экран Alpha; часть кнопок ещё обращается к Telescope |
| `08_helix_motions.lua` | Закомментированный эксперимент с AniMotion, сейчас не активен |
| `08_lualine.lua` | Строка статуса и winbar: Git, имя файла, диагностика, позиция и выделение |
| `08_neotree.lua` | Дерево файлов, буферы, Git status, символы документа, фильтры и слежение за текущим файлом |
| `08_noice_ui.lua` | Закомментированная настройка Noice, сейчас не активна |
| `08_other.lua` | Переходы между связанными файлами Rails, Go, Rust и Elixir через other.nvim |
| `08_tabs.lua` | Scope для буферов вкладки, tabline Tabby и выход из скобок через tabout |
| `09_completion.lua` | Magazine как `nvim-cmp`, источники LSP/буфера/командной строки, подписи и autopairs |
| `10_lint.lua` | Закомментированная настройка nvim-lint/RuboCop, сейчас не активна |
| `11_treesitter.lua` | Список языков и заготовка запуска Tree-sitter; есть незавершённая настройка |
| `12_lsp.lua` | Языковые серверы, диагностика, переходы, hover, inlay hints, Go и обработчики LSP |
| `13_telescope.lua` | Закомментированная конфигурация Telescope и расширений |
| `.ctags` | Правила тегов для Markdown-заголовков |
| `bclear.vim`, `macvim.vim` | Дополнительные Vim-цветовые схемы для `~/.vim/colors` |

### Основные возможности

- **Поиск и навигация:** fzf-lua, ripgrep, grug-far, AnyJump, esearch; Neo-tree и NERDTree; переходы между связанными файлами через other.nvim.
- **Редактирование:** commentary, EasyAlign, splitjoin, wildfire, mini.ai/surround/cursorword, autopairs, tabout и таблицы Markdown.
- **Git:** Fugitive и Gitsigns, включая blame текущей строки; для внешнего Git используется delta.
- **Тесты и команды:** Neotest с адаптером RSpec, vim-test, vim-dispatch и Overseer. Блок сочетаний запуска vim-test в `06_mappings.vim` закомментирован.
- **Интерфейс:** WhichKey, Alpha, Lualine, Tabby, Fidget, диаграмма диагностики Diagflow и scrollbar.
- **Herdr:** `herdr-nvim` включён с префиксом `<leader>h`.

### LSP и форматирование

| Язык | Сервер | Форматирование |
| --- | --- | --- |
| Ruby | Solargraph | Возможности Solargraph; project gems остаются в Bundler |
| Go | gopls | `go.nvim` использует gopls для gofmt/goimports |
| Lua | lua-language-server | stylua через Conform |
| Vimscript | vim-language-server | Отдельный formatter в Conform не задан |
| Rust | rust-analyzer | rustfmt с LSP fallback |
| Python | basedpyright | isort, затем black |
| JavaScript | Отдельный LSP не настроен | Первый доступный из prettierd/prettier |
| JSON | Отдельный LSP не настроен | jq |

Команда `:Format` вызывает Conform для буфера или выбранного диапазона. Это отдельная команда: автоматическое форматирование всех языков при сохранении не настроено. При сохранении срабатывает удаление хвостовых пробелов из `05_autocommands.vim`.

### Основные клавиши

Leader — **запятая**. Например, `<leader>ff` означает `,ff`.

| Клавиши | Действие |
| --- | --- |
| `;` | Перейти к вводу Ex-команды вместо `:` |
| `,ff` или `,q` | Поиск файлов через fzf-lua |
| `,b` | Поиск открытых буферов |
| `,fa` | Все pickers fzf-lua |
| `,m`, `,M` | Neo-tree для проекта или текущего файла |
| `,,`, `,.` | Буферы и Git status в Neo-tree |
| `,n`, `,N` | NERDTree для проекта или текущего файла |
| `,w` | Подсказки WhichKey |
| `,c` | Комментирование строки или выделения |
| `,gg`, `,gG`, `,gb` | Fugitive во вкладке, в окне, Git blame |
| `,ll`, `,lt` | Связанный файл или тест через other.nvim |
| `,co`, `,cc` | Открыть или закрыть quickfix |
| `,ec` | Выбор цветовой схемы через fzf-lua |
| `,eb` | Открыть `~/.vimrc` |
| `K` | Hover-документация |
| `gd`, `gD`, `gr`, `gA` | Определение, декларация, ссылки и code action у серверов с общим `on_attach` |
| `Tab`, `Shift-Tab`, `Enter` | Навигация и подтверждение completion |
| `Shift-Right`, `Shift-Left` | Следующая или предыдущая вкладка |
| `Q`, `Z` | Закрыть вкладку или удалить буфер |

### Известные незавершённые настройки

Конфиги перенесены с сохранением поведения; инвентаризация пакетов не меняет редактор.

1. В `11_treesitter.lua` остался буквальный `pattern = { '<filetype>' }`, а установка парсеров закомментирована. Список языков сам по себе парсеры не устанавливает.
2. Telescope не объявлен активным плагином, но на него ссылаются кнопки Alpha; остались также старые команды FZF и `require('search')`. Эти действия требуют отдельного исправления или возврата соответствующих плагинов.
3. В настройках Solargraph сохранено `useBunlder`; корректность этой опции требует пересмотра.
4. Подключение completion-capabilities к LSP закомментировано. Объявленный источник LSP completion не означает, что все расширенные возможности согласованы с сервером.
5. Большинство плагинов не закреплено на commit; исключение — используемый fork Adwaita. Восстановление на новых версиях Neovim и плагинов требует проверки запуском.

## Симлинки и будущая установка

Отдельных `install.sh` в этом репозитории нет: установка задаётся в mise. Исходные `home-files/install`, `install_osx` и `vim-files/install.sh` относятся к старым каталогам и не используются для новой структуры.

| Целевой путь | Источник относительно `my-mise` |
| --- | --- |
| `~/.zprofile` | `.zprofile` |
| `~/.zshrc` | `.zshrc` |
| `~/.zsh_plugins.txt` | `.zsh_plugins.txt` |
| `~/.gitconfig` | `.gitconfig` |
| `~/.vimrc` | `vim/.vimrc` |
| `~/.ctags` | `vim/.ctags` |
| `~/.config/nvim/init.vim` | `vim/init.vim` |
| `~/.vim/colors/bclear.vim` | `vim/bclear.vim` |
| `~/.vim/colors/macvim.vim` | `vim/macvim.vim` |

Перед реальной миграцией нужно сопоставить существующие файлы и симлинки, установить выбранные пакеты и затем переключить dotfiles. В сборке нет команды принудительного удаления конфликтующих путей. `~/.vim` целиком не заменяется.

Для чистой машины дополнительно понадобятся vim-plug, установка плагинов и Tree-sitter-парсеров. `PlugInstall` может выполнять сборку — например, `guihua.lua` содержит шаг `make`. Antidote и Ruby-provider также требуют своих зависимостей. Всё это отдельный этап после холодной проверки.

## Холодная проверка

Из любого каталога:

```sh
/opt/homebrew/bin/python3 -B ~/my-mise/verify.py
```

Проверяющий файл не пишет на диск, не использует сеть, не запускает дочерних процессов и не исполняет конфиги. Нужен Python с `tomllib` — версия 3.11 или новее. На другой машине путь к интерпретатору может отличаться.

Проверяются TOML и применённые ограничения локальной схемы, источники симлинков, контрольные суммы исходников, состав пакетов и покрытие найденных Nerd Fonts. Проверка checksum исходников рассчитана на эту машину, где пока существуют `~/home-files` и `~/vim-files`.

Отдельные проверки синтаксиса также не загружают конфигурацию:

```sh
/bin/zsh -f -n ~/my-mise/.zprofile
/bin/zsh -f -n ~/my-mise/.zshrc
/opt/homebrew/bin/luac -p ~/my-mise/vim/*.lua
```

Это **не** результат `mise bootstrap --dry-run`. Mise, установщики и Neovim не запускаются; совместимость плагинов, разрешение плавающих версий и установка пакетов остаются за пределами проверки. Итоги — в [CHECKS.txt](CHECKS.txt), происхождение пакетов — в [package-metadata.json](package-metadata.json).

Историческая оговорка: при первоначальном переносе первые чтения использовали login-shell, который мог загрузить прежний `.zprofile`. После этого команды выполняются с `login=false`. Подробности сохранены в архивном [README.txt](README.txt).

## Как поддерживать конфигурацию

- **Добавить программу:** сначала определить, относится ли она к `[tools]`, formula или cask. Для стороннего источника сохранить полный tap. При добавлении пакета обновить `package-metadata.json`, поскольку его проверяет `verify.py`.
- **Изменить версию языка:** редактировать `[tools]` либо конфиг конкретного проекта. Не добавлять параллельно второй менеджер версий.
- **Добавить плагин Neovim:** декларация идёт в `vim/01_bundle.vim`, настройка — в подходящий номерной файл, сочетания клавиш — в `vim/06_mappings.vim` или рядом с настройкой плагина.
- **Изменить оформление:** тема находится в `04_colorscheme.lua`, статусная строка — в `08_lualine.lua`, вкладки — в `08_tabs.lua`, дерево — в `08_neotree.lua`.
- **Сохранить локальное отличие:** использовать игнорируемый `mise.local.toml` в соответствующем проекте. Такой файл не заменяет автоматически глобальную конфигурацию для всех каталогов.
- **Проверить изменения:** повторить холодную проверку. Инвентаризация — датированный снимок; её счётчики и сведения об установках не обновляются автоматически.

Git-репозиторий инициализирован с веткой `main`. Первоначальный коммит и remote не созданы автоматически.
