# DayZ Command Line Launcher

**dayz-ctl** — это экспериментальный лаунчер (обозреватель серверов и
средство запуска) [DayZ][] в [Steam][221100] [Proton][] для Linux.

<!-- rule: current lang, other langs sorted by alpha -->
> Этот документ доступен на языках: [rus 🇷🇺][], [eng 🇬🇧][], [ua 🇺🇦][]

![logo][]

На момент реализации этого проекта [Bohemia Interactive][] всё еще не смогла
сделать рабочий лаунчер для игры, который мог бы корректно устанавливать
модификации и подключатся к игровым серверам. По этой причине появился этот
проект.

Основные особенности:

* Обозреватель серверов с информацией о каждом сервере
* Нечеткий поиск в обозревателе серверов на базе [fzf][]
* Автоматическая установка модов (как опция)
* Широкий набор фильтров для поиска серверов (карта, время суток,
  модификации, количество игроков, от первого лица, пароль и т.п.)
* Дополнительная информация в виде страны расположения (используя geoip
  базу) и ping для каждого сервера
* Список избранного, история последних 10 игр и создание ярлыков быстрого
  запуска для подключения к серверам
* Оффлайн режим [DayZCommunityOfflineMode][] с автоматической установкой,
  обновлением и возможностью выбора модификаций
* Меню конфигурации с параметрами запуска игры, настройками лаунчера,
  управлением и статистикой по модам
* Предоставляет ссылку с подробной информацией о сервере на
  [battlemetrics][]

Отдельное спасибо [dayz-linux-cli-launcher][] за идею и [dayzsalauncher][]
за API.

## Предварительный просмотр

<!-- markdownlint-disable -->
<div style="text-align:center">

> &nbsp;
> ![](extra/dayz-ctl-demo.svg)
> **Демонстрация лаунчера**

<details>
<summary>Больше скриншотов</summary>
<table border="0" cellspacing="0" cellpadding="0" style="border: none">
<tr>
  <td><img width="100%" src="extra/s_main.png"/><p>Главное меню</p></td>
  <td><img width="100%" src="extra/s_servers.png"/><p>Браузер серверов</p></td>
</tr>
<tr>
  <td><img width="100%" src="extra/s_servers_filter.png"/><p>Фильтрация серверов</p></td>
  <td><img width="100%" src="extra/s_servers_filter_map.png"/><p>Фильтрация по карте</p></td>
</tr>
<tr>
  <td><img width="100%" src="extra/s_servers_filter_applied.png"/><p>Применение фильтра</p></td>
  <td><img width="100%" src="extra/s_servers_favorites.png"/><p>Браузер избранного</p></td>
</tr>

<tr>
  <td><img width="100%" src="extra/s_servers_history.png"/><p>Браузер истории</p></td>
  <td><img width="100%" src="extra/s_servers_search.png"/><p>Нечеткий поиск</p></td>
</tr>
<tr>
  <td><img width="100%" src="extra/s_offline.png"/><p>Оффлайн режим</p></td>
  <td><img width="100%" src="extra/s_offline_mods.png"/><p>Моды для оффлайн</p></td>
</tr>
<tr>
  <td><img width="100%" src="extra/s_servers_mods.png"/><p>Моды сервера</p></td>
  <td><img width="100%" src="extra/s_mods.png"/><p>Информация о модах</p></td>
</tr>
<tr>
  <td><img width="100%" src="extra/s_config.png"/><p>Меню конфигурации</p></td>
  <td><img width="100%" src="extra/s_config_launch.png"/><p>Параметры запуска</p></td>
</tr>
<tr>
  <td><img width="100%" src="extra/s_about.png"/><p>Информация</p></td>
  <td><img width="100%" src="extra/s_news.png"/><p>Новости DayZ</p></td>
</tr>
</table>
</details>
</div>
<!-- markdownlint-enable -->

## Особенности использования SteamCMD

Имеется два режима работы лаунчера с использованием SteamCMD для управления
модами и без него в ручном режиме.

Вы можете комбинировать оба подхода, к примеру подписываться на те
модификации которые вам точно нужны будут в будущем переходя по ссылке, а
наличие обновлений проверять или принудительно обновлять моды при помощи
лаунчера. Также вы можете не подписываться на "сомнительные 50 модов"
очередного сервера и с легкостью удалить их одним действием из лаунчера, при
этом сохранив все моды на которые имеется подписка.

### Используя SteamCMD

* 🟢 Всё происходит автоматически
* 🟢 Автоматическая проверка наличия обновлений модов прямо сейчас
  (принудительно)
* 🟡 Не создается подписки на моды, они просто скачиваются
* 🟡 Требует закрытия клиента Steam для загрузки модов
* 🔴 Иногда нужно повторно авторизоваться в Steam

### Не используя SteamCMD

* 🟢 Привычное поведение если вы уже использовали другие решения, к примеру
  [dayz-linux-cli-launcher][]
* 🟡 Игра сама не запустится после скачивания модов
* 🟡 Steam бывает задерживает проверку обновлений и скачивает их только
  после перезапуска или подписки/отписки от мода
* 🔴 Подписываться на моды нужно самому руками

## Установка

### При помощи установщика

Для удобства установки имеется небольшой скрипт который сделает всё за вас
(по крайней мере попытается сделать)

Выполните это:

```bash
curl -sSfL https://raw.githubusercontent.com/WoozyMasta/dayz-ctl/master/install | bash
```

### Ручная установка

Для работы лаунчера вам необходимо убедится что у вас установлены все
зависимости:

* [jq][] - утилита для обработки JSON
* [fzf][] - утилита для нечеткого поиска
* [gum][] - утилита для создания диалогов и стилизации вывода
* `ping` (`iputils-ping`) - узнаем пинг до сервера (где включен ICMP)
* `geoiplookup` (`geoip-bin`) - узнаем страну размещения сервера
* `whois` - запасной вариант для geoiplookup, менее точный и более
  медленный, но не все записи есть в стандартной БД geoip
* `curl` - утилита для комуникации с различными API по HTTP/S
* `cut, tr, grep, pgrep, pkill, killal, timeout, sed, awk` (`gawk`) - куда
  же без класических утилит в скриптах
* [Steam][] - онлайн-сервис цифрового распространения компьютерных игр
* [SteamCMD][] - steamcmd Консольный клиент Steam
* [DayZ][221100] - и естественно сама игра

После чего можете склонировать репозиторий:

```bash
git clone git@github.com:WoozyMasta/dayz-ctl.git
# or
git clone https://github.com/WoozyMasta/dayz-ctl.git
# and run
cd dayz-ctl
./dayz-ctl
```

Или скачать сам файл скрипта:

```bash
curl -sSfL -o ~/.local/bin/dayz-ctl \
  https://raw.githubusercontent.com/WoozyMasta/dayz-ctl/master/dayz-ctl
chmod +x ~/.local/bin/dayz-ctl
# and run
dayz-ctl
```

### Emoji

Для нормального отображения элеменотов используются emoji, возможно дополнительно вам понадобится установить их, к примеру вы можете использовать [Noto][] шрифт от Google.

Ниже приведен список с названием пакета для разных дистрибутивов.

* `fonts-noto-color-emoji` - debian/ubuntu
* `google-noto-emoji-color-fonts` - centos
* `google-noto-emoji-fonts` - fedora
* `noto-fonts-emoji` - arch
* `font-noto-emoji` - alpine
* `noto-coloremoji-fonts` - suse

Или же если вам не нравятся emoji или вы не можете использовать их по какой то причине, вы можете применить патч для замены их на строки:

```bash
sed -e 's/▫️/•/g' -e 's/🟩/✕/g' -e 's/⬛/ /g' -e 's/🕒/time/g' -e 's/❔/?/g' \
  -e 's/🟢/ok/g' -e 's/🔴/no/g' -e 's/🌙/night/g' -e 's/☀️/day/g' \
  -e 's/🔒/yes/g' -e 's/🔓/no/g' -e 's/✅/ok/g' -e 's/❌/no/g' \
  -i "$(which dayz-ctl)"
```

## Проверялось в дистрибутивах

* 🟢 Debian bookworm
* 🟢 Debian bullseye
* 🟢 Debian buster
* 🟢 Ubuntu 18.04
* 🟢 Ubuntu 20.04
* 🟢 Ubuntu 22.04
* 🟢 Fedora latest
* 🟡 Centos 7 (small bugs)
* 🟡 Centos stream9 (small bugs)
* 🟢 Alpine latest
* 🟢 Alpine edge
* 🟢 Archlinux
* 🟡 Opensuse leap (small bugs)

## Прочее

### Steam

Лучше убирать все параметры запуска DayZ в Steam и управлять ими из лаунчера
или наоборот. Так как ключи могут дублироваться и это может вызвать
путаницу, или в худшем случае обрежет часть ключей, ведь у строки аргументов
есть лимит длинны, а на серверах с большим количеством модов используется и
так очень длинный параметр запуска.

Т.е. оставьте параметры запуска пустыми, или укажите только нужный вам набор
вспомогательных утилит и переменных, к примеру:

```bash
MANGOHUD=1 ENABLE_VKBASALT=1 gamemoderun %command%
```

### Синтаксис поиска

Вы можете ввести несколько условий поиска, разделенных пробелами. например
`^namalsk DE !PVE !RP`

| Ключ      | Тип соответствия                       | Описание                                     |
| --------- | -------------------------------------- | -------------------------------------------- |
| `sbtrkt`  | нечеткое совпадение                    | Элементы, соответствующие `sbtrkt`           |
| `'wild`   | точное совпадение (в кавычках)         | Элементы, включающие `wild`                  |
| `^music`  | точное совпадение префикса             | Элементы, начинающиеся с `music`             |
| `.mp3$`   | суффикс-точное совпадение              | Элементы, оканчивающиеся на `.mp3`           |
| `!fire`   | обратное точное совпадение             | Предметы, не содержащие слова `fire`         |
| `!^music` | точное соответствие обратного префикса | Элементы, которые не начинаются с `music`    |
| `!.mp3$`  | точное соответствие обратного суффикса | Элементы, которые не заканчиваются на `.mp3` |

Термин с одним символом черты действует как оператор ИЛИ

```regexp
PVE | RP
```

## Полезное

* <https://github.com/FeralInteractive/gamemode>
* <https://github.com/flightlessmango/MangoHud>
* <https://github.com/DadSchoorse/vkBasalt>
* <https://github.com/crosire/reshade-shaders>
* <https://github.com/StuckInLimbo/OBS-ReplayBuffer-Setup>
* <https://github.com/matanui159/ReplaySorcery>
* <https://github.com/LunarG/VulkanTools/blob/master/vkconfig/README.md>

```sh
MANGOHUD=1 ENABLE_VKBASALT=1 gamemoderun %command%
```

```sh
MANGOHUD=0 DXVK_HUD=fps DXVK_FRAME_RATE=60 ENABLE_VKBASALT=1 gamemoderun %command%
```

`DXVK_HUD=fps` ... `DXVK_HUD=full`

* `devinfo` — отображает название графического процессора и версию драйвера.
* `fps` — показывает текущую частоту кадров.
* `frametimes` — показывает график времени кадра.
* `submissions` — показывает количество командных буферов, отправленных на кадр.
* `drawcalls` — показывает количество вызовов отрисовки и проходов рендеринга на кадр.
* `pipelines` — показывает общее количество графических и вычислительных конвейеров.
* `descriptors` — показывает количество пулов дескрипторов и наборов дескрипторов.
* `memory` — показывает объем выделенной и используемой памяти устройства.
* `gpuload` — показывает предполагаемую загрузку графического процессора. Может быть неточным.
* `version` — показывает версию DXVK.
* `api` — показывает уровень функций D3D, используемый приложением.
* `cs` — показывает статистику рабочего потока.
* `compiler` — показывает активность компилятора шейдера.
* `samplers` — показывает текущее количество используемых пар сэмплеров [только для D3D9]
* `scale=x` — Масштабирует HUD в х раз (например, в 1,5)

Ограничение частоты кадров `DXVK_FRAME_RATE=0`

<!-- Links -->
[eng 🇬🇧]: README.md
[ua 🇺🇦]: README.ua.md
[rus 🇷🇺]: README.ru.md
[logo]: extra/dayz-ctl-logo.svg

[DayZ]: https://dayz.com
[Bohemia Interactive]: https://www.bohemia.net/games/dayz
[221100]: https://store.steampowered.com/app/221100
[dayz-linux-cli-launcher]: https://github.com/bastimeyer/dayz-linux-cli-launcher
[dayzsalauncher]: https://dayzsalauncher.com
[battlemetrics]: https://www.battlemetrics.com
[SteamCMD]: https://developer.valvesoftware.com/wiki/SteamCMD
[fzf]: https://github.com/junegunn/fzf
[jq]: https://github.com/stedolan/jq
[gum]: https://github.com/charmbracelet/gum
[DayZCommunityOfflineMode]: https://github.com/Arkensor/DayZCommunityOfflineMode
[Steam]: https://store.steampowered.com/about/
[Proton]: https://github.com/ValveSoftware/Proton
[Noto]: https://fonts.google.com/noto

<!-- 
DayZ DayZSA dayzstandalone dayz standalone linux nix proton steam
DayZ launcher Linux
DayZ servers browser linux
Дейз лаунчер линукс
-->
